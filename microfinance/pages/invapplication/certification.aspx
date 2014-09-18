<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="certification.aspx.cs"
    Inherits="pages_invapplication_certification" Title="Certification" %>

<%@ Register src="../../controls/invapplications/invSummary.ascx" tagname="invSummary" tagprefix="uc1" %>
<%@ Register src="../../controls/invapplications/invcomments.ascx" tagname="invcomments" tagprefix="uc2" %>

<%@ Register src="../../controls/invapplications/advise.ascx" tagname="advise" tagprefix="uc3" %>

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
                        <asp:LinkButton ID="btnInitialAssesment" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=initInterview">
                            <span id="initInvinfo" runat="server" class="badge pull-right notif"></span>
                            Initial Interview&#160;
                        </asp:LinkButton>
                    </li>               
                    <li>
                        <asp:LinkButton ID="btnPreApproval" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=receipt">
                            <span id="receiptinfo" runat="server" class="badge pull-right notif"></span>
                            Receipts&#160; 
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnAppraisals" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=certification">
                            <span id="certinfo" runat="server" class="badge pull-right notif"></span>
                            Certification&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnApproved" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=approved">
                            <span id="Apprinfo" runat="server" class="badge pull-right notif"></span>
                            Approved&#160;
                        </asp:LinkButton>
                   </li>
                  <%--  <li>
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
                    </li>--%> 
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
                            Certification</div>
                    </div>
                    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                        <div class="col-md-12 alert alert-info" style="padding: 8px">
                            <a class="close" data-dismiss="alert" href="#">×</a> <span>Application 
                            Information</span>
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
                                <span class="text-warning">Application No:</span> <span id="lblAppNo" runat="server">
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
                                <span class="text-warning">Investment Name:</span> <span id="lblInvestmentName" runat="server"></span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Investment Type:</span> <span id="lblInvtype" runat="server"></span>
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
                                            <asp:LinkButton runat="server" ID="btnInvSummary"><h6>Investment Summary</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnInvAdvise" runat="server"><h6>Investment Advises </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnComments" runat="server"><h6>Comments  </h6></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9 tab-content">
                                <div class="tab-pane_" style="min-height: 450px">
                                    <!-- content -->
                                    <uc1:invSummary ID="invSummary1" runat="server" />
                                    <uc2:invcomments ID="invcomments1" runat="server" />
                                    <uc3:advise ID="advise1" runat="server" />
                                </div>
                                <ul class="pager wizard">
                                    <li class="previous first" style="display: none;">
                                        <asp:LinkButton ID="btnFirst" runat="server">First</asp:LinkButton></li>
                                    <li class="previous">
                                        <asp:LinkButton ID="btnPrevious" runat="server" OnClick="btnPrevious_Click">Previous</asp:LinkButton></li>
                                    <li class="next last" style="display: none;">
                                        <asp:LinkButton ID="btnLast" runat="server">Last</asp:LinkButton></li>
                                    <li class="next">
                                        <asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click">Next</asp:LinkButton></li>
                                    <li class="next finish" style="display: none;">
                                        <asp:LinkButton ID="btnFinish" runat="server">Finish</asp:LinkButton></li>
                                </ul>
                            </div>
                        </div>
                        <br style="clear: both" />
                        <div class="center col-md-10">
                            <div class="center form-group">
                                <asp:Button ID="btnFinalize" runat="server" CssClass="btn btn-xs btn-primary col-md-2"
                                    Text="Submit" OnClick="btnFinalize_Click" />
                            </div>
                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="modal-dialog" style="width: 298px">
            <div class="modal-content" style="display: none" runat="server" id="popup101">
                <div class="modal-header">
                    <%--<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>--%>
                    <h5 class="modal-title" id="myModalAlertLabel">
                        Alert On Account</h5>
                </div>
                <div class="modal-body">
                    <p runat="server" id="pAlertmsg">
                    </p>
                </div>
                <div class="modal-footer" style="height: 20px">
                    <button class="btn btn-xs btn-primary" id="btnRemoveAlert" runat="server" onclick="removeAlert()"
                        type="button">
                        Remove Alert</button>
                    <button class="btn btn-xs btn-default" onclick="closeAlert()" type="button">
                        Close</button>
                </div>
                <br />
                <br />
            </div>
        </div>
    </div>
</asp:Content>
