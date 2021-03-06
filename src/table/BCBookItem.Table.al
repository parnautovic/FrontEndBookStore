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
        field(4; Author; Text[100])
        {
            Caption = 'Author';
            DataClassification = CustomerContent;
        }
        field(5; Image; MediaSet)
        {
            Caption = 'Image';
            DataClassification = CustomerContent;
        }
        field(6; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
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
