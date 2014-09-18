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

public partial class controls_mainTransactions : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        #region QueryStringBlock
        if (Request.QueryString["id"] != null)
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.AccountID = DecID;
            //  ShowMessageBox(" " + DecID + " ");
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountDataTable tblLoanAcc = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID));
            if (tblLoanAcc.Rows.Count > 0)
            {
                lblClient.InnerText = tblLoanAcc[0].datClientFullName.ToString();
                lblbranch.InnerText = util.displayValue("tbl_teams", tblLoanAcc[0].datTeamID.ToString());
                lbldate.InnerText = tblLoanAcc[0].datStartDate.ToLongDateString();
                lbltotalamt.InnerText = tblLoanAcc[0].datOutstandingAmount.ToString("C").Replace("$", "");
            }
        }
        if (!(Request.QueryString["trdelete"] == null))
        {
            try
            {
                string id = Request.QueryString["trdelete"];
                tempHolder.DeleteTransactionDetails1( Convert.ToInt32(MySessionManager.AccountID),Convert.ToInt32(id));

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "trdelete"));
            }
            catch
            { }
        }
        #endregion
        try
        { lblTotal.Text = tempHolder.GetTransTotalAmount(MySessionManager.AppID).ToString(); }
        catch (Exception ex)
        {
            lblTotal.Text = "0.00";
        }
    
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
    protected void btnSaveTransaction_Click(object sender, EventArgs e)
    {

        int counter = 0;

        mTempTableAdapters.GetTransactionDetailsTableAdapter transDetail = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        counter = Convert.ToInt32(transDetail.GetAccLastIndex(Convert.ToInt32 (MySessionManager.AccountID)));
        decimal debit = Convert.ToDecimal(txtDBvalue.Value);
        decimal credit = Convert.ToDecimal(txtCRvalue.Value);
        decimal total = 0;
        if (debit > 0)
        {
            total = debit;
        }
        else if (credit > 0)
        {
            total = -credit;
        }
        transDetail.InsertTransactionsDetails(counter + 1,
                                             txtDescription.Value.Trim(),
                                             Convert.ToInt32(ddlPaymentMode.Text),
                                             Convert.ToInt32(ddlAccount.Text),
                                             Convert.ToDecimal(txtDBvalue.Value.Trim()),
                                             Convert.ToDecimal((txtCRvalue.Value.Trim())),
                                             total,
                                             Convert.ToInt32(MySessionManager.AccountID));
        Page.Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri); 

    }
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        MySessionManager.cash = 0;
        MySessionManager.bank = 0;
        decimal amtDeductable= 0;
        decimal fees = 0;
        decimal amt =0;
        int ops =0;
        mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        mTemp.GetTransactionDetailsDataTable tblTempHolder = tempHolder.GetAccTransactions(Convert.ToInt32( MySessionManager.AccountID));
        LoanDSTableAdapters.FinancialTransactionsTableAdapter fintrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
        int rows = tblTempHolder.Rows.Count;

        for (int i = 0; i < rows; i++)
        {
            int? datDebitAc = null;
            int? datCreditAc = null;
            if (tblTempHolder[i].datDebit > 0)
            {
                datDebitAc = tblTempHolder[i].datAccountID;
                amt=tblTempHolder[i].datDebit;
                amtDeductable = amtDeductable + tblTempHolder[i].datDebit;
                ops = 1;
            }
            else if (tblTempHolder[i].datCredit > 0)
            {
                datCreditAc = tblTempHolder[i].datAccountID;
                amt = tblTempHolder[i].datCredit;
                amtDeductable = amtDeductable - tblTempHolder[i].datCredit;
                ops = 2;
            }
            //
            if (tblTempHolder[i].datPaymentMethod == 1)
            {
                getAmtForPaymentMode(amt,"cash",ops);
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
                                                MySessionManager.CurrentUser.BranchID,
                                                tblTempHolder[i].datCredit,
                                                tblTempHolder[i].datDebit,
                                                datCreditAc,
                                                datDebitAc,
                                                0,
                                                MySessionManager.CurrentUser.UserID);
        }

        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
        LoanAccountDS.GetLoanAccountDataTable tblLoaonAcc = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID));
        LoanAccountDSTableAdapters.GetAllLoanRepaymentsTableAdapter repayment = new LoanAccountDSTableAdapters.GetAllLoanRepaymentsTableAdapter();

        if(tblLoaonAcc.Rows.Count>0)
        {
            repayment.InsertLoanRepayment(receiptNo(),
                                          DateTime.Now,
                                          tblLoaonAcc[0].datID,
                                          tblLoaonAcc[0].datAccountNumber.ToString(),
                                          client.GetClientNo(Convert.ToInt32(MySessionManager.AccountID)),
                                          tblLoaonAcc[0].datIssueDate,
                                          tblLoaonAcc[0].datInterestRate,
                                          MySessionManager.cash,
                                          MySessionManager.bank,
                                          (MySessionManager.cash + MySessionManager.bank),
                                          fees,
                                          tblLoaonAcc[0].datLoanType,
                                          tblLoaonAcc[0].datPurpose,
                                          tblLoaonAcc[0].datTeamID,
                                          MySessionManager.CurrentUser.UserID);
        }

        loanAcc.UpdateNewAmtOutstanding(amtDeductable,Convert.ToInt32(MySessionManager.AccountID));

        decimal outstanding=Convert.ToDecimal(loanAcc.GetAmtOutstanding(Convert.ToInt32(MySessionManager.AccountID)));
        if (outstanding <= 0)
        {
            loanAcc.UpdateCloseAccount(Convert.ToInt32(MySessionManager.AccountID));
        }
        tempHolder.DeleteTempTransByAccID(Convert.ToInt32(MySessionManager.AccountID));
    }



    public string receiptNo()
    { return ""; }

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
    protected void lblTotal_TextChanged(object sender, EventArgs e)
    {
        if (Convert.ToDecimal((lblTotal.Text)) == 0)
        {
            btnFinalize.Visible = true;
        }
        else
        { btnFinalize.Visible = false; }
    }
    protected void gvDisburseLoan_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");

            string enpValue = this.gvDisburseLoan.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&trdelete=" + enpValue;

            delete.NavigateUrl = urlpathDel;
        }
    }
    public void getAmtForPaymentMode(decimal amt, string type, int ops)
    {
        if (type == "cash")
        { 
            //if
            MySessionManager.cash = MySessionManager.cash + amt;
        }
        else if (type == "bank")
        {
            MySessionManager.bank = MySessionManager.bank + amt;
        }
    }

    public string batch()
    {
        string t = "";
        DateTime date = DateTime.Now;
        t = "B343" + (date.Second + date.Minute + date.Hour).ToString();

        return t;
    }
}
