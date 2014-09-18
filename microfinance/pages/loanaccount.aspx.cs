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

public partial class pages_loanaccount : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        MySessionManager.CurrentTab = "";
        MySessionManager.AccountID = 0;

    }
    protected void txtSearchClient_TextChanged(object sender, EventArgs e)
    {
        if (txtSearchTerm.Text == "")
        {
            this.loanaccounts2.query = "SELECT     tbl_loan_accounts.datID, tbl_loan_accounts.datClientFullName, tbl_loan_accounts.datAccountNumber, opt_loan_types.datDescription AS loantype, "
                                     + " tbl_client.datEmailAddress "
                                     + " FROM tbl_loan_accounts INNER JOIN "
                                     + " tbl_client ON tbl_loan_accounts.datClientID = tbl_client.datID INNER JOIN "
                                     + " opt_loan_types ON tbl_loan_accounts.datLoanType = opt_loan_types.datID ";
            this.loanaccounts2.refreshData();
        }
        else
        {
            string searhterm = txtSearchTerm.Text.Trim();
            this.loanaccounts2.query = "SELECT     tbl_loan_accounts.datID, tbl_loan_accounts.datClientFullName, tbl_loan_accounts.datAccountNumber, opt_loan_types.datDescription AS loantype, "
                                 + " tbl_client.datEmailAddress "
                                 + " FROM tbl_loan_accounts INNER JOIN "
                                 + " tbl_client ON tbl_loan_accounts.datClientID = tbl_client.datID INNER JOIN "
                                 + " opt_loan_types ON tbl_loan_accounts.datLoanType = opt_loan_types.datID "
                                 + " WHERE     (tbl_loan_accounts.datClientFullName LIKE '%" + searhterm + "%') OR"
                                 + " (opt_loan_types.datDescription LIKE '%" + searhterm + "%') OR "
                                 + " (tbl_client.datEmailAddress LIKE '%" + searhterm + "%') OR "
                                 + " (tbl_loan_accounts.datAccountNumber LIKE '%" + searhterm + "%')";
            this.loanaccounts2.refreshData();
        }
    
    
    }
}
