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

public partial class controls_creditinformation : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }
    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (!(Request.QueryString["ctedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["ctedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadCreditinfo(id);
            }
        }
        else if (!(Request.QueryString["ctdelete"] == null))
        {
            string  id = Request.QueryString["ctdelete"];
            util.deleteItem("tbl_credit_information", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ctdelete"));
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
                DateTime issueDate = DateTime.Parse(txtIssueDate.Text, ukCulture.DateTimeFormat);

                DateTime expiryDate = DateTime.Parse(txtExpiryDate.Text, ukCulture.DateTimeFormat);

                LoanDSTableAdapters.CreditInformationTableAdapter creditinfo = new LoanDSTableAdapters.CreditInformationTableAdapter();
                if (!(type == "update"))
                {
                    creditinfo.InsertCreditInformation(MySessionManager.ClientID,
                                                       MySessionManager.AppID,
                                                       txtcreditor.Value.Trim(),
                                                       txtDescription.Value.Trim(),
                                                       Convert.ToDecimal(txtcreditvalue.Value.Trim()),
                                                       Convert.ToDecimal(txtMonthlyRepayment.Value.Trim()),
                                                       Convert.ToDecimal(txtOutstandingamt.Value.Trim()),
                                                       issueDate,
                                                       expiryDate
                                                       );
                }
                else
                {
                    creditinfo.updateCreditInformation(txtcreditor.Value.Trim(),
                                                       txtDescription.Value.Trim(),
                                                       Convert.ToDecimal(txtcreditvalue.Value.Trim()),
                                                       Convert.ToDecimal(txtMonthlyRepayment.Value.Trim()),
                                                       Convert.ToDecimal(txtOutstandingamt.Value.Trim()),
                                                       issueDate,
                                                       expiryDate,
                                                       1,
                                                       id);
                }
            }
            catch (Exception ex) { }






            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ctedit"));
        }
    }

    protected void gvCreditinformation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvCreditinformation.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&ctedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&ctdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }

    public void loadCreditinfo(int id)
    {
        LoanDSTableAdapters.CreditInformationTableAdapter creditinfo = new LoanDSTableAdapters.CreditInformationTableAdapter();
        LoanDS.CreditInformationDataTable tblcreditinfo = creditinfo.GetCreditInformationDetails(id);
        this.editskip.Value = "2";
        if (tblcreditinfo.Rows.Count > 0)
        {
            try
            {
                txtcreditor.Value = tblcreditinfo[0].datCreditor.ToString();
                txtcreditvalue.Value = tblcreditinfo[0].datCreditValue.ToString();
                txtDescription.Value = tblcreditinfo[0].datDescription.ToString();
                txtExpiryDate.Text = tblcreditinfo[0].datExpiryDate.ToString("dd-MM-yyyy");
                txtIssueDate.Text = tblcreditinfo[0].datIssueDate.ToString("dd-MM-yyyy");
                txtMonthlyRepayment.Value = tblcreditinfo[0].datMonthlyObligation.ToString();
                txtOutstandingamt.Value = tblcreditinfo[0].datOutstanding.ToString();
            }
            catch (Exception ex)
            {}
        }
    
    
        }
    protected void txtExpiryDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime issueDate = DateTime.Parse(txtIssueDate.Text, ukCulture.DateTimeFormat);
            DateTime expiryDate = DateTime.Parse(txtExpiryDate.Text, ukCulture.DateTimeFormat);

            if (issueDate > expiryDate)
            { ShowMessageBox("The Issue Date cannot be greater than the Expiry date"); }
            else { }

        }
        catch (Exception ex) { }


    }
    protected void txtIssueDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime issueDate = DateTime.Parse(txtIssueDate.Text, ukCulture.DateTimeFormat);
            DateTime expiryDate = DateTime.Parse(txtExpiryDate.Text, ukCulture.DateTimeFormat);

            if (issueDate > expiryDate)
            { ShowMessageBox("The Issue Date cannot be greater than the Expiry date"); }
            else { }

        }
        catch (Exception ex) { }
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            Type type;
            decimal m;
            int k;
            DateTime dt;
            DateTime dt1;
            if (txtcreditor.Value=="") { args.IsValid = false; ErrorMessage += "<p>The Creditor name cannot be empty </p>"; }
            if (!(Decimal.TryParse(txtcreditvalue.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The credit value must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtMonthlyRepayment.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value monthly repayment  must be a decimal </p>"; }
            if (!(DateTime.TryParse(txtIssueDate.Text, out dt1))) { args.IsValid = false; ErrorMessage += "<p> The Issue date is not in the correct format</p>"; }
            if (!(DateTime.TryParse(txtExpiryDate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The Expiry date is not in the correct format</p>"; }
            if ((dt - dt1).TotalDays < 0) { ErrorMessage += "<p>The issue date should not be less than expiry date </p>"; args.IsValid = false; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
