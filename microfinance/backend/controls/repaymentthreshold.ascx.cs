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
            if (!(Request.QueryString["rtedit"] == null))
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["rtedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadAsset(id);
                }
            }
        }
        catch (Exception ex){ Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "rtedit"));}
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        adminTableAdapters.GetOptRepaymentThresholdTableAdapter RT = new adminTableAdapters.GetOptRepaymentThresholdTableAdapter();
        if (!(type == "update"))
        {

            RT.InsertRepaymentThreshold(txtDescription.Value.Trim(),
                                        Convert.ToDecimal(txtMinLimit.Value.Trim()),
                                        Convert.ToDecimal(txtMaxLimit.Value.Trim()));
        }
        else if (type == "update")
        {
            RT.UpdateRepaymentThreshold(txtDescription.Value.Trim(),
                                        Convert.ToDecimal(txtMinLimit.Value.Trim()),
                                        Convert.ToDecimal(txtMaxLimit.Value.Trim()),
                                        id);
        }

        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "rtedit"));
    }

    public void loadAsset(int id)
    {
        adminTableAdapters.GetOptRepaymentThresholdTableAdapter RT = new adminTableAdapters.GetOptRepaymentThresholdTableAdapter();
        admin.GetOptRepaymentThresholdDataTable tbl = RT.GetRepaymentThresholdDetails(id);
        
        if (tbl.Rows.Count > 0)
        {
            txtDescription.Value = tbl[0].datDescription.ToString();
            txtMaxLimit.Value = tbl[0].datMax.ToString();
            txtMinLimit.Value = tbl[0].datMin.ToString();
            this.editskip.Value = "2";
        }
      }
    protected void gvRT_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvRT.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?rtedit=" + enpValue;
           
            edit.NavigateUrl = urlpath;
         
        }

    }
}
