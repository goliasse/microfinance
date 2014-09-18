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
        if (!(Request.QueryString["itedit"] == null))
        {
            try
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["itedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadIntRate(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "itedit")); }
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.GetInterestRateTypesTableAdapter IntRateType = new adminTableAdapters.GetInterestRateTypesTableAdapter();
        if (!(type == "update"))
        {
            IntRateType.InsertInterestRateDetails(txtDescription.Value);
        }
        else if(type=="update")
        {
            IntRateType.UpdateInterestRateTypes(txtDescription.Value,
                                                id);
       }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "itedit"));
    }

    public void loadIntRate(int id)
    {
        try
        {
            adminTableAdapters.GetInterestRateTypesTableAdapter IntRateType = new adminTableAdapters.GetInterestRateTypesTableAdapter();
            admin.GetInterestRateTypesDataTable tbl = IntRateType.GetInterestRatesDetail(id);
            if (tbl.Rows.Count > 0)
            {
                txtDescription.Value = tbl[0].datDescription.ToString();
                this.editskip.Value = "2";
            }
        }
        catch (Exception ex) { }
        }
    protected void gvAsset_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAsset.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?itedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            //delete.NavigateUrl = urlpathDel;
        }

    }
}
