<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="appraisals.aspx.cs"
    Inherits="pages_appraisals" Title="Loan Appraisal Stage" %>

<%@ Register Src="~/controls/LoanApplications/personalInformation.ascx" TagName="personalInformation"
    TagPrefix="uc1" %>
<%@ Register Src="~/controls/LoanApplications/EmploymentDetails.ascx" TagName="EmploymentDetails"
    TagPrefix="uc2" %>
<%@ Register Src="~/controls/LoanApplications/NextOfKins.ascx" TagName="NextOfKins"
    TagPrefix="uc3" %>
<%@ Register Src="~/controls/LoanApplications/Fees.ascx" TagName="Fees" TagPrefix="uc4" %>
<%@ Register Src="~/controls/LoanApplications/LoanDetails.ascx" TagName="LoanDetails"
    TagPrefix="uc5" %>
<%@ Register Src="~/controls/LoanApplications/PaymentPlan.ascx" TagName="PaymentPlan"
    TagPrefix="uc6" %>
<%@ Register Src="~/controls/LoanApplications/SupportingDocs.ascx" TagName="SupportingDocs"
    TagPrefix="uc7" %>
<%@ Register Src="~/controls/LoanApplications/Bankers.ascx" TagName="Bankers" TagPrefix="uc8" %>
<%@ Register Src="~/controls/LoanApplications/Collaterals.ascx" TagName="Collaterals"
    TagPrefix="uc9" %>
<%@ Register Src="~/controls/LoanApplications/checklist.ascx" TagName="checklist"
    TagPrefix="uc10" %>
<%@ Register Src="~/controls/LoanApplications/creditinformation.ascx" TagName="creditinformation"
    TagPrefix="uc11" %>
<%@ Register Src="~/controls/LoanApplications/Guarantor_Referee.ascx" TagName="Guarantor_Referee"
    TagPrefix="uc12" %>
<%@ Register Src="~/controls/LoanApplications/assets.ascx" TagName="assets" TagPrefix="uc13" %>
<%@ Register Src="~/controls/LoanApplications/Initiator.ascx" TagName="Initiator"
    TagPrefix="uc14" %>
<%@ Register Src="~/controls/LoanApplications/CompanyDetails.ascx" TagName="CompanyDetails"
    TagPrefix="uc15" %>
<%@ Register Src="~/controls/LoanApplications/ownership.ascx" TagName="ownership"
    TagPrefix="uc16" %>
<%@ Register Src="~/controls/LoanApplications/financial.ascx" TagName="financial"
    TagPrefix="uc17" %>
<%@ Register Src="~/controls/LoanApplications/Employees.ascx" TagName="Employees"
    TagPrefix="uc18" %>
<%@ Register Src="~/controls/LoanApplications/financial.ascx" TagName="financial"
    TagPrefix="uc19" %>
<%@ Register Src="~/controls/LoanApplications/EnterpriseDetails.ascx" TagName="EnterpriseDetails"
    TagPrefix="uc20" %>
<%@ Register Src="~/controls/LoanApplications/IncomeExpeditures.ascx" TagName="IncomeExpeditures"
    TagPrefix="uc21" %>
<%@ Register Src="~/controls/LoanApplications/Auditors.ascx" TagName="Auditors" TagPrefix="uc22" %>
<%@ Register Src="~/controls/LoanApplications/applicationRpt.ascx" TagName="applicationRpt"
    TagPrefix="uc23" %>
<%@ Register Src="~/controls/LoanApplications/religion.ascx" TagName="ReligionDetails"
    TagPrefix="uc24" %>
<%@ Register Src="~/controls/LoanApplications/spouse.ascx" TagName="SpouseDetails"
    TagPrefix="uc25" %>
<%@ Register Src="~/controls/LoanApplications/LoanReport.ascx" TagName="LoanReport"
    TagPrefix="uc26" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
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
        PageMethods.removertalert();
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
          <div class="container-fluid">
            <!-- Collect the nav links, forms, and other content for toggling -->
              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf">
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
                            PostBackUrl="~/pages/loanapplications.aspx?action=disbursement">
                            <span id="disbinfo" runat="server" class="badge pull-right notif"></span>
                            Disbursement&#160; 
                        </asp:LinkButton>
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
                            Appraisals</div>
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
                                            <asp:LinkButton runat="server" ID="personal"><h6>Personal Info.</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="empDetails" runat="server"><h6>Employment Details  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton runat="server" ID="cdetails"><h6>Company Details </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton runat="server" ID="initiator"><h6>Initiator(s)</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="ents" runat="server"><h6>Enterprises</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="ldetails" runat="server"><h6>Loan Details </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="fees" runat="server"><h6>Fees </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="pplan" runat="server"><h6>Payment Plan </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="collateral" runat="server"><h6>Collaterals</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="asset" runat="server"><h6>Asset </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="creditinfo" runat="server"><h6>Credit Information </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="bankers" runat="server"><h6>Bankers</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton runat="server" ID="emps"><h6> Employees </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="owners" runat="server"><h6>Owners </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="ine" runat="server"><h6>Incomes &amp; Expenditures </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="spouse" runat="server"><h6>Spouse Details </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="reli" runat="server"><h6>Religion Details </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="nok" runat="server"><h6>Next Of Kin</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="financial" runat="server"><h6>Financial </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="auditors" runat="server"><h6>Auditors </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="refgua" runat="server"><h6>Guarantor/Referees </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="supportingdocs" runat="server"><h6>Supporting Documents </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="checklist" runat="server"><h6>Checklist </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="loanrpt" runat="server"><h6>Loan Report </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="appRpt" runat="server"><h6>Application Report </h6></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9 tab-content" style="min-height: 510px">
                                <div class="tab-pane_">
                                    <uc1:personalInformation ID="personalInformation1" runat="server" />
                                    <uc14:Initiator id="Initiator1" runat="server" />
                                    <uc15:CompanyDetails ID="CompanyDetails1" runat="server" />
                                    <uc18:Employees ID="Employees1" runat="server" />
                                    <uc20:EnterpriseDetails ID="EnterprisesDetails1" runat="server" />
                                    <uc21:IncomeExpeditures ID="IncomeExpeditures1" runat="server" />
                                    <uc2:EmploymentDetails id="EmploymentDetails1" runat="server" />
                                    <uc24:ReligionDetails ID="ReligionDetails1" runat="server" />
                                    <uc25:SpouseDetails ID="SpouseDetails1" runat="server" />
                                    <uc3:NextOfKins id="NextOfKins1" runat="server" />
                                    <uc5:LoanDetails ID="LoanDetails1" runat="server" />
                                    <uc4:Fees id="Fees1" runat="server" />
                                    <uc6:PaymentPlan ID="PaymentPlan1" runat="server" />
                                    <uc16:ownership id="ownership1" runat="server" />
                                    <uc9:Collaterals id="Collaterals1" runat="server" />
                                    <uc17:financial id="financial1" runat="server" />
                                    <uc22:Auditors id="Auditors1" runat="server" />
                                    <uc8:Bankers id="Bankers1" runat="server" />
                                    <uc11:creditinformation id="creditinformation1" runat="server" />
                                    <uc12:Guarantor_Referee id="Guarantor_Referee1" runat="server" />
                                    <uc13:assets id="assets1" runat="server" />
                                    <uc7:SupportingDocs id="SupportingDocs1" runat="server" />
                                    <uc10:checklist ID="checklist2" runat="server" />
                                    <uc23:applicationRpt ID="applicationRpt1" runat="server" />
                                    <uc26:LoanReport ID="LoanReport1" runat="server" />
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
                                <asp:DropDownList ID="cmbAction" runat="server">
                                    <asp:ListItem>---Select Action --</asp:ListItem>
                                    <asp:ListItem>Forward Application</asp:ListItem>
                                    <asp:ListItem>Forward To Risk</asp:ListItem>
                                    <asp:ListItem>Forward To Legal</asp:ListItem>
                                    <asp:ListItem>Send Back For Review</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="center form-group">
                                <asp:Button ID="btnFinalize" CssClass="btn btn-xs btn-primary col-md-2" runat="server"
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

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
        $('#rootwizard').bootstrapWizard({});
        });
    </script>

</asp:Content>
