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

public partial class controls_Guarantor_Referee : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        ListItem LItem = new ListItem("--Select--", "0");
        //ddlGORR.Items.Insert(0, LItem);
        //ddlNationality.Items.Insert(0, LItem);

        if (!(Request.QueryString["gedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["gedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadGuarantor(id);
            }
        }
        else if (!(Request.QueryString["gdelete"] == null))
        {
            int id = Convert.ToInt32(Request.QueryString["gdelete"]);
            loadGuarantor(id);
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
                DateTime bDate = DateTime.Parse(txtBirthdate.Text, ukCulture.DateTimeFormat);

                LoanDSTableAdapters.GuarantorTableAdapter guarantor = new LoanDSTableAdapters.GuarantorTableAdapter();
                if (!(type == "update"))
                {
                    guarantor.InsertGuarantor(MySessionManager.ClientID,
                                              MySessionManager.AppID,
                                              Convert.ToInt32(ddlGORR.Text),
                                              txtfullname.Text,
                                              txtRelationship.Text,
                                              Convert.ToInt32(txtYrsAcquainted.Text),
                                              Convert.ToInt32(ddlNationality.Text),
                                              bDate,
                                              txtMobile.Text,
                                              txtHomeTelNo.Text,
                                              txtOfficeTelNo.Text,
                                              txtEmail.Text,
                                              txtHomeAddress.Value.Trim(),
                                              txtOfficeAddress.Value.Trim(),
                                              MySessionManager.CurrentUser.UserID);
                }
                else if (type == "update")
                {
                    guarantor.UpdateGuarantor(Convert.ToInt32(ddlGORR.Text),
                                              txtfullname.Text,
                                              txtRelationship.Text,
                                              Convert.ToInt32(txtYrsAcquainted.Text),
                                              Convert.ToInt32(ddlNationality.Text),
                                              bDate,
                                              txtMobile.Text,
                                              txtHomeTelNo.Text,
                                              txtOfficeTelNo.Text,
                                              txtEmail.Text,
                                              txtHomeAddress.Value.Trim(),
                                              txtOfficeAddress.Value.Trim(),
                                              id);


                }
                Utility util = new Utility();
                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "gedit"));
            }
            catch (Exception ex) { }
        }
    }
    protected void gvGuarantor_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvGuarantor.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&gedit=" + enpValue;

            edit.NavigateUrl = urlpath;

        }
    }

    public void loadGuarantor(int id)
    {

        LoanDSTableAdapters.GuarantorTableAdapter guarantor = new LoanDSTableAdapters.GuarantorTableAdapter();
        LoanDS.GuarantorDataTable tblguarantor = guarantor.GetGuarantorDetails (id);

        if (tblguarantor.Rows.Count > 0)
        {
            txtBirthdate.Text = tblguarantor[0].datDateOfBirth.ToShortDateString();
            txtEmail.Text = tblguarantor[0].datEmailAddress.ToString();
            txtfullname.Text = tblguarantor[0].datFullName.ToString();
            txtHomeTelNo .Text =tblguarantor[0].datHomeTelephoneNumber.ToString();
            txtMobile.Text = tblguarantor[0].datMobileNumber.ToString();
            txtOfficeAddress.Value = tblguarantor[0].datOfficeAddress.ToString();
            txtRelationship.Text = tblguarantor[0].datRelationship.ToString();
            txtYrsAcquainted.Text =tblguarantor[0].datNumberOfYears.ToString();
            txtOfficeTelNo .Text =tblguarantor[0].datOfficeTelephoneNUmber .ToString();
            txtHomeAddress.Value = tblguarantor[0].datResidentialAddress.ToString();
            try{
                if (tblguarantor[0].datGORR > 0) { ddlGORR.SelectedValue = tblguarantor[0].datGORR.ToString(); }
                if (tblguarantor[0].datNationalityID > 0) { ddlNationality.SelectedValue = tblguarantor[0].datNationalityID.ToString(); }
            }catch(Exception ex){}
            this.editskip.Value = "2";        
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
            if (txtfullname.Text == "") { args.IsValid = false; ErrorMessage += "<p> Provide the full name of the Guarantor </p>"; }
            if (!(int.TryParse(txtYrsAcquainted.Text, out k))) { args.IsValid = false; ErrorMessage += "<p> The number of year acquainted must be interger"; }
            //if (!(Decimal.TryParse(txtMonthlyExpenditure.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly expediture must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtmonthly.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly income must be a decimal </p>"; }
            if (!(DateTime.TryParse(txtBirthdate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The birthdate date is not in the correct format</p>"; }
            if (((DateTime.Now-dt).TotalDays/364)<18) { ErrorMessage += "<p>The guarantor must be more than 18 years </p>"; args.IsValid = false; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
