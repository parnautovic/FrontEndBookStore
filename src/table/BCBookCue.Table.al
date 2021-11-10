table 50403 "BCBook Cue"
{
    Caption = 'Book Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "No. of Items"; Integer)
        {
            Caption = 'No.';
            FieldClass = FlowField;
            CalcFormula = count("BCBook Item");
        }
        field(3; "Item CategorySRB"; Integer)
        {
            Caption = 'Serbian';
            FieldClass = FlowField;
            CalcFormula = count("BCBook Item" where("Item Category Code" = const('SRB_BOOK')));
        }
        field(4; "Item CategoryENG"; Integer)
        {
            Caption = 'English';
            FieldClass = FlowField;
            CalcFormula = count("BCBook Item" where("Item Category Code" = const('ENG_BOOK')));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}
