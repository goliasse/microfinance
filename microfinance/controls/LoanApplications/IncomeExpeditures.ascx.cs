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

public partial class controls_IncomeExpeditures : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loadIncomeExpenditure();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            LoanDSTableAdapters.IncomeExpenseTableAdapter incomeExpenditure = new LoanDSTableAdapters.IncomeExpenseTableAdapter();
            incomeExpenditure.InsertIncomeExpenses(MySessionManager.AppID,
                                                   MySessionManager.ClientID,
                                                   Convert.ToDecimal(txtBusinessSurplus.Value),
                                                   Convert.ToDecimal(txtIncome.Value),
                                                   Convert.ToDecimal(txtOtherIncome.Value),
                                                   Convert.ToDecimal(txtRentUtil.Value),
                                                   Convert.ToDecimal(txtFood.Text),
                                                   Convert.ToDecimal(txtEducation.Text),
                                                   Convert.ToDecimal(txtStaff.Text),
                                                   Convert.ToDecimal(txtTransport.Text),
                                                   Convert.ToDecimal(txthealth.Text),
                                                   Convert.ToDecimal(txtClothing.Value),
                                                   Convert.ToDecimal(txtEntertainment.Value),
                                                   Convert.ToDecimal(txtCharity.Value),
                                                   Convert.ToDecimal(txtPayment.Value),
                                                   Convert.ToDecimal(txtOthers.Value),
                                                   Convert.ToInt32(txtUnexpected.Value));
        }
        catch
        { }
    }

    public void loadIncomeExpenditure()
    {
        try
        {
            LoanDSTableAdapters.IncomeExpenseTableAdapter incomeExpenditure = new LoanDSTableAdapters.IncomeExpenseTableAdapter();
            LoanDS.IncomeExpenseDataTable tblincomeExpenditure = incomeExpenditure.GetIncomeExpense(MySessionManager.ClientID, MySessionManager.AppID);

           if(tblincomeExpenditure.Rows.Count>0)
           {
               txtBusinessSurplus.Value = tblincomeExpenditure[0].datBusinessSurplus.ToString();
               txtIncome.Value = tblincomeExpenditure[0].datIncome.ToString();
               txtOtherIncome.Value = tblincomeExpenditure[0].datOtherIncome.ToString();
               txtRentUtil.Value = tblincomeExpenditure[0].datRent.ToString();
               txtStaff.Text = tblincomeExpenditure[0].datStaff.ToString();
               txtTransport.Text = tblincomeExpenditure[0].datTransport.ToString();
               txtPayment.Value = tblincomeExpenditure[0].datPayments.ToString();
               txthealth.Text = tblincomeExpenditure[0].datHealth.ToString();
               txtEducation.Text = tblincomeExpenditure[0].datEducation.ToString();
               txtClothing.Value = tblincomeExpenditure[0].datClothing.ToString();
               txtCharity.Value = tblincomeExpenditure[0].datCharity.ToString();
               txtUnexpected.Value = tblincomeExpenditure[0].datUnexpected.ToString();
               txtOthers.Value = tblincomeExpenditure[0].datOthers.ToString();
               txtEntertainment.Value = tblincomeExpenditure[0].datEntertainment.ToString();
               txtFood.Text = tblincomeExpenditure[0].datFood.ToString();
           
           }
        }
       catch
       {}
    
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
            if (!(Decimal.TryParse(txtBusinessSurplus.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of businness surplus must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtIncome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of income must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtOtherIncome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The  value other income must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtRentUtil.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of rent utilies must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtFood.Text, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of food  must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtEducation.Text, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of education must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtStaff.Text, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of staff must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtTransport.Text, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of transport must be a decimal </p>"; }
            if (!(Decimal.TryParse(txthealth.Text, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of health must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtClothing.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of clothing must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtEntertainment.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of Entertainment must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtCharity.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of charity must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtPayment.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of payment must be a decimal </p>"; }
            if (!(Decimal.TryParse(txtOthers.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The value of others must be a decimal </p>"; }
           // if (!(int.TryParse(txtDuration.Value, out k))) { args.IsValid = false; ErrorMessage += "<p> The Duration must be interger"; }
            //if (!(Decimal.TryParse(txtLoanAmount.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The Loan Amount be a decimal </p>"; }
            //if (!(DateTime.TryParse(txtFirstPaymentDate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The First Payment date is not in the correct format</p>"; }
            //if (dt < DateTime.Now) { ErrorMessage += "<p>The First Payment date should not be less than today </p>"; args.IsValid = false; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
