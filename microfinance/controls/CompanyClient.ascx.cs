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

        fullname = txtcompanyname.Value;
        mainDSTableAdapters.ClientTableAdapter clients = new mainDSTableAdapters.ClientTableAdapter();
        int? objID =null;
        clients.InsertClient (GenerateClientNumber(),
                              2,
                              0,
                              this.txtInFullname.Value.Trim(),
                              "",
                              "",
                              this.fullname,
                              txttelno.Value.Trim(),
                              "",
                              txtCEmail.Value.Trim(), 
                              txtphysicalAddress.Value.Trim(), ref objID);
           

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
            ShowMessageBox("New Company has been created");
        
    }

    public string GenerateClientNumber()
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        int noClients = Convert.ToInt32(client.GetClientCount().ToString());
        string ClientNo = "C" + (100000 + (noClients+1)).ToString();
        return ClientNo;
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
