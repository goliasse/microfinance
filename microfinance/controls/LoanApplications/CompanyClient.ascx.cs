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

public partial class controls_CompanyClient : System.Web.UI.UserControl
{
    string fullname;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            fullname = txtcompanyname.Value;
            mainDSTableAdapters.ClientTableAdapter clients = new mainDSTableAdapters.ClientTableAdapter();
            int? objID = null;
            clients.InsertClient(GenerateClientNumber(),
                                  2,
                                  0,
                                  this.txtInFullname.Value.Trim(),
                                  "",
                                  "",
                                  this.fullname,
                                  txttelno.Value.Trim(),
                                  "",
                                  "",
                                  txtphysicalAddress.Value.Trim(),
                                  ref objID);



            if (objID.Value > 0)
            {
                // this.lblinfo.Text = "Client Profile Created Successfully...";
                MySessionManager.ClientID = Convert.ToInt32(objID);
                LoanDSTableAdapters.IntiatorTableAdapter initiator = new LoanDSTableAdapters.IntiatorTableAdapter();
                initiator.InsertInitiator(null,
                                          MySessionManager.ClientID,
                                          txtInFullname.Value,
                                          "",
                                          txtMobileno.Value.Trim(),
                                          null,
                                          txtEmail.Value.Trim(),
                                          null,
                                          null);


            }
            else
            {

            }
        }
    }

    public string GenerateClientNumber()
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        int noClients = Convert.ToInt32(client.GetClientCount().ToString());
        string ClientNo = "C" + (100000 + (noClients+1)).ToString();
        return ClientNo;
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
            //if (!(Decimal.TryParse(txtAveMonthlyIncome.Value, out m))) { args.IsValid = false; ErrorMessage += "<p>The Average Monthly Income must be a decimal </p>"; }
            //if (!(int.TryParse(txtDuration.Value, out k))) { args.IsValid = false; ErrorMessage += "<p> The Duration must be interger"; }
            //if (!(Decimal.TryParse(txtLoanAmount.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The Loan Amount be a decimal </p>"; }
            //if (!(DateTime.TryParse(txtFirstPaymentDate.Text, out dt))) { args.IsValid = false; ErrorMessage += "<p> The First Payment date is not in the correct format</p>"; }
            //if (dt < DateTime.Now) { ErrorMessage += "<p>The First Payment date should not be less than today </p>"; args.IsValid = false; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }

}
