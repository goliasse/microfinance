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
        if (!(Request.QueryString["msedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["msedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadMarital(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "msedit")); }
        }
        else if (!(Request.QueryString["asdelete"] == null))
        {
            string id = Request.QueryString["asdelete"];
            util.deleteItem("tbl_assets", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asdelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.MaritalStatusesTableAdapter mstatus = new adminTableAdapters.MaritalStatusesTableAdapter();
        if (!(type == "update"))
        {
            mstatus.InsertMaritalStatus(txtdescription.Value.Trim());
          
        }
        else if (type == "update")
        {
            mstatus.UpdateMaritalStatus(txtdescription.Value.Trim(),
                                        id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "msedit"));
    }

    public void loadMarital(int id)
    {
        adminTableAdapters.MaritalStatusesTableAdapter mstatus = new adminTableAdapters.MaritalStatusesTableAdapter();
        admin.MaritalStatusesDataTable tbl = mstatus.GetMaritalStatus(id);
        if (tbl.Rows.Count > 0)
        {
            txtdescription.Value = tbl[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?msedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
           // delete.NavigateUrl = urlpathDel;
        }

    }
}
