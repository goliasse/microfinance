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

public partial class pages_preapproved : System.Web.UI.Page
{
    public int currentTab
    {set;get;}
    public string ops
    {set;get;}
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {

       // ddlCreditTeam.SelectParameter["datTeamID"].DefaultValue = MySessionManager.CurrentUser.BranchID;

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        setNotifications();
        setUrls();
        showLoanAppInfo();

        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.AppID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(loanApp.getClientID(MySessionManager.AppID));
            showLoanAppInfo();


                }
        #region HideQueryString
        if (!(Request.QueryString["ops"] == null))
        {
            if (!(Request.QueryString["tab"] == null))
            {
                if (!(Request.QueryString["tab"] == ""))
                    currentTab = int.Parse(Request.QueryString["tab"]);
                else
                    currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
                ops = Request.QueryString["ops"].ToString();
                setTab();
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
                    currentTab = 0;
                ops = "load";
                setTab();
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
                currentTab = 0;
            setTab();
        } 
        #endregion

        if ((!(util.alert() == "")) && (MySessionManager.skipAlert == 0))
        {
            this.pAlertmsg.InnerText = util.alert();
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
    }
 
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter  loanApp1 = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int AppStage = Convert.ToInt32(loanApp1.getApplicationStatus(MySessionManager.AppID));
       

        if (cmbAction.Text == "Forward Application")
        {
            try
            {
                int ctID = Convert.ToInt32(ddlCreditTeam.SelectedValue);

                util.UpdateApplicationStatus("Forward Application", AppStage);
                LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
                loanApp.AssignCreditTeam(ctID, MySessionManager.AppID);
                Response.Redirect("~/pages/loanapplications.aspx", true);
            }
            catch (Exception ex) { }
        }
        else if (cmbAction.Text == "Send Back For Review")
        {
            util.UpdateApplicationStatus("Send Back For Review", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx", true);
        
        
            }
    }

    public void setNotifications()
    {
        try
        {
            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];

            this.initassinfo.InnerText = itemcount.intialassessment.ToString();
            this.preapprovedinfo.InnerText = itemcount.preapproval.ToString();
            this.Approvedinfo.InnerText = itemcount.approvedloans.ToString();
            this.Apprinfo.InnerText = (Convert.ToInt32(itemcount.approvalI.ToString()) + Convert.ToInt32(itemcount.approvalII.ToString()) + Convert.ToInt32(itemcount.approvalIII.ToString()) + Convert.ToInt32(itemcount.approvalIV.ToString()) + Convert.ToInt32(itemcount.approvalV.ToString())).ToString();
            this.Appraisalinfo.InnerText = itemcount.appraisal.ToString();
            this.legalinfo.InnerText = itemcount.legal.ToString();
            this.riskinfo.InnerText = itemcount.risk.ToString();
           // this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString())).ToString();
        }
        catch { }
    }

    public void setUrls()
    {
        this.btnPreAppRpt.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load";
        this.btnComment.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
    }

    public void setTab()
    {
        if (ops == "load")
        {
            loadSetTab();
        }
        else if (ops == "next")
        {
            this.currentTab++;
            if (currentTab < 5)
            {
                MySessionManager.CurrentTab = currentTab.ToString();
                loadSetTab();
            }
        }
        else if (ops == "previous")
        {
            this.currentTab--;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.loadSetTab();
        }
        else if (ops == "first")
        {
            this.currentTab = 1;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.loadSetTab();
        }
        else if (ops == "last")
        {
            this.currentTab = 4;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.loadSetTab();
        }
        else if (ops == null || ops == "")
        {
            if (currentTab == 0)
            {
                this.appDetailRpt1.Visible = true;
                this.comments1.Visible = false;
            }
        }
    }

    public void loadSetTab()
    {
        if (currentTab == 1)
        {
            this.appDetailRpt1.Visible = true;
            this.comments1.Visible = false;
        }
        else if (currentTab == 2)
        {
            this.appDetailRpt1.Visible = false;
            this.comments1.Visible = true;
        }
        else if (currentTab == 0)
        {
            this.appDetailRpt1.Visible = true;
            this.comments1.Visible = false;
        }
    }

    public void showLoanAppInfo()
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        if (tblLoanApp.Rows.Count > 0)
        {
            try
            {
                this.lblapplicantName.InnerText = client.GetClientsName(MySessionManager.ClientID).ToString();
                this.lblInterestRate.InnerText = tblLoanApp[0].datInterestRate.ToString("c").Replace("$", "") + "%";
                this.lblDuration.InnerText = tblLoanApp[0].datDuration.ToString() + " month(s)";
                this.lblAppNo.InnerText = tblLoanApp[0].datApplicationNumber.ToString();
                this.loanAmount.InnerText = tblLoanApp[0].datLoanAmount.ToString("c").Replace("$", "");
                this.lblloantype.InnerText = util.displayValue("opt_loan_types", tblLoanApp[0].datLoanType.ToString());
                this.lblClientNo.InnerText = client.GetClientNo(MySessionManager.ClientID).ToString();
            }
            catch (Exception ex)
            { }
        }

    }
}
