table 50401 "BCWebShopSetUp"
{
    Caption = 'WebShopSetUp';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Web Service URL"; Text[250])
        {
            Caption = 'Web Service URL';
            DataClassification = CustomerContent;
        }
        field(3; "Backend Username"; Text[100])
        {
            Caption = 'Backend Username';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(4; "Backend Password"; Text[100])
        {
            Caption = 'Backend Password';
            DataClassification = EndUserIdentifiableInformation;
            ExtendedDatatype = Masked;
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
