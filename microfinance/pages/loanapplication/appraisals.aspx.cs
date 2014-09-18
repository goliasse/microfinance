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

public partial class pages_appraisals : System.Web.UI.Page
{

    public int LoanType{set;get;}
    public int currentTab{set;get;}
    public string ops{set;get;}

    Utility util = new Utility();

    #region Obsolete
    //public enum  individual
    //{
    //    personalinfo=0,
    //    loandetails =8,
    //    fees = 9,
    //    paymentplan = 11,
    //    employmentdetails = 6,
    //    nextofkin = 7,
    //    collaterals = 12,
    //    assets = 18,
    //    bankers = 15,
    //    creditinfo = 16,
    //    guarantors = 17,
    //    supportingdocs = 19,
    //    checklist = 20,
    //    applicationRpt=21
    //}
    //public enum coporate
    //{
    //    companydetails = 2,
    //    initiator = 1,
    //    employee = 3,
    //    loandetails = 8,
    //    fees = 9,
    //    paymentplan = 11,
    //    collaterals = 12,
    //    assets = 18,
    //    bankers = 15,
    //    creditinfo = 16,
    //    financials = 13,
    //    auditors = 14,
    //    owners = 10,
    //    guarantors = 17,
    //    supportingdocs = 19,
    //    checklist = 20,
    //    applicationRpt = 21
    //}
    //public enum enterprise
    //{
    //    personalinfo = 0,
    //    enterprise = 4,
    //    income_exp = 5,
    //    employmentdetails = 6,
    //    nextofkin = 7,
    //    loandetails = 8,
    //    fees = 9,
    //    paymentplan = 11,
    //    collaterals = 12,
    //    assets = 18,
    //    bankers = 15,
    //    auditors = 14,

    //    creditinfo = 16,
    //    guarantors = 17,

    //    supportingdocs = 19,
    //    checklist = 20,
    //    applicationRpt = 21
    //} 
    #endregion

    public int[] indie = new int[] { 0, 6, 8, 9, 11, 12, 18, 16, 15, 7, 17, 19, 20,21, 24 };
    public int[] cor = new int[] { 1, 2, 8, 9, 11, 12, 18, 16, 15, 10, 13, 14, 17, 19, 20, 21,24 };
   public   int[] ent = new int[] {0,4,8,9,11,12,18,16,15,5,6,22,23,7,17,19,20,21, 24};

   [WebMethod]
   public static void removertalert()
   {
       LoanDSTableAdapters.AlertLogsTableAdapter alert = new LoanDSTableAdapters.AlertLogsTableAdapter();
       alert.RemoveAlert(MySessionManager.AppID);
      
   }
    protected void Page_Load(object sender, EventArgs e)
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        setNotifications();
       
        if (!(this.IsPostBack))
        {
            setUrls();
           
        }
        #region QueryStringBlock
        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.AppID = DecID;
            //int DecID = Convert.ToInt32(EncID);

            MySessionManager.ClientID = Convert.ToInt32(loanApp.getClientID(MySessionManager.AppID));

        }

        LoanType = Convert.ToInt32(loanApp.GetLoanType(MySessionManager.AppID, MySessionManager.ClientID));
        setLoanTypeTabs(LoanType);
        showLoanAppInfo();

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
                    if (LoanType == 2 || LoanType == 3)
                        currentTab = 2;
                    else
                        currentTab = 0;

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
                if (LoanType == 2 || LoanType == 3)
                {
                    currentTab = 2;
                    MySessionManager.CurrentTab = currentTab.ToString();
                }
                else
                {
                    currentTab = 0;
                    MySessionManager.CurrentTab = currentTab.ToString();
                }
            setTab(currentTab);
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
            //this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString())).ToString();
        }
        catch
        { }
    }

    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp1 = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int AppStage = Convert.ToInt32(loanApp1.getApplicationStatus(MySessionManager.AppID));
        Utility utilClass = new Utility();

        if (cmbAction.Text == "Forward Application")
        {
            ShowMessageBox("Are u sure on forwarding the application");
            utilClass.UpdateApplicationStatus("Forward Application To Approval", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
            }
        else if (cmbAction.Text == "Forward To Risk")
        {
            utilClass.UpdateApplicationStatus("Forward To Risk", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
            }
        else if (cmbAction.Text == "Forward To Legal")
        {
            utilClass.UpdateApplicationStatus("Forward To Legal", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
            }
        else if (cmbAction.Text == "Send Back For Review")
        {
            utilClass.UpdateApplicationStatus("Send Back For Review", AppStage);
            Response.Redirect("~/pages/loanapplications.aspx");
        
                }

    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.RegisterStartupScript("MessageBox", sJavaScript);
    }

    public void setLoanTypeTabs(int type)
    {

        if ((type == 1)||(type==4)||(type==5)||(type==6))
        {

            this.cdetails.Visible = false;
            this.initiator.Visible = false;
            setPanelsOff();
            this.financial.Visible = false;
            this.owners.Visible = false;
            this.auditors.Visible = false;
            this.emps.Visible = false;
            if(type==1)
            {
                this.personalInformation1.Visible = true;
                this.ine.Visible = false;
                this.ents.Visible = false;
                this.spouse.Visible = false;
                this.reli.Visible = false;
            }
            else if(type==4)
            {
                this.EnterprisesDetails1.Visible =true;
                //this.personal.Visible = false;
            }
             }
        else if (type == 2 || type == 3)
        {
            setPanelsOff();
            this.CompanyDetails1.Visible = true;
            this.empDetails.Visible = false;
            this.emps.Visible = false;
            this.personal.Visible = false;
            this.ents.Visible = false;
            this.nok.Visible = false;
            this.ine.Visible = false;
            this.reli.Visible = false;
            this.spouse.Visible = false;

            if (type == 2)
            {
                this.EnterprisesDetails1.Visible = false;
                this.personalInformation1.Visible = false;
            }
        
            }
    
        }

    public void changeTab(object sender, EventArgs e)
    {

        try
        {
            
            
            }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message.ToString());
        }
    
    
    
    }

    public void setTab(int i)
    {
        if (i == 0)
        {
            setPanelsOff();
            this.personalInformation1.Visible = true;
        }
        else if (i == 1)
        {
            setPanelsOff();
            this.Initiator1.Visible = true;
        }
        else if (i == 2)
        {
            setPanelsOff();
            this.CompanyDetails1.Visible = true;

        }
        else if (i == 3)
        {
            setPanelsOff();
            this.Employees1.Visible = true;
        }
        else if (i == 4)
        {
            setPanelsOff();
            this.EnterprisesDetails1.Visible = true;
        }
        else if (i == 5)
        {
            setPanelsOff();
            this.IncomeExpeditures1.Visible = true;
         }
        else if (i == 6)
        {
            setPanelsOff();
            this.EmploymentDetails1.Visible = true;
        }
        else if (i == 7)
        {
            setPanelsOff();
            this.NextOfKins1.Visible = true;
        }
        else if (i == 8)
        {
            setPanelsOff();
            this.LoanDetails1.Visible = true;
        }
        else if (i == 9)
        {
            setPanelsOff();
            this.Fees1.Visible = true;
        }
        else if (i == 10)
        {
            setPanelsOff();
            this.ownership1.Visible = true;

        }
        else if (i == 11)
        {
            setPanelsOff();
            this.PaymentPlan1.Visible = true;

        }
        else if (i == 12)
        {
            setPanelsOff();
            this.Collaterals1.Visible = true;
        }
        else if (i == 13)
        {
            setPanelsOff();
            this.financial1.Visible = true;

        }
        else if (i == 14)
        {
            setPanelsOff();
            this.Auditors1.Visible = true;

        }
        else if (i == 15)
        {
            setPanelsOff();
            this.Bankers1.Visible = true;

        }
        else if (i == 16)
        {
            setPanelsOff();
            this.creditinformation1.Visible = true;
        }
        else if (i == 17)
        {
            setPanelsOff();
            this.Guarantor_Referee1.Visible = true;
        }
        else if (i == 18)
        {
            setPanelsOff();
            this.assets1.Visible = true;
        }
        else if (i == 19)
        {
            setPanelsOff();
            this.SupportingDocs1.Visible = true;
        }
        else if (i == 20)
        {
            setPanelsOff();
            this.checklist2.Visible = true;
        }
        else if (i == 24)
        {
            setPanelsOff();
            this.applicationRpt1.Visible = true;
        }
        else if (i == 22)
        {
            setPanelsOff();
            this.SpouseDetails1.Visible = true;
        }
        else if (i == 23)
        {
            setPanelsOff();
            this.ReligionDetails1.Visible = true;
        }
        else if (i == 21)
        {
            setPanelsOff();
            this.LoanReport1.Visible = true;
        }

    }

    public void setPanelsOff()
    {
        this.personalInformation1.Visible=false;
        this.Initiator1.Visible = false;
        this.CompanyDetails1.Visible = false;
        this.EnterprisesDetails1.Visible = false;
        this.IncomeExpeditures1.Visible = false;
        this.CompanyDetails1.Visible = false;
        this.Employees1.Visible=false;
        this.EmploymentDetails1.Visible = false;
        this.LoanDetails1.Visible = false;
        this.ownership1.Visible = false;
        this.Auditors1.Visible = false;
        this.financial1.Visible = false;
        this.Initiator1.Visible = false;
        this.NextOfKins1.Visible = false;
        this.ownership1.Visible = false;
        this.Guarantor_Referee1.Visible = false;
        this.checklist2.Visible = false;
        this.Fees1.Visible = false;
        this.PaymentPlan1.Visible = false;
        this.Collaterals1.Visible = false;
        this.Bankers1.Visible = false;
        this.assets1.Visible = false;
        this.SupportingDocs1.Visible = false;
        this.creditinformation1.Visible = false;
        this.applicationRpt1.Visible = false;
        this.SpouseDetails1.Visible = false;
        this.ReligionDetails1.Visible = false;
        this.LoanReport1.Visible = false;
    }

    public void setUrls()
    {
        this.personal.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=0&ops=load";
        this.initiator.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load";
        this.cdetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
        this.emps.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load";
        this.ents.PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
        this.ine.PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=5&ops=load";
        this.empDetails .PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=6&ops=load";
        this.nok.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=7&ops=load";
        this.ldetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=8&ops=load";
        this.fees.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=9&ops=load";
        this.owners .PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=10&ops=load";
        this.financial.PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=13&ops=load";
        this.pplan.PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=11&ops=load";
        this.collateral.PostBackUrl =  HttpContext.Current.Request.Url.AbsoluteUri + "&tab=12&ops=load";
        this.auditors.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=14&ops=load";
        this.bankers.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=15&ops=load";
        this.creditinfo.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=16&ops=load";
        this.refgua.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=17&ops=load";
        this.asset.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=18&ops=load";
        this.supportingdocs.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=19&ops=load";
        this.checklist.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=20&ops=load";
        this.appRpt.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=21&ops=load";
        this.spouse.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=22&ops=load";
        this.reli.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=23&ops=load";
        this.loanrpt.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=24&ops=load";
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
        if (MySessionManager.CurrentTab !="")
        {
            this.ops = "Previous";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            if (currentTab > 1)
            {
                loadTab(currentTab, this.ops);
                btnPrevious.Visible = true;
                btnNext.Visible = true;
            }
            else
            {
                ShowMessageBox("You are on the first tab");
                btnPrevious.Visible = false;
            }
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {

        if (MySessionManager.CurrentTab !="")
        {
            this.ops = "Next";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            if (currentTab < 24)
            {
                loadTab(currentTab, this.ops);
                btnPrevious.Visible = true;
                btnNext.Visible = true;
            }
            else
            {
                ShowMessageBox("You are on the last tab");
                btnNext.Visible = false;
            }
        }
        else {  }
    }    

    public void loadTab(int id,string ops)
    {
        try
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            LoanType = Convert.ToInt32(loanApp.GetLoanType(MySessionManager.AppID, MySessionManager.ClientID));
            if (LoanType == 1)
            {
                for (int j = 0; j < indie.Length; j++)
                {
                    if (indie[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(indie[m]);
                            MySessionManager.CurrentTab = indie[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(m);
                                MySessionManager.CurrentTab = indie[m].ToString();
                            }
                        }
                    }
                }

            }
            else if (LoanType == 2 || LoanType == 3)
            {
                for (int j = 0; j < cor.Length; j++)
                {

                    if (cor[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(cor[m]);
                            MySessionManager.CurrentTab = cor[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(cor[m]);
                                MySessionManager.CurrentTab = cor[m].ToString();
                            }
                        }
                    }
                }
            }
            else if (LoanType == 4)
            {
                for (int j = 0; j < ent.Length; j++)
                {
                    if (ent[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(ent[m]);
                            MySessionManager.CurrentTab = ent[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(ent[m]);
                                MySessionManager.CurrentTab = ent[m].ToString();
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex) { }
    }
            
      
}
