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

public partial class controls_clients_coporateclient : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.editskip.Value != "2")
        {
            loadCompanyDetails(MySessionManager.ClientID);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime dt1 = DateTime.Parse("1/1/1953");
            if (txtRegistrationDate.Text == "") { dt1 = DateTime.Parse("1/1/1753"); } else { dt1 = DateTime.Parse(txtRegistrationDate.Text); }

            DateTime dt = DateTime.Parse(txtCommencementDate.Text);
            LoanDSTableAdapters.CoporateInformationTableAdapter companyDetails = new LoanDSTableAdapters.CoporateInformationTableAdapter();
            companyDetails.UpdateCoporateInformation(txtCompanyName.Value,
                                                      dt,
                                                      Convert.ToInt32(txtYearsInBusiness.Value.Trim()),
                                                      Convert.ToInt32(ddlIndustryType.Text),
                                                      Convert.ToInt32(ddlSector.SelectedValue),
                                                      txtPhysicalAddress.Value.Trim(),
                                                      txtTel1.Value.Trim(),
                                                      txtTel2.Value.Trim(),
                                                      txtFax.Value.Trim(),
                                                      txtNatureofbusiness.Value.Trim(),
                                                      ddlPremisesStatus.Text,
                                                      Convert.ToInt32(ddlRegistered.Text),
                                                      dt1,
                                                      txtRegistrationNumber.Text,
                                                      txtVATNo.Value.Trim(),
                                                      txtTIN.Value.Trim(),
                                                      txtwebsite.Value.Trim(),
                                                      MySessionManager.ClientID
                                                       );
            this.editskip.Value = "1";
        }
        catch (Exception ex) { }
    }

    public void loadCompanyDetails(int clientID)
    {
        try
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            mainDS.ClientRow tblClient = client.GetClientProfile(MySessionManager.ClientID)[0];
            LoanDSTableAdapters.CoporateInformationTableAdapter companyDetails = new LoanDSTableAdapters.CoporateInformationTableAdapter();
            LoanDS.CoporateInformationDataTable tblCompanyDetails = companyDetails.GetCoporateInformation(MySessionManager.ClientID);

            if (tblCompanyDetails.Rows.Count > 0)
            {
                txtCompanyName.Value = tblCompanyDetails[0].datCompanyName.ToString();
                txtCommencementDate.Text = tblCompanyDetails[0].datCommencementDate.ToShortDateString();
                txtNatureofbusiness.Value = tblCompanyDetails[0].datNatureOfBusiness.ToString();
                txtPhysicalAddress.Value = tblCompanyDetails[0].datPhysicalAddress.ToString();
                txtRegistrationNumber.Text = tblCompanyDetails[0].datRegistrationNumber.ToString();
                txtRegistrationDate.Text = tblCompanyDetails[0].datRegistrationDate.ToShortDateString();
                txtYearsInBusiness.Value = tblCompanyDetails[0].datYearsInBusiness.ToString();
                txtwebsite.Value = tblCompanyDetails[0].datWebsite.ToString();
                txtVATNo.Value = tblCompanyDetails[0].datVATNumber.ToString();
                txtTIN.Value = tblCompanyDetails[0].datTIN.ToString();
                if (tblCompanyDetails[0].IsdatTelephoneNumber1Null() == false)
                { txtTel1.Value = tblCompanyDetails[0].datTelephoneNumber1.ToString(); }
                else if (tblClient.IsdatMobileNumber1Null() == false)
                { txtTel1.Value = tblClient.datMobileNumber1.ToString(); }
                if (tblCompanyDetails[0].IsdatTelephoneNumber2Null() == false)
                { txtTel2.Value = tblCompanyDetails[0].datTelephoneNumber2.ToString(); }
                else if (tblClient.IsdatMobileNumber2Null() == false)
                { txtTel2.Value = tblClient.datMobileNumber2.ToString(); }
                txtTel2.Value = tblCompanyDetails[0].datTelephoneNumber2.ToString();
                txtFax.Value = tblCompanyDetails[0].datFaxNumber.ToString();
                if (tblCompanyDetails[0].IsdatIndustryTypeNull() == false) { ddlIndustryType.SelectedValue = tblCompanyDetails[0].datIndustryType.ToString(); }
                //if (tblCompanyDetails[0].IsdatSectorNull()==false) { if(ddlIndustryType.SelectedValue = tblCompanyDetails[0].datSector.ToString(); }
                if (tblCompanyDetails[0].IsdatPremissesStatusNull() == false) { ddlPremisesStatus.SelectedValue = tblCompanyDetails[0].datPremissesStatus.ToString(); }
                if (tblCompanyDetails[0].IsdatIsRegisteredNull() == false) { ddlRegistered.SelectedValue = tblCompanyDetails[0].datIsRegistered.ToString(); }
                this.type.Value = "update";
                this.editskip.Value = "2";
            }


        }
        catch (Exception ex)
        { }

    }
}
