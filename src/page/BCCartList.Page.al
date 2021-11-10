page 50408 "BCCart List"
{

    ApplicationArea = All;
    Caption = 'Cart List';
    PageType = List;
    SourceTable = "BCCart Line";
    UsageCategory = Administration;
    InsertAllowed = false;




    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Description';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit Price';

                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Amount';
                }
                field("Book User"; Rec."Book User")
                {
                    ToolTip = 'Specifies the value of the Book User field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Book User';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        BCLoginUser: Codeunit BCLoginUser;
    begin
        Rec.SetRange(Rec."Book User", BCLoginUser.GetUser());
        CurrPage.Update();
    end;




}
