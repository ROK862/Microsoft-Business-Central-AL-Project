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
    actions
    {
        area(Processing)
        {
            group(ActionGroup21)
            {
                Caption = 'Reset Mapping';
                Image = Recalculate;
                action(ProcessExceptions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reset Mapping';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Releases the vendors within this record to live environment.';

                    trigger OnAction()
                    // Initialize Relevent Registers.
                    var
                        Customers: Record "Customer";
                        Vendors: Record "EDI Vendors";

                    begin
                        // Confirm if user wants to continue with an action.
                        if Dialog.Confirm('You cannot revert this action! Are you sure you want to reset vendor mapping?', False) = true then begin
                            Vendors.Reset();
                            Vendors.SetCurrentKey("Entry No.");
                            repeat
                                // Make sure we are not at a new record.
                                if Vendors."Customer No." <> '' then
                                    Vendors.Delete(true);
                            until Vendors.Next() = 0;
                        end;
                    end;
                }
                action(Recalculate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Recalculate';
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+10';
                    ToolTip = 'Recalculates the vendors from a list of customers where the vendor tag is set.';

                    trigger OnAction()

                    // Initialize Relevent Registers.
                    var
                        Customers: Record "Customer";
                        Vendors: Record "EDI Vendors";

                    begin
                        // Confirm if user wants to continue with an action.
                        if Dialog.Confirm('You cannot revert this action! Are you sure you want to run the EDI maintanance?', False) = true then begin
                            Vendors.Reset();
                            Vendors.SetCurrentKey("Entry No.");
                            repeat
                                // Make sure we are not at a new record.
                                if Vendors."Customer No." <> '' then
                                    Vendors.Delete(true);
                            until Vendors.Next() = 0;

                            Customers.Reset();
                            Customers.SetCurrentKey("Search Name");
                            if Customers.FindSet() then begin
                                repeat
                                    Vendors."Entry No." := 100;
                                    Vendors."Order Class" := Vendors."Order Class"::Shoprite;
                                    Vendors."Customer No." := Customers."No.";
                                    Vendors."Ship-to Code" := Customers."No.";

                                    Vendors.Insert(true);
                                until Customers.Next() = 0;
                            end;
                        end;
                    end;
                }
            }

        }
    }
}
