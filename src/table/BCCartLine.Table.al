table 50402 "BCCart Line"
{
    Caption = 'Cart Line';
    DataClassification = ToBeClassified;

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

}
