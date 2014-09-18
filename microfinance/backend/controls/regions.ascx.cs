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
        if (!(Request.QueryString["rgedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["rgedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadRegion(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "rgedit")); }
        }
      
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.GetOptRegionTableAdapter region = new adminTableAdapters.GetOptRegionTableAdapter();

        if (!(type == "update"))
        {

            region.InsertRegion(txtDescription.Value.Trim());
        }
        else if (type == "update")
        {
           region.UpdateRegion(txtDescription.Value.Trim(),
                               id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "rgedit"));
    }

    public void loadRegion(int id)
    {
        adminTableAdapters.GetOptRegionTableAdapter region = new adminTableAdapters.GetOptRegionTableAdapter();
        admin.GetOptRegionDataTable tbl = region.GetOptRegionDetails(id);

        if (tbl.Rows.Count > 0)
        {
            txtDescription.Value = tbl[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
        }
    protected void gvRoles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvRoles.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?rgedit=" + enpValue;
           // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
           // delete.NavigateUrl = urlpathDel;
        }

    }
}
