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

public partial class controls_NextOfKins : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["nedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["nedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadNOK(id);
            }
        }
        else if (!(Request.QueryString["ndelete"] == null))
        {
            string id = Request.QueryString["ndelete"];
            util.deleteItem("tbl_next_of_kin",id);

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ndelete"));

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.NextOfKinsTableAdapter NextOfKin = new LoanDSTableAdapters.NextOfKinsTableAdapter();
            if (!(type == "update"))
            {
                NextOfKin.InsertNextOfKin(MySessionManager.ClientID,
                                           MySessionManager.AppID,
                                           txtfullname.Value.Trim(),
                                           txtMobile.Value.Trim(),
                                           txtHomeTel.Value.Trim(),
                                           txtOfficeTel.Value.Trim(),
                                           txtEmail.Value.Trim(),
                                           Convert.ToDecimal(txtpercentageshare.Value.Trim()),
                                           txtAddress.Value.Trim(),
                                           MySessionManager.CurrentUser.UserID,
                                           txtRelationship.Value.Trim());
            }
            else if (type == "update")
            {
                NextOfKin.UpdateNextOfKin(txtfullname.Value.Trim(),
                                          txtMobile.Value.Trim(),
                                          txtHomeTel.Value.Trim(),
                                          txtOfficeTel.Value.Trim(),
                                          txtEmail.Value.Trim(),
                                          Convert.ToDecimal(txtpercentageshare.Value.Trim()),
                                          txtAddress.Value.Trim(),
                                          id,
                                          txtRelationship.Value.Trim());
            }

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "nedit"));
        }

    }
    protected void gvNextOfKin_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvNextOfKin.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&nedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&ndelete=" + enpValue;
            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
    public void loadNOK(int id)
    {
        LoanDSTableAdapters.NextOfKinsTableAdapter nok = new LoanDSTableAdapters.NextOfKinsTableAdapter();
        LoanDS.NextOfKinsDataTable tblnok = nok.GetNextOfKinDetails(id);

        if (tblnok.Rows.Count > 0)
        {
            try
            {
                this.editskip.Value = "2";
                txtfullname.Value = tblnok[0].datFullName.ToString();
                txtHomeTel.Value = tblnok[0].datHomeTelephoneNumber.ToString();
                txtOfficeTel.Value = tblnok[0].datOfficeTelephoneNumber.ToString();
                txtMobile.Value = tblnok[0].datMobileNumber.ToString();
                txtpercentageshare.Value = tblnok[0].datPercentageShare.ToString();
                txtEmail.Value = tblnok[0].datEmailAddress.ToString();
                txtAddress.Value = tblnok[0].datAddress.ToString();
                txtRelationship.Value = tblnok[0].datRelationship.ToString();
               
            }
            catch (Exception ex)
            { 
            
            
            }
        }    
    
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
            if (txtfullname.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the Next of Kin </p>"; }
            if (txtRelationship.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the kind of relationship client has with the Next of Kin </p>"; }
            //if (!(int.TryParse(txtYrsAcquainted., out k))) { args.IsValid = false; ErrorMessage += "<p> The number of year acquainted must be interger"; }
            if (!(Decimal.TryParse(txtpercentageshare.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The percentage share must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtmonthly.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly income must be a decimal </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
