<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="reports.aspx.cs" Inherits="pages_report" Title="Reports " %>

<%@ Register src="../controls/LoanReports/ReportsCtrl.ascx" tagname="ReportsCtrl" tagprefix="uc1" %>
<%@ Register src="../controls/LoanReports/ReportContainer.ascx" tagname="ReportContainer" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
    <p>
        <h5><b>Reports</b></h5>
        <hr />
    </p>    
    <div style="min-height:80%">
        <uc1:ReportsCtrl ID="ReportsCtrl1" runat="server" />
        <uc2:ReportContainer ID="ReportContainer1" runat="server" />
    </div>
    </div>
</asp:Content>

