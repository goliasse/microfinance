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
        if (!(Request.QueryString["asedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["asedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadAsset(id);
            }
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
        LoanDSTableAdapters.AssetsTableAdapter Assets = new LoanDSTableAdapters.AssetsTableAdapter();
        if (!(type == "update"))
        {
           
            Assets.InsertAsset(MySessionManager.ClientID,
                               MySessionManager.AppID,
                               Convert.ToInt32(ddlAssetType.Text),
                               txtDescription.Value.Trim(),
                               Convert.ToInt32(txtvalue.Value.Trim()),
                               MySessionManager.CurrentUser.UserID);
        }
        else if(type=="update")
        {
            Assets.UpdateAsset(Convert.ToInt32(ddlAssetType.Text),
                               txtDescription.Value.Trim(),
                               MySessionManager.AppID,
                               MySessionManager.ClientID,
                               Convert.ToInt32(txtvalue.Value.Trim()),
                               1,
                               MySessionManager.CurrentUser.UserID,
                               id);
       }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asedit"));
    }

    public void loadAsset(int id)
    {
        LoanDSTableAdapters.AssetsTableAdapter assets = new LoanDSTableAdapters.AssetsTableAdapter();
        LoanDS.AssetsDataTable tblAssets = assets.GetAssetDetails(id);

           if(tblAssets.Rows.Count>0)
           {
              txtDescription .Value = tblAssets[0].datDescription .ToString();
              txtvalue .Value =tblAssets[0].datValue.ToString();
              ddlAssetType.SelectedIndex= ddlAssetType.Items.IndexOf(ddlAssetType.Items.FindByValue(tblAssets[0].datAssetTypeID.ToString()));
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

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&asedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;
        }

    }
}
