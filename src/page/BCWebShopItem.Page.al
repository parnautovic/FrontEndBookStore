page 50400 "BCWebShopItem"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Book Store';
    PageType = List;
    SourceTable = "BCBook Item";
    CardPageId = BCBookItemCard;
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
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                    ApplicationArea = All;
                    Caption = 'Author';
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the value of the Imgag field.';
                    ApplicationArea = All;
                    Caption = 'Image';
                }
                // field(BookUser; Rec.BookUser)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Book User';

                // }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                    Caption = 'Item Category Code';
                }
            }
        }
        area(FactBoxes)
        {
            part(Info; BCCartInfo)
            {
                ApplicationArea = All;
                // SubPageLink = "No." = field("No.");
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
                Caption = 'Add To Cart';

                trigger OnAction()
                var
                    BCAddItemEntry: Codeunit BCAddItemEntry;
                begin
                    BCAddItemEntry.Run(Rec);
                end;

            }
            action(DeleteCart)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Executes the Delete Cart action.';
                Image = Delete;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Delete Cart';

                trigger OnAction()
                var
                    BCCartLine: Record "BCCart Line";
                begin
                    BCCartLine.DeleteAll(true);

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
