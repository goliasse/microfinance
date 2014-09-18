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
        if (!(Request.QueryString["ctedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["ctedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadct(id);
            }
        }
        else if (!(Request.QueryString["ctdelete"] == null))
        {
            string id = Request.QueryString["ctdelete"];
            util.deleteItem("sys_credit_teams", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ctdelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.CreditTeamTableAdapter ct = new adminTableAdapters.CreditTeamTableAdapter();
        if (!(type == "update"))
        {

            ct.InsertCreditTeam(txtDescription.Value,
                                Convert.ToInt32(ddlBranch.SelectedValue),
                                1);
        }
        else if (type == "update")
        {
            ct.UpdateCreditTeam(txtDescription.Value.Trim(),
                                Convert.ToInt32(ddlBranch.SelectedValue),
                                1,
                                id);
        }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ctedit"));
    }

    public void loadct(int id)
    {
          adminTableAdapters.CreditTeamTableAdapter  ct = new adminTableAdapters.CreditTeamTableAdapter();
        admin.CreditTeamDataTable  tblct = ct.GetCreditTeamDetail(id);
        
           if(tblct.Rows.Count>0)
           {
              txtDescription .Value = tblct[0].datDescription .ToString();
              if (tblct[0].datTeamID > 0) { ddlBranch.SelectedValue = tblct[0].datTeamID.ToString(); }
              this.editskip.Value  = "2";
           }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?ctedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "?ctdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;
        }

    }
}
