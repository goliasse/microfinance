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

public partial class controls_clients_clientPortfolios : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (MySessionManager.AppID > 0)
        {
            this.itemLoanApp.Visible = true;
            this.ItemLoanAccount.Visible = false;
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            MySessionManager.ClientID = Convert.ToInt32(loanApp.getClientID(MySessionManager.AppID));

            try
            {
                mainDSTableAdapters.GetApplicationInfoTableAdapter appinfo = new mainDSTableAdapters.GetApplicationInfoTableAdapter();
                mainDS.GetApplicationInfoDataTable tblAppInfo = appinfo.GetApplicationInfo(MySessionManager.AppID);
                if (tblAppInfo.Rows.Count > 0)
                {
                    this.btnEditApp.HRef = setUrls(MySessionManager.AppID);
                    this.btnViewAppTracker.HRef = "~/pages/applicationtracker.aspx?id=" + MyEncryption.Encrypt(MySessionManager.AppID.ToString(), "12345678910");
                    if(tblAppInfo[0].IsdatLoanAmountNull()==false){this.lnAmt.InnerText = tblAppInfo[0].datLoanAmount.ToString("c").Replace("$", "");}
                    if (tblAppInfo[0].IsdatLoanTypeNull() == false) { this.lnType.InnerText = tblAppInfo[0].datLoanType.ToString(); }
                    if (tblAppInfo[0].IsdatApplicationStatusNull() == false) { this.lnAppStatus.InnerText = tblAppInfo[0].datApplicationStatus.ToString(); }
                    if (tblAppInfo[0].IsdatDurationNull() == false) { this.lnDuration.InnerText = tblAppInfo[0].datDuration.ToString() + " month(s)"; }
                    if (tblAppInfo[0].IsdatBranchNull() == false) { this.lnAppBranch.InnerText = tblAppInfo[0].datBranch.ToString(); }
                    if (tblAppInfo[0].IsdatApplicationDateNull() == false) { this.lnAppDate.InnerText = tblAppInfo[0].datApplicationDate.ToLongDateString(); }
                   
                }

            }
            catch (Exception ex) { }
        }
        else if(MySessionManager.AccountID > 0)
        {
            this.ItemLoanAccount.Visible = true;
            this.itemLoanApp.Visible = false;
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            MySessionManager.ClientID = Convert.ToInt32(loanAcc.GetClientIDFromAcc(Convert.ToInt32(MySessionManager.AccountID)));

            try
            {
                mainDSTableAdapters.GetLoanAccountInfoTableAdapter accinfo = new mainDSTableAdapters.GetLoanAccountInfoTableAdapter();
                mainDS.GetLoanAccountInfoDataTable tblAccInfo = accinfo.GetLoanAccountInfo(Convert.ToInt32(MySessionManager.AccountID));
                if (tblAccInfo.Rows.Count > 0)
                {
                    if (tblAccInfo[0].IsdatOutstandingAmountNull() == false) { this.lnOutstanding.InnerText = tblAccInfo[0].datOutstandingAmount.ToString("c").Replace("$", ""); }
                    if (tblAccInfo[0].IsdatStartDateNull() == false) { this.lnStartDate.InnerText = tblAccInfo[0].datStartDate.ToLongDateString(); }
                    if (tblAccInfo[0].IsdatEndDateNull() == false) { this.lnEndDate.InnerText = tblAccInfo[0].datEndDate.ToLongDateString(); }
                    if (tblAccInfo[0].IsdatBranchNull() == false) { this.lnAccBranch.InnerText = tblAccInfo[0].datBranch.ToString(); }
                    this.btnTransactions.HRef = "~/pages/transactions.aspx?id" + MyEncryption.Encrypt(MySessionManager.AccountID.ToString(), "12345678910") + "&action=entry";
                    this.btnViewStatement.HRef = "~/pages/loanaccount/loanaccountdetails.aspx?id" + MyEncryption.Encrypt(MySessionManager.AccountID.ToString(), "12345678910") + "&action=2";
                    this.btnMonitorAccount.HRef = "~/pages/loanaccount/loanaccountdetails.aspx?id" + MyEncryption.Encrypt(MySessionManager.AccountID.ToString(), "12345678910") + "&action=1";

                    
                }

            }
            catch (Exception ex) { }


        }

        try
        {
            mainDSTableAdapters.GetClientInfoTableAdapter clientInfo = new mainDSTableAdapters.GetClientInfoTableAdapter();
            mainDS.GetClientInfoDataTable tblClientInfo = clientInfo.GetClientInfo(MySessionManager.ClientID);
            if (tblClientInfo.Rows.Count > 0)
            {
                if (tblClientInfo[0].IsdatClientNameNull() == false) { clientname.InnerText = tblClientInfo[0].datClientName.ToString(); }
                if (tblClientInfo[0].IsdatClientNumberNull() == false) {clientNo.InnerText = tblClientInfo[0].datClientNumber.ToString();}
                if (tblClientInfo[0].IsdatMobileNumber1Null() == false) { clMobile.InnerText = tblClientInfo[0].datMobileNumber1.ToString(); }
            }
        }
        catch (Exception ex) { }   
    }
    public string setUrls(int AppID)
    {
        Utility util = new Utility();
        string url = "";
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanapp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        int status = Convert.ToInt32(loanapp.getApplicationStatus(AppID).ToString());
        if (status ==2){ url = "~/pages/loanapplication/initialassesment.aspx?id="+MyEncryption.Encrypt(AppID.ToString(),"12345678910");}
        else if (status ==3) { url = "~/pages/loanapplication/preapproved.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status ==4) { url = "~/pages/loanapplication/appraisals.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status == 5) { url = "~/pages/loanapplication/risk.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status ==6) { url = "~/pages/loanapplication/legal.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status > 6 || status < 12)
        { url = "~/pages/loanapplication/approvals.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status == 12) { url = "~/pages/loanapplication/approvedloans.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        else if (status > 12 || status < 16) 
        { url = "~/pages/loanapplication/disbursement.aspx?id=" + MyEncryption.Encrypt(AppID.ToString(), "12345678910"); }
        
        return url;
    }
}
