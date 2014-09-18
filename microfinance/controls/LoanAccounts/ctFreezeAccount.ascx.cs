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

public partial class controls_LoanAccounts_ctFreezeAccount : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try {
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountRow tblLoanAccRow = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];

            lblClientFullname.InnerText = tblLoanAccRow.datClientFullName.ToString();
            loanAmtOutstanding.InnerText = tblLoanAccRow.datOutstandingAmount.ToString("c").Replace("$", "");
            lblDuration.InnerText = tblLoanAccRow.datDuration.ToString()+" month(s)";
            lblExpiryDate.InnerText = tblLoanAccRow.datEndDate.ToString("D");
            lblInterestRate.InnerText = tblLoanAccRow.datInterestRate.ToString("c").Replace("$", "") + "%";
            lblLoanAmount.InnerText = tblLoanAccRow.datInitialAmount.ToString("c").Replace("$", "");
            lblLoanDate.InnerText = tblLoanAccRow.datStartDate.ToString("D");
            lblCategory.InnerText = util.displayValue("opt_categories", tblLoanAccRow.datCategory.ToString());

        
        }
        catch (Exception ex) { }
    }
    protected void btnFreezeAccount_Click(object sender, EventArgs e)
    {
        try { 
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountRow tblLoanAccRow = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
            LoanAccountDSTableAdapters.FrozenAccountsTableAdapter loanFreeze = new LoanAccountDSTableAdapters.FrozenAccountsTableAdapter();
            loanFreeze.InsertFrozenAccount(Convert.ToInt32(MySessionManager.AccountID),
                                           tblLoanAccRow.datAccountNumber,
                                           tblLoanAccRow.datTeamID,
                                           tblLoanAccRow.datPurpose,
                                           tblLoanAccRow.datOutstandingAmount,
                                           tblLoanAccRow.datCategory,
                                           DateTime.Now,
                                           tblLoanAccRow.datCreditTeamID,
                                           tblLoanAccRow.datClientFullName,
                                           tblLoanAccRow.datAgingDate,
                                           tblLoanAccRow.datLoanType);

            loanAcc.UpdateSetFrozenAccount(Convert.ToInt32(MySessionManager.AccountID));
            ShowMessageBox("Account No.:" + tblLoanAccRow.datAccountNumber + "- " + tblLoanAccRow.datClientFullName + " has been frozen");
        }
        catch (Exception ex) { }
    }
    protected void btnUnFreezeAccount_Click(object sender, EventArgs e)
    {
        try
        {
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountRow tblLoanAccRow = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
            LoanAccountDSTableAdapters.FrozenAccountsTableAdapter loanFreeze = new LoanAccountDSTableAdapters.FrozenAccountsTableAdapter();
            loanFreeze.InsertUnfrozenAccount(Convert.ToInt32(MySessionManager.AccountID),
                                             tblLoanAccRow.datAccountNumber,
                                             tblLoanAccRow.datTeamID,
                                             tblLoanAccRow.datPurpose,
                                             tblLoanAccRow.datOutstandingAmount,
                                             tblLoanAccRow.datCategory,
                                             DateTime.Now,
                                             tblLoanAccRow.datCreditTeamID,
                                             tblLoanAccRow.datClientFullName,
                                             tblLoanAccRow.datAgingDate,
                                             tblLoanAccRow.datLoanType);

            loanAcc.UpdateSetUnfrozenAccount(Convert.ToInt32(MySessionManager.AccountID));
            ShowMessageBox("Account No.:" + tblLoanAccRow.datAccountNumber + "- " + tblLoanAccRow.datClientFullName + " has been un-frozen");
        }
        catch (Exception ex) { }
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
