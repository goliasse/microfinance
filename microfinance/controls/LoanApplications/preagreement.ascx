<%@ Control Language="C#" AutoEventWireup="true" CodeFile="preagreement.ascx.cs" Inherits="controls_preagreement" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="row">
    <p>Pre Agreement Report </p>
    <hr />
    <div class="col-md-12">
    <rsweb:ReportViewer ID="rvPreagreement" runat="server" Font-Names="Verdana" 
            Font-Size="8pt"  Width="100%" Height="400px" 
            >
        <localreport reportpath="report\preagreement.rdlc">
            <datasources> 
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                    Name="ReportDS_GetRptPaymentPlan" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                    Name="ReportDS_GetSetupDetails" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" 
                    Name="ReportDS_LoanDetails" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" 
                    Name="ReportDS_GetRptFees" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource5" 
                    Name="ReportDS_GetRptClientProfile" />
            </datasources>
        </localreport>
    </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetRptClientProfile" 
            TypeName="ReportDSTableAdapters.GetRptClientProfileTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="ClientID" SessionField="ClientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetRptFees" 
            TypeName="ReportDSTableAdapters.GetRptFeesTableAdapter">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" 
                    Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetLoanDetails" 
            TypeName="ReportDSTableAdapters.LoanDetailsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetSetupDetails" 
            TypeName="ReportDSTableAdapters.GetSetupDetailsTableAdapter">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetRptPaymentPlan" 
            TypeName="ReportDSTableAdapters.GetRptPaymentPlanTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <hr />
</div>