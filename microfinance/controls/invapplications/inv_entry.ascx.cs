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

public partial class controls_invapplications_inv_entry : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
        InvestmentDS.GetInvestmentAppDataTable tblInvApp = InvApp.GetInvestmentApp(MySessionManager.InvAppID);
        
        mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
        try
        { lblTotal.Text = tempHolder.GetTransTotalAmount(MySessionManager.AppID).ToString(); }
        catch (Exception ex)
        {
            lblTotal.Text = "0.00";
        }
       
        if (tblInvApp.Rows.Count > 0)
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            lbltotalamt.InnerText = tblInvApp[0].datInvestmentAmount.ToString("c").Replace("$", "");
            lbldate.InnerText = DateTime.Now.ToLongDateString();
            lblClient.InnerText = client.GetClientsName(MySessionManager.ClientID).ToString();
            lblbranch.InnerText = util.displayValue("tbl_teams", InvApp.GetInvBranch(MySessionManager.InvAppID).ToString());
        }

        if (!(this.editskip.Value == "2"))
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
        try
        {

            int counter = 0;

            mTempTableAdapters.GetTransactionDetailsTableAdapter transDetail = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
            counter = Convert.ToInt32(transDetail.GetInvLastIndex(MySessionManager.AppID));
            decimal debit = Convert.ToDecimal(txtDBvalue.Value);
            decimal credit = Convert.ToDecimal(txtDBvalue.Value);
            decimal total = 0;
            if (debit > 0)
            {
                total = debit;
            }
            else if (credit > 0)
            {
                total = -credit;
            }
            transDetail.InsertInvTransactionDetails(counter + 1,
                                                    txtDescription.Value.Trim(),
                                                    Convert.ToInt32(ddlPaymentMode.Text),
                                                    Convert.ToInt32(ddlAccount.Text),
                                                    Convert.ToDecimal(txtDBvalue.Value.Trim()),
                                                    Convert.ToDecimal(txtDBvalue.Value.Trim()),
                                                    total,
                                                    MySessionManager.InvAppID );

            Page.Response.Redirect(Request.RawUrl);


        }
        catch (Exception ex) { }
    }
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        try
        {
            MySessionManager.cash = 0;
            MySessionManager.bank = 0;
            decimal amtDeductable = 0;
            decimal fees = 0;
            decimal amt = 0;
            int ops = 0;

            mTempTableAdapters.GetTransactionDetailsTableAdapter tempHolder = new mTempTableAdapters.GetTransactionDetailsTableAdapter();
            mTemp.GetTransactionDetailsDataTable tblTempHolder = tempHolder.GetInvTempTransactions(MySessionManager.InvAppID);
            LoanDSTableAdapters.FinancialTransactionsTableAdapter fintrans = new LoanDSTableAdapters.FinancialTransactionsTableAdapter();
            int rows = tblTempHolder.Rows.Count;

            for (int i = 0; i < rows; i++)
            {
                int? datDebitAc = null;
                int? datCreditAc = null;
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
                fintrans.InsertFinancialTransaction(MySessionManager.InvAppID,
                                                    MySessionManager.ClientID,
                                                    tblTempHolder[i].datAccountID,
                                                    MySessionManager.InvAppID,
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
                
                 
        }
        catch(Exception ex) { }

        //This block of code changes the status of the application
        try
        {
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateApplicationStatus(3, MySessionManager.InvAppID);
            Response.Redirect("~/pages/invapplications.aspx");

        }
        catch (Exception ex) { }
    }
    protected void gvInvEntry_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");

            string enpValue = this.gvInvEntry.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&trdelete=" + enpValue;

            delete.NavigateUrl = urlpathDel;
        }
    }
    protected void lblTotal_TextChanged(object sender, EventArgs e)
    {

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
   
    public void saveDebitTransaction(int datAccID, string batch, decimal debit, string accID, int weekno)
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
   
    public void getAmtForPaymentMode(decimal amt, string type, int ops)
    {
        if (type == "cash")
        {
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
