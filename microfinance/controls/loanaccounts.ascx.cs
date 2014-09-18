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

public partial class controls_loanaccounts : System.Web.UI.UserControl
{
    public string id { set; get; }
    public string query { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noAccounts.InnerHtml = e.AffectedRows.ToString();
    }

    public void refreshData()
    {
        if (query.Length > 0)
        {
            SqlDataSource1.SelectCommand = query;
            gvAccounts.DataBind();

        }
    }
    protected void gvAccounts_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink Loan = (HyperLink)e.Row.FindControl("hyperLoan");
            HyperLink Inv = (HyperLink)e.Row.FindControl("hyperInv");

            string enpValue = MyEncryption.Encrypt(this.gvAccounts.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");

            //Loan.NavigateUrl = "~/pages/clients.aspx?product=loan&id=" + enpValue;
            Inv.NavigateUrl = "~/pages/loanaccountdetails.aspx?id=" + enpValue + "";
        }
    }
}
