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

public partial class controls_paymentvoucher : System.Web.UI.UserControl
{
    public int id { set; get; }
    public string type { set; get; }
    public string typefv { set; get; }
    Utility util = new Utility();
    NumberToEnglish NTE = new NumberToEnglish();
    protected void Page_Load(object sender, EventArgs e)
    {
        ListItem LItem = new ListItem("--Select--", "0");
       // ddlPaymetMode.Items.Insert(0, LItem);
        
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        txtBranch.InnerText = util.displayValue("tbl_teams", loanApp.GetLoanAppBranch(MySessionManager.AppID, MySessionManager.ClientID).ToString());
        if (tblLoanApp.Rows.Count > 0)
        {
            this.lblTotalAmt.InnerText = tblLoanApp[0].datLoanAmount.ToString();
            // this.
        }
        if (!(this.editskip1.Value == "2"))
        {
           // txtVoucherNo.Value = getPVNo();
            loadfv();
            txtTotalAmount.Text = sumAmount().ToString();
            txtAmtWords.Value = NTE.changeNumericToWords(Convert.ToDouble(sumAmount())) + "Ghana Cedis ";
        }
        if (!(Request.QueryString["pvedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["pvedit"]);
            if (!(this.editskip.Value == "2"))
            {
                //txtVoucherNo.Value = getPVNo();
                loadpv(id);
            }
        }
        else if (!(Request.QueryString["pvdelete"] == null))
        {
            try
            {
                string id = Request.QueryString["pvdelete"];
                util.deleteItem("tbl_payment_vouchers", id);

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "pvdelete"));
            }
            catch
            { }
        }


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.PaymentVoucherTableAdapter paymentvoucher = new LoanDSTableAdapters.PaymentVoucherTableAdapter();
        if (!(type == "update"))
        {

            paymentvoucher.InsertPaymentVoucher(MySessionManager.ClientID,
                                                MySessionManager.AppID,
                                                txtDescription.Value.Trim(),
                                                txtReference.Value.Trim(),
                                                Convert.ToDecimal(txtAmount.Value.Trim()),
                                                Convert.ToInt32(ddlPaymetMode.Text),
                                                MySessionManager.CurrentUser.UserID);
        }
        else if (type == "update")
        {
            paymentvoucher.UpdatePaymentVoucher(txtDescription.Value.Trim(),
                                                txtReference.Value.Trim(),
                                                Convert.ToDecimal(txtAmount.Value.Trim()),
                                                Convert.ToInt32(ddlPaymetMode.Text),
                                                MySessionManager.CurrentUser.UserID,
                                                id);
        }


        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "pvedit"));
    }

    public void loadpv(int id)
    {
        LoanDSTableAdapters.PaymentVoucherTableAdapter pv = new LoanDSTableAdapters.PaymentVoucherTableAdapter();
        LoanDS.PaymentVoucherDataTable tblpv = pv.GetPaymentVoucherDetail(id);
        if (tblpv.Rows.Count > 0)
        {
            txtAmount.Value = tblpv[0].datAmount.ToString();
            txtReference.Value = tblpv[0].datReference.ToString();
            txtDescription.Value = tblpv[0].datDescription.ToString();
            //try { }
            // ddlPaymetMode.Items.IndexOf(ddlPaymetMode.Items.FindByValue(tblpv[0].datFeePaymentID.ToString())); 
            this.editskip.Value = "2";
        }
    }
    protected void gvPaymentVoucher_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvPaymentVoucher.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&pvedit=" + enpValue;

            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&pvdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }

    public decimal sumAmount()
    {
        decimal sum = 0;
        LoanDSTableAdapters.PaymentVoucherTableAdapter pv = new LoanDSTableAdapters.PaymentVoucherTableAdapter();
        sum = Convert.ToDecimal(pv.GetTotalAmount(MySessionManager.ClientID, MySessionManager.AppID));
        return sum;
    }
    protected void btnFinalVoucher_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.FinalVoucherTableAdapter finalv = new LoanDSTableAdapters.FinalVoucherTableAdapter();

        // fetch the en-GB culture
        CultureInfo ukCulture = new CultureInfo("en-GB");
        // pass the DateTimeFormat information to DateTime.Parse
        DateTime dt = DateTime.Parse(txtDate.Text, ukCulture.DateTimeFormat);


        if (!(typefv == "update"))
        {
           finalv.UpdateFinalVoucher1(txtVoucherNo.Value,
                                      dt,
                                      Convert.ToDecimal(txtTotalAmount.Text),
                                      txtAmtWords.Value.Trim(),
                                      MySessionManager.CurrentUser.UserID,
                                      DateTime.Now,
                                      MySessionManager.CurrentUser.UserID,
                                      DateTime.Now,
                                      Convert.ToInt32(FVID.Value));
            this.editskip1.Value = "1";
        }
        else 
        {
           finalv.UpdateFinalVoucher1(txtVoucherNo.Value,
                                      dt,
                                      Convert.ToDecimal(txtTotalAmount.Text),
                                      txtAmtWords.Value.Trim(),
                                      MySessionManager.CurrentUser.UserID,
                                      DateTime.Now,
                                      MySessionManager.CurrentUser.UserID,
                                      DateTime.Now,
                                      Convert.ToInt32(FVID.Value));
            this.editskip1.Value = "1";
   
        }
    }
    public void loadfv()
    {
        LoanDSTableAdapters.FinalVoucherTableAdapter finalv = new LoanDSTableAdapters.FinalVoucherTableAdapter();
        LoanDS.FinalVoucherDataTable tblfinalv =finalv.GetFinalVoucher(MySessionManager.ClientID, MySessionManager.AppID );
        if(tblfinalv .Rows.Count>0)
        {
            try
            {
                this.editskip1.Value = "2";
                FVID.Value = tblfinalv[0].datID.ToString();
                txtVoucherNo.Value = tblfinalv[0].datVoucherName.ToString();
                txtAmtWords.Value = tblfinalv[0].datAmountInWords.ToString();
                txtDate.Text = tblfinalv[0].datVoucherDate.ToString("dd-MM-yyyy");
                txtTotalAmount.Text = tblfinalv[0].datVoucherTotalAmount.ToString();
            }
            catch (Exception ex)
            { Console.Write(ex.Message); }

        }

    }
    public string getPVNo()
    {
        int index=0000000;
        try
        {
            Random rnd = new Random();
            index = rnd.Next(100000000, 999999999);
        }
        catch (Exception ex) { }
    
        return "PV"+index.ToString();
    
    
    }


}
 