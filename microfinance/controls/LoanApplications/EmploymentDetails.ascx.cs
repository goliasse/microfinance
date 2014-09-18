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

public partial class controls_EmploymentDetails : System.Web.UI.UserControl
{
    public int id {set;get;}
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            txtmonthly.Value = loanApp.GetAvMonthlyIncome(MySessionManager.AppID).ToString();
        }
        catch (Exception ex) { }

        if (!(this.editskip.Value  == "2"))
        {
            loadEmploymentDetails();
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
                DateTime empDate = DateTime.Parse(txtEmploymentDate.Text, ukCulture.DateTimeFormat);

                LoanDSTableAdapters.EmploymentDetailsTableAdapter empDetails = new LoanDSTableAdapters.EmploymentDetailsTableAdapter();

                if (getEmpDetails(MySessionManager.ClientID) > 0)
                {

                    empDetails.UpdateEmploymentDetails(Convert.ToInt32("0"),
                                                         txtcompanyname.Value.Trim(),
                                                         txtPhysicalAddress.Value.Trim(),
                                                         txtposition.Value.Trim(),
                                                         txtStaff.Value.Trim(),
                                                         empDate,
                                                         txtTel.Value.Trim(),
                                                         txtFaxNumber.Value.Trim(),
                                                         Convert.ToDecimal(txtmonthly.Value.Trim()),
                                                         Convert.ToDecimal(txtOtherincome.Value.Trim()),
                                                         Convert.ToDecimal(txtMonthlyExpenditure.Value.Trim()),
                                                         Convert.ToDecimal(txtDisposableIncome.Value.Trim()),
                                                         1,
                                                         MySessionManager.CurrentUser.UserID,
                                                         MySessionManager.ClientID);
                    this.editskip.Value = "1";



                }
                else
                {
                    empDetails.InsertEmploymentDetails(MySessionManager.ClientID,
                                                          Convert.ToInt32("0"),
                                                          txtcompanyname.Value.Trim(),
                                                          txtPhysicalAddress.Value.Trim(),
                                                          txtposition.Value.Trim(),
                                                          txtStaff.Value.Trim(),
                                                          DateTime.Parse(txtEmploymentDate.Text),
                                                          txtTel.Value.Trim(),
                                                          txtFaxNumber.Value.Trim(),
                                                          Convert.ToDecimal(txtmonthly.Value.Trim()),
                                                          Convert.ToDecimal(txtOtherincome.Value.Trim()),
                                                          Convert.ToDecimal(txtMonthlyExpenditure.Value.Trim()),
                                                          Convert.ToDecimal(txtDisposableIncome.Value.Trim()),
                                                          MySessionManager.CurrentUser.UserID);
                    this.editskip.Value = "2";
                }
            }
            catch (Exception ex) { }
        }                                    

    }


    public int getEmpDetails(int ClientID)
    {
        int id=0;
        LoanDSTableAdapters.EmploymentDetailsTableAdapter empDetails = new LoanDSTableAdapters.EmploymentDetailsTableAdapter();
        LoanDS.EmploymentDetailsDataTable tblEmpDetails = empDetails.GetEmploymentDetails(MySessionManager.ClientID);

        if (tblEmpDetails.Rows.Count > 0)
        {
            id= Convert.ToInt32(tblEmpDetails[0].datID.ToString());
        }

        return id; 
    }

    public void loadEmploymentDetails()
    {
        LoanDSTableAdapters.EmploymentDetailsTableAdapter empDetails = new LoanDSTableAdapters.EmploymentDetailsTableAdapter();
        LoanDS.EmploymentDetailsDataTable tblEmpDetails = empDetails.GetEmploymentDetails(MySessionManager.ClientID);

        if (tblEmpDetails.Rows.Count > 0)
        {
            txtcompanyname.Value = tblEmpDetails[0].datCompanyName.ToString();
            txtPhysicalAddress.Value = tblEmpDetails[0].datPhysicalAddress.ToString();
            txtposition.Value = tblEmpDetails[0].datPosition.ToString();
            txtOtherincome.Value = tblEmpDetails[0].datOtherIncome.ToString();
            txtStaff.Value = tblEmpDetails[0].datStaffID.ToString();
            txtTel.Value = tblEmpDetails[0].datTelephoneNumber.ToString();
            txtmonthly.Value = tblEmpDetails[0].datMonthlyIncome.ToString();
            txtFaxNumber.Value = tblEmpDetails[0].datFaxNumber.ToString();
            txtMonthlyExpenditure.Value = tblEmpDetails[0].datMonthlyExpenditure.ToString();
            txtDisposableIncome.Value = tblEmpDetails[0].datDisposalbleIncome.ToString();
            txtEmploymentDate.Text = tblEmpDetails[0].datDateOfEmployment.ToString("dd-MM-yyyy");
            this.editskip.Value = "2";
           
        }
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
            if (txtcompanyname.Value=="") { args.IsValid = false; ErrorMessage += "<p> Provide the company name </p>"; }
            //if (!(int.TryParse(txtDuration.Value, out k))) { args.IsValid = false; ErrorMessage += "<p> The Duration must be interger"; }
            if (!(Decimal.TryParse(txtMonthlyExpenditure.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly expediture must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtOtherincome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The other income must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtmonthly.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The monthly income must be a decimal </p>"; }
            if (!(DateTime.TryParse(txtEmploymentDate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The employment date is not in the correct format</p>"; }
            if (dt > DateTime.Now) { ErrorMessage += "<p>The First Payment date should not be less than today </p>"; args.IsValid = false; } 
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
