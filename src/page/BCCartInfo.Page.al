page 50402 "BCCartInfo"
{

    Caption = 'CartInfo';
    PageType = ListPart;
    SourceTable = "BCCart Line";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field(Amount; Rec.CalcAmount())
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                    Caption = 'Amount';

                }
                field("Book User"; Rec."Book User")
                {
                    ToolTip = 'Specifies the value of the Book User field.';
                    ApplicationArea = All;
                    Caption = 'User';


                }
                field("Book User No."; Rec."User number")
                {
                    ToolTip = 'Specifies the value of the Book User No. field.';
                    ApplicationArea = All;
                    Caption = 'User number';
                }



            }
            group(Total)
            {
                Caption = 'Total';

                field("Total Quantity"; Rec.CalcTotalQuantity())
                {
                    ToolTip = 'Specifies the value of the CalcTotalQuantity() field.';
                    ApplicationArea = All;
                    Caption = 'Total Quantity';

                }
                // field("Total Amount"; Rec.CalcTotalAmount())
                // {
                //     ToolTip = 'Specifies the value of the CalcTotalQuantity() field.';
                //     ApplicationArea = All;
                //     Caption = 'Total Amount';
                //     trigger OnDrillDown()

                //     begin
                //         CurrPage.SaveRecord();
                //         Page.Run(Page::BCCartInfo);
                //     end;
                // }

            }
        }
    }


    trigger OnOpenPage()
    var
    begin
        Rec.SetRange("Book User", BCLoginUser.GetUser());
        CurrPage.Update();
    end;


    var
        BCLoginUser: Codeunit BCLoginUser;

}
