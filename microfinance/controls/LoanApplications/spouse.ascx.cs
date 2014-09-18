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

public partial class controls_spouse : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
        {
            loadSpouseDetails();
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
                DateTime dt = DateTime.Parse(txtDateMarried.Text, ukCulture.DateTimeFormat);

                LoanDSTableAdapters.GetSpouseTableAdapter spouse = new LoanDSTableAdapters.GetSpouseTableAdapter();
                int ID = getSpouseID();
                if (ID > 0)
                {

                    spouse.UpdateSpouse(txtFullName.Value.Trim(),
                                         telno.Value.Trim(),
                                         Convert.ToInt32(ddlNo1.SelectedValue),
                                         txtidNo.Value.Trim(),
                                         Convert.ToInt32(txtNameOfDependents.Value.Trim()),
                                         dt,
                                         txtNameOfEmployer.Value.Trim(),
                                         txtTelNo.Value.Trim(),
                                         txtPhysicalAddress.Value.Trim(),
                                         txtIndustry.Value.Trim(),
                                         txtEmpNo.Value.Trim(),
                                         txtPosition.Value.Trim(),
                                         txtContactPersion.Value.Trim(),
                                         Convert.ToDecimal(txtMonthly.Value.Trim()),
                                         ID);
                    this.editskip.Value = "1";



                }
                else
                {
                    spouse.InsertSpouse(MySessionManager.AppID,
                                        MySessionManager.ClientID,
                                        txtFullName.Value.Trim(),
                                        telno.Value.Trim(),
                                        Convert.ToInt32(ddlNo1.SelectedValue),
                                        txtidNo.Value.Trim(),
                                        Convert.ToInt32(txtNameOfDependents.Value.Trim()),
                                        dt,
                                        txtNameOfEmployer.Value.Trim(),
                                        txtTelNo.Value.Trim(),
                                        txtPhysicalAddress.Value,
                                        txtIndustry.Value.Trim(),
                                        txtEmpNo.Value.Trim(),
                                        txtPosition.Value.Trim(),
                                        txtContactPersion.Value.Trim(),
                                        Convert.ToDecimal(txtMonthly.Value.Trim())
                                        );
                    this.editskip.Value = "1";
                }
            }
            catch (Exception ex) { }
        }
    }

    public int getSpouseID()
    {
        int ID;
        LoanDSTableAdapters.GetSpouseTableAdapter spouse = new LoanDSTableAdapters.GetSpouseTableAdapter();
        LoanDS.GetSpouseDataTable tblSpouse = spouse.GetSpouse(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblSpouse.Rows.Count > 0)
            ID = int.Parse(tblSpouse[0].datID.ToString());
        else
            ID = 0;

        return ID;
    }

    public void loadSpouseDetails()
    {
        LoanDSTableAdapters.GetSpouseTableAdapter spouse = new LoanDSTableAdapters.GetSpouseTableAdapter();
        LoanDS.GetSpouseDataTable tblSpouse = spouse.GetSpouse(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblSpouse.Rows.Count > 0)
        {
            txtContactPersion.Value = tblSpouse[0].datContactPerson.ToString();
            txtDateMarried.Text = tblSpouse[0].datDateMarried.ToString("dd-MM-yyyy");
            txtNameOfDependents.Value = tblSpouse[0].datNumberOfDependents.ToString();
            txtEmpNo.Value = tblSpouse[0].datEmployeeNumber.ToString();
            txtFullName.Value = tblSpouse[0].datFullName.ToString();
            txtMonthly.Value = tblSpouse[0].datMonthlyIncome.ToString();
            txtPhysicalAddress.Value =tblSpouse[0].datEmployerAddress.ToString();
            txtidNo.Value = tblSpouse[0].datIdentificationNumber.ToString();
            //ddlNo1.SelectedIndex = ddlNo1.Items.IndexOf(ddlNo1.Items.FindByText(tblSpouse[0].idtype.ToString()));
            telno.Value = tblSpouse[0].datTelephoneNumber.ToString();
            txtPosition.Value = tblSpouse[0].datPosition.ToString();        
        }
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {
        CultureInfo ukCulture = new CultureInfo("en-GB");
        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            Type type;
            decimal m;
            int k;
            DateTime dt;
            if (txtFullName.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the spouse </p>"; }
           // if (txtRelationship.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the kind of relationship client has with the Next of Kin </p>"; }
            if (txtTelNo.Value=="") { args.IsValid = false; ErrorMessage += "<p> The telephone cannot be blank"; }
            if (!(Convert.ToInt32(ddlNo1.SelectedValue)>0)) { args.IsValid = false; ErrorMessage += "<p> Please select the ID of the spouse <p>"; }
            //if (!(Decimal.TryParse(txtpercentageshare.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The percentage share must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtmonthly.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly income must be a decimal </p>"; }
            if(!(DateTime.TryParse(txtDateMarried.Text,ukCulture,DateTimeStyles.None,out dt))){args.IsValid = false; ErrorMessage += "<p> The date married must be a decimal </p>";}
            if ((DateTime.Now - dt).TotalDays < 0) { args.IsValid = false; ErrorMessage += "<p> The date married must be less than today's date </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
