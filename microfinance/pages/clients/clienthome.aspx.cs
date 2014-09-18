using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pages_clients_clienthome : System.Web.UI.Page
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
            loadClientInformation(MySessionManager.ClientID);

        }

        #endregion

        coporateclientprofile.Visible = false;
        individualclientprofile.Visible = false;
        enterpriseclientprofile.Visible = false;
        loanaccounts.Visible = false;
        invaccounts.Visible = false;
        pendingloans.Visible = false;
        pendinginvestments.Visible = false;
        statuslog.Visible = false;

        if (Request.QueryString["loanAppid"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["loanAppid"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            //MySessionManager.AppID = DecID;
            //int DecID = Convert.ToInt32(EncID);
            MySessionManager.AppID = DecID;
            loadClientInformation(MySessionManager.ClientID);
            statuslog.Visible = true;
         }
    }

    protected void btnPersonalInfo_Click(object sender, EventArgs e)
    {
        getProfileType(MySessionManager.ClientID);
        statuslog.Visible = false;
    }

    public void getProfileType(int ClientID)
    {
        try
        {
            mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
            int? type = int.Parse(client.GetClientType(ClientID).ToString());

            if (type == 1)
            {
                this.individualclientprofile.Visible = true;
                this.enterpriseclientprofile.Visible = false;
                this.coporateclientprofile.Visible = false;
            }
            else if (type == 2)
            {
                this.individualclientprofile.Visible = false;
                this.enterpriseclientprofile.Visible = false;
                this.coporateclientprofile.Visible = true;
            }
            else if (type == 3)
            {
                this.individualclientprofile.Visible = true;
                this.enterpriseclientprofile.Visible = false;
                this.coporateclientprofile.Visible = false;
            }
        }
        catch (Exception ex) { }
    }
    public void loadClientInformation(int ClientID)
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        mainDS.ClientDataTable cinfo = client.GetClientProfile(ClientID);
        if (cinfo.Count > 0)
        {
            try
            {
                mainDS.ClientRow rinfo = cinfo[0];
                lblClientName.InnerText = rinfo.datClientName.ToString();
                lblClientNo.InnerText = rinfo.datClientNumber.ToString();
                string ctype = "Individual";
                if (rinfo.datClientType == 2)
                {
                    ctype = "Corporate";
                }
                lblClientType.InnerText = ctype;

                lblEmail.InnerText = rinfo.datEmailAddress;
                lblMobile.InnerText = rinfo.datMobileNumber1 + " " + rinfo.datMobileNumber2;
                lblNationality.InnerText = rinfo.datNationality.ToString();
                lblPostalAddress.InnerText = rinfo.datPostalAddress;
                lblResAddress.InnerText = rinfo.datCurrentResidentialAddress;
                lblTelephone.InnerText = rinfo.datHomeTelephoneNumber;
            }
            catch (Exception ex) { }

            
            
        }

    }
    protected void btnCoporateInfo_Click(object sender, EventArgs e)
    {
        loanaccounts.Visible = true;
        statuslog.Visible = false;
    }
    protected void btnJointInfo_Click(object sender, EventArgs e)
    {
        invaccounts.Visible = true;
        statuslog.Visible = false;
    }
    protected void btnInitiatorsInfo_Click(object sender, EventArgs e)
    {
        pendinginvestments.Visible = true;
        statuslog.Visible = false;
    }
    protected void btnDirectors_Click(object sender, EventArgs e)
    {
        pendingloans.Visible = true;
        statuslog.Visible = false;
    }
}
