<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="approvedloans.aspx.cs"
    Inherits="pages_individualappraisal" Title="Approved Loans" %>

<%@ Register Src="~/controls/LoanApplications/appDetailRpt.ascx" TagName="ApplicationReport"
    TagPrefix="uc1" %>
<%@ Register Src="~/controls/LoanApplications/preagreement.ascx" TagName="preagreement"
    TagPrefix="uc2" %>
<%@ Register Src="~/controls/LoanApplications/SupportingDocRpt.ascx" TagName="supportingdocsRpt"
    TagPrefix="uc3" %>
<%@ Register Src="~/controls/LoanApplications/pdc.ascx" TagName="PDC" TagPrefix="uc4" %>
<%@ Register Src="~/controls/LoanApplications/declaration.ascx" TagName="Declaration"
    TagPrefix="uc5" %>
<%@ Register Src="~/controls/LoanApplications/PaymentPlan.ascx" TagName="PaymentPlan"
    TagPrefix="uc6" %>
<%@ Register Src="~/controls/LoanApplications/checklist.ascx" TagName="checklist"
    TagPrefix="uc10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
    function alertMessage()
    { 
        $.blockUI({ message: $('#<%=popup101.ClientID %>'), css: { width: '300px'} });
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
          <div class="container-fluid">
           
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
                            Risk&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnLegalAssessment" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=legal">
                            <span  id="legalinfo" runat="server" class="badge pull-right notif"></span>
                            Legal&#160;
                        </asp:LinkButton>
                   </li>
                   <%-- <li>
                        <asp:LinkButton ID="btnReview" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=review">
                            <span  id="reviewinfo" runat="server" class="badge pull-right notif"></span>
                            Review&#160;
                        </asp:LinkButton>
                    </li>--%>
                    <li>
                        <asp:LinkButton ID="btnApproval" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=approval">
                            <span  id="Apprinfo" runat="server" class="badge pull-right notif"></span>
                            Approvals&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="Approvedloans" runat="server" 
                            PostBackUrl="~/pages/loanapplications.aspx?action=approvedloans"><span 
                            id="Approvedinfo" runat="server" class="badge pull-right notif"></span>Approved Loans&#160; </asp:LinkButton>
                     </li> 
                    <li>
                        <asp:LinkButton ID="disbursement" runat="server" 
                            PostBackUrl="~/pages/loanapplications.aspx?action=disbursement"><span 
                            id="disbinfo" runat="server" class="badge pull-right notif"></span>Disbursement&#160; </asp:LinkButton>
                    </li>
                    
                  </ul>
                </div><!-- /.navbar-collapse -->
              </div><!-- /.container-fluid -->
        </nav>
        </asp:Panel>
        <asp:Panel ID="mPanelContent" runat="server">
            <div class="row">
                <div class="panel panel-default bootstrap-admin-no-table-panel">
                    <div class="panel-heading">
                        <div class="text-muted bootstrap-admin-box-title">
                            Approved Loans
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
                                <span class="text-warning">Application No:</span> <span id="lblAppNo" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Loan Amount:</span> <span id="loanAmount" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Interest Rate:</span> <span id="lblInterestRate" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Duration:</span> <span id="lblDuration" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Outstanding Amt.:</span> <span id="lblAmtOutstanding"
                                    runat="server"></span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Loan Type:</span> <span id="lblloantype" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Loan Date:</span> <span id="lblLoanDate" runat="server">
                                </span>
                                <br />
                            </div>
                        </div>
                        <div class="col-md-12" id="rootwizard" style="padding-left: 0">
                            <div class="navbar col-md-3" style="padding-left: 0; padding-right: 0;">
                                <div class="container col-md-12" style="padding-left: 0; padding-right: 0;">
                                    <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                        <li>
                                            <asp:LinkButton ID="btnAppDetails" runat="server"><h6>Application Details</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnSupDocs" runat="server"><h6>Supporting Documents </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnRepayment" runat="server"><h6>Repayment Schedule  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnPDC" runat="server"><h6>Post Dated Cheques </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnChecklist" runat="server"><h6>Checklist </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnDec" runat="server"><h6>Declaration </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnPreAgreement" runat="server"><h6>Pre Agreement </h6></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="tab-content col-md-9">
                                <div class="tab-pane_" id="tab1">
                                    <uc1:ApplicationReport ID="ApplicationReport1" runat="server" />
                                    <uc2:preagreement ID="preagreement1" runat="server" />
                                    <uc3:supportingdocsRpt ID="supportingdocs1" runat="server" />
                                    <uc5:Declaration ID="Declaration1" runat="server" />
                                    <uc4:PDC id="PDC1" runat="server" />
                                    <uc6:PaymentPlan ID="PaymentPlan1" runat="server" />
                                    <uc10:checklist ID="checklist1" runat="server" />
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
                            <div class="center col-md-10">
                                <div class="form-group">
                                    <asp:DropDownList ID="cmbAction" runat="server">
                                        <asp:ListItem>---Select Action --</asp:ListItem>
                                        <asp:ListItem>Forward Application</asp:ListItem>
                                        <asp:ListItem>Send Back For Review</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="btnFinalize" CssClass="btn btn-xs btn-primary col-md-2" runat="server"
                                        Text="Finalize" OnClick="btnFinalize_Click" />
                                </div>
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="modal-dialog" style="width: 298px">
            <div class="modal-content" style="display: none" runat="server" id="popup101">
                <div class="modal-header">
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

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
        $('#rootwizard').bootstrapWizard({});
        });
        
        function alertMessage()
        { 
            $.blockUI({ message: $('#<%=popup101.ClientID %>'), css: { width: '300px'} });
        }
        function closeAlert()
        {
            $.unblockUI();
        }
        function removeAlert()
        {
            $('#<%=btnRemoveAlert.ClientID%>').click(function() {
              $.blockUI();
              $.ajax({
                type: "POST",
                url: "approvedloans.aspx?action=removealert",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(msg) {
                    $.unblockUI();
                  }
                });
             });
        }
    </script>

</asp:Content>
