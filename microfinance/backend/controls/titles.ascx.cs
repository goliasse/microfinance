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
        if (!(Request.QueryString["tedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["tedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadAsset(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tedit")); }
        }
        //else if (!(Request.QueryString["asdelete"] == null))
        //{
        //    string id = Request.QueryString["asdelete"];
        //    util.deleteItem("tbl_assets", id);
        //    Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asdelete"));
        //}
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.TitlesTableAdapter title = new adminTableAdapters.TitlesTableAdapter();

        if (!(type == "update"))
        {
            title.InsertTitle(txtDescription.Value);
         
        }
        else if (type == "update")
        {
           title.UpdateTitle(txtDescription.Value,
                             id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tedit"));
    }

    public void loadAsset(int id)
    {
        try
        {
            adminTableAdapters.TitlesTableAdapter title = new adminTableAdapters.TitlesTableAdapter();
            admin.TitlesDataTable tbl = title.GetTitle(id);
            if (tbl.Rows.Count > 0)
            {
                txtDescription.Value = tbl[0].datDescription.ToString();
                this.editskip.Value = "2";
            }
        }
        catch (Exception ex) { }
        }
    protected void gvTitle_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvTitle.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?tedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            //delete.NavigateUrl = urlpathDel;
        }

    }
}
