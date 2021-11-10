table 50402 "BCCart Line"
{
    Caption = 'Cart Line';
    DataClassification = CustomerContent;



    fields
    {
        field(1; "Cart No."; Integer)
        {
            Caption = 'Cart No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(3; Description; Text[20])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }
        field(4; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;

        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     Rec.Amount := Rec.Quantity * Rec."Unit Price";
            // end;

        }
        field(7; "Book User"; Text[250])
        {
            Caption = 'Book User';
            DataClassification = CustomerContent;
            // Editable = false;

        }
        field(8; "User number"; Text[250])
        {
            Caption = 'User number';
            DataClassification = CustomerContent;

        }




    }
    keys
    {
        key(PK; "Cart No.")
        {
            Clustered = true;
        }
        key(Key1; "No.")
        {

        }
    }

    procedure CalcAmount(): Decimal;
    begin

        Rec.Amount := Rec.Quantity * Rec."Unit Price";
        exit(Rec.Amount);
    end;



    procedure CalcTotalQuantity(): Decimal;
    begin
        Rec.CalcSums(Quantity);
        exit(Rec.Quantity);
    end;







}
