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
using System.Globalization;

public partial class controls_Fees : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
       

        LoanDSTableAdapters.PDCTableAdapter  loanApp = new LoanDSTableAdapters.PDCTableAdapter();
        //txtLoanAmt.Value = Convert.ToString(loanApp.Get(MySessionManager.AppID, MySessionManager.ClientID)).ToString();

        if (!(Request.QueryString["pedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["pedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadpdc(id);
            }
        }
        else if (!(Request.QueryString["pdelete"] == null))
        {
            try
            {
                string id = Request.QueryString["pdelete"];
                util.deleteItem("tbl_pdc", id);

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "pdelete"));
            }
            catch
            { }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                // fetch the en-GB culture
                CultureInfo ukCulture = new CultureInfo("en-GB");
                // pass the DateTimeFormat information to DateTime.Parse
                DateTime dt = DateTime.Parse(txtDate.Text, ukCulture.DateTimeFormat);
                LoanDSTableAdapters.PDCTableAdapter pdc = new LoanDSTableAdapters.PDCTableAdapter();
                if (!(type == "update"))
                {

                    pdc.InsertPDC(MySessionManager.ClientID,
                                  MySessionManager.AppID,
                                  txtBank.Value.Trim(),
                                  dt,
                                  txtchequeno.Value.Trim(),
                                  Convert.ToDecimal(txtAmt.Value.Trim()),
                                  0,
                                  MySessionManager.CurrentUser.UserID);
                }
                else if (type == "update")
                {
                    pdc.UpdatePDC(txtBank.Value.Trim(),
                                  dt,
                                  txtchequeno.Value.Trim(),
                                  Convert.ToDecimal(txtAmt.Value.Trim()),
                                  0,
                                  MySessionManager.CurrentUser.UserID,
                                  MySessionManager.ClientID,
                                  MySessionManager.AppID);
                }

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "pedit"));
            }
            catch (Exception ex) { }

        }
    }
    protected void gvFees_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvFees.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&pedit=" + enpValue;

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&pdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
    public void loadpdc(int id)
    {
        LoanDSTableAdapters.PDCTableAdapter  pdc = new LoanDSTableAdapters.PDCTableAdapter();
        LoanDS.PDCDataTable tblPDC = pdc.GetPDCDetails(id);

        if (tblPDC.Rows.Count > 0)
        {
            txtAmt.Value = tblPDC[0].datAmount.ToString();
            txtchequeno.Value = tblPDC[0].datCheque.ToString();
            txtBank.Value = tblPDC[0].datBank.ToString();
            txtDate.Text = tblPDC[0].datDate.ToString("dd-MM-yyyy");
            this.editskip.Value="2";
        }
    
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            CultureInfo ukCulture = new CultureInfo("en-GB");
            decimal m;
            int k;
            DateTime dt;
            if (txtBank.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the bank </p>"; }
            if (txtchequeno.Value == "") { args.IsValid = false; ErrorMessage += "<p> The cheque number cannot be blank </p>"; }
            if (!(Decimal.TryParse(txtAmt.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The amount must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            if (!(DateTime.TryParse(txtDate.Text,ukCulture ,DateTimeStyles.None ,out dt))) { args.IsValid = false; ErrorMessage += "<p> The date is not in the correct format </p>"; }
            if ((dt - DateTime.Now).TotalDays < 0) { args.IsValid = false; ErrorMessage += "<p> The date must be greater than today's date </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}

