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

public partial class controls_invapplications_constituentInvestors : System.Web.UI.UserControl
{
    public string type { set; get; }
    public int id { set; get; }

    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["ciedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["ciedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadPersonalInformation(id);
            }
        }
        else if (!(Request.QueryString["cidelete"] == null))
        {
            string id = Request.QueryString["cidelete"];
            util.deleteItem("", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "cidelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        // fetch the en-GB culture
        CultureInfo ukCulture = new CultureInfo("en-GB");
        // pass the DateTimeFormat information to DateTime.Parse
        DateTime dt = DateTime.Parse(txtBirthdate.Text, ukCulture.DateTimeFormat);
        string clientname = txtfirstname.Value.Trim() + " " + txtMiddlename.Value.Trim() + " " + txtSurname.Value.Trim();
        InvestmentDSTableAdapters.GetConstituentInvestorsTableAdapter ci = new InvestmentDSTableAdapters.GetConstituentInvestorsTableAdapter();
        if (type != "update")
        {
            int nochildren;
            if (txtNoChildren.Text == "")
            { nochildren = 0; }
            else { nochildren = Convert.ToInt32(txtNoChildren.Text); }

            

           
            ci.InsertConstituentInvestors(Convert.ToInt32(ddlTitle.Text),
                                          txtfirstname.Value.Trim(),
                                          txtMiddlename.Value.Trim(),
                                          txtSurname.Value.Trim(),
                                          Convert.ToInt32(ddlNo1.SelectedValue),
                                          Convert.ToInt32(ddlNo2.SelectedValue),
                                          Convert.ToInt32(ddlidNo3.SelectedValue),
                                          txtidNo1.Value.Trim(),
                                          txtidNo2.Value.Trim(),
                                          txtidNo3.Value.Trim(),
                                          Convert.ToInt32(ddlNationality.SelectedValue),
                                          Convert.ToInt32(ddlRegion.SelectedValue),
                                          Convert.ToInt32(ddlMaritalStatus.SelectedValue),
                                          Convert.ToInt32(ddlGender.SelectedValue),
                                          dt,
                                          txttelephone.Value.Trim(),
                                          txtOfficePhone.Value,
                                          txtMobileNo1.Value.Trim(),
                                          txtMobileNo2.Value.Trim(),
                                          txtfaxnumber.Value,
                                          txtEmail.Value.Trim(),
                                          Convert.ToInt32(ddlRecStatus.Text),
                                          txthomeAddress.Value.Trim(),
                                          txtpreviousAddress.Value.Trim(),
                                          txtPostalAddress.Value.Trim(),
                                          MySessionManager.CurrentUser.UserID,
                                          MySessionManager.ClientID,
                                          Convert.ToInt32(txtPercentageshare.Value));
            this.editskip.Value = "1";
        }
        else
        {
            ci.UpdateCI(Convert.ToInt32(ddlTitle.Text),
                        txtfirstname.Value,
                        txtMiddlename.Value,
                        txtSurname.Value,
                        Convert.ToInt32(ddlNo1.SelectedValue),
                        Convert.ToInt32(ddlNo2.SelectedValue),
                        Convert.ToInt32(ddlidNo3.SelectedValue),
                        txtidNo1.Value,
                        txtidNo2.Value,
                        txtidNo3.Value,
                        Convert.ToInt32(ddlNationality.SelectedValue),
                        Convert.ToInt32(ddlMaritalStatus.SelectedValue),
                        Convert.ToInt32(ddlRegion.SelectedValue),
                        Convert.ToInt32(ddlGender.SelectedValue),
                        dt,
                        txttelephone.Value.Trim(),
                        txtOfficePhone.Value,
                        txtMobileNo1.Value.Trim(),
                        txtMobileNo2.Value.Trim(),
                        txtfaxnumber.Value,
                        txtEmail.Value.Trim(),
                        Convert.ToInt32(ddlRecStatus.Text),
                        txthomeAddress.Value.Trim(),
                        txtpreviousAddress.Value.Trim(),
                        txtPostalAddress.Value.Trim(),
                        Convert.ToInt32( txtPercentageshare.Value.Trim()),
                        MySessionManager.ClientID,
                        MySessionManager.InvAppID,
                        MySessionManager.CurrentUser.UserID,
                        id);
            this.editskip.Value = "1";
        }
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ciedit"));
    }
    public void loadPersonalInformation(int id)
    {
        try
        {
           InvestmentDSTableAdapters.GetConstituentInvestorsTableAdapter ci = new InvestmentDSTableAdapters.GetConstituentInvestorsTableAdapter();
            InvestmentDS.GetConstituentInvestorsDataTable tblCI= ci.GetCIDetails(id);

            if (tblCI.Rows.Count > 0)
            {
                this.editskip.Value = "2";
                if (tblCI[0].IsdatFirstNameNull() == false) { txtfirstname.Value = tblCI[0].datFirstName.ToString(); }
                if (tblCI[0].IsdatSurnameNull() == false) { txtSurname.Value = tblCI[0].datSurname.ToString(); }
                if (tblCI[0].IsdatMiddleNameNull() == false) { txtMiddlename.Value = tblCI[0].datMiddleName.ToString(); }
                if (tblCI[0].IsdatIDType1Null() == false) { ddlNo1.SelectedValue = tblCI[0].datIDType1.ToString(); }
                if (tblCI[0].IsdatIDType2Null() == false) { ddlNo2.SelectedValue = tblCI[0].datIDType2.ToString(); }
                if (tblCI[0].IsdatIDType3Null() == false) { ddlidNo3.SelectedValue = tblCI[0].datIDType3.ToString(); }
                if (tblCI[0].IsdatGenderNull() == false) { ddlGender.SelectedValue = tblCI[0].datGender.ToString(); }
                if (tblCI[0].IsdatTitleNull() == false) { ddlTitle.SelectedValue = tblCI[0].datTitle.ToString(); }
                if (tblCI[0].IsdatRegionNull() == false) { ddlRegion.SelectedValue = tblCI[0].datRegion.ToString(); }
                if (tblCI[0].IsdatMaritalStatusNull() == false) { ddlMaritalStatus.SelectedValue = tblCI[0].datMaritalStatus.ToString(); }
                if (tblCI[0].IsdatNationalityNull() == false) { ddlNationality.SelectedValue =  tblCI[0].datNationality.ToString(); }
                if (tblCI[0].IsdatResidentialStatusNull() == false) { ddlRecStatus.SelectedValue = tblCI[0].datResidentialStatus.ToString(); }
                if (tblCI[0].IsdatIDValue1Null() == false) { txtidNo1.Value = tblCI[0].datIDValue1.ToString(); }
                if (tblCI[0].IsdatIDValue2Null() == false) { txtidNo2.Value = tblCI[0].datIDValue2.ToString(); }
                if (tblCI[0].IsdatIDValue3Null() == false) { txtidNo3.Value = tblCI[0].datIDValue3.ToString(); }
                if (tblCI[0].IsdatResidentialStatusNull() == false) { ddlRecStatus.SelectedValue = tblCI[0].datResidentialStatus.ToString(); }
                if (tblCI[0].IsdatMobileNumber1Null() == false) { txtMobileNo1.Value = tblCI[0].datMobileNumber1.ToString(); }
                if (tblCI[0].IsdatMobileNumber2Null() == false) { txtMobileNo2.Value = tblCI[0].datMobileNumber2.ToString(); }
                if (tblCI[0].IsdatOfficeTelephoneNumberNull() == false) { txtOfficePhone.Value = tblCI[0].datOfficeTelephoneNumber.ToString(); }
                if (tblCI[0].IsdatPostalAddressNull() == false) { txtPostalAddress.Value = tblCI[0].datPostalAddress.ToString(); }
                if (tblCI[0].IsdatNearestLandMarkNull() == false) { txtLandMark.Value = tblCI[0].datNearestLandMark.ToString(); }
                if (tblCI[0].IsdatCurrentResidentialAddressNull() == false) { txthomeAddress.Value = tblCI[0].datCurrentResidentialAddress.ToString(); }
                if (tblCI[0].IsdatHomeTelephoneNumberNull() == false) { txttelephone.Value = tblCI[0].datHomeTelephoneNumber.ToString(); }
                if (tblCI[0].IsdatFaxNumberNull() == false) { txtfaxnumber.Value = tblCI[0].datFaxNumber.ToString(); }
                if (tblCI[0].IsdatEmailAddressNull() == false) { txtEmail.Value = tblCI[0].datEmailAddress.ToString(); }
                if (tblCI[0].IsdatDateOfBirthNull() == false) { txtBirthdate.Text = Convert.ToDateTime(tblCI[0].datDateOfBirth.ToString()).ToString("dd-MM-yyyy"); }
            }
        }
        catch
        {

        }

    }
}
