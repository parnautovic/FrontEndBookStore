page 50402 "BCCartInfo"
{

    Caption = 'CartInfo';
    PageType = ListPart;
    SourceTable = "BCCart Line";
    //  SourceTableView = sorting(BCCartLine) where("Book User"= const());

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
                field("Book User"; BCLoginUser.GetUser())
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FillUser() field.';
                    Caption = 'Book User';


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
                field(Image; Rec."Item Image")
                {
                    ApplicationArea = All;
                    Caption = 'Image';
                    ToolTip = 'Specifies the value of the Image field.';


                }
            }
        }
    }



    // trigger OnOpenPage()
    // ;
    // begin
    //     Rec.DeleteAll(true);
    // end;

    var
        BCLoginUser: Codeunit BCLoginUser;

}
