page 50403 "BCLoginRegisterUser"
{

    Caption = 'Login/Register User';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BCWebShopSetUp;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Username; Username)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Username field.';
                    Caption = 'Username';

                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password field.';
                    Caption = 'Password';
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Register)
            {
                Caption = 'Register';
                Image = Add;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Register action.';

                trigger OnAction()
                var
                    BCLoginUser: Codeunit BCLoginUser;
                begin
                    BCLoginUser.SetUser(Username);
                    BCLoginUser.Register(Password);
                    CurrPage.Close();
                end;
            }
            action(Login)
            {
                Caption = 'Login';
                Image = ValidateEmailLoggingSetup;
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Login action.';

                trigger OnAction()
                var
                    BCLoginUser: codeunit BCLoginUser;
                begin
                    BCLoginUser.SetUser(Username);
                    BCLoginUser.ValidatePassword(Password);
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        Username: Text[250];
        Password: Text[250];

}
