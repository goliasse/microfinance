<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="accountrefreshment.aspx.cs" Inherits="pages_accountrefreshment" Title="Account Refreshment" %>
<%@ Register src="~/controls/LoanApplications/personalInformation.ascx" tagname="personalInformation" tagprefix="uc1" %>
<%@ Register src="~/controls/LoanApplications/EmploymentDetails.ascx" tagname="EmploymentDetails" tagprefix="uc2" %>
<%@ Register src="~/controls/LoanApplications/NextOfKins.ascx" tagname="NextOfKins" tagprefix="uc3" %>
<%@ Register src="~/controls/LoanApplications/Fees.ascx" tagname="Fees" tagprefix="uc4" %>
<%@ Register src="~/controls/LoanApplications/LoanDetails.ascx" tagname="LoanDetails" tagprefix="uc5" %>
<%@ Register src="~/controls/LoanApplications/PaymentPlan.ascx" tagname="PaymentPlan" tagprefix="uc6" %>
<%@ Register src="~/controls/LoanApplications/SupportingDocs.ascx" tagname="SupportingDocs" tagprefix="uc7" %>
<%@ Register src="~/controls/LoanApplications/Bankers.ascx" tagname="Bankers" tagprefix="uc8" %>
<%@ Register src="~/controls/LoanApplications/Collaterals.ascx" tagname="Collaterals" tagprefix="uc9" %>
<%@ Register src="~/controls/LoanApplications/checklist.ascx" tagname="checklist" tagprefix="uc10" %>
<%@ Register src="~/controls/LoanApplications/creditinformation.ascx" tagname="creditinformation" tagprefix="uc11" %>
<%@ Register src="~/controls/LoanApplications/Guarantor_Referee.ascx" tagname="Guarantor_Referee" tagprefix="uc12" %>
<%@ Register src="~/controls/LoanApplications/assets.ascx" tagname="assets" tagprefix="uc13" %>
<%@ Register src="~/controls/LoanApplications/Initiator.ascx" tagname="Initiator" tagprefix="uc14" %>
<%@ Register src="~/controls/LoanApplications/CompanyDetails.ascx" tagname="CompanyDetails" tagprefix="uc15" %>
<%@ Register src="~/controls/LoanApplications/ownership.ascx" tagname="ownership" tagprefix="uc16" %>
<%@ Register src="~/controls/LoanApplications/financial.ascx" tagname="financial" tagprefix="uc17" %>
<%@ Register src="~/controls/LoanApplications/Employees.ascx" tagname="Employees" tagprefix="uc18" %>
<%@ Register src="~/controls/LoanApplications/financial.ascx" tagname="financial" tagprefix="uc19" %>
<%@ Register src="~/controls/LoanApplications/EnterpriseDetails.ascx" tagname="EnterpriseDetails" tagprefix="uc20" %>
<%@ Register src="~/controls/LoanApplications/IncomeExpeditures.ascx" tagname="IncomeExpeditures" tagprefix="uc21" %>
<%@ Register src="~/controls/LoanApplications/Auditors.ascx" tagname="Auditors" tagprefix="uc22" %>
<%@ Register src="~/controls/LoanApplications/applicationRpt.ascx" tagname="applicationRpt" tagprefix="uc23" %>
<%@ Register src="~/controls/LoanApplications/religion.ascx" tagname="ReligionDetails" tagprefix="uc24" %>
<%@ Register src="~/controls/LoanApplications/spouse.ascx" tagname="SpouseDetails" tagprefix="uc25" %>
<%@ Register src="~/controls/LoanApplications/LoanReport.ascx" tagname="LoanReport" tagprefix="uc26" %>

<%@ Register src="~/controls/LoanAccounts/ctRefreshment.ascx" tagname="ctRefreshment" tagprefix="uc27" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
    <asp:Panel ID="mPanelContent" runat="server">
        <div class="row">
        <div class="panel panel-default bootstrap-admin-no-table-panel">
            <div class="panel-heading">
                <div class="text-muted bootstrap-admin-box-title">Appraisals</div>
            </div>
            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
           <div class="col-md-12 alert alert-info"  padding:8px">
                    <a class="close" data-dismiss="alert" href="#">×</a>
                    <span>Application Information</span>
                    <hr style="margin:2px 0;color:White" />
                    <div class="col-md-4">
                        <span class="text-warning">Client Name:</span> <span id="lblapplicantName" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                         <span class="text-warning">Client No:</span> <span id="lblClientNo" runat="server"></span><br />
                         <hr style="margin:2px 0" />
                         <span class="text-warning">Application No:</span> <span id="lblAppNo" runat="server"></span><br />
                    </div>
                    <div class="col-md-4">
                        <span class="text-warning">Loan Amount:</span> <span id="loanAmount" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Interest Rate:</span> <span id="lblInterestRate" runat="server"></span><br />
                         <hr style="margin:2px 0" />
                        <span class="text-warning">Duration:</span> <span id="lblDuration" runat="server"></span><br />
                       
                    </div> 
                    <div class="col-md-4">
                        <span class="text-warning">Outstanding Amt.:</span> <span id="lblAmtOutstanding" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Loan Type:</span> <span id="lblloantype" runat="server"></span><br />
                        <hr style="margin:2px 0" />
                        <span class="text-warning">Loan Date:</span> <span id="lblLoanDate" runat="server"></span><br />
                       
                    </div>
                 </div> 
                <div  class="col-md-12" id="rootwizard">
                    <div class="col-md-3">
                        <div class="container col-md-12">
                            <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                <li ><asp:LinkButton runat="server" id="ctRefresh"><h6>Refreshment Details</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="personal"><h6>Personal Info.</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="empDetails" runat="server"><h6>Employment Details  </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="initiator"><h6>Initiator(s)</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="cdetails"><h6>Company Details </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="ents" runat="server"><h6>Enterprises</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="ldetails" runat="server"><h6>Loan Details </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="fees" runat="server"><h6>Fees </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="pplan" runat="server"><h6>Payment Plan </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="collateral" runat="server"><h6>Collaterals</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="asset" runat="server"><h6>Asset </h6></asp:LinkButton></li>  
                                <li ><asp:LinkButton id="creditinfo" runat="server"><h6>Credit Information </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="bankers" runat="server"><h6>Bankers</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="emps"><h6> Employees </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="owners" runat="server"><h6>Owners </h6></asp:LinkButton></li>                         
                                 <li ><asp:LinkButton id="ine" runat="server"><h6>Incomes &amp; Expenditures </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="spouse" runat="server"><h6>Spouse Details </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="reli" runat="server"><h6>Religion Details </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="nok" runat="server"><h6>Next Of Kin</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="financial" runat="server"><h6>Financial </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="auditors" runat="server"><h6>Auditors </h6></asp:LinkButton></li>                 
                                <li ><asp:LinkButton id="refgua" runat="server"><h6>Guarantor/Referees </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="supportingdocs" runat="server"><h6>Supporting Documents </h6></asp:LinkButton></li>                                
                                <li ><asp:LinkButton id="checklist" runat="server"><h6>Checklist </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="loanrpt" runat="server"><h6>Loan Report </h6></asp:LinkButton></li> 
                                <li ><asp:LinkButton id="appRpt" runat="server"><h6>Application Report </h6></asp:LinkButton></li>                                
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-9 tab-content">
                        <div class="tab-pane_">
                            <uc27:ctRefreshment ID="ctRefreshment1" runat="server" />
                            <uc1:personalInformation ID="personalInformation1" runat="server" />
                            <uc14:Initiator ID="Initiator1" runat="server" />
                            <uc15:CompanyDetails ID="CompanyDetails1" runat="server" />
                            <uc18:Employees ID="Employees1" runat="server" />
                            <uc20:EnterpriseDetails ID="EnterprisesDetails1" runat="server" />
                            <uc21:IncomeExpeditures ID="IncomeExpeditures1" runat="server" />
                            <uc2:EmploymentDetails ID="EmploymentDetails1" runat="server" />
                            <uc24:ReligionDetails ID="ReligionDetails1" runat="server" />
                            <uc25:SpouseDetails ID="SpouseDetails1" runat="server" />
                            <uc3:NextOfKins ID="NextOfKins1" runat="server" />
                            <uc5:LoanDetails ID="LoanDetails1" runat="server" />
                            <uc4:Fees ID="Fees1" runat="server" />
                            <uc6:PaymentPlan ID="PaymentPlan1" runat="server" />
                            <uc16:ownership ID="ownership1" runat="server" />
                            <uc9:Collaterals ID="Collaterals1" runat="server" /> 
                            <uc17:financial ID="financial1" runat="server" />
                            <uc22:Auditors ID="Auditors1" runat="server" />
                            <uc8:Bankers ID="Bankers1" runat="server" />
                            <uc11:creditinformation ID="creditinformation1" runat="server" />
                            <uc12:Guarantor_Referee ID="Guarantor_Referee1" runat="server" />
                            <uc13:assets ID="assets1" runat="server" />
                            <uc7:SupportingDocs ID="SupportingDocs1" runat="server" />
                            <uc10:checklist ID="checklist2" runat="server" />
                            <uc23:applicationRpt ID="applicationRpt1" runat="server" />
                            <uc26:LoanReport ID="LoanReport1" runat="server" />  
                        </div>
                        <ul class="pager wizard">
                            <li class="previous first" style="display:none;"><asp:LinkButton ID="btnFirst" runat="server">First</asp:LinkButton></li>
                            <li class="previous"><asp:LinkButton ID="btnPrevious" runat="server" 
                                    onclick="btnPrevious_Click">Previous</asp:LinkButton></li>
                            <li class="next last" style="display:none;"><asp:LinkButton ID="btnLast" runat="server">Last</asp:LinkButton></li>
                            <li class="next"><asp:LinkButton ID="btnNext" runat="server" 
                                    onclick="btnNext_Click">Next</asp:LinkButton></li>
                            <li class="next finish" style="display:none;"><asp:LinkButton ID="btnFinish" runat="server">Finish</asp:LinkButton></li>                          
                        </ul>
                    </div>
                    
           </div>
           <br style="clear:both" /> 
           <%--<div class="center col-md-10">
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
                    <asp:Button ID="btnFinalize" CssClass="btn btn-sm btn-primary" runat="server" 
                        Text="Finalize" onclick="btnFinalize_Click" /> 
                </div>
           </div>--%>
           <br /> 
                          
            </div>
        </div>                 
    </div>
    </asp:Panel>
    
 </div>
</asp:Content>

