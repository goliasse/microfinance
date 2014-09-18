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
        if (!(Request.QueryString["idedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["idedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadIndustry(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "idedit")); }
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
        adminTableAdapters.GetIndustryTableAdapter industry = new adminTableAdapters.GetIndustryTableAdapter();

        if (!(type == "update"))
        {

            industry.InsertIndustry(txtDescription.Value);
        }
        else if(type=="update")
        {
             industry.UpdateIndustry(txtDescription.Value.Trim(),
                                     id);
       }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "idedit"));
    }
    
    public void loadIndustry(int id)
    {
        adminTableAdapters.GetIndustryTableAdapter industry = new adminTableAdapters.GetIndustryTableAdapter();
        admin.GetIndustryDataTable tbl = industry.GetIndustryDetails(id);

           if(tbl.Rows.Count>0)
           {
              txtDescription.Value = tbl[0].datDescription.ToString();
              this.editskip.Value  = "2";
           }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?idedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
           /// delete.NavigateUrl = urlpathDel;
        }

    }
}
