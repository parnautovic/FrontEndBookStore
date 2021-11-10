page 50407 "BCBook HeadLine"
{

    Caption = 'Book HeadLine';
    PageType = HeadlinePart;
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                Caption = 'General';
                field(GreetingText; 'Welcome!')
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
                field(GreetingText2; 'Book Store')
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
            }
        }
    }




}
