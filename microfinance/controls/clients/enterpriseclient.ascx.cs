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

public partial class controls_clients_enterpriseclient : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loadEnterpriseDetails();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
 
        }
        catch (Exception ex) { }

    }
    public void loadEnterpriseDetails()
    {
        try
        {
            LoanDSTableAdapters.EnterpriseDetailsTableAdapter entDetails = new LoanDSTableAdapters.EnterpriseDetailsTableAdapter();
            LoanDS.EnterpriseDetailsDataTable tblEntDetails = entDetails.GetEnterpriseDetails(MySessionManager.ClientID, MySessionManager.AppID);

            if (tblEntDetails.Rows.Count > 0)
            {
                txtEntName.Value = tblEntDetails[0].datEnterpriseName.ToString();
                txtPhysicalAddress.Value = tblEntDetails[0].datPhysicalAddress.ToString();
                txtRegDate.Text = tblEntDetails[0].datRegistrationDate.ToShortDateString();
                txtRegNo.Value = tblEntDetails[0].datRegistrationNumber.ToString();
                txtTelephoneNo.Text = tblEntDetails[0].datTelephoneNumber.ToString();
                txtFaxNo.Text = tblEntDetails[0].datFaxNumber.ToString();
                txtActivity.Text = tblEntDetails[0].datActivity.ToString();
                txtDateOfOccupancy.Text = tblEntDetails[0].datOccupancy.ToShortDateString();

                if (tblEntDetails[0].IsdatSectorNull() == false) { ddlSector.SelectedValue = tblEntDetails[0].datSector.ToString(); }
                if (tblEntDetails[0].IsdatPremisesNull() == false) { ddlEnterprisePremStatus.SelectedValue = tblEntDetails[0].datPremises.ToString(); }

            }
        }
        catch(Exception ex)
        { }
    }
}
