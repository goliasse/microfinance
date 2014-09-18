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
        try
        {
            if (!(Request.QueryString["lcedit"] == null))
            {
                type = "update";
                id = Convert.ToInt32(Request.QueryString["lcedit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadLoanCat(id);
                }
               // Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lcedit"));
            }
        }
        catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lcedit")); }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            adminTableAdapters.GetLoanCategoriesTableAdapter loanCategories = new adminTableAdapters.GetLoanCategoriesTableAdapter();
            if (!(type == "update"))
            {
                loanCategories.InsertLoanCategories(txtCategories.Value.Trim(),
                                                    Convert.ToInt32(txtMinDays.Value.Trim()),
                                                    Convert.ToInt32(txtMaxDays.Value.Trim()),
                                                    ddlPerformance.SelectedValue,
                                                    Convert.ToDecimal(txtPF.Value.Trim()));

            }
            else if (type == "update")
            {
                loanCategories.UpdateLoanCategories(txtCategories.Value.Trim(),
                                                    Convert.ToInt32(txtMinDays.Value.Trim()),
                                                    Convert.ToInt32(txtMaxDays.Value.Trim()),
                                                    ddlPerformance.SelectedValue,
                                                    Convert.ToDecimal(txtPF.Value),
                                                    id);
            }

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "lcedit"));
        }
        catch (Exception ex) { }
    }

    public void loadLoanCat(int id)
    {
        adminTableAdapters.GetLoanCategoriesTableAdapter loanCat = new adminTableAdapters.GetLoanCategoriesTableAdapter();
        admin.GetLoanCategoriesDataTable tbl = loanCat.GetLoanCategoriesDetails(id);

        if (tbl.Rows.Count > 0)
        {
            txtCategories.Value = tbl[0].datDescription.ToString();
            txtMinDays.Value = tbl[0].datMinDays.ToString();
            txtMaxDays.Value = tbl[0].datMaxDays.ToString();
            if (tbl[0].datPerformance.ToString().Length > 0) { ddlPerformance.SelectedValue = tbl[0].datPerformance.ToString(); }
           // txtPerformance.Value = tbl[0].datPerformance.ToString();
            txtPF.Value = tbl[0].datProvisionFactor.ToString();
            this.editskip.Value = "2";

        }
    }
    protected void gvloanCat_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvloanCat.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?lcedit=" + enpValue;
            // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            // delete.NavigateUrl = urlpathDel;
        }

    }
}
