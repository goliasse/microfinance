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

public partial class controls_LoanAccounts_ctRefreshment : System.Web.UI.UserControl
{
    public decimal interestamt { set; get; }
    public int OldAccount { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter LoanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountRow tblLoanAcc = LoanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
            txtIntRate.Text = tblLoanAcc.datInterestRate.ToString();
            txtLoanAmount.Text = tblLoanAcc.datOutstandingAmount.ToString();
            if (tblLoanAcc.datLoanType > 0){ddlLoanType.SelectedValue = tblLoanAcc.datLoanType.ToString();}
            if (tblLoanAcc.datInterestRateType > 0) { ddlInterestRateType.SelectedValue = tblLoanAcc.datInterestRateType.ToString(); }
            
        }
        catch (Exception ex) { }


    }
    protected void btnSaveNewApplication_Click(object sender, EventArgs e)
    {
        createNewApp();

    }

    public void createNewApp()
    {
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter LoanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountRow tblLoanAcc = LoanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];

        string AppID;
        string AppNewID = "";
        try
        {
            LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter RefreshAccount = new LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter();
            LoanAccountDS.GetAccountRefreshmentRecordDataTable tblRefreshAccount = RefreshAccount.GetAccountRefreshmentRecord(Convert.ToInt32(MySessionManager.AccountID));

            if (tblRefreshAccount.Rows.Count>0)
            {
                MySessionManager.AppID = tblRefreshAccount[0].datNewAppID;
            }
            else
            {
                int? getAppID = null;

                AppID = tblLoanAcc.datApplicationID.ToString();
                LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
                LoanAccountDSTableAdapters.AccountRefreshmentTableAdapter LoanAccRefreshment = new LoanAccountDSTableAdapters.AccountRefreshmentTableAdapter();

                string appNo = loanApp.GetLoanApplicationNo(Convert.ToInt32(AppID)).ToString() + "-00";
                LoanAccRefreshment.InsertNewRefreshApp(MySessionManager.ClientID,
                                                       tblLoanAcc.datClientFullName.ToString(),
                                                       Convert.ToInt32(ddlLoanType.SelectedValue),
                                                       appNo,
                                                       Convert.ToDecimal(txtLoanAmount.Text),
                                                       Convert.ToDecimal(txtLoanAmount.Text),
                                                       Convert.ToDecimal(txtLoanAmount.Text),
                                                       Convert.ToInt32(txtDuration.Text),
                                                       1,
                                                       Convert.ToDecimal(txtIntRate.Text),
                                                       DateTime.Now,
                                                       Convert.ToDateTime(txtFirstPaymentDate.Text),
                                                       0,
                                                       Convert.ToInt32(ddlInterestRateType.SelectedValue),
                                                       Convert.ToInt32(AppID),
                                                       Convert.ToInt32(ddlCT.SelectedValue),
                                                       Convert.ToInt32(tblLoanAcc.datTeamID),
                                                       ref getAppID);

                AppNewID = getAppID.ToString();

                LoanAccRefreshment.InsertCopyAssets(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyAuditors(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyBankers(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyChecklist(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyCollaterals(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyComments(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyCorporateInfo(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyCreditInformation(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyEnterprises(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyFees(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyFinancials(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyGuarantor(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyIncomeExpense(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyIntiator(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyLegalReports(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyNextOfKin(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyNoOfEmployees(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyOwnership(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyPaymentPlan(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyPDC(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyPreApprovalReports(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyReligion(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyReports(AppID, AppNewID);
                LoanAccRefreshment.InsertCopyRiskReport(AppID, AppNewID);
                LoanAccRefreshment.InsertCopySpouse(AppID, AppNewID);
                LoanAccRefreshment.InsertCopySupportingDocuments(AppID, AppNewID);

                LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter loanAcRef = new LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter();
                loanAcRef.InsertAccountRefreshment(Convert.ToInt32(MySessionManager.AccountID),
                                                   Convert.ToInt32(AppID));
                loanAcRef.UpdateNewAppID(Convert.ToInt32(AppNewID),
                                         Convert.ToInt32(MySessionManager.AccountID));
                MySessionManager.AppID = Convert.ToInt32(AppNewID);
            }
        }
        catch (Exception ex) { }
    }


    public void completeRefreshment()
    {
        int OldAppID=0;

        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountDataTable tblLoanAcc = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID));

        LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter loanAccRefRecord = new LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter();
        LoanAccountDS.GetAccountRefreshmentRecordDataTable tblLoanAccRefRecord = loanAccRefRecord.GetAccountRefreshmentRecord(Convert.ToInt32(MySessionManager.AccountID));
        OldAccount = tblLoanAccRefRecord[0].datOldAppID;

        if(tblLoanAcc.Rows.Count>0)
        {
         createAccount(tblLoanAcc[0].datOutstandingAmount);
        }

        LoanDSTableAdapters.FinancialTransactionsTableAdapter FinTrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
        FinTrans.InsertFinancialTransaction(OldAppID,
                                            MySessionManager.ClientID,
                                            1,
                                            tblLoanAcc[0].datID,
                                            "Account Refreshed",
                                            "closed",
                                            0,
                                            tblLoanAcc[0].datTeamID,
                                            tblLoanAcc[0].datOutstandingAmount,
                                            0,
                                            0,
                                            0,
                                            0,
                                            MySessionManager.CurrentUser.UserID
                                            );

        LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter loanAcRef = new LoanAccountDSTableAdapters.GetAccountRefreshmentRecordTableAdapter();
        loanAcRef.UpdateSetAccountClosed(Convert.ToInt32(MySessionManager.AccountID));


        loanAccRefRecord.UpdateNewAccountID(Convert.ToInt32(MySessionManager.AccountID), tblLoanAcc[0].datID);

    }


    public void createAccount(decimal AmtOut1)
    {

       //LoanAccountDS. 

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        mainDS.ClientDataTable tblClient = client.GetClientProfile(MySessionManager.ClientID);

        decimal interestrate = Convert.ToDecimal(tblLoanApp[0].datInterestRate.ToString());

        decimal IntAmt = (Convert.ToDecimal(AmtOut1) * (interestrate / 100));
        interestamt = IntAmt;
        decimal AmtOut = Convert.ToDecimal(AmtOut1);
        decimal FinRptBalance_monthly = IntAmt + AmtOut;
        DateTime enddate = addMonth(DateTime.Now, Convert.ToInt32(tblLoanApp[0].datDuration.ToString()));

        if ((tblClient.Rows.Count > 0) || (tblLoanApp.Rows.Count > 0))
        {

            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter account = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            account.InsertLoanAccount(createAccountNumber(MySessionManager.ClientID),
                                      Convert.ToDecimal(tblLoanApp[0].datFees.ToString()),
                                      MySessionManager.ClientID,
                                      MySessionManager.AppID,
                                      Convert.ToInt32(tblLoanApp[0].datTeamID.ToString()),
                                      DateTime.Now,
                                      enddate,
                                      Convert.ToInt32(tblLoanApp[0].datInterestRate),
                                      Convert.ToInt32(tblLoanApp[0].datDuration.ToString()),
                                      0,
                                      IntAmt,
                                      AmtOut,
                                      FinRptBalance_monthly,
                                      MySessionManager.CurrentUser.UserID,
                                      FinRptBalance_monthly,
                                      DateTime.Now,
                                      DateTime.Now,
                                      Convert.ToInt32(tblLoanApp[0].datPurpose.ToString()),
                                      IntAmt,
                                      Convert.ToInt32(tblLoanApp[0].datRefreshedID.ToString()),
                                      Convert.ToInt32(tblLoanApp[0].datCreditTeamID.ToString()),
                                      tblClient[0].datClientName.ToString(),
                                      Convert.ToInt32(tblLoanApp[0].datLoanType.ToString()));
        }
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountDataTable tblLoanAc = loanAc.GetLoanAccount1(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblLoanAc.Rows.Count > 0)
        {
            MySessionManager.AccountID = tblLoanAc[0].datID;
            MySessionManager.AppBranchID = tblLoanApp[0].datTeamID;
        }

    }

    public string createAccountNumber(int ClientID)
    {
        string CNo = "";
        CNo = "C" + CNo + DateTime.Now.Year.ToString() + DateTime.Now.Minute.ToString();
        CNo = CNo + ClientID.ToString() + "-01";

        return CNo;

    }

    public DateTime addMonth(DateTime myDate, int months)
    {
        myDate = myDate.AddDays(0).AddMonths(months);
        return myDate;
    }
}
