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

public partial class controls_clients_individualclient : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
        {
            loadPersonalInformation();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (!(txtfirstname.Value == "" || txtSurname.Value == ""))
            {
                int nochildren;
                if (txtNoChildren.Text == "")
                { nochildren = 0; }
                else { nochildren = Convert.ToInt32(txtNoChildren.Text); }

                // fetch the en-GB culture
                CultureInfo ukCulture = new CultureInfo("en-GB");
                // pass the DateTimeFormat information to DateTime.Parse
                DateTime dt = DateTime.Parse(txtBirthdate.Text, ukCulture.DateTimeFormat);

                string clientname = txtfirstname.Value.Trim() + " " + txtMiddlename.Value.Trim() + " " + txtSurname.Value.Trim();
                mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
                client.UpdateClient(GenerateClientNumber(),
                                    Convert.ToInt32(ddlTitle.Text),
                                    txtfirstname.Value.Trim(),
                                    txtMiddlename.Value.Trim(),
                                    txtSurname.Value.Trim(),
                                    clientname,
                                    ddlNo1.Text,
                                    ddlNo2.Text,
                                    ddlidNo3.Text,
                                    txtidNo1.Value.Trim(),
                                    txtidNo2.Value.Trim(),
                                    txtidNo3.Value.Trim(),
                                    Convert.ToInt32(ddlNationality.SelectedValue),
                                    Convert.ToInt32(ddlRegion.SelectedValue),
                                    Convert.ToInt32(ddlMaritalStatus.SelectedValue),
                                    txtSpouse.Text,
                                    nochildren,
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
                                    txtLandMark.Value.Trim(),
                                    MySessionManager.CurrentUser.UserID,
                                    MySessionManager.ClientID);
                this.editskip.Value = "1";
            }
        }catch(Exception ex){}
    }
    public void loadPersonalInformation()
    {
        try
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            mainDS.ClientDataTable tblClient = client.GetClientProfile(MySessionManager.ClientID);

            if (tblClient.Rows.Count > 0)
            {
                this.editskip.Value = "2";
            
                if (tblClient[0].IsdatFirstNameNull() == false) { txtfirstname.Value = tblClient[0].datFirstName.ToString(); }
                if (tblClient[0].IsdatSurnameNull() == false) { txtSurname.Value = tblClient[0].datSurname.ToString(); }
                if (tblClient[0].IsdatMiddleNameNull() == false) { txtMiddlename.Value = tblClient[0].datMiddleName.ToString(); }
                if (tblClient[0].IsdatIDType1Null() == false) { ddlNo1.SelectedValue = tblClient[0].datIDType1; }
                if (tblClient[0].IsdatIDType2Null() == false) { ddlNo2.SelectedValue = tblClient[0].datIDType2; }
                if (tblClient[0].IsdatIDType3Null() == false) { ddlidNo3.SelectedValue = tblClient[0].datIDType3; }
                if (tblClient[0].IsdatGenderNull() == false) { ddlGender.SelectedValue = tblClient[0].datGender.ToString(); }
                if (tblClient[0].IsdatTitleNull() == false) { ddlTitle.SelectedValue = tblClient[0].datTitle.ToString(); }
                if (tblClient[0].IsdatRegionNull() == false) { ddlRegion.SelectedValue = tblClient[0].datRegion.ToString(); }
                if (tblClient[0].IsdatMaritalStatusNull() == false) { ddlMaritalStatus.SelectedValue = tblClient[0].datMaritalStatus.ToString(); }
                if (tblClient[0].IsdatNationalityNull() == false) { ddlNationality.SelectedValue = tblClient[0].datNationality.ToString(); }
                if (tblClient[0].IsdatResidentialStatusNull() == false) { ddlRecStatus.SelectedValue = tblClient[0].datResidentialStatus.ToString(); }
                if (tblClient[0].IsdatIDValue1Null() == false) { txtidNo1.Value = tblClient[0].datIDValue1.ToString(); }
                if (tblClient[0].IsdatIDValue2Null() == false) { txtidNo2.Value = tblClient[0].datIDValue2.ToString(); }
                if (tblClient[0].IsdatIDValue3Null() == false) { txtidNo3.Value = tblClient[0].datIDValue3.ToString(); }
               // if (tblClient[0].IsdatResidentialStatusNull() == false) { ddlRecStatus.SelectedValue = tblClient[0].datResidentialStatus.ToString(); }
                if (tblClient[0].IsdatSpouseNull() == false) { txtSpouse.Text = tblClient[0].datSpouse.ToString(); }
                if (tblClient[0].IsdatNoChildrenNull() == false) { txtNoChildren.Text = tblClient[0].datNoChildren.ToString(); }
                if (tblClient[0].IsdatMobileNumber1Null() == false) { txtMobileNo1.Value = tblClient[0].datMobileNumber1.ToString(); }
                if (tblClient[0].IsdatMobileNumber2Null() == false) { txtMobileNo2.Value = tblClient[0].datMobileNumber2.ToString(); }
                if (tblClient[0].IsdatOfficeTelephoneNumberNull() == false) { txtOfficePhone.Value = tblClient[0].datOfficeTelephoneNumber.ToString(); }
                if (tblClient[0].IsdatPostalAddressNull() == false) { txtPostalAddress.Value = tblClient[0].datPostalAddress.ToString(); }
                if (tblClient[0].IsdatNearestLandMarkNull() == false) { txtLandMark.Value = tblClient[0].datNearestLandMark.ToString(); }
                if (tblClient[0].IsdatCurrentResidentialAddressNull() == false) { txthomeAddress.Value = tblClient[0].datCurrentResidentialAddress.ToString(); }
                if (tblClient[0].IsdatPreviousResidentialAddressNull() == false) { txtpreviousAddress.Value = tblClient[0].datPreviousResidentialAddress.ToString(); }
                if (tblClient[0].IsdatHomeTelephoneNumberNull() == false) { txttelephone.Value = tblClient[0].datHomeTelephoneNumber.ToString(); }
                if (tblClient[0].IsdatFaxNumberNull() == false) { txtfaxnumber.Value = tblClient[0].datFaxNumber.ToString(); }
                if (tblClient[0].IsdatEmailAddressNull() == false) { txtEmail.Value = tblClient[0].datEmailAddress.ToString(); }
                if (tblClient[0].IsdatDateOfBirthNull() == false) { txtBirthdate.Text = tblClient[0].datDateOfBirth.ToString("dd-MM-yyyy"); }
            }
        }
        catch
        {

        }

    }
    public string GenerateClientNumber()
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        int noClients = Convert.ToInt32(MySessionManager.ClientID);
        string ClientNo = "C" + (100000 + noClients).ToString();
        return ClientNo;
    }
}
