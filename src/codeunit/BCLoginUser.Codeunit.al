codeunit 50402 "BCLoginUser"
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    procedure Register(Password: Text[250])
    begin
        if not IsolatedStorage.Contains(Username) then
            IsolatedStorage.Set(Username, Password)
        else
            Error('Username already exists.');
    end;

    procedure SetUser(UsernameTxt: Text[250])
    begin
        Username := UsernameTxt;
    end;


    procedure GetUser(): Text
    begin
        exit(Username);
    end;

    procedure SetUserCustomerNo("Customer No.": Text)
    begin
        IsolatedStorage.Set(Username + 'ID', "Customer No.")
    end;

    procedure GetUserCustomerNo() UserNo: Text
    begin
        if Username <> '' then
            IsolatedStorage.Get(Username + 'ID', UserNo);
    end;






    procedure ValidatePassword(Password: Text[250])
    var
        PasswordToCheck: Text;
    begin
        if not IsolatedStorage.Get(Username, PasswordToCheck) then
            Error('Username does not exist.');
        if PasswordToCheck <> Password then
            Error('Incorrect password.');
    end;

    var
        Username: Text;


}