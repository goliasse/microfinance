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

public partial class pages_investmentaccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ///Querystring Block
        ///
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString["action"] == "intmaturity")
            {
                this.invclientlist11.Visible = true;
                this.invclientlist21.Visible = false;
                this.invclientlist31.Visible = false;
                this.invclientlist41.Visible = false;

            }
            else if (Request.QueryString["action"] == "invmaturity") 
            {
                this.invclientlist21.Visible = true;
                this.invclientlist11.Visible = false;
                this.invclientlist31.Visible = false;
                this.invclientlist41.Visible = false;
            }
            else if (Request.QueryString["action"] == "matured") 
            {
                this.invclientlist11.Visible = false;
                this.invclientlist21.Visible = false;
                this.invclientlist31.Visible = true;
                this.invclientlist41.Visible = false;
            }
            else if (Request.QueryString["action"] == "disbursed")
            {


                if (RoleExist(5))
                {

                    this.invclientlist41.type = "Financial Officer";
                    string sql = "SELECT datID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datInvestmentAmount "
                               + " FROM tbl_investment_accounts "
                               + " WHERE (datActiveAccountStatus = 5) OR (datPaymentStatus = 5) AND datTeamID =" + MySessionManager.CurrentUser.BranchID + "";
                    this.invclientlist41.refreshData(sql);
                }
                else if(RoleExist(7))
                {
                    this.invclientlist41.type = "Financial Controller";
                    string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                               + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                               + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 2";
                    this.invclientlist41.refreshData(sql);
                }
                else if(RoleExist(8))
                {
                    this.invclientlist41.type = "Cashier";
                    string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                               + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                               + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 2";
                    this.invclientlist41.refreshData(sql);
                
                }

                this.invclientlist11.Visible = false;
                this.invclientlist21.Visible = false;
                this.invclientlist31.Visible = false;
                this.invclientlist41.Visible = true;
            }
        }
        else
        { 
            this.invclientlist11.Visible = false;
            this.invclientlist21.Visible = false;
            this.invclientlist31.Visible = false;
            this.invclientlist41.Visible = false;
        }
        setNotifications();
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

    /// <summary>
    /// This function checks if a user has that role
    /// </summary>
    /// <param name="role">The ID of the role that you want to check</param>
    /// <returns>A bool value that indicates whether a user has a right</returns>
    public bool RoleExist(int role)
    {
        bool result = false;
        //string[] mroles;
        try
        {
            adminTableAdapters.tbl_secondary_rolesTableAdapter roles = new adminTableAdapters.tbl_secondary_rolesTableAdapter();
            admin.tbl_secondary_rolesDataTable tblroles = roles.GetRoleID(MySessionManager.CurrentUser.UserID);
            if (tblroles.Rows.Count > 0)
            {
                //mroles = new  string[tblroles.Count];
                for (int i = 0; i < tblroles.Count; i++)
                {
                    if (tblroles[i].datRoleID == role)
                    {
                        result = true;
                    }
                }
            }
        }
        catch (Exception ex) { }
        return result;

    }
}
