<%@ Page Language="C#" MasterPageFile="~/backend/MasterPage.master" AutoEventWireup="true" CodeFile="parameters.aspx.cs" Inherits="backend_pages_parameters" Title="Parameters" %>
<%@ Register src="~/backend/controls/area.ascx" tagname="area" tagprefix="uc1" %>
<%@ Register src="~/backend/controls/assettype.ascx" tagname="assettype" tagprefix="uc2" %>
<%@ Register src="~/backend/controls/branch.ascx" tagname="branch" tagprefix="uc3" %>
<%@ Register src="~/backend/controls/creditteams.ascx" tagname="creditteams" tagprefix="uc4" %>
<%@ Register src="~/backend/controls/feepayment.ascx" tagname="feepayment" tagprefix="uc5" %>
<%@ Register src="~/backend/controls/feetype.ascx" tagname="feetype" tagprefix="uc6" %>
<%@ Register src="~/backend/controls/checklistItems.ascx" tagname="checklistItems" tagprefix="uc7" %>
<%@ Register src="~/backend/controls/collateraltypes.ascx" tagname="collateraltypes" tagprefix="uc8" %>
<%@ Register src="~/backend/controls/finacctypes.ascx" tagname="finacctypes" tagprefix="uc9" %>
<%@ Register src="~/backend/controls/identificationtypes.ascx" tagname="identificationtypes" tagprefix="uc10" %>
<%@ Register src="~/backend/controls/industry.ascx" tagname="industry" tagprefix="uc11" %>
<%@ Register src="~/backend/controls/institutes.ascx" tagname="institutes" tagprefix="uc12" %>
<%@ Register src="~/backend/controls/interestratetypes.ascx" tagname="interestratetypes" tagprefix="uc13" %>
<%@ Register src="~/backend/controls/ledgers.ascx" tagname="ledgers" tagprefix="uc14" %>
<%@ Register src="~/backend/controls/loancategories.ascx" tagname="loancategories" tagprefix="uc15" %>
<%@ Register src="~/backend/controls/loanpurpose.ascx" tagname="loanpurpose" tagprefix="uc16" %>
<%@ Register src="~/backend/controls/nationalities.ascx" tagname="nationalities" tagprefix="uc17" %>
<%@ Register src="~/backend/controls/premisesstatutes.ascx" tagname="premisesstatutes" tagprefix="uc18" %>
<%@ Register src="~/backend/controls/regions.ascx" tagname="regions" tagprefix="uc19" %>
<%@ Register src="~/backend/controls/maritalstatuses.ascx" tagname="maritalstatuses" tagprefix="uc20" %>
<%@ Register src="~/backend/controls/titles.ascx" tagname="titles" tagprefix="uc21" %>
<%@ Register src="~/backend/controls/roles.ascx" tagname="roles" tagprefix="uc22" %>
<%@ Register src="~/backend/controls/investmentcategory.ascx" tagname="investmentcategory" tagprefix="uc23" %>
<%@ Register src="~/backend/controls/bulletinboard.ascx" tagname="bulletinboard" tagprefix="uc24" %>
<%@ Register src="~/backend/controls/repaymentthreshold.ascx" tagname="repaymentthreshold" tagprefix="uc25" %>
<%@ Register src="~/backend/controls/loantypes.ascx" tagname="loantypes" tagprefix="uc26" %>

<%@ Register src="~/backend/controls/checklistcat.ascx" tagname="checklistcat" tagprefix="uc27" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                <div  class="col-md-12" id="rootwizard">
                    <div class="nav-bar col-md-3">
                        <div class="container col-md-12">
                            <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                <li ><asp:LinkButton runat="server" id="areas"><h6>Areas</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="assetTypes"><h6>Asset Types</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="branch"><h6>Branch</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="btnChklistCat"><h6>Check List Categories</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton runat="server" id="bulletin"><h6> Bulletin Board </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="chklist" runat="server"><h6>Check List Items</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnColl" runat="server"><h6>Collateral Types </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnCT" runat="server"><h6>Credit Teams  </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnPayment" runat="server"><h6>Fee Payment Modes </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnFeeTypes" runat="server"><h6>Fee Types </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnFinAcTypes" runat="server"><h6>Finance Acc Types</h6></asp:LinkButton></li>
                              <%--  <li ><asp:LinkButton id="btnFrequencies" runat="server"><h6>Frequencies </h6></asp:LinkButton></li>--%>
                                <li ><asp:LinkButton id="btnHearAbt" runat="server"><h6>Hear About Us </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnIDTypes" runat="server"><h6>Identification Types</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnIndustry" runat="server"><h6>Industry </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnInstitutes" runat="server"><h6>Institutes</h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnIntRate" runat="server"><h6>Interest Rates Types </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnInvCat" runat="server"><h6>Investment Category </h6></asp:LinkButton></li>                           
                                <li ><asp:LinkButton id="btnLedgers" runat="server"><h6>Ledgers </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnLoanCat" runat="server"><h6>Loan Categories </h6></asp:LinkButton></li>                 
                                <li ><asp:LinkButton id="btnLoanPurpose" runat="server"><h6>Loan Purpose </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnLoanTypes" runat="server"><h6>Loan Types </h6></asp:LinkButton></li>                                
                                <li ><asp:LinkButton id="btnMaritalStatuses" runat="server"><h6>Marital Statuses </h6></asp:LinkButton></li>                                
                                <li ><asp:LinkButton id="btnPremStatuses" runat="server"><h6>Premises Statuses </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnRegion" runat="server"><h6>Region </h6></asp:LinkButton></li> 
                                <li ><asp:LinkButton id="btnRepayment" runat="server"><h6>Repayment Thresholds</h6></asp:LinkButton></li>      
                                <li ><asp:LinkButton id="btnRoles" runat="server"><h6>Roles </h6></asp:LinkButton></li>
                                <li ><asp:LinkButton id="btnTitles" runat="server"><h6>Titles </h6></asp:LinkButton></li>                          
                            </ul>
                        </div>
                        
                    </div>
                    <div class="col-md-9 tab-content">
                        <div>   
                            <uc1:area ID="area1" runat="server" />
                            <uc2:assettype ID="assettype1" runat="server" />
                            <uc20:maritalstatuses ID="maritalstatuses1" runat="server" />
                            <uc19:regions ID="regions1" runat="server" />
                            <uc18:premisesstatutes ID="premisesstatutes1" runat="server" />
                            <uc17:nationalities ID="nationalities1" runat="server" />
                            <uc16:loanpurpose ID="loanpurpose1" runat="server" />
                            <uc15:loancategories ID="loancategories1" runat="server" />
                            <uc14:ledgers ID="ledgers1" runat="server" />
                            <uc13:interestratetypes ID="interestratetypes1" runat="server" />
                            <uc12:institutes ID="institutes1" runat="server" />
                            <uc11:industry ID="industry1" runat="server" />
                            <uc3:branch ID="branch1" runat="server" /> 
                            <uc4:creditteams ID="creditteams1" runat="server" />
                            <uc5:feepayment ID="feepayment1" runat="server" />
                            <uc6:feetype ID="feetype1" runat="server" />
                            <uc7:checklistItems ID="checklistItems1" runat="server" />
                            <uc8:collateraltypes ID="collateraltypes1" runat="server"/>
                            <uc9:finacctypes ID="finacctypes1" runat="server" />
                            <uc10:identificationtypes ID="identificationtypes1" runat="server" />
                            <uc22:roles ID="roles1" runat="server" />
                            <uc23:investmentcategory ID="investmentcategory1" runat="server" />
                            <uc26:loantypes ID="loantypes1" runat="server" />
                            <uc25:repaymentthreshold ID="repaymentthreshold1" runat="server" />
                            <uc21:titles ID="titles1" runat="server" />
                            <uc24:bulletinboard ID="bulletinboard1" runat="server" />
                            <uc27:checklistcat ID="checklistcat1" runat="server" />
                        </div>
                        <ul class="pager wizard">
                            <li class="previous first" style="display:none;"><a href="javascript:void(0);">First</a></li>
                            <li class="previous"><a href="javascript:void(0);">Previous</a></li>
                            <li class="next last" style="display:none;"><a href="javascript:void(0);">Last</a></li>
                            <li class="next"><a href="javascript:void(0);">Next</a></li>
                            <li class="next finish" style="display:none;"><a href="javascript:;">Finish</a></li>                               
                            
                        </ul>
                    </div>   
                    
           </div> 
           <br />                 
            </div>
    </div>
    
</asp:Content>

