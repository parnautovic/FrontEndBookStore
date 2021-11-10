codeunit 50407 "BCLogOut"
{
    trigger OnRun()
    var
        BCLoginUser: Codeunit BCLoginUser;

    begin
        BCLoginUser.SetUser('');
        Message('You logout successfull.');

    end;



}