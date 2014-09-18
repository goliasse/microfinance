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
    public string type{ set; get; }
    public int id  { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        try{
        if (!(Request.QueryString["ftedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["ftedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadFeeType(id);
            }
          Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ftedit")); 
        }
        }
        catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ftedit")); }
        //else if (!(Request.QueryString["ftasdelete"] == null))
        //{
        //    string id = Request.QueryString["ftdelete"];
        //    util.deleteItem("opt_fee_types", id);
        //    Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ftdelete"));
        //}
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.FeeTypeTableAdapter feetype = new adminTableAdapters.FeeTypeTableAdapter();
        if (!(type == "update"))
        {
           
            feetype.InsertFeeType(txtDescription.Value.Trim());
        }
        else if(type=="update")
        {
            feetype.UpdateFeeType(txtDescription.Value.Trim(),
                                  id);
       }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ftedit"));
    }

    public void loadFeeType(int id)
    {
        adminTableAdapters.FeeTypeTableAdapter feetype = new adminTableAdapters.FeeTypeTableAdapter();
        admin.FeeTypeDataTable tblFeeType = feetype.GetFeeTypeDetails(id);

           if(tblFeeType.Rows.Count>0)
           {
              txtDescription .Value = tblFeeType[0].datDescription.ToString();
              this.editskip.Value  = "2";
           }
        }
    protected void gvFeeType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvFeeType.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?ftedit=" + enpValue;
            //////string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "?ftdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            ////delete.NavigateUrl = urlpathDel;
        }

    }
    protected void gvFeeType_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
