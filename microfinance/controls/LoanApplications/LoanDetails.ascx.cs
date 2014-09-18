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

public partial class controls_LoanDetails : System.Web.UI.UserControl
{
    public string AppNumber{set;get; }
    // fetch the en-GB culture
    CultureInfo ukCulture = new CultureInfo("en-GB");
   // CultureInfo usCulture = new CultureInfo("en-GB");
    protected void Page_Load(object sender, EventArgs e)
    {
        //ListItem Litem = new ListItem("--Select--", "0");
        //ddlInterestRate.Items.Insert(0,Litem);
        //ddlloanpurpose.Items.Insert(0,Litem);
        //ddlLoanType.Items.Insert(0,Litem);
        //ddlTypeOfBusiness.Items.Insert(0,Litem);
        if (!(this.editskip.Value == "2"))
        {
            loadLoanDetails(MySessionManager.AppID);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            // pass the DateTimeFormat information to DateTime.Parse
            DateTime myDateTime = DateTime.Parse(txtFirstPaymentDate.Text, ukCulture.DateTimeFormat);
            try
            {
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
                                               Convert.ToInt32(ddlFrequency.Text),
                                               Convert.ToInt32(ddlInterestRate.Text),
                                               "");
                this.editskip.Value = "1";

                //loadLoanDetails(MySessionManager.AppID);
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.Message.ToString());


            }
        }
    }

    public void loadLoanDetails(int AppID)
    {

        try{
           // DateTime myDateTime = DateTime.Parse(txtFirstPaymentDate.Text, usCulture.DateTimeFormat).To;
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            LoanDS.LoanApplicationsDataTable loanAppDetails = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
            if (loanAppDetails.Rows.Count > 0)
            {
                    txtLoanAmount.Value = loanAppDetails[0].datLoanAmount.ToString();
                    txtDuration.Value = loanAppDetails[0].datDuration.ToString();
                    txtFirstPaymentDate.Text = DateTime.Parse(loanAppDetails[0].datFirstPaymentDate.ToString()).ToString("dd-MM-yyyy");
                    txtNoYrs.Value = loanAppDetails[0].datNumberOfYears.ToString();
                    txtInterestrate.Value = loanAppDetails[0].datInterestRate.ToString();
                    if (loanAppDetails[0].IsdatLoanTypeNull() == false) { ddlLoanType.SelectedValue = loanAppDetails[0].datLoanType.ToString(); }
                    if (loanAppDetails[0].IsdatInterestRateNull() == false) { ddlInterestRate.SelectedValue = loanAppDetails[0].datInterestRateType.ToString(); }
                    if (loanAppDetails[0].IsdatPurposeNull() == false) { ddlloanpurpose.SelectedValue = loanAppDetails[0].datPurpose.ToString(); }
                    if (loanAppDetails[0].IsdatTypeOfBusinessNull() == false) { ddlTypeOfBusiness.SelectedValue = loanAppDetails[0].datTypeOfBusiness.ToString(); }
                    if (loanAppDetails[0].IsdatAveMonthlyIncomeNull() == false) { txtAveMonthlyIncome.Value = loanAppDetails[0].datAveMonthlyIncome.ToString(); }
                    if (loanAppDetails[0].IsdatNatureOfBusinessNull() == false) { txtNatureOfBusiness.Value = loanAppDetails[0].datNatureOfBusiness.ToString(); }
                    string ApNo = loanAppDetails[0].datApplicationNumber.ToString();
                    if (ApNo == "")
                    {
                        this.appCode.Value = (100000+(Convert.ToInt32(loanAppDetails[0].datID.ToString()))).ToString();
                    }
                    else
                    {
                        this.appCode.Value = loanAppDetails[0].datApplicationNumber.ToString();
                    }
                    this.editskip.Value = "2";
                }
                else
                {}
            
        }
        catch (Exception ex)
        {

                Console.WriteLine(ex.Message);
            
        }
    }

    public void UpdateCompanyClientName(string ClientName)
    {

        //Copy the Initiator Details From the Clients  Table 
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        mainDS.ClientRow tblClient = client.GetClientProfile(MySessionManager.ClientID)[0];

        string Fullname = tblClient.datFirstName.ToString()+ tblClient.datMiddleName.ToString()+ tblClient.datSurname.ToString();

        LoanDSTableAdapters.IntiatorTableAdapter initiator = new LoanDSTableAdapters.IntiatorTableAdapter();
        initiator.InsertInitiator (MySessionManager.AppID,
                                   MySessionManager.ClientID,
                                   Fullname,
                                   null,
                                   tblClient.datMobileNumber1.ToString(),
                                   tblClient.datHomeTelephoneNumber.ToString(),
                                   tblClient.datEmailAddress.ToString(),
                                   tblClient.datFaxNumber.ToString(),
                                   tblClient.datCurrentResidentialAddress.ToString());


        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        loanApp.UpdateClientName(ClientName, MySessionManager.ClientID); 
    }

    public void UpdateIndividualClient()
    {
        //Get Clients profile information
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        mainDS.ClientRow tblClient = client.GetClientProfile(MySessionManager.ClientID)[0];

        string Fullname = tblClient.datFirstName.ToString()+" "+tblClient.datMiddleName.ToString()+" "+ tblClient.datSurname.ToString();

        //Delete all initiators tied up the application
        LoanDSTableAdapters.IntiatorTableAdapter initiator = new LoanDSTableAdapters.IntiatorTableAdapter();
        initiator.DeleteInitiator(MySessionManager.AppID, MySessionManager.ClientID);
        
         LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        loanApp.UpdateClientName(Fullname, MySessionManager.ClientID); 
        
    
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {
        CultureInfo ukCulture = new CultureInfo("en-GB");
        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            
            decimal m;
            int k;
            DateTime dt;
            //if (!(Decimal.TryParse(txtAveMonthlyIncome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The Average Monthly Income must be a decimal </p>"; }
            //if (!(int.TryParse(txtDuration.Value, out k))) { args.IsValid = false; ErrorMessage += "<p> The Duration must be interger"; }
            //if (!(Decimal.TryParse(txtLoanAmount.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The Loan Amount be a decimal </p>"; }
            if (!(DateTime.TryParse(txtFirstPaymentDate.Text, ukCulture ,DateTimeStyles.None, out dt))) { args.IsValid = false; ErrorMessage += "<p> The First Payment date is not in the correct format</p>"; }
            if (dt < DateTime.Now) { ErrorMessage += "<p>The First Payment date should not be less than today </p>"; args.IsValid = false; } 
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }

 }

