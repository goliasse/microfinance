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
using System.Web.Services;

public partial class pages_clients : System.Web.UI.Page
{
    [WebMethod]
    public static void mywebMethod(string type, int? appID, int? accID)
    {
        if (appID != null)
        { MySessionManager.AppID = Convert.ToInt32(appID); MySessionManager.AccountID = 0; }
        if (accID != null)
        { MySessionManager.AccountID = Convert.ToInt32(accID); MySessionManager.AppID = 0; }
     
    }
    protected void Page_Load(object sender, EventArgs e)
    {

       // this.contentPanel.Load;
       
        if (this.IsPostBack == true)
        {
            if (Request.QueryString["action"] == "investmentaccounts")
            {
                //clients1.query = "";
                //clients1.refreshData();

            }
            else if (Request.QueryString["action"] == "loanaccounts")
            {
                //clients1.query = "";
                //clients1.refreshData();
            }
            else if (Request.QueryString["action"] == "applications")
            {

            }
            else
            { }
        }  
        if (Request.QueryString["action"] == "loan")
        {
            string clientid = Request.QueryString["id"];

        }
        else if (Request.QueryString["action"] == "investment")
        {

        }
        
          

    }
    protected void searchClient(object sender, EventArgs e)
    {
        if (txtSearchTerm.Text == "")
        {
            this.clients1.query = "SELECT datID, datClientNumber, datClientName, datEmailAddress, datMobileNumber1 "
                                 +" FROM   tbl_client ";
            this.clients1.refreshData();
        }
        else
        {
            string searhterm = txtSearchTerm.Text.Trim();
            this.clients1.query = "SELECT datID, datClientNumber, datClientName, datEmailAddress, datMobileNumber1 "
                                 +" FROM   tbl_client "
                                 +" WHERE     (datClientName LIKE '%"+ searhterm +"%') OR "
                                 +" (datClientNumber LIKE '%"+ searhterm +"%') OR "
                                 +" (datEmailAddress LIKE '%"+ searhterm +"%') OR "
                                 +" (datMobileNumber1 LIKE '%"+ searhterm +"%') ";
            this.clients1.refreshData();
                }
    }
    protected void btnSearchClient_TextChanged(object sender, EventArgs e)
    {
        if (txtSearchTerm.Text == "")
        {
            this.clients1.query = "SELECT DISTINCT ClientProfileID, Fullname, EmailAddress, MobilePhoneNumber FROM tblClientProfile";
            this.clients1.refreshData();
        }
        else
        {
            string searhterm = txtSearchTerm.Text.Trim();
            this.clients1.query = "SELECT datID, datClientNumber, datClientName, datEmailAddress, datMobileNumber1 "
                                 + " FROM   tbl_client "
                                 + " WHERE     (datClientName LIKE '%" + searhterm + "%') OR "
                                 + " (datClientNumber LIKE '%" + searhterm + "%') OR "
                                 + " (datEmailAddress LIKE '%" + searhterm + "%') OR "
                                 + " (datMobileNumber1 LIKE '%" + searhterm + "%') ";
            this.clients1.refreshData();
        }
    }
    public void refreshcontrol() 
    {
        UserControl uc = new UserControl();
        uc.LoadControl("~/controls/clients/clientPortfolios.ascx");
        ucHolder.Controls.Add(uc);
    }
    
}
