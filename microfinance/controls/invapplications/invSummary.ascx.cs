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

public partial class controls_invapplications_invSummary : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        loadInvSummary();
    }
    /// <summary>
    /// Loads  the record of the selected application  
    /// </summary>
    public void loadInvSummary()
    {
        try
        {
            mainDSTableAdapters.GetClientInfoTableAdapter client = new mainDSTableAdapters.GetClientInfoTableAdapter();
            mainDS.GetClientInfoDataTable tblClient = client.GetClientInfo(MySessionManager.ClientID);
            if(tblClient.Rows.Count>0)
            {
                if(tblClient[0].IsdatClientNameNull()==false ){lblClientName.InnerText = tblClient[0].datClientName.ToString();}
                if(tblClient[0].IsdatClientNumberNull()==false ){lblClientNo.InnerText = tblClient[0].datClientNumber.ToString();}
                if(tblClient[0].IsdatMobileNumber1Null()==false ){lblMobile1.InnerText = tblClient[0].datMobileNumber1.ToString();}

            
            
            }

            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvestmentDS.GetInvestmentAppDataTable tblInvApp = InvApp.GetInvestmentApp(MySessionManager.InvAppID);

            if (tblInvApp.Rows.Count > 0) 
            {
                if (tblInvApp[0].IsdatInvestmentNameNull() == false) { this.lblInvestmentName.InnerText = tblInvApp[0].datInvestmentName.ToString(); }
                if (tblInvApp[0].IsdatInterestRatePerAnnumNull() == false) { this.lblRatePerAnnum.InnerText = tblInvApp[0].datInterestRatePerAnnum.ToString("c").Replace("$",""); }
                if (tblInvApp[0].IsdatInvestmentTypeNull() == false) { this.lblType.InnerText =util.displayValue("opt_investment_types" ,tblInvApp[0].datInvestmentType.ToString()); }
                if (tblInvApp[0].IsdatTermsNull() == false) { this.lblTerms.InnerText =util.displayValue("opt_terms" , tblInvApp[0].datTerms.ToString())+" days"; }
                if (tblInvApp[0].IsdatInvestmentNameNull() == false) { this.lblInvestmentName.InnerText = tblInvApp[0].datInvestmentName.ToString(); }
                if (tblInvApp[0].IsdatModeOfRepaymentNull() == false) { this.lblModeOfInv.InnerText = util.displayValue("opt_payment_modes", tblInvApp[0].datModeOfRepayment.ToString()); }
                if (tblInvApp[0].IsdatFrequencyOfInterestPaymentNull() == false) { this.lblFreqPayment.InnerText = util.displayValue("opt_frequencies_investments", tblInvApp[0].datFrequencyOfInterestPayment.ToString()); }
                if (tblInvApp[0].IsdatInvestmentAmountNull() == false) { this.lblAmount.InnerText = tblInvApp[0].datInvestmentAmount.ToString("c").Replace("$",""); }
                if (tblInvApp[0].IsdatValueDateNull() == false) { this.txtValue.Text = tblInvApp[0].datValueDate.ToString("dd-MM-yyyy"); }  
            }
        }
        catch (Exception ex) { }







    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime dt=DateTime.Parse(txtValue .Text, ukCulture);
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateSetValueDate(dt,MySessionManager.InvAppID);


        }
        catch (Exception ex) { }
    }
}
