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


public partial class pages_disbursement : System.Web.UI.Page
{
    public int currentTab { set; get; }
    public string ops { set; get; }
    Utility util = new Utility();
    [WebMethod]
    public static void removertalert()
    {
        LoanDSTableAdapters.AlertLogsTableAdapter alert = new LoanDSTableAdapters.AlertLogsTableAdapter();
        alert.RemoveAlert(MySessionManager.AppID);

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        setUrls();
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/logout.aspx");
        }
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
       
        setNotifications();
        setPanelsOff();
        


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
                setPanels(currentTab);
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
                setPanels(currentTab);

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

            setPanels(currentTab);
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
        //this.reviewinfo.InnerText = itemcount.cmreview.ToString();
        this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString())).ToString();

         LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int status = Convert.ToInt32(loanApp.getApplicationStatus(MySessionManager.AppID));
        if (status == 13)
        { 
             this.disbinfo.InnerText = itemcount.disbursementI.ToString();
        }
        else if (status == 14)
        { 
            this.disbinfo.InnerText = itemcount.disbursementII.ToString();
        }
        else if (status == 15)
        {
            this.disbinfo.InnerText = itemcount.disbursementIII.ToString();
        }
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
        else if (cmbAction.Text == "Send Back For Review")
        {
            utilClass.UpdateApplicationStatus("Send Back For Review", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
        }
    }

    public void setUrls()
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int status = Convert.ToInt32(loanApp.getApplicationStatus(MySessionManager.AppID));
        if (status == 13)
        {
            this.btnTransEntry.Visible = false;
            this.btnEditPV.Visible = false;
            this.btnPreparePV.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
            
        }
        else if (status == 14)
        {
            this.btnPreparePV.Visible = false;
            this.btnTransEntry.Visible = false;
            this.btnEditPV.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=6&ops=load";
        }
        else if (status == 15)
        {
            this.btnPreparePV.Visible = false;
            this.btnEditPV.Visible = false;
            this.btnTransEntry.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=5&ops=load";
            this.divSubmit.Visible = false;
        }

        this.btnApplicationDetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri+"&tab=1&ops=load";
        this.btnPVReport.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load";
        this.btnSupDocs.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
       
       
    }

    public void setPanelsOff()
    {
        
        this.transactionEntry1.Visible =false;
        this.paymentvoucher1.Visible = false;
        this.applicationRpt1.Visible = false;
        this.paymentvoucherRpt1.Visible = false;
        this.SupportingDocRpt1.Visible = false;
        this.editpaymentvoucher1.Visible = false;
    }
    
    public void setPanels(int id)
    {
        if (id == 0)
        { 
            setPanelsOff();
            this.applicationRpt1.Visible = true;
        }
        else if (id == 1)
        {
            setPanelsOff();
            this.applicationRpt1.Visible = true;
        }
        else if (id == 2)
        {
            setPanelsOff();
            this.paymentvoucher1.Visible = true;  
        }
        else if (id == 3)
        {
            setPanelsOff();
            this.paymentvoucherRpt1.Visible = true;
        }
        else if (id == 4)
        {
            setPanelsOff();
            this.SupportingDocRpt1.Visible = true;
        }
        else if (id == 5)
        {
            setPanelsOff();
            this.transactionEntry1.Visible = true;
        }
        else if (id == 6)
        {
            setPanelsOff();
            this.editpaymentvoucher1.Visible = true;
        
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


    public void setTab()
    {
        if (ops == "load")
        {
            setPanels(currentTab);
        }
        else if (ops == "next")
        {
            this.currentTab++;
            if (currentTab < 5)
            {
                MySessionManager.CurrentTab = currentTab.ToString();
                setPanels(currentTab);
            }
        }
        else if (ops == "previous")
        {
            this.currentTab--;
            MySessionManager.CurrentTab = currentTab.ToString();
            setPanels(currentTab);
        }
        else if (ops == "first")
        {
            this.currentTab = 1;
            MySessionManager.CurrentTab = currentTab.ToString();
            setPanels(currentTab);
        }
        else if (ops == "last")
        {
            this.currentTab = 4;
            MySessionManager.CurrentTab = currentTab.ToString();
            setPanels(currentTab);
        }
        else if (ops == null || ops == "")
        {
            if (currentTab == 0)
            {
                applicationRpt1.Visible = true;
                SupportingDocRpt1.Visible = false;
                transactionEntry1.Visible = false;
                paymentvoucher1.Visible = false;
                editpaymentvoucher1.Visible = false;
            }
        }
    }

}
