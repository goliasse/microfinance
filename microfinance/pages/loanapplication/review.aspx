<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="review.aspx.cs" Inherits="pages_loanapplication_review" Title="Applications to be reviewed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
        <nav class="navbar navbar-default" role="navigation">
          <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
           <%-- <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </button>
              <a class="navbar-brand" href="#"></a>
            </div>--%>

            <!-- Collect the nav links, forms, and other content for toggling -->
             <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle">
                    <li>
                        <asp:LinkButton ID="btnInitialAssesment" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=initialassesment">
                            <span id="initassinfo" runat="server" class="badge pull-right notif"></span>
                            Initial Assesment&#160;
                        </asp:LinkButton>
                    </li>               
                    <li>
                        <asp:LinkButton ID="btnPreApproval" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=preapproved">
                            <span id="preapprovedinfo" runat="server" class="badge pull-right notif"></span>
                            Pre Approved&#160; 
                        </asp:LinkButton>
                   </li>
                      
                    <li>
                        <asp:LinkButton ID="btnAppraisals" runat="server"  PostBackUrl="~/pages/loanapplications.aspx?action=appraisals">
                            <span id="Appraisalinfo" runat="server" class="badge pull-right notif"></span>
                            Appraisals &#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnRiskAssessment" runat="server"  PostBackUrl="~/pages/loanapplications.aspx?action=risk">
                            <span id="riskinfo" runat="server" class="badge pull-right notif"></span>
                            Risk Assessment&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnLegalAssessment" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=legal">
                            <span  id="legalinfo" runat="server" class="badge pull-right notif"></span>
                            Legal Assessment&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnReview" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=review">
                            <span  id="reviewinfo" runat="server" class="badge pull-right notif"></span>
                            Review&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnApproval" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=approval">
                            <span  id="Apprinfo" runat="server" class="badge pull-right notif"></span>
                            Approvals&#160;
                        </asp:LinkButton>
                    </li> 
                    <li>
                        <asp:LinkButton ID="disbursement" runat="server" 
                            PostBackUrl="~/pages/loanapplications.aspx?action=disbursement"><span 
                            id="disbinfo" runat="server" class="badge pull-right notif"></span>Disbursement&#160; </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnApprovedloans" runat="server" 
                            PostBackUrl="~/pages/loanapplications.aspx?action=approvedloans"><span 
                            id="Approvedinfo" runat="server" class="badge pull-right notif"></span>Approved Loans&#160; </asp:LinkButton>
                     </li>
                  </ul>
                </div><!-- /.navbar-collapse -->
             </div><!-- /.container-fluid -->
        </nav>
    </asp:Panel>
    
    </div>
</asp:Content>

