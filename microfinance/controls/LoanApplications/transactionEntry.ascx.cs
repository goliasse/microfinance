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

public partial class controls_transactionEntry : System.Web.UI.UserControl
{
    public decimal interestamt { set; get; }
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
      
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        lblbranch.InnerText = util.displayValue("tbl_teams", loanApp.GetLoanAppBranch(MySessionManager.AppID, MySessionManager.ClientID).ToString());
        mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        try
        { lblTotal.Text = tempHolder.GetTransTotalAmount(MySessionManager.AppID).ToString(); }
        catch (Exception ex)
        {
            lblTotal.Text = "0.00";
        }
        
        if (tblLoanApp.Rows.Count > 0)
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            lbltotalamt.InnerText = tblLoanApp[0].datLoanAmount.ToString("c").Replace("$", "");
            lbldate.InnerText = DateTime.Now.ToLongDateString();
            lblClient.InnerText = client.GetClientsName(MySessionManager.ClientID).ToString();
        
        }

        if (!(this.editskip.Value =="2"))
        {

        }
        if (!(Request.QueryString["trdelete"] == null))
        {
            try
            {
                string id = Request.QueryString["trdelete"];
                tempHolder.DeleteTransactionDetails(Convert.ToInt32(id), MySessionManager.AppID);

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "trdelete"));
            }
            catch
            { }
        }
        
    }
    protected void btnSaveTransaction_Click(object sender, EventArgs e)
    {

        int counter=0;
      
        mTempTableAdapters.GetTransactionDetailsTableAdapter transDetail = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        counter = Convert.ToInt32(transDetail.GetLastIndex(MySessionManager.AppID));
        decimal debit=Convert.ToDecimal(txtDBvalue.Value);
        decimal credit=Convert.ToDecimal (txtDBvalue.Value);
        decimal total=0;
        if(debit>0)
        {
            total=debit;
        }
        else if(credit>0)
        {
          total =-credit;
        }
        transDetail.InsertTransactionDetails(MySessionManager.AppID,
                                             counter+1,
                                             txtDescription.Value.Trim(),
                                             Convert.ToInt32(ddlPaymentMode.Text),
                                             Convert.ToInt32(ddlAccount.Text),
                                             Convert.ToDecimal(txtDBvalue.Value.Trim()),
                                             Convert.ToDecimal((txtDBvalue.Value.Trim())),
                                             total);
        
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
    }



    public void createAccount()
    {
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        mainDS.ClientDataTable tblClient = client.GetClientProfile(MySessionManager.ClientID);

        decimal interestrate = Convert.ToDecimal(tblLoanApp[0].datInterestRate.ToString());

        decimal IntAmt = (Convert.ToDecimal(lbltotalamt.InnerText)*(interestrate/100));
        interestamt = IntAmt;
        decimal AmtOut = Convert.ToDecimal(lbltotalamt.InnerText);
        decimal FinRptBalance_monthly = IntAmt+AmtOut;
        DateTime enddate = addMonth(DateTime.Now, Convert.ToInt32(tblLoanApp[0].datDuration.ToString()));

        if((tblClient.Rows.Count>0)||(tblLoanApp.Rows.Count>0))
        {
            int refreshedID = 0;
            if(tblLoanApp[0].IsdatRefreshedIDNull()==false)
            {
                refreshedID = tblLoanApp[0].datRefreshedID;
            }
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
                                      refreshedID,
                                      Convert.ToInt32(tblLoanApp[0].datCreditTeamID.ToString()),
                                      tblClient[0].datClientName.ToString(),
                                      Convert.ToInt32(tblLoanApp[0].datLoanType.ToString()));  
        }
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountDataTable tblLoanAc = loanAc.GetLoanAccount1(MySessionManager.AppID, MySessionManager.ClientID);

        if(tblLoanAc.Rows.Count>0)
        {
            MySessionManager.AccountID = tblLoanAc[0].datID;
            MySessionManager.AppBranchID= tblLoanApp[0].datTeamID;
        }
       
    }

    public void saveCreditTransaction(int datAccID, string batch, decimal credit, string accID, int weekno)
    {
            LoanDSTableAdapters.FinancialTransactionsTableAdapter finantrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
            finantrans.InsertFinancialTransaction(MySessionManager.ClientID,
                                                  MySessionManager.AppID,
                                                  Convert.ToInt32(accID),
                                                  datAccID,
                                                  "Interest on Loan Amount", 
                                                  batch,
                                                  0,
                                                  Convert.ToInt32("0"),
                                                  Convert.ToDecimal(credit),
                                                  0,
                                                  Convert.ToInt32(accID),
                                                  null,
                                                  weekno,
                                                  MySessionManager.CurrentUser.UserID
                                                  );

       
    }

    public void saveDebitTransaction(int datAccID,string batch,decimal debit, string accID,int weekno)
    {
        LoanDSTableAdapters.FinancialTransactionsTableAdapter finantrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
        finantrans.InsertFinancialTransaction(MySessionManager.ClientID,
                                              MySessionManager.AppID,
                                              Convert.ToInt32(accID),
                                              datAccID,
                                              "Interest on Loan Amount",
                                              batch,
                                              0,
                                              null,
                                              0,
                                              debit,
                                              null,
                                              Convert.ToInt32(accID),
                                              weekno,
                                              MySessionManager.CurrentUser.UserID
                                              );
    
  
    }
    
    public void saveDisburse(int accid, decimal cash, decimal bank)
    {
        Decimal totalAmt = cash+bank;
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountDataTable  tblLoanAcc = loanAcc.GetLoanAccount(accid);
        if(tblLoanAcc.Rows.Count>0)
        {
            
        LoanDSTableAdapters.GetDisburseLoanTableAdapter disburse = new LoanDSTableAdapters.GetDisburseLoanTableAdapter();
        disburse.InsertDisburseLoan(accid,
                                    tblLoanAcc[0].datAccountNumber.ToString(),
                                    tblLoanAcc[0].datClientFullName.ToString(),
                                    DateTime.Now,
                                    tblLoanAcc[0].datEndDate,
                                    tblLoanAcc[0].datInterestRate,
                                    cash,
                                    bank,
                                    totalAmt,
                                    tblLoanAcc[0].datFees,
                                    tblLoanAcc[0].datLoanType,
                                    tblLoanAcc[0].datPurpose,
                                    tblLoanAcc[0].datTeamID,
                                    tblLoanAcc[0].datCreditTeamID,
                                    MySessionManager .CurrentUser.UserID);

             }
    }

 
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        MySessionManager.cash = 0;
        MySessionManager.bank = 0;
        decimal amtDeductable = 0;
        decimal fees = 0;
        decimal amt = 0;
        int ops = 0;

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        
        int status =Convert.ToInt32(loanApp.getApplicationStatus(MySessionManager.AppID));

        util.UpdateApplicationStatus("Forward Application", status);

        createAccount();
        
        mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        mTemp.GetTransactionDetailsDataTable tblTempHolder =tempHolder.GetTempTransactions(MySessionManager.AppID);
        LoanDSTableAdapters.FinancialTransactionsTableAdapter fintrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
        int rows =tblTempHolder.Rows.Count;
 
        for(int i=0;i<rows;i++)
        {
            int? datDebitAc=null;
            int? datCreditAc= null;
            if (tblTempHolder[i].datDebit > 0)
            {
                datDebitAc = tblTempHolder[i].datAccountID;
                amt = tblTempHolder[i].datDebit;

                ops = 1;
            }
            else if (tblTempHolder[i].datCredit > 0)
            {
                datCreditAc = tblTempHolder[i].datAccountID;
                amt = tblTempHolder[i].datCredit;
                ops = 2;
            }
            //
            if (tblTempHolder[i].datPaymentMethod == 1)
            {
                getAmtForPaymentMode(amt, "cash", ops);
            }
            else if (tblTempHolder[i].datPaymentMethod == 2)
            {
                getAmtForPaymentMode(amt, "bank", ops);
            }
             fintrans.InsertFinancialTransaction(MySessionManager.AppID,
                                                 MySessionManager.ClientID,
                                                 tblTempHolder[i].datAccountID,
                                                 Convert.ToInt32(MySessionManager.AccountID),
                                                 tblTempHolder[i].datDescription,
                                                 batch(),
                                                 tblTempHolder[i].datPaymentMethod,
                                                 MySessionManager.AppBranchID,
                                                 tblTempHolder[i].datCredit,
                                                 tblTempHolder[i].datDebit,
                                                 datCreditAc,
                                                 datDebitAc,
                                                 0,
                                                 MySessionManager.CurrentUser.UserID); 
        }
        saveDisburse(Convert.ToInt32(MySessionManager.AccountID),MySessionManager.cash,MySessionManager.bank);
        saveCreditTransaction(Convert.ToInt32(MySessionManager.AccountID), batch(),interestamt, "1", 1);
        saveDebitTransaction(Convert.ToInt32(MySessionManager.AccountID),batch(),interestamt ,"1",0);
        interest_payment_dates(MySessionManager.AppID,Convert.ToInt32(MySessionManager.AccountID),DateTime.Now,12);

        Response.Redirect("~/pages/loanapplications.aspx");
    }

    protected void gvDisburseLoan_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");

            string enpValue = this.gvDisburseLoan.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&trdelete=" + enpValue;

            delete.NavigateUrl = urlpathDel;
        }
    }

    public string createAccountNumber(int ClientID)
    {
        string CNo = "";
        CNo = "L"+ CNo +DateTime.Now.Year.ToString()+DateTime.Now.Minute.ToString();
        CNo = CNo + ClientID.ToString()+"-00";

        return CNo;
    
    }

    public DateTime addMonth(DateTime myDate, int months)
    {
        myDate = myDate.AddDays(0).AddMonths(months);
        return myDate;
    }

    protected void lblTotal_TextChanged(object sender, EventArgs e)
    {
        if (Convert.ToDecimal((lblTotal.Text)) == 0)
        {
            btnFinalize.Visible = true;
        }
        else
        { btnFinalize.Visible = false; }
    }

    public void interest_payment_dates(int AppID,int AccID,DateTime date,int duration)
    {
        LoanDSTableAdapters.InsertInterestDateTableAdapter intDates = new LoanDSTableAdapters.InsertInterestDateTableAdapter();
        DateTime startDate=date;
        DateTime[] curentDate = new DateTime[duration];
        string strDate;
        for (int i = 0; i<12; i++)
        {

            if (i == 0)
            {
                curentDate[i] = startDate;
                strDate = startDate.Month.ToString() + "-" + startDate.Day.ToString();
                intDates.InsertInterestDates(AccID, AppID, strDate);
            }
            else
            {
                DateTime dt = startDate.AddMonths(i);
                int prevMnths = curentDate[i - 1].Month;
                if (dt.Month > prevMnths + 1)
                {
                    dt = lastDay(curentDate[i - 1].Month, curentDate[i - 1].Year);
                    strDate = dt.Month.ToString() + "-" + dt.Day.ToString();
                    intDates.InsertInterestDates(AccID, AppID, strDate);
                }
                else
                {
                    curentDate[i] = dt;
                    strDate = dt.Month.ToString() + "-" + dt.Day.ToString();
                    intDates.InsertInterestDates(AccID, AppID, strDate);
                }
            }
        } 
    }

    public DateTime lastDay(int Month, int Year)
    {
        DateTime output = new DateTime(Year, Month, DateTime.DaysInMonth(Year,Month));
        return output;
    }

    public string batch()
    {
        string t = "";
        DateTime date = DateTime.Now;
        t = "B343" + (date.Second + date.Minute + date.Hour).ToString();

        return t;
    }
    public void getAmtForPaymentMode(decimal amt, string type,int ops)
    {
        if (type == "cash")
        {
            MySessionManager.cash =MySessionManager.cash + amt;
        }
        else if (type == "bank")
        {
            MySessionManager.bank = MySessionManager.bank + amt;
        }
    }
}
