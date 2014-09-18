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

public partial class controls_EnterpriseDetails : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ListItem LItem = new ListItem("--Select--", "0");
        //ddlEnterprisePremStatus.Items.Insert(0, LItem);
        //ddlSector.Items.Insert(0, LItem);
       
        loadEnterpriseDetails();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                LoanDSTableAdapters.EnterpriseDetailsTableAdapter enterprisedetails = new LoanDSTableAdapters.EnterpriseDetailsTableAdapter();
                enterprisedetails.InsertEnterpriseDetails(MySessionManager.AppID,
                                                          MySessionManager.ClientID,
                                                          txtEntName.Value,
                                                          txtTelephoneNo.Text,
                                                          txtFaxNo.Text,
                                                          txtPhysicalAddress.Value,
                                                          txtActivity.Text,
                                                          DateTime.Parse(txtRegDate.Text),
                                                          txtRegNo.Value,
                                                          Convert.ToInt32(ddlEnterprisePremStatus.Text),
                                                          DateTime.Parse(txtDateOfOccupancy.Text),
                                                          Convert.ToInt32(ddlSector.Text)
                                                         );
            }
            catch { }
        }
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

                if (tblEntDetails[0].IsdatSectorNull()==false){ddlSector.SelectedValue = tblEntDetails[0].datSector.ToString();}
                if (tblEntDetails[0].IsdatPremisesNull() == false) { ddlEnterprisePremStatus.SelectedValue = tblEntDetails[0].datPremises.ToString(); }

            }
        }
        catch
        { }
    
    
        
    }

    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {  
            decimal m;
            int k;
            DateTime dt;
            if (txtEntName.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the Enterprise </p>"; }
            //if (!(int.TryParse(txtYrsAcquainted., out k))) { args.IsValid = false; ErrorMessage += "<p> The number of year acquainted must be interger"; }
            //if (!(Decimal.TryParse(txtMonthlyExpenditure.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly expediture must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            //if (!(Decimal.TryParse(txtmonthly.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly income must be a decimal </p>"; }
            if (!(DateTime.TryParse(txtRegDate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The registration date is not in the correct format</p>"; }
            if (((DateTime.Now - dt).TotalDays) < 0) { ErrorMessage += "<p> The enterprise cannot be registered in a future date</p>"; args.IsValid = false; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }

}
