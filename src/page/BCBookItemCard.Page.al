page 50404 "BCBookItemCard"
{

    Caption = 'BookItemCard';
    PageType = Card;
    SourceTable = "BCBook Item";
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
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
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                    ApplicationArea = All;
                    Caption = 'Author';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }

            }
        }
    }

}
