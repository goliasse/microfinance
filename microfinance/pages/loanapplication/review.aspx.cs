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

public partial class pages_loanapplication_review : System.Web.UI.Page
{

    [WebMethod]
    public static void removertalert()
    {
        LoanDSTableAdapters.AlertLogsTableAdapter alert = new LoanDSTableAdapters.AlertLogsTableAdapter();
        alert.RemoveAlert(MySessionManager.AppID);

    }
    protected void Page_Load(object sender, EventArgs e)
    {

        setNotifications();
    }

    public void setNotifications()
    {
        try
        {
            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];

            this.initassinfo.InnerText = itemcount.intialassessment.ToString();
            this.preapprovedinfo.InnerText = itemcount.preapproval.ToString();
            this.Approvedinfo.InnerText = itemcount.approvedloans.ToString();
            this.Apprinfo.InnerText = (Convert.ToInt32(itemcount.approvalI.ToString()) + Convert.ToInt32(itemcount.approvalII.ToString()) + Convert.ToInt32(itemcount.approvalIII.ToString()) + Convert.ToInt32(itemcount.approvalIV.ToString()) + Convert.ToInt32(itemcount.approvalV.ToString())).ToString();
            this.Appraisalinfo.InnerText = itemcount.appraisal.ToString();
            this.legalinfo.InnerText = itemcount.legal.ToString();
            this.riskinfo.InnerText = itemcount.risk.ToString();
            this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString())).ToString();
        }
        catch { }
    }

}
