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
using System.Runtime.InteropServices;

public partial class controls_Fees : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        ListItem LItem = new ListItem("--Select--", "0");
        ddlFee.Items.Insert(0, LItem);
        ddlPaymentMode.Items.Insert(0, LItem);

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        if (tblLoanApp.Rows.Count > 0)
        {
            txtUpdatedLoanAmt.Text = tblLoanApp[0].datLoanAmount.ToString("c").Replace("$", "");
            txtUpddateDisburseAmt.Text = tblLoanApp[0].datDisburseAmount.ToString("c").Replace("$", "");
        
        }
        txtLoanAmt.Value = Convert.ToString(loanApp.GetLoanAmount(MySessionManager.AppID, MySessionManager.ClientID)).ToString();

        if (!(Request.QueryString["fedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["fedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadfee(id);
            }
        }
        else if (!(Request.QueryString["fdelete"] == null))
        {
            try
            {
                string id = Request.QueryString["fdelete"];
               updateLoanAmount("delete", 0, 0, Convert.ToInt32(id));
                util.deleteItem("tbl_fees", id);
               
                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "fdelete"));
            }
            catch
            { }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.LoanFeesTableAdapter fee = new LoanDSTableAdapters.LoanFeesTableAdapter();
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            decimal amt = Convert.ToDecimal(txtAmt.Value.Trim());
            int pmode = Convert.ToInt32(ddlPaymentMode.Text);
            if (!(type == "update"))
            {

                fee.InsertLoanFee(MySessionManager.ClientID,
                                  MySessionManager.AppID,
                                  Convert.ToInt32(ddlFee.Text),
                                  pmode,
                                  Convert.ToDecimal(txtPercentage.Value),
                                  amt);
            }
            else if (type == "update")
            {
                fee.UpdateLoanFees(Convert.ToInt32(ddlFee.Text),
                                   Convert.ToInt32(ddlPaymentMode.Text),
                                   Convert.ToDecimal(txtPercentage.Value),
                                   amt,
                                   id);
            }
            updateLoanAmount("add", amt, pmode, 0);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "fedit"));
        }
    }
    protected void gvFees_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            //HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvFees.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&fedit=" + enpValue;

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&fdelete=" + enpValue;

            //edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
    public void loadfee(int id)
    {
        LoanDSTableAdapters.LoanFeesTableAdapter fees = new LoanDSTableAdapters.LoanFeesTableAdapter();
        LoanDS.LoanFeesDataTable tblLoanFees = fees.GetLoanFeeDetails(id);

        if (tblLoanFees.Rows.Count > 0)
        {

            txtAmt.Value = tblLoanFees[0].datAmount.ToString();
            txtPercentage.Value = tblLoanFees[0].datPercentage.ToString();
            ddlFee.SelectedIndex = ddlFee.Items.IndexOf(ddlFee.Items.FindByValue(tblLoanFees[0].datFeeTypeID.ToString()));
            ddlPaymentMode.SelectedIndex = ddlPaymentMode .Items.IndexOf(ddlPaymentMode.Items.FindByValue (tblLoanFees[0].datFeePaymentID.ToString() ));
            this.editskip.Value="2";
        }
    
    }


    public void updateLoanAmount(string type,decimal value, int pmode, int id)
    {
      
        decimal loanAmt=0;
        decimal diburseAmt=0;
        decimal pplanAmt=0;
        decimal fees=0;
        LoanDSTableAdapters.LoanFeesTableAdapter fee = new LoanDSTableAdapters.LoanFeesTableAdapter();
        
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        if (tblLoanApp.Rows.Count > 0)
        {
            loanAmt = tblLoanApp[0].datLoanAmount;
            diburseAmt = tblLoanApp[0].datDisburseAmount;
            pplanAmt = tblLoanApp[0].datPaymentPlanAmount;
           try
           {
                fees = tblLoanApp[0].datFees;
            }
           catch(Exception ex)
           {
                fees = 0;
            }
           

            if (type == "delete")
            {
               LoanDS.LoanFeesDataTable tblfee = fee.GetLoanFeeDetails(id);
               pmode= tblfee[0].datFeePaymentID;
               value = tblfee[0].datAmount;
                if (pmode == 1)
                {
                    diburseAmt = diburseAmt - value;
                    pplanAmt = pplanAmt - value;
                }
                else if (pmode == 2)
                {
                    diburseAmt = diburseAmt + value;
                }
                else if (pmode == 3)
                {
                    fees = fees - value;
                }
            }
            else if (type == "add")
            {
                if (pmode == 1)
                {
                    diburseAmt = diburseAmt + value;
                    pplanAmt = pplanAmt + value;
                }
                else if (pmode == 2)
                {
                    diburseAmt = diburseAmt - value;
                }
                else if (pmode == 3)
                {
                    fees = fees + value;
                }
            }
            
        }
        loanApp.UpdateLoanAmountComponents(diburseAmt, pplanAmt, fees,MySessionManager.AppID, MySessionManager.ClientID); 
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

            if (!(Decimal.TryParse(txtPercentage.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The percentage must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtAmt.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The fee must be a decimal </p>"; }
            if (!((Convert.ToInt32(ddlFee.SelectedValue)) > 0)) { args.IsValid = false; ErrorMessage += "<p> Please select the fee to charged </p>"; }
            if (!((Convert.ToInt32(ddlPaymentMode.SelectedValue))>0)) { args.IsValid = false; ErrorMessage += "<p> Please select the payment mode </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}

