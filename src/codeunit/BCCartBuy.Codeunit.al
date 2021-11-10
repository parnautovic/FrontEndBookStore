codeunit 50405 "BCCartBuy"
{
    trigger OnRun()
    var
        BCCartLine: Record "BCCart Line";
        BCSOAPRequest: Codeunit BCSOAPRequest;
        SDJsonObject: JsonObject;
        SLJsonObject: JsonObject;
        LineResult: Text;
        OrderLinePath: Text;
        HeaderNo: Text;


        NewLineNum: Integer;
    // CustomerName: Text;

    begin
        SDJsonObject := CallODataService('salesOrders', createSalesOrder());
        OrderLinePath := getOrderLinePath(GetFieldValue('id', SDJsonObject).AsText());

        NewLineNum := 1000;
        if BCCartLine.FindSet() then
            repeat
                NewLineNum := NewLineNum + 1;
                SLJsonObject := CallODataService(OrderLinePath, createSalesLine(NewLineNum, BCCartLine."No.", BCCartLine.Quantity, BCCartLine."Unit Price"));
            until BCCartLine.Next() = 0;
        // SLJsonObject := CallODataService(OrderLinePath, createSalesLine(20000, '1001', 2, 40));
        // SLJsonObject := CallODataService(OrderLinePath, createSalesLine(30000, '1100', 1, 70));

        SLJsonObject.WriteTo(LineResult);
        Message('Your doc number is: %1', GetFieldValue('number', SDJsonObject).AsCode());
        HeaderNo := GetFieldValue('number', SDJsonObject).AsText();
        BCSOAPRequest.SendToPost(HeaderNo);
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

    local procedure getOrderLinePath(Id: Text): Text
    begin
        exit('salesOrders(' + id + ')/salesOrderLines');
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


    local procedure createSalesOrder() Result: Text
    var
        BCLoginUser: Codeunit BCLoginUser;
        SalesOrderJSONObject: JsonObject;
    begin
        SalesOrderJSONObject.Add('number', '');
        SalesOrderJSONObject.Add('orderDate', format(System.Today(), 0, 9));
        SalesOrderJSONObject.Add('customerNumber', BCLoginUser.GetUserCustomerNo());
        SalesOrderJSONObject.WriteTo(Result);
    end;

    local procedure createSalesLine(LineNo: Integer; ItemNo: Code[20]; Qty: Decimal; Price: Decimal) ReturnValue: Text
    var
        SalesLineJSONObject: JsonObject;
    begin
        SalesLineJSONObject.Add('sequence', LineNo);
        SalesLineJSONObject.Add('lineType', 'Item');
        SalesLineJSONObject.Add('lineObjectNumber', ItemNo);
        SalesLineJSONObject.Add('quantity', Qty);
        SalesLineJSONObject.Add('unitPrice', Price);
        SalesLineJSONObject.Add('shipQuantity', Qty);
        SalesLineJSONObject.WriteTo(ReturnValue);
    end;

    var
        Base64Convert: Codeunit "Base64 Convert";


}