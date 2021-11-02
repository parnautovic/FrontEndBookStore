table 50400 "BCBook Item"
{
    Caption = 'Book Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(4; Comment; Text[100])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
