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

public partial class backend_controls_roles : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["redit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["redit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadRole(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "redit")); }
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
        adminTableAdapters.GetRolesTableAdapter roles = new adminTableAdapters.GetRolesTableAdapter(); 

        if (!(type == "update"))
        {
            roles.InsertRole(txtrole.Value.Trim(),
                             Convert.ToDecimal(txtApprovalLimit.Value.Trim()),
                             Convert.ToInt32(txtSessionDuration.Value.Trim()),
                             txtEmailAddress.Value.Trim());
                            
          
        }
        else if (type == "update")
        {
            roles.UpdateRoles(txtrole.Value.Trim(),
                             Convert.ToDecimal(txtApprovalLimit.Value.Trim()),
                             Convert.ToInt32(txtSessionDuration.Value.Trim()),
                             txtEmailAddress.Value.Trim(),
                             id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "redit"));
    }

    public void loadRole(int id)
    {
        try
        {
            adminTableAdapters.GetRolesTableAdapter roles = new adminTableAdapters.GetRolesTableAdapter();
            admin.GetRolesDataTable tbl = roles.GetRolesDetail(id);
            if (tbl.Rows.Count > 0)
            {
                txtrole.Value = tbl[0].datDescription.ToString();
                txtApprovalLimit.Value = tbl[0].datApprovalLimit.ToString();
                txtSessionDuration.Value = tbl[0].datSessionDuration.ToString();
                txtEmailAddress.Value = tbl[0].datEmailAddress.ToString();
                this.editskip.Value = "2";
            }
        }
        catch (Exception ex) { }
        }
    protected void gvRoles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvRoles.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?redit=" + enpValue;
           // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
           // delete.NavigateUrl = urlpathDel;
        }

    }
}
