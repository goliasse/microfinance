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

public partial class controls_Enterprise : System.Web.UI.UserControl
{
    string fullname;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        fullname = txtSurname.Value + ' ' + txtMiddlename.Value + ' ' + txtfirstname.Value;

        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        int? objID = null;
        client.InsertClient(GenerateClientNumber(),
                            3,
                            Convert.ToInt32(this.ddlTitle.SelectedValue),
                            txtfirstname.Value.Trim(),
                            txtMiddlename.Value.Trim(),
                            txtSurname.Value.Trim(),
                            fullname,
                            txttelephone.Value.Trim(),
                            txtMobileNo.Value.Trim(),
                            txtEmail.Value.Trim(),
                            txthomeAddress.Value.Trim(), ref objID);


        if (objID.Value > 0)
        {
            MySessionManager.ClientID = Convert.ToInt32(objID);
        }
        ShowMessageBox("New Enterprise has been created");
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
