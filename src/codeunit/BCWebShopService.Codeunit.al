codeunit 50400 "BCWebShopService"
{
    trigger OnRun()
    var
        BCWebShopSetUp: Record BCWebShopSetUp;
        BCBookItem: Record "BCBook Item";
        Base64Convert: Codeunit "Base64 Convert";
        httpClient: httpClient;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        AuthString: Text;
        UserPwdTok: Label '%1:%2', Comment = '%1 is username, %2 is password';
        WebErrorMsg: Label 'Error occurred: %1', Comment = '%1 is http status code';
        BackEndWebShopUrlLbl: Label '%1/itemsPA?$filter=intern eq ''PA''', Comment = '%1 is Web Shop url';
        AuthLbl: Label 'Basic %1', Comment = '%1 is AuthString';
    begin
        BCWebShopSetup.Get();

        // TODO - new procedure for authorization
        AuthString := StrSubstNo(UserPwdTok, BCWebShopSetUp."Backend Username", BCWebShopSetUp."Backend Password");
        AuthString := Base64Convert.ToBase64(AuthString);
        httpClient.DefaultRequestHeaders().Add('Authorization', StrSubstNo(Authlbl, AuthString));


        httpClient.Get(StrSubstNo(BackEndWebShopUrlLbl, BCWebShopSetUp."Web Service URL"), HttpResponseMessage);

        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            ParseJson(ResponseText, BCBookItem);
            //Page.Run(Page::BCWebShopItem, BCBookItem);
        end
        else
            Error(WebErrorMsg, HttpResponseMessage.HttpStatusCode());
    end;

    local procedure ParseJson(AuthString: Text; BCBookItem: Record "BCBook Item")
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        ItemJsonToken: JsonToken;
        ItemJsonObject: JsonObject;
    begin
        JsonObject.ReadFrom(AuthString);
        JsonObject.Get('value', JsonToken);
        JsonArray := JsonToken.AsArray();

        foreach ItemJsonToken in JsonArray do begin
            ItemJsonObject := ItemJsonToken.AsObject();
            BCBookItem.Init();
            BCBookItem."No." := CopyStr(GetFieldValue(ItemJsonObject, 'no').AsCode(), 1, MaxStrLen(BCBookItem."No."));
            BCBookItem.Description := CopyStr(GetFieldValue(ItemJsonObject, 'description').AsText(), 1, MaxStrLen(BCBookItem.Description));
            BCBookItem."Unit Price" := GetFieldValue(ItemJsonObject, 'unitPrice').AsDecimal();
            BCBookItem.Author := CopyStr(GetFieldValue(ItemJsonObject, 'author').AsText(), 1, MaxStrLen(BCBookItem.Author));
            BCBookItem."Item Category Code" := CopyStr(GetFieldValue(ItemJsonObject, 'itemcategory').AsCode(), 1, MaxStrLen(BCBookItem."Item Category Code"));
            loadPictures(BCBookItem, ItemJsonObject);
            BCBookItem.Insert();
        end;
    end;

    local procedure GetFieldValue(var JsonObject: JsonObject; FieldName: Text): JsonValue
    var
        JsonToken: JsonToken;

    begin
        JsonObject.Get(FieldName, JsonToken);
        exit(JsonToken.AsValue());
    end;

    local procedure loadPictures(var BCBookItem: Record "BCBook Item"; var ItemJsonObject: JsonObject)
    var
        Base64Convert: Codeunit "Base64 Convert";
        tempBlob: Codeunit "Temp Blob";
        ImageDataBase64: Text;
        PictureName: Text;
        Mime: Text;
        InStream: InStream;
        OutStream: OutStream;
    begin
        TempBlob.CreateOutStream(OutStream);
        ImageDataBase64 := GetFieldValue(ItemJsonObject, 'imageDataBase64').AsText();
        Base64Convert.FromBase64(ImageDataBase64, OutStream);
        TempBlob.CreateInStream(InStream);

        PictureName := GetFieldValue(ItemJsonObject, 'pictureName').AsText();
        Mime := GetFieldValue(ItemJsonObject, 'mime').AsText();

        BCBookItem.Image.ImportStream(InStream, pictureName, mime);
    end;

    // local procedure ImageLoad(var ItemJsonObject: JsonObject; BCBookItem: Record "BCBook Item")
    // var
    //     Base64Convert: Codeunit "Base64 Convert";
    //     tempBlob: Codeunit "Temp Blob";
    //     ImageDataBase64: Text;
    //     ImageDataDecoded: Text;
    //     InStream: InStream;
    //     outStream: OutStream;
    // begin
    //     imageDataBase64 := GetFieldValue(ItemJsonObject, 'imageBase64').AsText();
    //     ImageDataDecoded := Base64Convert.FromBase64(ImageDataBase64);

    //     tempBlob.CreateOutStream(outStream);
    //     outStream.Write(ImageDataDecoded);
    //     tempBlob.CreateInStream(InStream);

    //     //  BCBookItem..ImportStream(InStream, 'Item Image');
    // end;


    // trigger OnRun()
    // var
    //     BCWebShopSetUp: Record BCWebShopSetUp;
    //     Item: Record Item;
    //     Base64Convert: Codeunit "Base64 Convert";
    //     httpClient: httpClient;
    //     HttpResponseMessage: HttpResponseMessage;
    //     ResponseText: Text;
    //     AuthString: Text;
    //     UserPwdTok: Label '%1:%2', Comment = '%1 is username, %2 is password';
    //     WebErrorMsg: Label 'Error occurred: %1', Comment = '%1 is http status code';
    //     BackEndWebShopUrlLbl: Label '%1/itemsPA?$filter=intern eq ''PA''', Comment = '%1 is Web Shop url';
    //     AuthLbl: Label 'Basic %1', Comment = '%1 is AuthString';
    // begin
    //     BCWebShopSetup.Get();

    //     // TODO - new procedure for authorization
    //     AuthString := StrSubstNo(UserPwdTok, BCWebShopSetUp."Backend Username", BCWebShopSetUp."Backend Password");
    //     AuthString := Base64Convert.ToBase64(AuthString);
    //     httpClient.DefaultRequestHeaders().Add('Authorization', StrSubstNo(Authlbl, AuthString));


    //     httpClient.Get(StrSubstNo(BackEndWebShopUrlLbl, BCWebShopSetUp."Web Service URL"), HttpResponseMessage);

    //     if HttpResponseMessage.IsSuccessStatusCode() then begin
    //         HttpResponseMessage.Content().ReadAs(ResponseText);
    //         ParseJson(ResponseText, Item);
    //         //Page.Run(Page::BCWebShopItem, BCBookItem);
    //     end
    //     else
    //         Error(WebErrorMsg, HttpResponseMessage.HttpStatusCode());
    // end;

    // local procedure ParseJson(AuthString: Text; Item: Record Item)
    // var
    //     JsonObject: JsonObject;
    //     JsonToken: JsonToken;
    //     JsonArray: JsonArray;
    //     ItemJsonToken: JsonToken;
    //     ItemJsonObject: JsonObject;
    // begin
    //     JsonObject.ReadFrom(AuthString);
    //     JsonObject.Get('value', JsonToken);
    //     JsonArray := JsonToken.AsArray();

    //     foreach ItemJsonToken in JsonArray do begin
    //         ItemJsonObject := ItemJsonToken.AsObject();
    //         Item.Init();
    //         Item."No." := CopyStr(GetFieldValue(ItemJsonObject, 'no').AsCode(), 1, MaxStrLen(Item."No."));
    //         Item.Description := CopyStr(GetFieldValue(ItemJsonObject, 'description').AsText(), 1, MaxStrLen(Item.Description));
    //         Item."Unit Price" := GetFieldValue(ItemJsonObject, 'unitPrice').AsDecimal();


    //         Item.Insert();
    //     end;
    // end;

    // local procedure GetFieldValue(var JsonObject: JsonObject; FieldName: Text): JsonValue
    // var
    //     JsonToken: JsonToken;

    // begin
    //     JsonObject.Get(FieldName, JsonToken);
    //     exit(JsonToken.AsValue());
    // end;

    // local procedure ImageLoad(var ItemJsonObject: JsonObject; BCBookItem: Record "BCBook Item")
    // var
    //     Base64Convert: Codeunit "Base64 Convert";
    //     tempBlob: Codeunit "Temp Blob";
    //     ImageDataBase64: Text;
    //     ImageDataDecoded: Text;
    //     InStream: InStream;
    //     outStream: OutStream;
    // begin
    //     imageDataBase64 := GetFieldValue(ItemJsonObject, 'imageBase64').AsText();
    //     ImageDataDecoded := Base64Convert.FromBase64(ImageDataBase64);

    //     tempBlob.CreateOutStream(outStream);
    //     outStream.Write(ImageDataDecoded);
    //     tempBlob.CreateInStream(InStream);

    //     //  BCBookItem..ImportStream(InStream, 'Item Image');
    // end;




}