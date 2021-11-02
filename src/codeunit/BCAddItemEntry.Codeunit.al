codeunit 50401 "BCAddItemEntry"
{
    TableNo = "BCBook Item";
    trigger OnRun()
    var

    begin
        // CreateBookItem(Rec);
        IncreaseQty(Rec);
    end;


    local procedure IncreaseQty(BCBookItem: Record "BCBook Item")
    var
        BCCartLine: Record "BCCart Line";

    begin
        BCCartLine.SetRange(BCCartLine."No.", BCBookItem."No.");
        if BCCartLine.IsEmpty() then begin
            BCCartLine.Init();
            BCCartLine."Cart No." := 0;
            BCCartLine.Validate("No.", BCBookItem."No.");
            BCCartLine.Validate(Description, BCBookItem.Description);
            BCCartLine.Validate("Unit Price", BCBookItem."Unit Price");
            BCCartLine.Validate(Quantity, 1);
            BCCartLine.Insert(true);
        end
        else begin
            BCCartLine.FindFirst();
            BCCartLine.Validate(Quantity, BCCartLine.Quantity + 1);
            BCCartLine.Modify(true);
        end;

    end;

}