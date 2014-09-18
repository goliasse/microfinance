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
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.AssetTypesTableAdapter assettypes = new adminTableAdapters.AssetTypesTableAdapter();
        if (!(type == "update"))
        {
            assettypes.InsertAssetType(txtDescription.Value.Trim());
        }
        else if (type == "update")
        {
            assettypes.UpdateAssetType(txtDescription.Value.Trim(),
                                       id);
        }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asedit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.AssetTypesTableAdapter assettypes = new adminTableAdapters.AssetTypesTableAdapter();
        admin.AssetTypesDataTable tblAssetType = assettypes.GetAssetType(id);

           if(tblAssetType.Rows.Count>0)
           {
              txtDescription.Value = tblAssetType[0].datDescription.ToString();
              this.editskip.Value  = "2";
           }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?asedit=" + enpValue;

            edit.NavigateUrl = urlpath;
        }

    }
}
