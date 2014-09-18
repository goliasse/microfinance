<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvApplicationDetails.ascx.cs" Inherits="controls_invapplications_InvApplicationDetails" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Investmest Application Report</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in"
            style="padding: 4px 2px">
            <div class="col-md-12">
                <hr />
                <rsweb:ReportViewer ID="rvAppDetails" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Height="400px">
                    <LocalReport ReportPath="report\InvestmentReports\appdetails.rdlc">
                        
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                                Name="ReportDS1_tbl_investment_application" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                                Name="ReportDS1_tbl_inv_pay_sched" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" 
                                Name="ReportDS1_tblBankers" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" 
                                Name="ReportDS1_tbl_supporting_documents" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource5" 
                                Name="ReportDS1_tbl_contact_person" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource6" 
                                Name="ReportDS1_tbl_next_of_kin" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource7" 
                                Name="ReportDS1_tbl_next_of_kin_inv" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource8" 
                                Name="ReportDS1_tbl_next_of_kin_inv1" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource9" 
                                Name="ReportDS_GetRptPersonalInformation" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource10" 
                                Name="ReportDS1_tbl_constituent_investor" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource11" 
                                Name="ReportDS1_tbl_beneficiary" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource12" 
                                Name="ReportDS1_tbl_corporate_info" />
                        </DataSources>
                        
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource12" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetCorporateInformation" 
                    TypeName="ReportDS1TableAdapters.tbl_corporate_infoTableAdapter">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ClientID" QueryStringField="ClientID" 
                            Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetRptInvBeneficiaries" 
                    TypeName="ReportDS1TableAdapters.tbl_beneficiaryTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetInvestorsDetails" 
                    TypeName="ReportDS1TableAdapters.tbl_constituent_investorTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetRptPersonalInformation" 
                    TypeName="ReportDSTableAdapters.GetRptPersonalInformationTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="clientID" SessionField="ClientID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetNextOfKinInv" 
                    TypeName="ReportDS1TableAdapters.tbl_next_of_kin_inv1TableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetNextOfKinBeneficiaries" 
                    TypeName="ReportDS1TableAdapters.tbl_next_of_kin_invTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetNextOfKin1" 
                    TypeName="ReportDS1TableAdapters.tbl_next_of_kinTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetInvContactPerson" 
                    TypeName="ReportDS1TableAdapters.tbl_contact_personTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" 
                    DeleteMethod="Delete" InsertMethod="Insert" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetRptInvSupDoc" 
                    TypeName="ReportDS1TableAdapters.tbl_supporting_documentsTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_datID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="datClientID" Type="Int32" />
                        <asp:Parameter Name="datApplicationID" Type="Int32" />
                        <asp:Parameter Name="datApplicationID1" Type="Int32" />
                        <asp:Parameter Name="datFileName" Type="String" />
                        <asp:Parameter Name="datDescription" Type="String" />
                        <asp:Parameter Name="datFilePath" Type="String" />
                        <asp:Parameter Name="status" Type="Int32" />
                        <asp:Parameter Name="modifiedDate" Type="DateTime" />
                        <asp:Parameter Name="userID" Type="Int32" />
                        <asp:Parameter Name="Original_datID" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="datClientID" Type="Int32" />
                        <asp:Parameter Name="datApplicationID" Type="Int32" />
                        <asp:Parameter Name="datApplicationID1" Type="Int32" />
                        <asp:Parameter Name="datFileName" Type="String" />
                        <asp:Parameter Name="datDescription" Type="String" />
                        <asp:Parameter Name="datFilePath" Type="String" />
                        <asp:Parameter Name="status" Type="Int32" />
                        <asp:Parameter Name="modifiedDate" Type="DateTime" />
                        <asp:Parameter Name="userID" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetInvBankers" 
                    TypeName="ReportDS1TableAdapters.tblBankersTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                    DeleteMethod="Delete" InsertMethod="Insert" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetRptInvPaySchedule" 
                    TypeName="ReportDS1TableAdapters.tbl_inv_pay_schedTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_datID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="datAccountID" Type="Int32" />
                        <asp:Parameter Name="datDate" Type="DateTime" />
                        <asp:Parameter Name="datDays" Type="Int32" />
                        <asp:Parameter Name="datAmount" Type="Decimal" />
                        <asp:Parameter Name="datIntAccrued" Type="Decimal" />
                        <asp:Parameter Name="datPenalty" Type="Decimal" />
                        <asp:Parameter Name="datRollOver" Type="Decimal" />
                        <asp:Parameter Name="datStatus" Type="Int32" />
                        <asp:Parameter Name="datDatePaid" Type="DateTime" />
                        <asp:Parameter Name="datBatchNo" Type="String" />
                        <asp:Parameter Name="status" Type="Int32" />
                        <asp:Parameter Name="modifiedDate" Type="DateTime" />
                        <asp:Parameter Name="userID" Type="Int32" />
                        <asp:Parameter Name="Original_datID" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="datAccountID" Type="Int32" />
                        <asp:Parameter Name="datDate" Type="DateTime" />
                        <asp:Parameter Name="datDays" Type="Int32" />
                        <asp:Parameter Name="datAmount" Type="Decimal" />
                        <asp:Parameter Name="datIntAccrued" Type="Decimal" />
                        <asp:Parameter Name="datPenalty" Type="Decimal" />
                        <asp:Parameter Name="datRollOver" Type="Decimal" />
                        <asp:Parameter Name="datStatus" Type="Int32" />
                        <asp:Parameter Name="datDatePaid" Type="DateTime" />
                        <asp:Parameter Name="datBatchNo" Type="String" />
                        <asp:Parameter Name="status" Type="Int32" />
                        <asp:Parameter Name="modifiedDate" Type="DateTime" />
                        <asp:Parameter Name="userID" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetRptInvestmentDetails" 
                    TypeName="ReportDS1TableAdapters.tbl_investment_applicationTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
            <hr />
        </div>
    </div>
</div>