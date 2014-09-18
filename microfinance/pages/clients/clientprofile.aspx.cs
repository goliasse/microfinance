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

public partial class pages_clientprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        #region QueryStringBlock
        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            //MySessionManager.AppID = DecID;
            //int DecID = Convert.ToInt32(EncID);
            MySessionManager.ClientID = DecID;
            getProfileType(MySessionManager.ClientID);

        } 
        #endregion

    }

    public void getProfileType(int ClientID)
    {
        try
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            int? type = int.Parse(client.GetClientType(ClientID).ToString());

            if (type == 1)
            {
                this.individualclient1.Visible = true;
                this.enterpriseclient1.Visible = false;
                this.coporateclient1.Visible = false;
            }
            else if (type == 2)
            {
                this.individualclient1.Visible = false;
                this.enterpriseclient1.Visible = false;
                this.coporateclient1.Visible = true;
            }
            else if (type == 3)
            {
                this.individualclient1.Visible = true;
                this.enterpriseclient1.Visible = false;
                this.coporateclient1.Visible = false;
            }
        }
        catch (Exception ex) { }
    }
}
