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

public partial class pages_invapplications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/logout.aspx");
        }
        MySessionManager.InvAppID = 0;
        MySessionManager.ClientID = 0;
        MySessionManager.skipAlert = 0;
        getDirections(Request.QueryString["action"]);
        setNotifications();
    }

    public void getDirections(string page)
    {
        if (!(page == null) || (MySessionManager.CurrentUser == null))
        {
            if (page == "initInterview")
            {
                this.clientlist1.type = "initInterview";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 1) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;

            }
            if (page == "receipt")
            {
                this.clientlist1.type = "receipt";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                             + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                             + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 2) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;

            }
            else if (page == "certification")
            {
                this.clientlist1.type = "certification";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 3) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "approved")
            {
                this.clientlist1.type = "approved";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 4) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "intMaturity")
            {
                //SELECT * FROM tbl_investment_accounts WHERE datActiveAccountStatus = 3 AND datTeamID =" + MySessionManager.CurrentUser.BranchID + "
                this.clientlist1.type = "intMaturity";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 100) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "invMaturity")
            {
                //SELECT * FROM tbl_investment_accounts WHERE datActiveAccountStatus = 3 AND datTeamID =" + MySessionManager.CurrentUser.BranchID + "
                this.clientlist1.type = "invMaturity";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 100) ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "matured")
            {
                //SELECT tbl_inv_pay_sched.datID  FROM tbl_inv_pay_sched INNER JOIN tbl_investment_account	ON tbl_investment_accounts.datID=tbl_inv_pay_sched.datAccountID WHERE tbl_inv_pay_sched.datDate <= GETDATE() AND tbl_inv_pay_sched.datStatus = 104 AND datTeamID =
                this.clientlist1.type = "matured";
                string sql = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                            + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                            + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 3) ";
                this.clientlist1.refreshData(sql);
               
            }
            this.clientlist1.Visible = true;
        }
        else
        {
            this.clientlist1.Visible = false;
        }

    }
    public void setNotifications()
    {
        try
        {

            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];
            this.initInvinfo.InnerText = itemcount.initInterview.ToString();
            this.receiptinfo.InnerText = itemcount.receipts.ToString();
            this.certinfo.InnerText = itemcount.certification.ToString();
            this.InvApproved.InnerText = itemcount.InvApproved.ToString();
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
