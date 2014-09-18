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

public partial class pages_invapplication_initInterview : System.Web.UI.Page
{
    Utility util = new Utility();

    [WebMethod]
    public static void removertalert()
    {
        InvestmentDSTableAdapters.GetAlertTableAdapter alert = new InvestmentDSTableAdapters.GetAlertTableAdapter();
        alert.DeleteInvAlert(MySessionManager.InvAppID);
    }
    public int currentTab{ set; get; }
    public string ops { set; get; }
    public int[] indie = { 1, 2, 8, 9, 10, 11, 12 };
    public int[] joint = { 1, 3, 8, 9, 10, 11, 12 };
    public int[] insti = { 1, 4, 6, 9, 10, 11, 12 };
    public int[] intrust = { 1, 5, 7, 8, 9, 10, 11, 12 };

    protected void Page_Load(object sender, EventArgs e)
    {
        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
        
        
        #region "QueryString Block"
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
                        currentTab =1;

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
                    currentTab =1;
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
        showLoanAppInfo();
        setNotifications();
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
        {
            this.ops = "Next";
            currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
            if (currentTab < 12)
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
        else { }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentTab != "")
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
    public void setURLs()
    {

        this.btnIntestmentDetails.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=1&ops=load";
        this.btnPersonalInfo.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=2&ops=load";
        this.btnJointInfo.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=3&ops=load";
        this.btnCoporateInfo.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=4&ops=load";
        this.btnInitiatorsInfo.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=5&ops=load";
        this.btnDirectors.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=6&ops=load";
        this.btnBeneficiaries.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=7&ops=load";
        this.btnnok.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=8&ops=load";
        this.btnConPerson.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=9&ops=load";
        this.btnbankers.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=10&ops=load";
        this.btnsupportingdocs.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=11&ops=load";
        this.btnAdvise.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&tab=12&ops=load";

        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
        int type =Convert.ToInt32(InvApp.GetInvestmentType(MySessionManager.InvAppID));
        if(type==1)
        {
            this.btnJointInfo.Visible = false;
            this.btnCoporateInfo.Visible = false;
            this.btnDirectors.Visible = false;
            this.btnBeneficiaries.Visible = false;
            this.btnInitiatorsInfo.Visible = false;
        }
        else if (type == 2) 
        {
            this.btnPersonalInfo.Visible = false;
            this.btnDirectors.Visible = false;
            this.btnBeneficiaries.Visible = false;
            this.btnCoporateInfo.Visible = false;
            this.btnInitiatorsInfo.Visible = false;
        }
        else if (type == 3)
        {
            this.btnPersonalInfo.Visible = false;
            this.btnBeneficiaries.Visible = false;
            this.btnJointInfo.Visible = false;
            btnInitiatorsInfo.Visible = false;
            this.btnnok.Visible = false;        
        }
        else if (type == 4)
        {
            this.btnPersonalInfo.Visible = false;
            this.btnCoporateInfo.Visible = false;
            this.btnJointInfo.Visible = false;
            this.btnDirectors.Visible = false;
        }


    }

    public void setPanelsOff()
    {
        this.investmentdetails1.Visible = false;
        this.personalInformation1.Visible = false;
        this.nextofkin1.Visible = false;
        this.constituentInvestors1.Visible = false;
        this.contactperson1.Visible = false;
        this.supportingdocs1.Visible = false;
        this.beneficiaries1.Visible = false;
        this.bankers1.Visible = false;
        this.advise1.Visible = false;
        this.InitiatorsInfo1.Visible = false;
        this.coporateInfo1.Visible = false;
        this.directors1.Visible = false;
          
    }

    public void setTab(int i)
    {
        if (i == 1)
        {
            setPanelsOff();
            this.investmentdetails1.Visible = true;
        }
        else if (i == 2)
        {
            setPanelsOff();
            this.personalInformation1.Visible = true;
        }
        else if (i == 3)
        {
            setPanelsOff();
            this.constituentInvestors1.Visible = true;
        }
        else if (i == 4)
        {
            setPanelsOff();          
            this.coporateInfo1.Visible = true;
        }
        else if (i == 5)
        {
            setPanelsOff();
            this.InitiatorsInfo1.Visible = true;
        }
        else if (i == 6)
        {
            setPanelsOff();
            this.directors1.Visible = true;
        }
        else if (i == 7)
        {
            setPanelsOff();
            this.beneficiaries1.Visible = true;
        }
        else if (i == 8)
        {
            setPanelsOff();
            this.nextofkin1.Visible = true;
        }
        else if (i == 9)
        {
            setPanelsOff();
            this.contactperson1.Visible = true;
        }
        else if (i == 10)
        {
            setPanelsOff();
            this.bankers1.Visible = true;
        }
        else if (i == 11)
        {
            setPanelsOff();
            this.supportingdocs1.Visible = true;
        }
        else if (i == 12)
        {
            setPanelsOff();
            this.advise1.Visible = true;
        }
        
    }

   
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        try
        {
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateApplicationStatus(2, MySessionManager.InvAppID);
            Response.Redirect("~/pages/invapplications.aspx");

        }
        catch (Exception ex) { }
    }
  
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
               if(tblInvApp[0].IsdatInvestmentAmountNull()==false){ this.lblInvestmentAmount.InnerText = tblInvApp[0].datInvestmentAmount.ToString("c").Replace("$", "");}
               if (tblInvApp[0].IsdatInvestmentNameNull() == false) { this.lblInvestmentName.InnerText = tblInvApp[0].datInvestmentName.ToString(); }
               if (tblInvApp[0].IsdatTermsNull() == false) { this.lblTerm.InnerText =util.displayValue("opt_terms", tblInvApp[0].datTerms.ToString()) + " days"; }
               if(tblInvApp[0].IsdatApplicationNumberNull()==false){ this.lblAppNo.InnerText = tblInvApp[0].datApplicationNumber.ToString();}
               if(tblInvApp[0].IsdatValueDateNull()==false){ this.lblValueDate.InnerText = tblInvApp[0].datValueDate.ToString("c").Replace("$", "");}
               if(tblInvApp[0].IsdatInvestmentTypeNull()==false){  this.lblInvtype.InnerText = util.displayValue("opt_investment_types", tblInvApp[0].datInvestmentType.ToString());}
               if (tblInvApp[0].IsdatFrequencyOfInterestPaymentNull() == false) { this.lblAccInterest.InnerText = tblInvApp[0].datFrequencyOfInterestPayment.ToString(); }
               if (tblInvApp[0].IsdatValueDateNull() == false) { this.lblValueDate.InnerText = tblInvApp[0].datValueDate.ToString("dd-MM-yyyy"); }
                
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
            this.InvApproved.InnerText = itemcount.InvApproved.ToString();
        }
        catch(Exception ex)
        { }
    }
    public void loadTab(int id, string ops)
    {
        try
        {
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
             int InvType = Convert.ToInt32(InvApp.GetInvestmentType(MySessionManager.InvAppID));
            if (InvType == 1)
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
            else if (InvType == 2 )
            {
                for (int j = 0; j < joint.Length; j++)
                {

                    if (joint[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(joint[m]);
                            MySessionManager.CurrentTab = joint[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(joint[m]);
                                MySessionManager.CurrentTab = joint[m].ToString();
                            }
                        }
                    }
                }
            }
            else if( InvType == 3)
            {
                for (int j = 0; j < insti.Length; j++)
                {

                    if (insti[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(insti[m]);
                            MySessionManager.CurrentTab = insti[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(insti[m]);
                                MySessionManager.CurrentTab = insti[m].ToString();
                            }
                        }
                    }
                }
            }
            else if (InvType == 4)
            {
                for (int j = 0; j < intrust.Length; j++)
                {
                    if (intrust[j] == id)
                    {
                        if (ops == "Next")
                        {
                            int m = j + 1;
                            setTab(intrust[m]);
                            MySessionManager.CurrentTab = intrust[m].ToString();
                        }
                        else if (ops == "Previous")
                        {
                            if (j > 0)
                            {
                                int m = j - 1;
                                setTab(intrust[m]);
                                MySessionManager.CurrentTab = intrust[m].ToString();
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex) { }
    }
    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
