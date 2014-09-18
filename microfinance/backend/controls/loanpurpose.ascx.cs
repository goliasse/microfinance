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
        if (!(Request.QueryString["lpedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["lpedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadLoanPurpose(id);
                }
                //Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lpedit"));
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lpedit")); }
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.GetLoanPurposeTableAdapter loanpurpose = new adminTableAdapters.GetLoanPurposeTableAdapter();
        if (!(type == "update"))
        {
            loanpurpose.InsertLoanPurpose(txtdescription.Value.Trim(),1);
          
        }
        else if (type == "update")
        {
            loanpurpose.UpdateLoanPurpose(txtdescription.Value.Trim(),
                                          1,
                                          id);
        }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lpedit"));
    }

    public void loadLoanPurpose(int id)
    {
        adminTableAdapters.GetLoanPurposeTableAdapter loanpurpose = new adminTableAdapters.GetLoanPurposeTableAdapter();
        admin.GetLoanPurposeDataTable tbl = loanpurpose.GetLoanPurposeDetails(id);

           if(tbl.Rows.Count>0)
           {
              txtdescription.Value = tbl[0].datDescription.ToString();
              this.editskip.Value  = "2";
           }
        }
    protected void gvloanPurpose_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvloanPurpose.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?lpedit=" + enpValue;
           // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
          //  delete.NavigateUrl = urlpathDel;
        }

    }
}
