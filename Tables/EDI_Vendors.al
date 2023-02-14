/// <summary>
/// Table EDI Vendors (ID 52005).
/// </summary>
table 52005 "EDI Vendors"
{
    Caption = 'EDI Vendors';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Vendor Code"; CODE[20])
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;

            TableRelation = "Customer"."No.";
            ValidateTableRelation = true;

            trigger onValidate()

            begin
                // TODO: Add validation for customer entry.
            end;
        }
        field(4; "EDI Vendors No."; Integer)
        {
            Caption = 'EDI Vendors No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Order Class"; option)
        {
            OptionCaption = 'Shoprite,PNP,Metro,Woermann';
            OptionMembers = "Shoprite","PNP","Metro","Woermann";
        }
        field(6; "Ship-to Code"; Code[20])
        {
            Caption = 'Main Account';
            DataClassification = ToBeClassified;

            TableRelation = "Customer"."No.";
            ValidateTableRelation = true;

            trigger onValidate()

            begin
                // TODO: Add validation for customer entry.
            end;
        }
    }
    keys
    {
        key(PK; "Vendor Code", "Customer No.", "Ship-to Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        VendorRecord: Record "EDI Vendors";

    begin
        VendorRecord.SETCURRENTKEY("Vendor Code", "EDI Vendors No.");
        VendorRecord.SETRANGE("Vendor Code", "Vendor Code");
        IF VendorRecord.FINDLAST THEN
            "EDI Vendors No." := VendorRecord."EDI Vendors No." + 1
        ELSE
            "EDI Vendors No." := 1;
        "Entry No." := VendorRecord.Count();
    end;
}
