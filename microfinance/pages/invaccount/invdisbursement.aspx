<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="invdisbursement.aspx.cs"
    Inherits="pages_invaccount_invdisbursement" Title="Untitled Page" %>

<%@ Register src="../../controls/invaccounts/editpaymentvoucher.ascx" tagname="editpaymentvoucher" tagprefix="uc1" %>
<%@ Register src="../../controls/invaccounts/paymentvoucher.ascx" tagname="paymentvoucher" tagprefix="uc2" %>
<%@ Register src="../../controls/invaccounts/paymentvoucherRpt.ascx" tagname="paymentvoucherRpt" tagprefix="uc3" %>

<%@ Register src="../../controls/invaccounts/InvSummary.ascx" tagname="InvSummary" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf1">
                    <li>
                        <asp:LinkButton ID="btnRiskAssessment" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=intMaturity">
                            <span id="intmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Interest Maturity&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnLegalAssessment" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=invmaturity">
                            <span  id="invmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Investment Maturity&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnApproval" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=matured">
                            <span  id="Apprinfo" runat="server" class="badge pull-right notif"></span>
                            Matured&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnInvDisbursement" runat="server" PostBackUrl="~/pages/investmentaccount.aspx?action=matured">
                            <span  id="invdisbInfo" runat="server" class="badge pull-right notif"></span>
                            Disbursement&#160;
                        </asp:LinkButton>
                    </li> 
                  </ul>
                </div><!-- /.navbar-collapse -->
                  
              </div><!-- /.container-fluid -->
            </nav>
        </asp:Panel>
        <asp:Panel ID="row" runat="server">
            <div class="row">
                <div class="panel panel-default bootstrap-admin-no-table-panel">
                    <div class="panel-heading">
                        <div class="text-muted bootstrap-admin-box-title">
                            Interest Maturity
                        </div>
                    </div>
                    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                        <div class="col-md-12 alert alert-info" style="padding: 8px">
                            <a class="close" data-dismiss="alert" href="#">×</a> <span>Application Information</span>
                            <hr style="margin: 2px 0; color: White" />
                            <div class="col-md-4">
                                <span class="text-warning">Client Name:</span> <span id="lblapplicantName" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Client No:</span> <span id="lblClientNo" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Account No:</span> <span id="lblAccNo" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Amount:</span> <span id="lblInvestmentAmount"
                                    runat="server"></span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Accrued Interest:</span> <span id="lblAccInterest" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Terms:</span> <span id="lblTerm" runat="server"></span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Name:</span> <span id="lblInvestmentName" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Investment Type:</span> <span id="lblInvtype" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Date:</span> <span id="lblValueDate" runat="server"></span>
                                <br />
                            </div>
                        </div>
                        <div class="col-md-12" id="rootwizard" style="padding-left: 0">
                            <div class="navbar col-md-3" style="padding-left: 0; padding-right: 0;">
                                <div class="container col-md-12" style="padding-left: 0; padding-right: 0;">
                                    <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                        <li>
                                            <asp:LinkButton runat="server" ID="btnIntMatPayout"><h6>Interest Maturity Pay Out</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnAccComments" runat="server"><h6>Comments  </h6></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9 tab-content">
                                <div class="tab-pane_" style="min-height: 450px">
                                    <%--Put Content Here --%>
                                    <uc4:InvSummary ID="InvSummary1" runat="server" />
                                    <uc3:paymentvoucherRpt ID="paymentvoucherRpt1" runat="server" />
                                    <uc2:paymentvoucher ID="paymentvoucher1" runat="server" />
                                    <uc1:editpaymentvoucher ID="editpaymentvoucher1" runat="server" />
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
