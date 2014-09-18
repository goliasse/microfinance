<%@ Control Language="C#" AutoEventWireup="true" CodeFile="paymentvoucherRpt.ascx.cs"
    Inherits="controls_paymentvoucherRpt" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="">
    <p>
        Payment Voucher
    </p>
    <hr />
    <rsweb:ReportViewer ID="rvPaymentVoucher" runat="server" Font-Names="Verdana" Font-Size="8pt"
        Width="100%" Height="400px">
        <LocalReport ReportPath="report\paymentvoucher.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="ReportDS_GetRptPaymentVoucher" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="ReportDS_GetRptPaymentVoucherDetails" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" Name="mainDS_SetupDetails" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetSetupDetails" TypeName="mainDSTableAdapters.SetupDetailsTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetRptPaymentVoucherDetails" TypeName="ReportDSTableAdapters.GetRptPaymentVoucherDetailsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
            <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetRptPaymentVoucher" TypeName="ReportDSTableAdapters.GetRptPaymentVoucherTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
            <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <hr />
    <div class="col-md-12">
    </div>
</div>
