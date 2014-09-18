<%@ Control Language="C#" AutoEventWireup="true" CodeFile="appDetailRpt.ascx.cs"
    Inherits="controls_Application_Detail_Report" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Pre Approval Report</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in"
            style="padding: 4px 2px">
            <div class="col-md-12">
                <hr />
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Height="400px">
                    <LocalReport ReportPath="report\preApprovalReport.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" Name="ReportDS_tbl_pre_approval_reports" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="ReportDS_Collateral" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" Name="ReportDS_GetRptCreditInformation" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource6" Name="ReportDS_loanDetails" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.loanDetailsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <hr />
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
            SelectCommand="loanDetails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetLoanDetails" TypeName="ReportDSTableAdapters.LoanDetailsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetLoanCollateral" TypeName="ReportDSTableAdapters.CollateralTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetPreliminaryReport" TypeName="ReportDSTableAdapters.tbl_pre_approval_reportsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetRptCreditInformation" TypeName="ReportDSTableAdapters.GetRptCreditInformationTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</div>
