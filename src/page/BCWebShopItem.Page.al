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
                    BCLoginUser: Codeunit BCLoginUser;
                begin
                    if BCLoginUser.GetUser() <> '' then
                        BCAddItemEntry.Run(Rec)
                    else
                        Message('You have to Login First.');


                end;

            }
            action(Cart)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Executes the Cart action.';
                Image = AddAction;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'View Cart';

                RunObject = page "BCCart List";


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
                    Question: Text;
                    Answer: Boolean;
                    Text000Lbl: Label 'Do you want to delete all item in the cart?';
                begin

                    Question := Text000Lbl;
                    Answer := Dialog.Confirm(Question, true);
                    //Message(Text001Lbl, Answer);
                    if Answer then begin
                        BCCartLine.DeleteAll(true);
                        Message('You successfully deleted all items in cart.');
                    end;

                end;
            }
            action(Borrow)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Executes the Delete Cart action.';
                Image = Bank;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Borrow';

                trigger OnAction()
                var
                    BCLoginUser: Codeunit BCLoginUser;
                begin
                    if (BCLoginUser.GetUser() = '') then
                        Message('Loginuj se.')
                    else
                        Message(BCLoginUser.GetUser());

                end;


            }
            action(Buy)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Executes Buy action.';
                Image = Check;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Buy';

                trigger OnAction()
                var
                    BCCartLine: Record "BCCart Line";
                    BCCartBuy: Codeunit BCCartBuy;
                    BCLoginUser: Codeunit BCLoginUser;

                begin
                    if BCLoginUser.GetUser() <> '' then begin
                        if not BCCartLine.IsEmpty then begin
                            BCCartBuy.Run();
                            BCCartLine.DeleteAll();
                            CurrPage.Update();
                        end

                        else
                            Message('Your Cart is Empty.');
                    end
                    else
                        Message('You have to Login First.');
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
