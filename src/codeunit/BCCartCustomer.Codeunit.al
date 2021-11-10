codeunit 50404 "BCCartCustomer"
{
    trigger OnRun()
    var
        BCLoginUser: Codeunit BCLoginUser;
        CustomerJsonObject: JsonObject;

    begin
        CustomerJsonObject := CallODataService('customers', CreateCustomer());
        //Message('Your Customer Number is: %1', GetFieldValue('number', CustomerJsonObject).AsCode());

        BCLoginUser.SetUserCustomerNo(GetFieldValue('number', CustomerJsonObject).AsText());
    end;

    procedure CallODataService(OperationName: Text; ContentBody: Text): JsonObject
    var

        httpClient: HttpClient;
        HttpContent: HttpContent;
        httpHeaders: HttpHeaders;
        httpResponseMessage: HttpResponseMessage;
        ResponseJSONToken: JsonToken;
        ResponseText: Text;

    begin
        AddAuthorizationToHeader(httpClient);
        HttpContent.GetHeaders(httpHeaders);
        HttpContent.WriteFrom(ContentBody);
        httpHeaders.Remove('Content-Type');
        httpHeaders.Add('Content-Type', 'application/json');
        if not httpClient.Post(getServicePath(operationName), HttpContent, httpResponseMessage) then
            Error('Error.');
        if httpResponseMessage.IsSuccessStatusCode then begin
            httpResponseMessage.Content.ReadAs(ResponseText);
            ResponseJSONToken.ReadFrom(ResponseText);
            exit(ResponseJSONToken.AsObject())
        end else begin
            httpResponseMessage.Content.ReadAs(ResponseText);
            Error('Error: %1\from request: %2', ResponseText, ContentBody);
        end;
    end;

    local procedure getServicePath(OperationName: Text): Text
    begin
        //exit('http://ptsv2.com/t/webstore-session-kc/post');
        exit('https://bc-webshop.westeurope.cloudapp.azure.com:7048/bc/api/v2.0/companies(3adc449e-8621-ec11-bb76-000d3a29933c)/' + OperationName);
    end;



    local procedure GetFieldValue(FieldName: Text; JSONObject: JsonObject): JsonValue
    var
        JSONToken: JsonToken;
    begin
        JSONObject.Get(FieldName, JSONToken);
        exit(JSONToken.AsValue());
    end;

    local procedure AddAuthorizationToHeader(var httpClient: httpClient)
    var
        AuthString: Text;
        BasicTok: Label 'Basic %1', Comment = '%1 = placeholder for username and password.';
        UserPwdTok: Label '%1:%2', Comment = '%1 = Username, %2 = Password.';
    begin
        AuthString := StrSubstNo(UserPwdTok, 'admin', 'Pa$$w0rd!');
        httpClient.DefaultRequestHeaders().Add('Authorization',
            StrSubstNo(BasicTok,
                Base64Convert.ToBase64(AuthString)));
    end;

    local procedure CreateCustomer() Result: Text
    var
        BCLoginUser: Codeunit BCLoginUser;
        CustomerJSONObject: JsonObject;

    begin
        CustomerJSONObject.Add('number', '');
        CustomerJSONObject.Add('displayName', BCLoginUser.GetUser());
        CustomerJSONObject.WriteTo(Result);
    end;

    var
        Base64Convert: Codeunit "Base64 Convert";



}