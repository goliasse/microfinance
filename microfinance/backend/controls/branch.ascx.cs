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
        if (!(Request.QueryString["bredit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["bredit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadAsset(id);
            }
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        adminTableAdapters.BranchTableAdapter Branch = new adminTableAdapters.BranchTableAdapter();
        if (!(type == "update"))
        {

             Branch.InsertBranch(txtBranch.Value.Trim(),
                                 Convert.ToInt32(ddlArea.Text),
                                 txtaddress.Value,
                                 txtTelephone.Value);
        }
        else if (type == "update")
        {
            Branch.UpdateBranch(txtBranch.Value.Trim(),
                                Convert.ToInt32(ddlArea.Text),
                                txtaddress.Value,
                                txtTelephone.Value,
                                id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "bredit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.BranchTableAdapter branch = new adminTableAdapters.BranchTableAdapter();
        admin.BranchDataTable tblBranch = branch.GetBranchDetails(id);

           if(tblBranch.Rows.Count>0)
           {
               try
               {
                   this.editskip.Value = "2";
                   txtBranch.Value = tblBranch[0].datDescription.ToString();
                   txtaddress.Value = tblBranch[0].datAddress.ToString();
                   ddlArea.SelectedIndex = ddlArea.Items.IndexOf(ddlArea.Items.FindByValue(tblBranch[0].datLocation.ToString()));
                   txtTelephone.Value = tblBranch[0].datTelephone.ToString();
               }
               catch (Exception ex) { }
               
           }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?bredit=" + enpValue;
           // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            //delete.NavigateUrl = urlpathDel;
        }

    }
}
