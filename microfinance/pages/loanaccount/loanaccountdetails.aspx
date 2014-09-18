<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="loanaccountdetails.aspx.cs" Inherits="pages_loanaccountdetails" Title="Accounts Pages" %>
<%@ Register src="~/controls/LoanAccounts/ctFreezeAccount.ascx" tagname="ctFreezeAccount" tagprefix="uc1" %>
<%@ Register src="~/controls/LoanAccounts/ctMonitoring.ascx" tagname="ctMonitoring" tagprefix="uc2" %>
<%@ Register src="~/controls/LoanAccounts/ctRefreshment.ascx" tagname="ctRefreshment" tagprefix="uc3" %>
<%@ Register src="~/controls/LoanAccounts/ctScheduledPayments.ascx" tagname="ctScheduledPayments" tagprefix="uc4" %>
<%@ Register src="~/controls/LoanAccounts/ctTransfer.ascx" tagname="ctTransfer" tagprefix="uc5" %>
<%@ Register src="~/controls/LoanAccounts/ctUnfreezeAccount.ascx" tagname="ctUnfreezeAccount" tagprefix="uc6" %>
<%@ Register src="~/controls/LoanAccounts/ctStatement.ascx" tagname="ctStatement" tagprefix="uc7" %>
<%@ Register src="~/controls/LoanAccounts/ctDefault.ascx" tagname="ctDefault" tagprefix="uc8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <div class="col-md-12">
            <div class="panel panel-default bootstrap-admin-no-table-panel">
                <div class="panel-heading">
                    <div class="text-muted bootstrap-admin-box-title">Account Management </div>
                </div>
                <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                    <div class="col-md-12 alert alert-info"  padding:8px">
                    <a class="close" data-dismiss="alert" href="#">×</a>
                    <span>Account Information</span>
                    <hr style="margin:2px 0;color:White" />
                    <div class="col-md-4">
                        <span class="text-warning">Client Name:</span> <span id="lblClienttName" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Client No.:</span><span id="lblClientNo" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Account No:</span> <span id="lblAccNo" runat="server"></span><br />
                    </div>
                    <div class="col-md-4">
                        <span class="text-warning">Loan Amount:</span> <span id="lblloanAmount" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Interest Rate:</span><span id="lblIntRate" runat="server"></span><br /> 
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Duration:</span><span id="lblDuration" runat="server"></span><br />  
                    </div> 
                    <div class="col-md-4">
                        <span class="text-warning">Outstanding Amt.:</span> <span id="lblAmtOutstanding" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Loan Type:</span> <span id="lblloantype" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Loan Date:</span> <span id="lblEmail" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <%--<span class="text-warning">Outstanding Amt.:</span> <span id="Span3" runat="server"></span><br />--%>
                    </div>     
        </div>
                </div>
                <%--<!-- Root Wizard for content -->--%>
                <div  class="col-md-12" id="rootwizard">
                    <div class="navbar col-md-3">
                        <div class="container_ col-md-12">
                            <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                <li><asp:LinkButton ID="btnAccStatement" runat="server" ><h6> Account Statement </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAssignCT" runat="server"><h6>  Re-Assign Credit Team </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAccTransfer" runat="server"><h6> Account Transfer </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAccRefreshment" runat="server"><h6> Account Refreshment </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAccMonitoring" runat="server"><h6> Account Monitoring </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnScheduledPayments" runat="server"><h6> Scheduled Payments </h6></asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnFreezeAcc" runat="server"><h6> (Un)Freeze Account </h6></asp:LinkButton></li>
                                <%--<li><asp:LinkButton ID="btnUnFreezeAcc" runat="server"><h6> Un-Freeze Account </h6></asp:LinkButton></li>    --%>                  
                            </ul>
                        </div>
                    </div>
                     <div class="tab-content col-md-9">
                        <div class="tab-pane_" id="tab1">
                            <uc4:ctScheduledPayments ID="ctScheduledPayments1" runat="server" />
                            <uc6:ctUnfreezeAccount ID="ctUnfreezeAccount1" runat="server" />
                            <uc5:ctTransfer ID="ctTransfer1" runat="server" />
                            <uc8:ctDefault ID="ctDefault1" runat="server" />
                            <uc2:ctMonitoring ID="ctMonitoring1" runat="server" />
                            <uc3:ctRefreshment ID="ctRefreshment1" runat="server" />
                            <uc1:ctFreezeAccount ID="ctFreezeAccount1" runat="server" />
                            <uc7:ctStatement ID="ctStatement1" runat="server" />
                        </div>
                     </div>
                </div>
            </div>
            
        </div>
    </div>
  <script type="text/javascript" language="javascript">
    $(document).ready(function() { 
        $('#rootwizard').bootstrapWizard({});
    });
    
  </script>
</asp:Content>

