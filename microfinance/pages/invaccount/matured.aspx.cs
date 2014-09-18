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

public partial class pages_invapplication_matured : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ///Querystring Block
        ///
        if (Request.QueryString.Count > 0)
        {
            
            InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter invAcc = new InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter();
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            MySessionManager.InvAccID = DecID;
            MySessionManager.ClientID = Convert.ToInt32(invAcc.GetClientID(MySessionManager.InvAppID));
            if (Request.QueryString["action"] == "int") { Page.Title = "Interest Maturity"; }
            if (Request.QueryString["action"] == "inv") { Page.Title = "Investment Maturity"; }
            if (Request.QueryString["action"] == "rol") { Page.Title = "Roll Over"; }
        }
        setNotifications();
    }
    protected void btnFinalize_Click(object sender, EventArgs e)
    {

    }

    /// <summary>
    /// This function sets the notifications
    /// </summary>
    public void setNotifications()
    {
        try
        {

            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];
            this.intmaturityinfo.InnerText = itemcount.IntMaturity.ToString();
            this.invmaturityinfo.InnerText = itemcount.InvMaturity.ToString();
            //this.certinfo.InnerText = itemcount.certification.ToString();
            //this.InvApproved.InnerText = itemcount.InvApproved.ToString();
            //this.Appraisalinfo.InnerText = itemcount.appraisal.ToString();
            //this.legalinfo.InnerText = itemcount.legal.ToString();
            //this.riskinfo.InnerText = itemcount.risk.ToString();
            //// this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            //this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString()) + (Convert.ToInt32(itemcount.disbursementIII.ToString()))).ToString();
        }
        catch
        { }
    }
}
