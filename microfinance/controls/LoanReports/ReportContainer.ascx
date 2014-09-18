<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReportContainer.ascx.cs" Inherits="controls_LoanReports_ReportContainer" %>
<%@ Register src="rptClientMovement.ascx" tagname="rptClientMovement" tagprefix="uc1" %>
<%@ Register src="rptFinancialAging.ascx" tagname="rptFinancialAging" tagprefix="uc2" %>
<%@ Register src="rptPortfolioAging.ascx" tagname="rptPortfolioAging" tagprefix="uc3" %>
<%@ Register src="rptCreditBalance.ascx" tagname="rptCreditBalance" tagprefix="uc4" %>
<%@ Register src="rptDisbursement.ascx" tagname="rptDisbursement" tagprefix="uc5" %>
<%@ Register src="rptFrozenBalance.ascx" tagname="rptFrozenBalance" tagprefix="uc6" %>
<%@ Register src="rptLoanExpiry.ascx" tagname="rptLoanExpiry" tagprefix="uc7" %>
<%@ Register src="rptLargestExposure.ascx" tagname="rptLargestExposure" tagprefix="uc8" %>
<%@ Register src="rptpii.ascx" tagname="rptpii" tagprefix="uc9" %>
<%@ Register src="rptPBD.ascx" tagname="rptPBD" tagprefix="uc10" %>
<%@ Register src="rptPSR.ascx" tagname="rptPSR" tagprefix="uc11" %>
<%@ Register src="rptLoanRepayment.ascx" tagname="rptLoanRepayment" tagprefix="uc12" %>
<%@ Register src="rptPortfolioRpt.ascx" tagname="rptPortfolioRpt" tagprefix="uc13" %>
<%@ Register src="rptPSO.ascx" tagname="rptPSO" tagprefix="uc14" %>
<%@ Register src="rptScheduledPayment.ascx" tagname="rptScheduledPayment" tagprefix="uc15" %>
<div class="col-md-12">    
    <uc1:rptClientMovement ID="rptClientMovement1" runat="server" /> 
    <uc2:rptFinancialAging ID="rptFinancialAging1" runat="server" /> 
    <uc3:rptPortfolioAging ID="rptPortfolioAging1" runat="server" />
    <uc4:rptCreditBalance ID="rptCreditBalance1" runat="server" />
    <uc5:rptDisbursement ID="rptDisbursement1" runat="server" />
    <uc6:rptFrozenBalance ID="rptFrozenBalance1" runat="server" />
    <uc7:rptLoanExpiry ID="rptLoanExpiry1" runat="server" />
    <uc8:rptLargestExposure ID="rptLargestExposure1" runat="server" />
    <uc9:rptpii ID="rptpii1" runat="server" />
    <uc10:rptPBD ID="rptPBD1" runat="server" />
    <uc11:rptPSR ID="rptPSR1" runat="server" />
    <uc12:rptLoanRepayment ID="rptLoanRepayment1" runat="server" />
    <uc13:rptPortfolioRpt ID="rptPortfolioRpt1" runat="server" />
    <uc14:rptPSO ID="rptPSO1" runat="server" />
    <uc15:rptScheduledPayment ID="rptScheduledPayment1" runat="server" />
</div>










