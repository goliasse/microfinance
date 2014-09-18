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
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["ltedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["ltedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadLoanType(id);
                }
            }
            catch (Exception ex)
            { }
        }
        else if (!(Request.QueryString["ltdelete"] == null))
        {
            string id = Request.QueryString["ltdelete"];
           // util.deleteItem("tbl_assets", id);
            //Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asdelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.LoanTypesTableAdapter loanTypes = new adminTableAdapters.LoanTypesTableAdapter();
        if (!(type == "update"))
        {

            loanTypes.InsertLoanTypes(txtDescription.Value.Trim());
        }
        else if (type == "update")
        {
            loanTypes.UpdateLoanType(txtDescription.Value.Trim(),
                                     id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ltedit"));
    }

    public void loadLoanType(int id)
    {
        
        adminTableAdapters.LoanTypesTableAdapter loantype = new adminTableAdapters.LoanTypesTableAdapter();
        admin.LoanTypesDataTable tblLoanTypes = loantype.GetLoanType(id);

        if (tblLoanTypes.Rows.Count > 0)
        {
            txtDescription.Value = tblLoanTypes[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?ltedit=" + enpValue;
            

            edit.NavigateUrl = urlpath;
           //delete.NavigateUrl = urlpathDel;
        }

    }
}
