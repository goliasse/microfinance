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

public partial class controls_InitialInterview : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (this.Page.IsValid == true)
        //{
            //dtCompare.ValueToCompare = DateTime.Now.ToShortDateString();
            //dtCompare.Visible = false;
            //if (!(this.editskip.Value == "2"))
            //{
            //    loadLoanDetails(MySessionManager.AppID);
            //}
        //}
        //else { Response.Write("<font color='red'><i><b>" + txtFirstPaymentDate.Text + "</b> must be greater than todays date</i></font>"); }
    }
    public void loadLoanDetails(int AppID)
    {
        try
        {

            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            LoanDS.LoanApplicationsDataTable loanAppDetails = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
            if (loanAppDetails.Rows.Count > 0)
            {
                string ApNo;
                
                try { ApNo = loanAppDetails[0].datApplicationNumber.ToString(); }
                catch (Exception ex) { ApNo = ""; }
                if (ApNo == "")
                {
                    this.appCode.Value = (100000 + (Convert.ToInt32(loanAppDetails[0].datID.ToString()))).ToString();
                }
                else
                {
                    this.appCode.Value = loanAppDetails[0].datApplicationNumber.ToString();
                }
                this.editskip.Value = "2";
                if (loanAppDetails[0].IsdatLoanAmountNull() == false) { txtLoanAmount.Value = loanAppDetails[0].datLoanAmount.ToString(); }
                if (loanAppDetails[0].IsdatDurationNull() == false) { txtDuration.Value = loanAppDetails[0].datDuration.ToString();}
                if (loanAppDetails[0].IsdatFirstPaymentDateNull() == false) { txtFirstPaymentDate.Text = DateTime.Parse(loanAppDetails[0].datFirstPaymentDate.ToString()).ToString("dd-MM-yyyy");}
                if (loanAppDetails[0].IsdatInterestRateNull() == false) { txtInterestrate.Value = loanAppDetails[0].datInterestRate.ToString(); }
                try
                {
                    ddlLoanType.ClearSelection();
                    ddlTypeOfBusiness.ClearSelection();
                    ddlloanpurpose.ClearSelection();
                    ddlInterestRate.ClearSelection();
                    if (loanAppDetails[0].IsdatLoanTypeNull()==false) { ddlLoanType.SelectedValue = loanAppDetails[0].datLoanType.ToString(); }
                    if (loanAppDetails[0].IsdatInterestRateTypeNull()==false) { ddlInterestRate.SelectedValue = loanAppDetails[0].datInterestRateType.ToString(); }
                    if (loanAppDetails[0].IsdatPurposeNull()==false) { ddlloanpurpose.SelectedValue = loanAppDetails[0].datPurpose.ToString(); }
                    if (loanAppDetails[0].IsdatTypeOfBusinessNull()==false) { ddlTypeOfBusiness.SelectedValue = loanAppDetails[0].datTypeOfBusiness.ToString(); }

                }
                catch (Exception ex) { }
                

                txtAveMonthlyIncome.Value = loanAppDetails[0].datAveMonthlyIncome.ToString();
                
               
            }
            else
            { }

        }
        catch (Exception ex)
        {

            Console.WriteLine(ex.Message);

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                // this.dtCompare.Visible = true;

                // fetch the en-GB culture
                CultureInfo ukCulture = new CultureInfo("en-GB");
                // pass the DateTimeFormat information to DateTime.Parse
                DateTime myDateTime = DateTime.Parse(txtFirstPaymentDate.Text, ukCulture.DateTimeFormat);

                mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
                string clientname = client.GetClientsName(MySessionManager.ClientID).ToString();
                int noyrs = 0;
                if (!int.TryParse(txtNoYrs.Value, out noyrs))
                    txtNoYrs.Value = "0";

                LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
                loanApp.Update_IntialInterview(MySessionManager.AppID,
                                               0,
                                               Convert.ToInt32(ddlLoanType.Text),
                                               txtNatureOfBusiness.Value,
                                               ddlTypeOfBusiness.Text,
                                               noyrs,
                                               Convert.ToDecimal(txtAveMonthlyIncome.Value),
                                               appCode.Value.Trim(),
                                               Convert.ToDecimal(txtLoanAmount.Value.Trim()),
                                               Convert.ToDecimal(txtLoanAmount.Value.Trim()),
                                               Convert.ToDecimal(txtLoanAmount.Value.Trim()),
                                               clientname,
                                               Convert.ToInt32(txtDuration.Value.Trim()),
                                               Convert.ToInt32(ddlloanpurpose.Text),
                                               Convert.ToDecimal(txtInterestrate.Value.Trim()),
                                               myDateTime,
                                               Convert.ToInt32("0"),
                                               Convert.ToInt32(ddlInterestRate.Text),
                                               "");
                this.editskip.Value = "2";

                //loadLoanDetails(MySessionManager.AppID);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message.ToString());
            }
            #region Obsolete
            //try
            //{
            //    mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            //    string clientname = client.GetClientName(MySessionManager.ClientID)[0].datClientName.ToString();

            //int noofyrs = 0;
            //DateTime dt = DateTime.Parse(txtFirstPaymentDate.Text);
            //if (!(txtNoYrs.Value==""))
            //{
            //    noofyrs = Convert.ToInt32(txtNoYrs.Value.Trim());
            //}

            //LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            //loanApp.Update_IntialInterview(MySessionManager.AppID,
            //                               0,
            //                               Convert.ToInt32(ddlLoanType.Text),
            //                               txtNatureOfBusiness.Value.Trim(),
            //                               ddlTypeOfBusiness.Text,
            //                               Convert.ToInt32 (noofyrs),
            //                               Convert.ToDecimal(txtAveMonthlyIncome.Value.Trim()),
            //                               GenerateAppNumber(),
            //                               Convert.ToDecimal(txtLoanAmount.Value.Trim()),
            //                               0,
            //                               0,
            //                               clientname,
            //                               Convert.ToInt32(txtDuration.Value.Trim()),
            //                               Convert.ToInt32(ddlloanpurpose.Text),
            //                               Convert.ToDecimal(txtInterestrate.Value.Trim()),
            //                               dt,
            //                               Convert.ToInt32(ddlFrequency.Text),
            //                               Convert.ToInt32(ddlInterestRate.Text),
            //                               "");

            //}
            //catch
            //{
            //} 
            #endregion
        }
        else
        {
          // this.vIntialAssesment.ErrorMessage = 
        
        
        }

    }


   
    public void pageValidation(object source, ServerValidateEventArgs args) 
    {
        args.IsValid = true;
        string ErrorMessage="";
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            Type type;
            decimal m;
            int k;
            DateTime dt;
            if (!(Decimal.TryParse(txtAveMonthlyIncome.Value, out m))) { args.IsValid = false;  ErrorMessage += "<p>The Average Monthly Income must be a decimal </p>"; }
            if (!(int.TryParse(txtDuration.Value, out k))) { args.IsValid = false; ErrorMessage += "<p> The Duration must be interger"; }
            if (!(Decimal.TryParse(txtLoanAmount.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The Loan Amount be a decimal </p>"; }
            if (!(DateTime.TryParse(txtFirstPaymentDate.Text,ukCulture, DateTimeStyles.None ,out dt))) { args.IsValid = false; ErrorMessage += "<p> The First Payment date is not in the correct format</p>"; }
            if (dt < DateTime.Now) { ErrorMessage += "<p>The First Payment date should not be less than today </p>"; args.IsValid = false; } else { args.IsValid = true; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}

