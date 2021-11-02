page 50401 "BCWebShop Setup"
{

    Caption = 'Book Store Setup';
    PageType = Card;
    SourceTable = BCWebShopSetUp;
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    AdditionalSearchTerms = 'Web Shop';

    layout
    {
        area(content)
        {
            group("Backend Web Service")
            {
                Caption = 'Backend Web Service';


                field("Web Service URL"; Rec."Web Service URL")
                {
                    ToolTip = 'Specifies the value of the Web Service URL field.';
                    ApplicationArea = All;
                    Caption = 'Web Service URL';
                    MultiLine = true;
                }
            }
            group("Backend WebService Credntials")
            {
                Caption = 'Backend WebService Credntials';
                field("Backend Password"; Rec."Backend Password")
                {
                    ToolTip = 'Specifies the value of the Backend Password field.';
                    ApplicationArea = All;
                    Caption = 'Backend Password';
                }
                field("Backend Username"; Rec."Backend Username")
                {
                    ToolTip = 'Specifies the value of the Backend Username field.';
                    ApplicationArea = All;
                    Caption = 'Backend Username';
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        //Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Web Service URL" := 'https://<servername>/<service>/api/1.0';
            Rec.Insert();
        end;
    end;


}


