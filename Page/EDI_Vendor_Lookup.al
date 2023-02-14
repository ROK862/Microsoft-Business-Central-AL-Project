/// <summary>
/// Page Vendor_Register (ID 52001).
/// </summary>
page 52001 Vendor_Register
{
    Caption = 'Electronic Data Interchange Vendor List';
    PageType = List;
    SourceTable = "EDI Vendors";
    ApplicationArea = Basic, Suite, Assembly;
    DataCaptionFields = "Customer No.";
    QueryCategory = 'Electronic Data Interchange';
    RefreshOnActivate = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Record Entry No.';
                    ApplicationArea = All;
                }

                field("Order Class"; Rec."Order Class")
                {
                    ToolTip = 'Specify the EDI Order Class.';
                    ApplicationArea = Basic, Suite;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Link the Vendor to an Active Customer.';
                    ApplicationArea = Basic, Suite;
                    Lookup = true;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specify the Ship-to-Customer No.';
                    ApplicationArea = Basic, Suite;
                }
                field("EDI Vendors No."; Rec."EDI Vendors No.")
                {
                    ToolTip = 'Specifies the value of the EDI Vendors No. field.';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
