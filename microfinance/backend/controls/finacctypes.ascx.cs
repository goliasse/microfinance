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

public partial class controls_assets : System.Web.UI.UserControl
{
    public string type { set; get; }
    public int id { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["faedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["faedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadAsset(id);
            }
        }
        else if (!(Request.QueryString["fadelete"] == null))
        {
            string id = Request.QueryString["fadelete"];
            util.deleteItem("opt_finance_acc_types", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "fadelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.FinanceAccTypesTableAdapter financeAcc = new adminTableAdapters.FinanceAccTypesTableAdapter();
       
        if (!(type == "update"))
        { 
            financeAcc.InsertFinanceAccTypes(txtDescription.Value.Trim());
        }
        else if(type=="update")
        {
            financeAcc.UpdateFinanceAccountType(txtDescription.Value.Trim(),
                                                id);
       }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "faedit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.FinanceAccTypesTableAdapter financeAcc = new adminTableAdapters.FinanceAccTypesTableAdapter();
        
        admin.FinanceAccTypesDataTable tblFinanceAcc = financeAcc.GetFinanceAccTypeDetails(id);

           if(tblFinanceAcc.Rows.Count>0)
           {
              txtDescription .Value = tblFinanceAcc[0].datDescription .ToString();
              this.editskip.Value  = "2";
           }
        }
    protected void gvFinanceAcc_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvFinanceAcc.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?faedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "?fadelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;
        }

    }
    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
}
