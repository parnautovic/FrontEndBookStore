codeunit 50406 "BCSOAPRequest"
{
    procedure SendToPost(No: Text)
    var

        httpClient: HttpClient;
        httpContent: HttpContent;
        httpResponse: HttpResponseMessage;
        httpHeaders: HttpHeaders;

        ResponseText: Text;
        WebErrorMsg: Label 'Error occurred: %1', Comment = '%1 is http status code';
        WebErrorMsg2Lbl: Label 'Error on server side: %1, Error Text Number 2', Comment = '%1 is http status code,%2 is eror 2.';


    begin

        AddAuthorizationToHeader(httpClient);
        httpContent.GetHeaders(httpHeaders);


        httpContent.WriteFrom(
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="urn:microsoft-dynamics-schemas/codeunit/SOAPWsPA">'
  + '<soapenv:Header/>'
   + '<soapenv:Body>'
     + '<soap:Calc>'
        + '<soap:no>' + No + '</soap:no>'
      + '</soap:Calc>'
  + '</soapenv:Body>'
+ '</soapenv:Envelope>');

        httpHeaders.Remove('Content-Type');
        httpHeaders.Add('Content-Type', 'text/xml');
        httpHeaders.Add('SOAPAction', '"urn:microsoft-dynamics-schemas/codeunit/SOAPWsPA:Calc"');

        // httpClient.Post('http://ptsv2.com/t/ybjgf-1635848578/post', httpContent, httpResponse);
        if not httpClient.Post('https://bc-webshop.westeurope.cloudapp.azure.com:7047/BC/WS/CRONUS%20International%20Ltd./Codeunit/SOAPWsPA', httpContent, httpResponse) then
            Error(WebErrorMsg, httpResponse.HttpStatusCode());


        if httpResponse.IsSuccessStatusCode() then begin

            httpResponse.Content.ReadAs(ResponseText);
            Message('Purchase' + ParseResponse(ResponseText));

        end else
            Error(WebErrorMsg2Lbl, httpResponse.HttpStatusCode(), ParseResponseError(ResponseText));
    end;

    /// <summary>
    /// AddAuthorizationToHeader.
    /// </summary>
    /// <param name="httpClient">VAR httpClient.</param>
    procedure AddAuthorizationToHeader(var httpClient: httpClient)
    var
        Base64Convert: Codeunit "Base64 Convert";
        AuthString: Text;
        BasicTok: Label 'Basic %1', Comment = '%1 = placeholder for username and password.';
        UserPwdTok: Label '%1:%2', Comment = '%1 = Username, %2 = Password.';
    begin
        AuthString := StrSubstNo(UserPwdTok, 'admin', 'Pa$$w0rd!');
        httpClient.DefaultRequestHeaders().Add('Authorization',
            StrSubstNo(BasicTok,
                Base64Convert.ToBase64(AuthString)));
    end;

    local procedure ParseResponse(ResponseText: Text): Text
    var
        ResponseXMLDocument: XMLDocument;
        RootXmlElement: XMLElement;
        BodyXMLNode: XMLNode;
        OperationResultXMLNode: XMLNode;
        ResultXMLNode: XMLNode;
    begin
        XMLDocument.ReadFrom(ResponseText, ResponseXMLDocument);
        ResponseXMLDocument.GetRoot(RootXmlElement);
        RootXmlElement.GetChildNodes().Get(1, BodyXMLNode);
        BodyXMLNode.AsXmlElement().GetChildNodes().Get(1, OperationResultXMLNode);
        OperationResultXMLNode.AsXmlElement().GetChildNodes().Get(1, ResultXMLNode);
        if ResultXMLNode.IsXmlElement() then
            exit(ResultXMLNode.AsXmlElement().InnerText)
        else
            exit('Something went wrong.');
    end;

    local procedure ParseResponseError(ResponseText: Text[100]): Text[100]
    begin
        Error('Procedure ParseResponseError not implemented.');
    end;

}