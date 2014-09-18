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

public partial class pages_invapplication_certification : System.Web.UI.Page
{
   
    Utility util = new Utility();
    public int currentTab { set; get; }
    public string ops { set; get; }
    [WebMethod]
    public static void removertalert()
    {
        InvestmentDSTableAdapters.GetAlertTableAdapter alert = new InvestmentDSTableAdapters.GetAlertTableAdapter();
        alert.DeleteInvAlert(MySessionManager.InvAppID);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        #region "QueryString Block"
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.InvAppID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(invApp.GetClientID(MySessionManager.InvAppID));
            if (!(Request.QueryString["ops"] == null))
            {
                if (!(Request.QueryString["tab"] == null))
                {
                    if (!(Request.QueryString["tab"] == ""))
                        currentTab = int.Parse(Request.QueryString["tab"]);
                    else
                        currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
                    ops = Request.QueryString["ops"].ToString();
                    setTab(currentTab);
                    MySessionManager.CurrentTab = currentTab.ToString();
                    MySessionManager.OpsTab = "load";

                    string urlpath = util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tab");
                    urlpath = util.RemoveQueryStringByKey(urlpath, "ops");
                    Response.Redirect(urlpath);
                }
                else
                {
                    if (!(Request.QueryString["tab"] == ""))
                        currentTab = int.Parse(Request.QueryString["tab"]);
                    else
                        currentTab = 1;

                    ops = "load";
                    setTab(currentTab);

                    MySessionManager.CurrentTab = currentTab.ToString();
                    MySessionManager.OpsTab = "load";
                    util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tab");
                    util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ops");
                }
            }
            else
            {
                ops = MySessionManager.OpsTab.ToString();

                //For handling the tabs
                if (!(MySessionManager.CurrentTab == ""))

                    currentTab = int.Parse(MySessionManager.CurrentTab);
                else
                    currentTab = 1;
                MySessionManager.CurrentTab = currentTab.ToString();
                setTab(currentTab);
            } 
        #endregion


            //For posting the alert that has been placed on the application
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
            setURLS();
        setNotifications();
        showLoanAppInfo();
    }

    /// <summary>
    /// Sets the links for the tabs to be directed to the desired page
    /// </summary>
    public void setURLS()
    {
        this.btnInvSummary.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load"; 
        this.btnInvAdvise.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load"; 
        this.btnComments.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load"; 
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
                if (tblInvApp[0].IsdatValueDateNull() == false) { this.lblValueDate.InnerText = tblInvApp[0].datValueDate.ToString("dd-MM-yyyy"); }
            }
            catch (Exception ex)
            { }
        }

    }

    /// <summary>
    /// This functions sets the notifications on the page
    /// </summary>
    public void setNotifications()
    {
        try
        {

            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];

            this.initInvinfo.InnerText = itemcount.initInterview.ToString();
            this.receiptinfo.InnerText = itemcount.receipts.ToString();
            this.certinfo.InnerText = itemcount.certification.ToString();
            this.Apprinfo.InnerText = itemcount.InvApproved.ToString();
                //this.Appraisalinfo.InnerText = itemcount.appraisal.ToString();
            //this.legalinfo.InnerText = itemcount.legal.ToString();
            //this.riskinfo.InnerText = itemcount.risk.ToString();
            //// this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            //this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString()) + (Convert.ToInt32(itemcount.disbursementIII.ToString()))).ToString();
        }
        catch
        { }
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
        {
            //this.ops = "previous";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            this.currentTab--;
            if (this.currentTab > 0)
            {
                MySessionManager.CurrentTab = currentTab.ToString();
                this.setTab(currentTab);
            }
        }
        else { MySessionManager.CurrentTab = "1"; setTab(Convert.ToInt32(MySessionManager.CurrentTab)); }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
        {
            //this.ops = "previous";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            this.currentTab++;
            if (this.currentTab < 4)
            {
                MySessionManager.CurrentTab = currentTab.ToString();
                this.setTab(currentTab);
            }
        }
        else { MySessionManager.CurrentTab = "1"; setTab(Convert.ToInt32(MySessionManager.CurrentTab)); }
    }
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        try
        {
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateApplicationStatus(4, MySessionManager.InvAppID);
            Response.Redirect("~/pages/invapplications.aspx");

        }
        catch (Exception ex) { }
    }

    public void setTab(int id)
    {
        try
        {
            if (id == 1) 
            {
                this.invcomments1.Visible =false;
                this.invSummary1.Visible =true;
                this.advise1.Visible = false;
            }
            else if (id == 2)
            {
                this.invcomments1.Visible = false;
                this.invSummary1.Visible = false;
                this.advise1.Visible = true;
            }
            else if (id == 3)
            {
                this.invcomments1.Visible = true;
                this.invSummary1.Visible = false;
                this.advise1.Visible = false;
            }
            else
            {
                this.invcomments1.Visible = false;
                this.invSummary1.Visible = true;
                this.advise1.Visible = false;
            }
        }
        catch (Exception ex) { }
    }
}
