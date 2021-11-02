page 50400 "BCWebShopItem"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Book Store';
    PageType = List;
    SourceTable = "BCBook Item";
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    AdditionalSearchTerms = 'Web Shop';


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
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                    Caption = 'Comment';
                }
            }
        }
        area(FactBoxes)
        {
            part(Info; BCCartInfo)
            {
                ApplicationArea = All;
                //SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddToCart)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Executes the AddToCart action.';
                Image = AddAction;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'AddToCart';

                trigger OnAction()
                var
                    BCAddItemEntry: Codeunit BCAddItemEntry;
                begin
                    BCAddItemEntry.Run(Rec);

                end;

            }
        }
    }



    trigger OnOpenPage()
    var
        BCWebShopService: Codeunit BCWebShopService;
    begin
        Rec.DeleteAll(true);
        BCWebShopService.Run();
    end;



}
