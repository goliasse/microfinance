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
using System.Web.Services;

public partial class pages_invapplication_receipt : System.Web.UI.Page
{
    Utility util = new Utility();

    [WebMethod]
    public static void removertalert()
    {
        InvestmentDSTableAdapters.GetAlertTableAdapter alert = new InvestmentDSTableAdapters.GetAlertTableAdapter();
        alert.DeleteInvAlert(MySessionManager.InvAppID);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();

        //int DecID = Convert.ToInt32(EncID);

        
        #region "QueryString Block"
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.InvAppID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(invApp.GetClientID(MySessionManager.InvAppID));
        #endregion
            setNotifications();
        if ((!(util.alert1() == "")) && (MySessionManager.skipAlert == 0))
        {
            this.pAlertmsg.InnerText = util.alert1();
            // Define the name and type of the client scripts on the page.
            String csname1 = "PopupScript";
            String csname2 = "ButtonClickScript";
            Type cstype = this.GetType();

            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, csname1))
            {
                String cstext1 = "alertMessage();";
                cs.RegisterStartupScript(cstype, csname1, cstext1, true);
            }
            MySessionManager.skipAlert = 1;
        }
        showLoanAppInfo();
    }


    /// <summary>
    /// This function displays information about current application being worked
    /// </summary>
    public void showLoanAppInfo()
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
        InvestmentDS.GetInvestmentAppDataTable tblInvApp = invApp.GetInvestmentApp(MySessionManager.InvAppID);
        if (tblInvApp.Rows.Count > 0)
        {
            try
            {
                this.lblapplicantName.InnerText = client.GetClientsName(MySessionManager.ClientID).ToString();
                this.lblClientNo.InnerText = client.GetClientNo(MySessionManager.ClientID).ToString();
                if (tblInvApp[0].IsdatInvestmentAmountNull() == false) { this.lblInvestmentAmount.InnerText = tblInvApp[0].datInvestmentAmount.ToString("c").Replace("$", ""); }
                if (tblInvApp[0].IsdatInvestmentNameNull() == false) { this.lblInvestmentName.InnerText = tblInvApp[0].datInvestmentName.ToString(); }
                if (tblInvApp[0].IsdatTermsNull() == false) { this.lblTerm.InnerText = util.displayValue("opt_terms", tblInvApp[0].datTerms.ToString()) + " days"; }
                if (tblInvApp[0].IsdatApplicationNumberNull() == false) { this.lblAppNo.InnerText = tblInvApp[0].datApplicationNumber.ToString(); }
                if (tblInvApp[0].IsdatValueDateNull() == false) { this.lblValueDate.InnerText = tblInvApp[0].datValueDate.ToString("c").Replace("$", ""); }
                if (tblInvApp[0].IsdatInvestmentTypeNull() == false) { this.lblInvtype.InnerText = util.displayValue("opt_investment_types", tblInvApp[0].datInvestmentType.ToString()); }
                if (tblInvApp[0].IsdatFrequencyOfInterestPaymentNull() == false) { this.lblAccInterest.InnerText = tblInvApp[0].datFrequencyOfInterestPayment.ToString(); }

            }
            catch (Exception ex)
            { }
        }

    }
    public void setNotifications()
    {
        try
        {

            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];

            this.initInvinfo.InnerText = itemcount.initInterview.ToString();
            this.receiptinfo.InnerText = itemcount.receipts.ToString();
            this.certinfo.InnerText = itemcount.certification.ToString();
            //this.Apprinfo.InnerText = (Convert.ToInt32(itemcount.approvalI.ToString()) + Convert.ToInt32(itemcount.approvalII.ToString()) + Convert.ToInt32(itemcount.approvalIII.ToString()) + Convert.ToInt32(itemcount.approvalIV.ToString()) + Convert.ToInt32(itemcount.approvalV.ToString())).ToString();
            //this.Appraisalinfo.InnerText = itemcount.appraisal.ToString();
            //this.legalinfo.InnerText = itemcount.legal.ToString();
            //this.riskinfo.InnerText = itemcount.risk.ToString();
            //// this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            //this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString()) + (Convert.ToInt32(itemcount.disbursementIII.ToString()))).ToString();
        }
        catch
        { }
    }

}
