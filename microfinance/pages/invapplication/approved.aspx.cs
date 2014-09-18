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

public partial class pages_invapplication_approved : System.Web.UI.Page
{
    Utility util = new Utility();
    public int currentTab { set; get; }
    public string ops { set; get; }
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

        setURLs();
        setNotifications();
        showLoanAppInfo();
    }

    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        try
        {
            ///End the application process.
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateApplicationStatus(5, MySessionManager.InvAppID);


            ///Converts the application into an account
            InvestmentDS.GetInvestmentAppDataTable rowInvApp = InvApp.GetInvestmentApp(MySessionManager.InvAppID);

            if (rowInvApp.Rows.Count > 0)
            {
                InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter InvAcc = new InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter();
                InvAcc.InsertInvAccount(rowInvApp[0].datInvestmentName,
                                        rowInvApp[0].datApplicationNumber,
                                        MySessionManager.ClientID,
                                        rowInvApp[0].datInvestmentType,
                                        rowInvApp[0].datTerms,
                                        rowInvApp[0].datInvestmentAmount,
                                        rowInvApp[0].datInterestRatePerAnnum,
                                        rowInvApp[0].datFrequencyOfInterestPayment,
                                        rowInvApp[0].datModeOfRepayment,
                                        rowInvApp[0].datAdvise,
                                        rowInvApp[0].datValueDate,
                                        rowInvApp[0].datInvestmentAmount,
                                        MySessionManager.CurrentUser.BranchID,
                                        0,
                                        0,
                                        0,
                                        0,
                                        1,
                                        MySessionManager.InvAppID);


                ///Calculates the interest for the days elapsed before creation of the account
                int days = DateDiff(DateTime.Now, rowInvApp[0].datValueDate);
                int term = Convert.ToInt32(util.displayValue("opt_terms",rowInvApp[0].datTerms.ToString()));
                if (days > term)
                    days = term;

                InvestmentAccountDSTableAdapters.GetInterestCalcTableAdapter InvAcc1 = new InvestmentAccountDSTableAdapters.GetInterestCalcTableAdapter();

                if (days > 0)
                {
                    decimal previousInt = calc_interest(MySessionManager.InvAppID, days);

                    ///Insert a new record into the calculation table for the Daily chron-job
                    InvAcc1.InsertInvCalc(MySessionManager.InvAppID.ToString(),
                                          MySessionManager.ClientID,
                                          rowInvApp[0].datApplicationNumber.ToString(),
                                          DateTime.Now.ToShortDateString(),
                                          rowInvApp[0].datInvestmentAmount,
                                          rowInvApp[0].datInterestRatePerAnnum,
                                          days,
                                          term,
                                          previousInt,
                                          previousInt);
                }
                else 
                {
                    
                       // decimal previousInt = calc_interest(MySessionManager.InvAppID, days);

                        ///Insert a new record into the calculation table for the Daily chron-job
                        InvAcc1.InsertInvCalc(MySessionManager.InvAppID.ToString(),
                                              MySessionManager.ClientID,
                                              rowInvApp[0].datApplicationNumber.ToString(),
                                              DateTime.Now.ToShortDateString(),
                                              rowInvApp[0].datInvestmentAmount,
                                              rowInvApp[0].datInterestRatePerAnnum,
                                              0,
                                              term,
                                              0,
                                              0);
                    }
                
                
                }
            
            Response.Redirect("~/pages/invapplications.aspx");

        }
        catch (Exception ex) { }

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

    /// <summary>
    /// Sets the link for each 
    /// </summary>
    public void setURLs()
    {
        this.btnSetValueDate.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load";
        this.btnAppDetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
        this.btnInvAdvise.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load";
        this.btnComments.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
        
    }


    /// <summary>
    /// This function sets the notification for each Investment Application tab
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
            this.InvApproved.InnerText = itemcount.InvApproved.ToString();
        }
        catch(Exception ex)
        { }
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
                //if (tblInvApp[0].() == false) { this.lblValueDate.InnerText = tblInvApp[0].d.ToString("c").Replace("$", ""); }
                if (tblInvApp[0].IsdatInvestmentTypeNull() == false) { this.lblInvtype.InnerText = util.displayValue("opt_investment_types", tblInvApp[0].datInvestmentType.ToString()); }
                if (tblInvApp[0].IsdatFrequencyOfInterestPaymentNull() == false) { this.lblAccInterest.InnerText = tblInvApp[0].datFrequencyOfInterestPayment.ToString(); }
                if (tblInvApp[0].IsdatValueDateNull() == false) { this.lblValueDate.InnerText = tblInvApp[0].datValueDate.ToString("dd-MM-yyyy"); }
            }
            catch (Exception ex)
            { }
        }

    }

    /// <summary>
    /// Set the User control for the tab to show
    /// </summary>
    /// <param name="id">An int value that represents a user control</param>
    public void setTab(int id)
    {
        try
        {
            if (id == 1)
            {
                this.setValuedDate1.Visible = true;
                this.InvApplicationDetails1.Visible = false;
                this.invcomments1.Visible = false;
                this.advise1.Visible = false;
            }
            else if (id == 2)
            {
                this.setValuedDate1.Visible = false;
                this.InvApplicationDetails1.Visible = true;
                this.invcomments1.Visible = false;
                this.advise1.Visible = false;
            }
            else if (id == 3)
            {
                this.setValuedDate1.Visible = false;
                this.InvApplicationDetails1.Visible = false;
                this.invcomments1.Visible = false;
                this.advise1.Visible = true;
            }
            else if (id == 4)
            {
                this.setValuedDate1.Visible = false;
                this.InvApplicationDetails1.Visible = false;
                this.invcomments1.Visible = true;
                this.advise1.Visible = false;
            }
            else
            {
                this.setValuedDate1.Visible = false;
                this.InvApplicationDetails1.Visible = false;
                this.invcomments1.Visible = false;
                this.advise1.Visible = false;
            }
        }
        catch (Exception ex) { }
    }


    /// <summary>
    /// Calculate the interest of an application for a certain number of days
    /// It takes the ID of the investment application and the number of days
    /// </summary>
    /// <param name="id">The Investment Application ID </param>
    /// <param name="days">The number of days</param>
    /// <returns>The interest that have been calculated</returns>
    public decimal calc_interest(int id, int days)
    {
        decimal interest=0;
        decimal intRate=0;
        decimal amt=0;
        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
        InvestmentDS.GetInvestmentAppDataTable tblInvApp = InvApp.GetInvestmentApp(MySessionManager.InvAppID);

        if (tblInvApp.Rows.Count > 0)
        {
            intRate = tblInvApp[0].datInterestRatePerAnnum;
            amt = tblInvApp[0].datInvestmentAmount;
        }
        interest =((amt*intRate)/36500)*days;
        return interest;
    
    }
    /// <summary>
    /// //calculate the date difference between two dates. 
    /// </summary>
    /// <param name="dt">The former date</param>
    /// <param name="dt1">The later date</param>
    /// <returns>An Integer value that is equal the number of days</returns>
    public int DateDiff(DateTime dt, DateTime dt1)
    {
        int days=0;

        days =Convert.ToInt32((dt - dt1).TotalDays);

        return days;
    }
}
