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
public partial class controls_area : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(Request.QueryString["aredit"] == null))
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["aredit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadAsset(id);
                }
            }
        }
        catch (Exception ex){
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "aredit"));
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.AreasTableAdapter area = new adminTableAdapters.AreasTableAdapter();
        if (!(type == "update"))
        {

            area.InsertArea(txtArea.Value.Trim());
        }
        else if (type == "update")
        {
            area.UpdateArea(txtArea.Value.Trim(),
                            id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "aredit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.AreasTableAdapter area = new adminTableAdapters.AreasTableAdapter();
        admin.AreasDataTable tblArea = area.GetArea(id);
        
        if (tblArea.Rows.Count > 0)
        {
            txtArea.Value = tblArea[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
      }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?aredit=" + enpValue;
           
            edit.NavigateUrl = urlpath;
         
        }

    }
}
