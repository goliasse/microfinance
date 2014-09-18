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
        if (!(Request.QueryString["psedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["psedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadPremiseStatus(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "psedit")); }
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.PremisesStatusTableAdapter pmstatus = new adminTableAdapters.PremisesStatusTableAdapter();
        if (!(type == "update"))
        {
            pmstatus.InsertPremisesStatus(txtdescription.Value);
          
        }
        else if (type == "update")
        {
           pmstatus.UpdatePremisesStatus(txtdescription.Value.Trim(), 
                               id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "psedit"));
    }

    public void loadPremiseStatus(int id)
    {
        adminTableAdapters.PremisesStatusTableAdapter pmstatus = new adminTableAdapters.PremisesStatusTableAdapter();
        admin.PremisesStatusDataTable tbl = pmstatus.GetPremisasStatusDetails(id);
        if (tbl.Rows.Count > 0)
        {
            txtdescription.Value = tbl[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
        }
    protected void gvPremisesStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvPremisesStatus.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?psedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            //delete.NavigateUrl = urlpathDel;
        }

    }
}
