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

public partial class pages_approvals : System.Web.UI.Page
{
    public int currentTab{set;get;}
    public string ops{set;get;}
    Utility util = new Utility();

    [WebMethod]
    public static void removertalert()
    {
        LoanDSTableAdapters.AlertLogsTableAdapter alert = new LoanDSTableAdapters.AlertLogsTableAdapter();
        alert.RemoveAlert(MySessionManager.AppID);

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (MySessionManager.CurrentUser.BranchID <= 0)
                Response.Redirect("~/login.aspx");
        }
        catch
        {
            Response.Redirect("~/login.aspx");
        }
        showLoanAppInfo();
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();

        if (!(this.IsPostBack))
        {
            this.lbtnAppDetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load"; ;
            this.lbtnSupDocs.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load"; ;
            this.lbtnComments.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
            this.lbtnAppRpts.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
        }
       
        setNotifications();

        #region QueryStringSection
        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.AppID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(loanApp.getClientID(MySessionManager.AppID));
            //int DecID = Convert.ToInt32(EncID);
            showLoanAppInfo();
        }
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

        setApprovalLimit(MySessionManager.CurrentUser.RoleID);

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



    public void setNotifications()
    {

        mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
        mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID,MySessionManager.CurrentUser.TeamID)[0];

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

    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp1 = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int AppStage = Convert.ToInt32(loanApp1.getApplicationStatus(MySessionManager.AppID));
        Utility utilClass = new Utility();

        if (cmbAction.Text == "Forward Application")
        {
            utilClass.UpdateApplicationStatus("Forward Application", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
        }
        else if (cmbAction.Text == "Approve Loan")
        {
            utilClass.UpdateApplicationStatus("Forward to Approved Loans", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
        }
        else if (cmbAction.Text == "Send Back For Review")
        {
            utilClass.UpdateApplicationStatus("Send Back For Review To Appraisal", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
        }
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
            else
            { ShowMessageBox("You are on the last tab"); btnNext.Visible = false; }
        }
        else if (ops == "previous")
        {
            this.currentTab--;
            if (currentTab > 0)
            {
                MySessionManager.CurrentTab = currentTab.ToString();
                this.loadSetTab();
            }
            else {ShowMessageBox("You are on the first tab"); btnPrevious.Visible = false; }
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
                applicationRpt1.Visible = true;
                SupportingDocRpt1.Visible = false;
                comments1.Visible = false;
                appReport1.Visible = false;
            }
        }
    }

    public void loadSetTab()
    {
        if (currentTab == 1)
        {
            applicationRpt1.Visible = true;
            SupportingDocRpt1.Visible = false;
            comments1.Visible = false;
            appReport1.Visible = false;
        }
        else if (currentTab == 2)
        {
            applicationRpt1.Visible = false ;
            SupportingDocRpt1.Visible = false;
            comments1.Visible = false;
            appReport1.Visible = true;
        }
        else if (currentTab == 3)
        {
            applicationRpt1.Visible = false ;
            SupportingDocRpt1.Visible = true;
            comments1.Visible = false ;
            appReport1.Visible = false;
        }
        else if (currentTab == 4)
        {
            applicationRpt1.Visible = false;
            SupportingDocRpt1.Visible = false;
            comments1.Visible = true;
            appReport1.Visible = false;


        }

        else if (currentTab == 0)
        {
            applicationRpt1.Visible = true;
            SupportingDocRpt1.Visible = false;
            comments1.Visible = false;
            appReport1.Visible = false; 
        }
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
        {
            this.ops = "previous";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            this.setTab();
        }
        else { MySessionManager.CurrentTab = "1"; }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
        {
            this.ops = "next";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            this.setTab();
        }
        else { MySessionManager.CurrentTab = "1"; }
    }

    public void setApprovalLimit(int level)
    {
        double values=0.0;
        double loanAmt = 0.0;
      
        mainDSTableAdapters.GetApprovalLevelTableAdapter dslevel = new mainDSTableAdapters.GetApprovalLevelTableAdapter();
        values  = Convert.ToDouble(dslevel.GetApprovalLimit(level));

       
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        loanAmt  = Convert.ToDouble(loanApp.GetLoanAmount(MySessionManager.AppID, MySessionManager.ClientID));


        if (values < loanAmt)
        {
            cmbAction.Items[1].Enabled = false;  
        }
        else
        {
            cmbAction.Items[1].Enabled = true;
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
  
    protected void RemoveAlert()
    {
        string msg = this.pAlertmsg.InnerText;
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        loanApp.saveAlert("",
                          MySessionManager.AppID);
        LoanDSTableAdapters.AlertLogsTableAdapter alertLog = new LoanDSTableAdapters.AlertLogsTableAdapter();
        // LoanDS.AlertLogsDataTable tblAlertLog = alertLog.


    }
    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
