page 50406 "BCBook Queue"
{

    Caption = 'Book Queue';
    PageType = CardPart;
    SourceTable = "BCBook Cue";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;



    layout
    {


        area(content)
        {
            cuegroup(General)
            {
                Caption = 'Book';
                field("No. of Items"; Rec."No. of Items")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Style = Attention;
                    DrillDownPageId = BCWebShopItem;
                    Caption = 'No. of All Items';
                }
                field("Item CategorySRB"; Rec."Item CategorySRB")
                {
                    ToolTip = 'Specifies the value of the Category field.';
                    ApplicationArea = All;
                    Style = Attention;
                    DrillDownPageId = BCWebShopItem;
                    Caption = 'No. of Books in Serbian';


                }
                field("Item CategoryENG"; Rec."Item CategoryENG")
                {
                    ToolTip = 'Specifies the value of the Category field.';
                    ApplicationArea = All;
                    Style = Attention;
                    DrillDownPageId = BCWebShopItem;
                    Caption = 'No. of Books in English';
                }
            }
        }
    }


    trigger OnOpenPage()

    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

    end;

}
