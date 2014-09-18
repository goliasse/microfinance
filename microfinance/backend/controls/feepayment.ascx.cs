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
        if (!(Request.QueryString["fpedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["fpedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadAsset(id);
            }
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "fpedit"));
        }
        //else if (!(Request.QueryString["asdelete"] == null))
        //{
        //    string id = Request.QueryString["asdelete"];
        //    util.deleteItem("op", id);
        //    Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asdelete"));
        //}
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.AssetsTableAdapter Assets = new LoanDSTableAdapters.AssetsTableAdapter();
        if (!(type == "update"))
        {
            adminTableAdapters.GetFeePaymentTableAdapter feepayment = new adminTableAdapters.GetFeePaymentTableAdapter();
            feepayment.InsertFeePayment(txtvalue.Value.Trim());
        }
        else if(type=="update")
        {
             adminTableAdapters.GetFeePaymentTableAdapter feepayment = new adminTableAdapters.GetFeePaymentTableAdapter();
            feepayment.UpdateFeePayment(txtvalue.Value.Trim(),
                                        id);
       }
       
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "asedit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.GetFeePaymentTableAdapter feepayment = new adminTableAdapters.GetFeePaymentTableAdapter();
        admin.GetFeePaymentDataTable tblFeePayment = feepayment.GetFeePaymentDetails(id);
           if(tblFeePayment.Rows.Count>0)
           {
              
              txtvalue.Value =tblFeePayment[0].datDescription.ToString();
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

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?fpedit=" + enpValue;
            //string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
           // delete.NavigateUrl = urlpathDel;
        }

    }
}
