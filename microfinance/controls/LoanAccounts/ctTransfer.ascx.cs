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

public partial class controls_LoanAccounts_ctTransfer : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            LoanAccountDS.GetLoanAccountRow tblLoanAccRow = loanAcc.GetLoanAccount(Convert.ToInt32(MySessionManager.AccountID))[0];
            lblBranch.InnerText = util.displayValue("tbl_teams", tblLoanAccRow.datTeamID.ToString());
            lblCreditTeam.InnerText = util.displayValue("sys_credit_teams", tblLoanAccRow.datCreditTeamID.ToString());

        }
        catch (Exception ex) { }
    }
    protected void btnAccountTransfer_Click(object sender, EventArgs e)
    {
        try
        {
            LoanAccountDSTableAdapters.GetLoanAccountTableAdapter loanAcc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
            loanAcc.AccountTransfer(Convert.ToInt32(ddlNewBranch.Text),
                                    Convert.ToInt32(ddlNewCT.Text),
                                    Convert.ToInt32(MySessionManager.AccountID));
            ShowMessageBox("Account has been transfered successfully");
            MySessionManager.CurrentTab = "";
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
