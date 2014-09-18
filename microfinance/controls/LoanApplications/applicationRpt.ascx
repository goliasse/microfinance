<%@ Control Language="C#" AutoEventWireup="true" CodeFile="applicationRpt.ascx.cs"
    Inherits="controls_applicationRpt" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Application Report</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in"
            style="padding: 4px 2px">
            <div class="col-md-12">
                <hr />
                <rsweb:ReportViewer ID="rvAppraisalReport" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Height="400px" OnLoad="rvAppraisalReport_Load">
                    <LocalReport ReportPath="report\appraisalReport.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="ReportDS_GetRptPersonalInformation" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="ReportDS_GetRptInitiator" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource28" Name="ReportDS_LoanDetails" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" Name="ReportDS_GetRptFees" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource5" Name="ReportDS_GetRptCorporateInformation" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource6" Name="ReportDS_Collateral" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource7" Name="ReportDS_GetRptAsset" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource8" Name="ReportDS_GetRptPaymentPlan" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource9" Name="ReportDS_GetRptEmploymentDetails" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource10" Name="ReportDS_GetRptEnterprise" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource11" Name="ReportDS_GetRptNoOfEmployee" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource12" Name="ReportDS_GetRptFinancial" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource14" Name="ReportDS_GetRptAuditors" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource13" Name="ReportDS_GetRptCreditInformation" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource15" Name="ReportDS_GetRptSupportingDocuments" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource16" Name="ReportDS_GetRptBankers" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource17" Name="ReportDS_GetRptGuarantor" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource18" Name="ReportDS_GetRptIncomeExpense" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource19" Name="ReportDS_GetRptOwnership" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource20" Name="ReportDS_GetRptNextOfKin" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource21" Name="ReportDS_tbl_pre_approval_reports" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource22" Name="ReportDS_GetRptLoanReport" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource23" Name="ReportDS_GetRptRiskReport" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource24" Name="ReportDS_GetRptLegalReports" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource26" Name="ReportDS_loanDetails" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource27" Name="ReportDS_GetRptComments" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource29" Name="mainDS_SetupDetails" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource29" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetSetupDetails" TypeName="mainDSTableAdapters.SetupDetailsTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource28" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.loanDetailsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource27" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetRptComments" TypeName="ReportDSTableAdapters.GetRptCommentsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                        <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource26" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.loanDetailsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource25" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.loanDetailsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="GetRptInitiator" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <hr />
        </div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptPersonalInformation" TypeName="ReportDSTableAdapters.GetRptPersonalInformationTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptInitiator" TypeName="ReportDSTableAdapters.GetRptInitiatorTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.loanDetailsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptFees" TypeName="ReportDSTableAdapters.GetRptFeesTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptCorporateInformation" TypeName="ReportDSTableAdapters.GetRptCorporateInformationTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetLoanCollateral" TypeName="ReportDSTableAdapters.CollateralTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptAsset" TypeName="ReportDSTableAdapters.GetRptAssetTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptPaymentPlan" TypeName="ReportDSTableAdapters.GetRptPaymentPlanTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptEmploymentDetails" TypeName="ReportDSTableAdapters.GetRptEmploymentDetailsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptEnterprise" TypeName="ReportDSTableAdapters.GetRptEnterpriseTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="ClientID" Type="Int32" />
                <asp:Parameter Name="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptNoOfEmployee" TypeName="ReportDSTableAdapters.GetRptNoOfEmployeeTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource12" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptFinancial" TypeName="ReportDSTableAdapters.GetRptFinancialTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource13" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptCreditInformation" TypeName="ReportDSTableAdapters.GetRptCreditInformationTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource14" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptAuditors" TypeName="ReportDSTableAdapters.GetRptAuditorsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource16" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptBankers" TypeName="ReportDSTableAdapters.GetRptBankersTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource15" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptSupportingDocuments" TypeName="ReportDSTableAdapters.GetRptSupportingDocumentsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource17" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptGuarantor" TypeName="ReportDSTableAdapters.GetRptGuarantorTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource18" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptIncomeExpense" TypeName="ReportDSTableAdapters.GetRptIncomeExpenseTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource19" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptOwnership" TypeName="ReportDSTableAdapters.GetRptOwnershipTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource20" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptNextOfKin" TypeName="ReportDSTableAdapters.GetRptNextOfKinTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource21" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetPreliminaryReport" TypeName="ReportDSTableAdapters.tbl_pre_approval_reportsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource22" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptLoanReport" TypeName="ReportDSTableAdapters.GetRptLoanReportTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource24" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptLegalReports" TypeName="ReportDSTableAdapters.GetRptLegalReportsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource23" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptRiskReport" TypeName="ReportDSTableAdapters.GetRptRiskReportTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</div>
