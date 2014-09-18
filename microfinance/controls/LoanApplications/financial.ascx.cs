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

public partial class controls_financial : System.Web.UI.UserControl
{
    public string type { set; get; }
    public int id{ set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        //ListItem LItem = new ListItem("--Select--", "0");
        //ddlYear.Items.Insert(0, LItem);
        populateYears();

        if (!(Request.QueryString["fiedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["fiedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadfinancial(id);
            }
        }
        else if (!(Request.QueryString["fidelete"] == null))
        {
            int id = Convert.ToInt32(Request.QueryString["fidelete"]);
            loadfinancial(id);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.FinancialsTableAdapter financials = new LoanDSTableAdapters.FinancialsTableAdapter();
            if (!(type == "update"))
            {
                financials.InsertFinancials(MySessionManager.ClientID,
                                            MySessionManager.AppID,
                                            ddMonth.Text,
                                            ddlYear.Text,
                                            txtSales.Text,
                                            txtCostOfSales.Text,
                                            txtGrossProfit.Text,
                                            txtAdminCost.Text,
                                            txtNetProfit.Text,
                                            MySessionManager.CurrentUser.UserID);
            }
            else if (type == "update")
            {
                financials.UpdateFinancials(ddMonth.Text,
                                            ddlYear.Text,
                                            txtSales.Text,
                                            txtCostOfSales.Text,
                                            txtGrossProfit.Text,
                                            txtAdminCost.Text,
                                            txtNetProfit.Text,
                                            MySessionManager.CurrentUser.UserID,
                                            id);
            }
            Utility util = new Utility();
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "fiedit"));
        }
    }

    public void populateYears()
    {
       

        int startYr = DateTime.Now.Year-20;
        int endYr = DateTime.Now.Year;

        for (int i = startYr; i < endYr + 1; i++)
        {
            ddlYear.Items.Add(i.ToString());
        
                }
    
            }
    protected void gvFinancial_SelectedIndexChanged(object sender, EventArgs e)
    {
      

    }

    public void loadfinancial(int ID)
    {
        LoanDSTableAdapters.FinancialsTableAdapter financial = new LoanDSTableAdapters.FinancialsTableAdapter();
        LoanDS.FinancialsDataTable tblfinancial = financial.GetFinancials(MySessionManager.AppID, MySessionManager.ClientID);

            if (tblfinancial.Rows.Count > 0)
            {
                try
                {
                  if(Convert.ToInt32(tblfinancial[0].datYear)>0)  ddlYear.SelectedValue = tblfinancial[0].datYear.ToString();
                  if (Convert.ToInt32(tblfinancial[0].datMonth.Length)>0) { ddMonth.SelectedValue = tblfinancial[0].datMonth.ToString(); }
                }
                catch (Exception ex) { }    
                txtAdminCost.Text = tblfinancial[0].datAdminCost.ToString();
                txtCostOfSales.Text = tblfinancial[0].datCostOfSales.ToString();
                txtGrossProfit.Text = tblfinancial[0].datGrossOfProfit.ToString();
                txtNetProfit.Text = tblfinancial[0].datNetProfit.ToString();
                txtSales.Text = tblfinancial[0].datSales.ToString();
                this.editskip.Value = "2";
            }
   
        }
    protected void gvFinancial_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvFinancial.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&fiedit=" + enpValue;

            edit.NavigateUrl = urlpath;

        }
    }

    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            decimal m;
            int k;
            DateTime dt;
            if (!(Convert.ToInt32(ddlYear.SelectedValue) > 0)) { args.IsValid = false; ErrorMessage += "<p> Please select the year  </p>"; }
            if (!(Convert.ToInt32(ddMonth.SelectedValue) > 0)) { args.IsValid = false; ErrorMessage += "<p> Please select the month  </p>"; }
            if (!(Decimal.TryParse(txtAdminCost.Text, out m))) { args.IsValid = false; ErrorMessage += "<p> The Admin cost must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtCostOfSales.Text, out m))) { args.IsValid = false; ErrorMessage += "<p> The  cost of sales must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtGrossProfit.Text, out m))) { args.IsValid = false; ErrorMessage += "<p> The gross profit must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtNetProfit.Text, out m))) { args.IsValid = false; ErrorMessage += "<p> The Net amount be a decimal </p>"; }
            if (!(Decimal.TryParse(txtSales.Text, out m))) { args.IsValid = false; ErrorMessage += "<p> The sale must be a decimal </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }

    }
}

