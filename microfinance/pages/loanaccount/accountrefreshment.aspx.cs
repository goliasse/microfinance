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

public partial class pages_accountrefreshment : System.Web.UI.Page
{
    Utility util = new Utility();
    public int currentTab{set;get;}
    public string ops { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/login.aspx");
        }

        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter LoanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountRow tblLoanAcc = LoanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
        int LoanType = tblLoanAcc.datLoanType;
        setLoanTypeTabs(tblLoanAcc.datLoanType);
        showLoanAppInfo();

        try
        {

            LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter LoanAcRef = new LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter();
            LoanAccountDS.GetAccountRefreshmentRecordDataTable tblAccountRef = LoanAcRef.GetAccountRefreshmentRecord(Convert.ToInt32(MySessionManager.AccountID));

            if (!(tblAccountRef.Rows.Count>0))
            {
                MySessionManager.AppID = tblLoanAcc.datApplicationID;
                MySessionManager.ClientID = tblLoanAcc.datClientID;
            }
            else
            {
                MySessionManager.AppID = tblAccountRef[0].datNewAppID;
                MySessionManager.ClientID = tblLoanAcc.datClientID;
            }

        }
        catch (Exception ex) { }
        setUrls();

       

        #region QueryString
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
                    currentTab = 25;
                else
                    currentTab = 25;
            setTab(currentTab);
        }  
        #endregion
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
        else if (i == 21)
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
        else if (i == 24)
        {
            setPanelsOff();
            this.LoanReport1.Visible = true;
        }
        else if (i == 25)
        {
            setPanelsOff();
            this.ctRefreshment1.Visible = true;
        }
    }

    public void setPanelsOff()
    {
        this.personalInformation1.Visible = false;
        this.Initiator1.Visible = false;
        this.CompanyDetails1.Visible = false;
        this.EnterprisesDetails1.Visible = false;
        this.IncomeExpeditures1.Visible = false;
        this.CompanyDetails1.Visible = false;
        this.Employees1.Visible = false;
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
        this.ctRefreshment1.Visible = false;
    }
   
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        this.ops = "previous";
        currentTab = Convert.ToInt32(MySessionManager.CurrentTab);

        if (currentTab > 1)
        {
            currentTab = currentTab - 1;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.setTab(currentTab);
        }
        else
        {
            currentTab = 1;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.setTab(currentTab);
        }
    }
    
    protected void btnNext_Click(object sender, EventArgs e)
    {

        this.ops = "next";
        currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
        if (currentTab < 24)
        {
            currentTab = currentTab + 1;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.setTab(currentTab);
        }
        else
        {
            currentTab = 24;
            MySessionManager.CurrentTab = currentTab.ToString();
            this.setTab(currentTab);
        }
    }

    public void setLoanTypeTabs(int type)
    {

        if ((type == 1) || (type == 4) || (type == 5) || (type == 6))
        {

            this.cdetails.Visible = false;
            this.initiator.Visible = false;
            setPanelsOff();
            this.financial.Visible = false;
            this.owners.Visible = false;
            this.auditors.Visible = false;
            this.emps.Visible = false;
            if (type == 1)
            {
                this.personalInformation1.Visible = true;
                this.ine.Visible = false;
                this.ents.Visible = false;
                this.spouse.Visible = false;
                this.reli.Visible = false;
            }
            else if (type == 4)
            {
                this.EnterprisesDetails1.Visible = true;
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

    public void setUrls()
    {
        this.personal.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=0&ops=load";
        this.initiator.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load";
        this.cdetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
        this.emps.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load";
        this.ents.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
        this.ine.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=5&ops=load";
        this.empDetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=6&ops=load";
        this.nok.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=7&ops=load";
        this.ldetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=8&ops=load";
        this.fees.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=9&ops=load";
        this.owners.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=10&ops=load";
        this.financial.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=13&ops=load";
        this.pplan.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=11&ops=load";
        this.collateral.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=12&ops=load";
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
        this.ctRefresh.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=25&ops=load"; 
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
                this.lblAppNo.InnerText = tblLoanApp[0].datApplicationNumber.ToString();
                this.loanAmount.InnerText = tblLoanApp[0].datLoanAmount.ToString("c").Replace("$", "");
                if (tblLoanApp[0].datLoanType > 0)
                {
                    this.lblloantype.InnerText = util.displayValue("opt_loan_types", tblLoanApp[0].datLoanType.ToString());
                }
            }
            catch (Exception ex)
            { }
        }

    }

    


}
