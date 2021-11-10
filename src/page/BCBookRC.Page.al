page 50405 "BCBook RC"
{

    Caption = 'Book RC';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {

            part(BookHeadLine; "BCBook HeadLine")
            {
                ApplicationArea = All;
            }
            part("Book Queue"; "BCBook Queue")
            {
                ApplicationArea = All;

            }

        }
    }
    actions
    {
        area(Processing)
        {



            action("Login/Register")
            {
                ApplicationArea = All;
                Caption = 'Login/Register';
                Promoted = true;
                PromotedOnly = true;
                RunObject = Page BCLoginRegisterUser;
                ToolTip = 'Executes the Login/Register action.';
            }
            action(Logout)
            {
                ApplicationArea = All;
                Caption = 'Logout';
                Promoted = true;
                PromotedOnly = true;
                RunObject = Codeunit BCLogOut;
                ToolTip = 'Executes the Logout action.';

            }
        }

    }

}
