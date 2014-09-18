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

public partial class controls_LoanReports_ReportContainer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["action"] != null)
        {
            string reportType=Request.QueryString["Action"];
            GetReport(reportType);
        }

    }

    public void GetReport(string reportType)
    {
        try
        {
            if (reportType == "")
            { setpanelsOff(); }
            else if (reportType == "agingportfolio")
            {
                setpanelsOff();
                this.rptPortfolioAging1.Visible = true;
            }
            else if (reportType == "clientmovement")
            {
                setpanelsOff();
                this.rptClientMovement1.Visible = true;
            }
            else if (reportType == "creditbalance")
            {
               
                setpanelsOff();
                this.rptCreditBalance1.Visible = true;
            }
            //else if (reportType == "clientmovement")
            //{
            //    setpanelsOff();
            //    this.rptClientMovement1.Visible = true;
            //}
            else if (reportType == "disbursement")
            {
                setpanelsOff();
                this.rptDisbursement1.Visible = true;
            }
            else if (reportType == "frozenbal")
            {
                setpanelsOff();
                this.rptFrozenBalance1.Visible = true;
            }
            else if (reportType == "largeexpo")
            {
                setpanelsOff();
                this.rptLargestExposure1.Visible = true;
            }
            else if (reportType == "loanexpiry")
            {

                setpanelsOff();
                this.rptLoanExpiry1.Visible = true;
            }
            else if (reportType == "pii")
            {
                setpanelsOff();
                this.rptpii1.Visible = true;
            }
            else if (reportType == "portfoliorpt")
            {
                setpanelsOff();
                this.rptPortfolioRpt1.Visible = true;

            }
            else if (reportType == "pso")
            {
                setpanelsOff();
                this.rptPSO1.Visible = true;

            }
            else if (reportType == "pbd")
            {
                setpanelsOff();
                this.rptPBD1.Visible = true;

            }
            else if (reportType == "psr")
            {
                setpanelsOff();
                this.rptPSR1.Visible = true;

            }
            else if (reportType == "repaymentrpt")
            {
                setpanelsOff();
                this.rptLoanRepayment1.Visible = true;
            }
            else if (reportType == "agingfinancial")
            {
                setpanelsOff();
                this.rptFinancialAging1.Visible = true;
            }
            else if (reportType == "schpayments")
            {
                setpanelsOff();
                this.rptScheduledPayment1.Visible = true;
            }

        }
        catch (Exception ex) { }
    
    }

    public void setpanelsOff()
    {
        this.rptFinancialAging1.Visible = false;
        this.rptClientMovement1.Visible = false;
        this.rptPortfolioAging1.Visible = false;
        this.rptCreditBalance1.Visible = false;
        this.rptDisbursement1.Visible = false;
        this.rptFrozenBalance1.Visible = false;
        this.rptLoanExpiry1.Visible = false;
        this.rptLargestExposure1.Visible = false;
        this.rptpii1.Visible = false;
        this.rptPBD1.Visible = false;
        this.rptLoanRepayment1.Visible = false;
        this.rptPSR1.Visible = false;
        this.rptPortfolioRpt1.Visible = false;
        this.rptPSO1.Visible = false;
        this.rptScheduledPayment1.Visible = false;
    }
}
