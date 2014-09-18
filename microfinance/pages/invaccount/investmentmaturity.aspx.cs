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

public partial class pages_invapplication_investmentmaturity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {



        setNotifications();
    }

    /// <summary>
    /// This functions add a number of days to a specified date and return that date
    /// </summary>
    /// <param name="date">The intial date</param>
    /// <param name="days">An Integer indicating the number of days to add</param>
    /// <returns>DateTime</returns> 
    public DateTime addDaysElapsed(DateTime date, int days)
    {
        DateTime dt = DateTime.Now;
        try
        {
            dt = date.AddDays(days);
        }
        catch (Exception ex) { }
        return dt;

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
