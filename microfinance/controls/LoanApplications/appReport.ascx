<%@ Control Language="C#" AutoEventWireup="true" CodeFile="appReport.ascx.cs" Inherits="controls_appReport" %>
<div class="">
<p> Application Report </p>
<hr />
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<rsweb:ReportViewer ID="ReportViewer1" runat="server">
</rsweb:ReportViewer>
<hr />
</div>
