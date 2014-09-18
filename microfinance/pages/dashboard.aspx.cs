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

public partial class dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/logout.aspx");
        }
        
        this.dbi_databar1.Visible =false;
        this.dbi_financials1 .Visible =false;
        this.dbi_payments1.Visible= false;
        this.dbi_portfolios1 .Visible=false;
        this.dbi_debt_provision1.Visible = false;
        mainDSTableAdapters.GetMenuItemsTableAdapter menuItems = new mainDSTableAdapters.GetMenuItemsTableAdapter();
        mainDS.GetMenuItemsDataTable tblMenuItems =menuItems.GetMenuItems(MySessionManager.CurrentUser.UserID);

        if (tblMenuItems.Rows.Count > 0)
        {
            foreach (mainDS.GetMenuItemsRow r in tblMenuItems)
            {
                if (r.datType.ToString() == "Dashboard")
                {
                    if (r.datControlName.ToString() == "LoanDisbursement")
                    {
                        this.dbi_databar1.Visible = true;
                    }
                    else if (r.datControlName.ToString() == "LoanRepayment")
                    {
                        this.dbi_payments1.Visible = true;
                    }
                    else if (r.datControlName.ToString() == "LoanInterestIncome")
                    {
                        this.dbi_financials1.Visible = true;
                    }
                    else if (r.datControlName.ToString() == "LoanDebtProvision")
                    {
                        this.dbi_debt_provision1.Visible = true;
                    }
                    else if (r.datControlName.ToString() == "LoanCategories")
                    {
                        this.dbi_portfolios1.Visible = true;
                    }
                }
            }
        }
    }
}
