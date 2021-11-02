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
                    Caption = 'Amount';
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        Rec.DeleteAll(true);
    end;

}
