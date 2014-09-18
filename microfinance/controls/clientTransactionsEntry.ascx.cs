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

public partial class controls_clientTransactionsEntry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Page.IsPostBack == false)
        {
            SqlDataSource1.SelectParameters["search"].DefaultValue = " ";
            gvTransactionClientList.DataBind();
        }
    }
    protected void txtSearchClient_TextChanged(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["search"].DefaultValue = txtSearchTerm.Text;
        gvTransactionClientList.DataBind();
    }
    protected void gvTransactionClientList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
        {
            string enpValue = MyEncryption.Encrypt(this.gvTransactionClientList.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");
            

            HyperLink link = (HyperLink) e.Row.FindControl("HyperEntry");
            link.NavigateUrl = HttpContext.Current.Request.Url.AbsoluteUri+"?id="+ enpValue +"&action=entry";
    

        
        }
    }
}
