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

public partial class pages_loanaccountdetails : System.Web.UI.Page
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();

        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.AccountID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(loanAcc.GetClientIDFromAcc(Convert.ToInt32(MySessionManager.AccountID)));
        }

        if (Request.QueryString["action"] != null)
        {
            //  MySessionManager.CurrentTab=null;
            string action = Request.QueryString["action"];
            MySessionManager.CurrentTab = action;
            setPanel(action);
            Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "action"));
        }
        else { setPanel(""); }

        showAccountInfomartion();
        setUrls();
    }



    public void showAccountInfomartion()
    {
        try { 
             LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
             LoanAccountDS.GetLoanAccountRow tblLoanAcc = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
             mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
             lblAccNo.InnerText = " " + tblLoanAcc.datAccountNumber.ToString();
             lblClienttName.InnerText = " " + tblLoanAcc.datClientFullName.ToString();
             lblEmail.InnerText = " " + tblLoanAcc.datIssueDate.ToString("d MMMM  yyyy");
             lblloantype.InnerText = " " + util.displayValue("opt_loan_types", tblLoanAcc.datLoanType.ToString());
             lblAmtOutstanding.InnerText = " " + tblLoanAcc.datOutstandingAmount.ToString("c").Replace("$", "");
             lblloanAmount.InnerText = " " + tblLoanAcc.datInitialAmount.ToString("c").Replace("$", "");
             lblClientNo.InnerText = " " + client.GetClientNo(tblLoanAcc.datClientID);
             lblDuration.InnerText = " " + tblLoanAcc.datDuration.ToString()+" month(s)";
             lblIntRate.InnerText = " " + tblLoanAcc.datInterestRate.ToString("c").Replace("$", "") + "%";
        }
        catch (Exception ex) { }
    }

    public void setUrls()
    {
        this.btnAccMonitoring.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=1";
        this.btnAccRefreshment.PostBackUrl = "~/pages/loanaccount/accountrefreshment.aspx?actionid=refresh";//HttpContext.Current.Request.Url.AbsoluteUri + "&action=refreshment";
        this.btnAccStatement.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=2";
        this.btnAccTransfer.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=3";
        this.btnAssignCT.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=4";
        this.btnFreezeAcc.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=7";
        this.btnScheduledPayments.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=6";
       // this.btnUnFreezeAcc.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "&action=unfreezeacc";
    }

    public void setPanel(string action)
    {
        try
        {
            if (action != "")
            {
                if (action == "1")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = true;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "2")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = true;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "3")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = true;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "4")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = true;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "5")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = true;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "6")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = true;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "7")
                {
                    this.ctFreezeAccount1.Visible = true;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
                else if (action == "8")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = true;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = false;
                }
            }
            else
            {
                if (MySessionManager.CurrentTab == "")
                {
                    this.ctFreezeAccount1.Visible = false;
                    this.ctMonitoring1.Visible = false;
                    this.ctRefreshment1.Visible = false;
                    this.ctScheduledPayments1.Visible = false;
                    this.ctUnfreezeAccount1.Visible = false;
                    this.ctTransfer1.Visible = false;
                    this.ctStatement1.Visible = false;
                    this.ctDefault1.Visible = true;
                }
                else {

                    setPanel(MySessionManager.CurrentTab);
                }
            }
        }
        catch (Exception ex) { }
    
    
    
    
    }
}
