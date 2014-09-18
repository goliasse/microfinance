using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pages_finance_finhome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReceiptPanel.Visible = false;
        PaymentPanel.Visible = false;
        JournalPanel.Visible = false;
        receiptpendinglist.Visible = false;
        disbursementpendinglist.Visible = false;
        try
        {
            mainDSTableAdapters.NotificationCountTableAdapter tblCounter = new mainDSTableAdapters.NotificationCountTableAdapter();
            mainDS.NotificationCountRow itemcount = tblCounter.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID, MySessionManager.CurrentUser.TeamID)[0];
            
            this.pendingRecInfo.InnerText = (Convert.ToInt32(itemcount.receipts.ToString ())).ToString();
            this.pendingDisInfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString()) + Convert.ToInt32(itemcount.disbursementIII.ToString())).ToString();
        }
        catch (Exception ex) { 
        
        }
        

        if (Request.QueryString["panel"] != null) 
        {
            if (Request.QueryString["panel"] == "Receipt")
            {
                ReceiptPanel.Visible = true;
                
            }
            if (Request.QueryString["panel"] == "Payment")
            {
                PaymentPanel.Visible = true;
            }
            if (Request.QueryString["panel"] == "Journal")
            {
                JournalPanel.Visible = true;
            }
            if (Request.QueryString["panel"] == "PendingReceipt")
            {
                this.receiptpendinglist.type = "receipt";
                string sql1 = "SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus "
                             + "FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType "
                             + "WHERE (tbl_investment_application.datTeamID = " + MySessionManager.CurrentUser.BranchID + ") AND (tbl_investment_application.datApplicationStatus = 2) ";
                this.receiptpendinglist .refreshData(sql1);             
                this.receiptpendinglist.Visible = true;
                


            }

            if (Request.QueryString["panel"] == "PendingDisbursement")
            {
                int init_ = 0;
                string condition = " AND (";
                if (RoleExist(5) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=13"; init_++; }
                if (RoleExist(7) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=14"; init_++; }
                if (RoleExist(8) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=15"; init_++; }
                if (condition == " AND (") { condition = "0=1"; } else { condition += ")"; }

                this.disbursementpendinglist.type = "disbursement";

                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                             + "FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + "WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + condition;



                
                this.disbursementpendinglist.refreshData(sql);
                this.disbursementpendinglist.Visible = true;


            }
            
        }
        
    }


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
