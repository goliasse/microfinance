using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class controls_LoanReports_ReportsCtrl : System.Web.UI.UserControl
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnRptAgingPortfolio_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=agingportfolio");
    }
    protected void btnRptClientMovement_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=clientmovement");
    }
    protected void btnRptCreditBal_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=creditbalance");
    }
    protected void btnRptDisbursement_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=disbursement");
    }
    protected void btnRptFrozenBal_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=frozenbal");
    }
    protected void btnRptLargeExp_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=largeexpo");
    }
    protected void btnRptLoanExpiry_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=loanexpiry");
    }
    protected void btnRptPII_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=pii");
    }
    protected void btnRptPortfolioRpt_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=portfoliorpt");
    }
    protected void btnRptPSO_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=pso");
    }
    protected void btnRptPBD_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=pbd");
    }
    protected void btnRptPSR_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=psr");
    }
    protected void btnRepaymentRpt_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=repaymentrpt");
    }
    protected void btnFinancialAging_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect (HttpContext.Current.Request.Url.AbsoluteUri +"?action=agingfinancial");
    }
    protected void btnSchPayments_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=schpayments");
    }
    protected void btnAccountListing_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=aclisting");
    }
    protected void btnClientConRatio_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=clientconration");
    }
    protected void btnCIS_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=cis");
    }
    protected void btnCustomerRanking_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=cranks");
    }
    protected void btnInvExpNotice_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=invexpnotice");
    }
    protected void btnFinTrans_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=fintrans");
    }
    protected void btnIntRedInv_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=intredinv");
    }
    protected void btnInvestmentStatus_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=invstatus");
    }
    protected void btnInvestment_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=investment");
    }
    protected void btnMaturityPortfolio_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=maturityportfolio");
    }
    protected void btnIntMaturity_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=intmaturity");
    }
    protected void btnNewInvestment_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=newinv");
    }
    protected void btnNewInvAnalysis_Click(object sender, EventArgs e)
    {
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri + "?action=schpayments");
    }
    protected void btnPeriodIntEarned_Click(object sender, EventArgs e)
    {

    }
    protected void btnRedemption_Click(object sender, EventArgs e)
    {

    }
    protected void btnRedemptionIss_Click(object sender, EventArgs e)
    {

    }
    protected void btnRepaymentCatInt_Click(object sender, EventArgs e)
    {

    }
    protected void btnRepaymentCatInvAmt_Click(object sender, EventArgs e)
    {

    }
    protected void btnRollOver_Click(object sender, EventArgs e)
    {

    }
    protected void btnTermsCatInt_Click(object sender, EventArgs e)
    {

    }
    protected void btnTermsCatInvAmt_Click(object sender, EventArgs e)
    {

    }
    protected void btnTermsRepayInt_Click(object sender, EventArgs e)
    {

    }
    protected void btnTermsRepayInvAmt_Click(object sender, EventArgs e)
    {

    }
    protected void btnWeightedAveInt_Click(object sender, EventArgs e)
    {

    }
}
