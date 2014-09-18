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

public partial class pages_loanapplications : System.Web.UI.Page
{
    public string sql;
    public string type;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/logout.aspx");
        }
        MySessionManager.CurrentTab = null;
        MySessionManager.AppID = 0;
        MySessionManager.ClientID = 0;
        MySessionManager.skipAlert = 0;
        setNotifications();
         //this.clientlist1.Visible = false;
        getDirections(Request.QueryString["action"]);
       // setMenuList();
}



    public void getDirections(string page)
    {
        if (!(page == null)||(MySessionManager.CurrentUser ==null))
        {
            if (page == "initialassesment")
            {
                this.clientlist1.type = "initialassesment";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                           + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                           + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 2";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;

            }
            if (page == "preapproved")
            {
                this.clientlist1.type = "preapproved";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                           + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                           + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 3";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;

            }
            else if (page == "appraisals")
            {
                this.clientlist1.type = "appraisals";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                              + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 4 "+ getCTPartQuery(MySessionManager.CurrentUser.UserID);
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "risk")
            {
                this.clientlist1.type = "risk";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                              + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 5 ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "legal")
            {
                this.clientlist1.type = "legal";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                              + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 6 ";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "approval")
            {
                string location="";
                if (! checkBranchRole())
                {
                     location= " AND datTeamID =" + MySessionManager.CurrentUser.BranchID.ToString();
                }

                int init_ = 0;
                string condition = " AND (";
                if(RoleExist(6)==true )
                { condition += " tbl_loan_application.datApplicationStatus=7 "; init_++; }
                if(RoleExist(11)==true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=8"; init_++; }
                if (RoleExist(10) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=9"; init_++; }
                if (RoleExist(13) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=10"; init_++; }
                if (RoleExist(14) == true)
                { if (init_ > 0) { condition += "OR"; } condition += " tbl_loan_application.datApplicationStatus=11"; init_++; }

                if (condition == " AND (") { condition = "AND 0=1 "; } else { condition += ")"; }
                this.clientlist1.type = "approval";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                             + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + " WHERE (1=1) " + condition + location;
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            else if (page == "approvedloans")
            {
                this.clientlist1.type = "approvedloans";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                             + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID"
                             + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 12";
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
            //else if (page == "review")
            //{
            //    string condition = "AND";
            //    if (RoleExist(1) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=18"; }
            //    else if (RoleExist(2) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=20"; }
            //    else if (RoleExist(6) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=21"; }
            //    else if (RoleExist(6) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=21"; }
            //    else if (RoleExist(6) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=21"; }
            //    else if (RoleExist(4) == true)
            //    { condition += "tbl_loan_application.datApplicationStatus=9"; }
            //    this.clientlist1.type = "review";
            //    string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount"
            //                + " FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
            //                + " WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + condition;
            //    this.clientlist1.refreshData(sql);
            //    this.clientlist1.Visible = true;
            //}
            else if (page == "disbursement")
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
                this.clientlist1.type = "disbursement";
                string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount "
                             + "FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "
                             + "WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID +  condition;
                this.clientlist1.refreshData(sql);
                this.clientlist1.Visible = true;
            }
        }
        else
        {
            //string sql = "SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount " 
            //            +" FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID "  
            //            +" WHERE datTeamID =" + MySessionManager.CurrentUser.BranchID + " AND tbl_loan_application.datApplicationStatus = 0";
            //this.clientlist1.refreshData(sql);
            this.clientlist1.Visible = false;
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
                     if (tblroles[i].datRoleID  == role)
                     {
                         result = true;
                     }
                 }
            }
        }
        catch (Exception ex) {  }
        return result;
    
    }
    public bool checkBranchRole()
    {
        bool result = false;

        adminTableAdapters.tbl_secondary_rolesTableAdapter roles = new adminTableAdapters.tbl_secondary_rolesTableAdapter();
        admin.tbl_secondary_rolesDataTable tblroles = roles.GetRoleID(MySessionManager.CurrentUser.UserID);
        if (tblroles.Rows.Count > 0)
        {
            for (int i = 0; i < tblroles.Count; i++)
            {
                if (tblroles[i].datRoleID == 10 || tblroles[i].datRoleID == 11 || tblroles[i].datRoleID == 12)
                { return (result = true); }
            }
        }
        return result;
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
           // this.reviewinfo.InnerText = itemcount.cmreview.ToString();
            this.disbinfo.InnerText = (Convert.ToInt32(itemcount.disbursementI.ToString()) + Convert.ToInt32(itemcount.disbursementII.ToString())+(Convert.ToInt32 (itemcount.disbursementIII.ToString()))).ToString();
        }
        catch
        { }
        }

    public void setMenuList()
    {
        bool exist = false;
        mainDSTableAdapters.GetMenuItemsTableAdapter menuItem = new mainDSTableAdapters.GetMenuItemsTableAdapter();
        mainDS.GetMenuItemsDataTable tblmenuItem = menuItem.GetMenuItems(MySessionManager.CurrentUser.UserID);
        mainDSTableAdapters.GetAllMenuItemsTableAdapter menu = new mainDSTableAdapters.GetAllMenuItemsTableAdapter();
        mainDS.GetAllMenuItemsDataTable tblmenu = menu.GetData();
        foreach (mainDS.GetAllMenuItemsRow r in tblmenu)
        {
            foreach (mainDS.GetMenuItemsRow l in tblmenuItem)
            {
                if (l.datControlName.ToString() == r.datControlName.ToString())
                {
                    exist = true;
                    setControl(exist, r.datControlName, r.datControlType);
                    continue;
                }
                else { exist = false; }
                setControl(exist, r.datControlName, r.datControlType);

            }
        }
    }
    public void setControl(bool exist, string control, string type)
    {
        if (exist)
        {
            try
            {
                if (type == "LinkButton")
                {
                    LinkButton link = (LinkButton)FindControl(control);
                    LinkButton link1 = (LinkButton)ControlFinder.FindControlRecursive(this, control);
                    link.Visible = true;
                    link1.Visible = true;
                }
            }
            catch (Exception ex) { }
        }
        else
        {
            try
            {
                if (type == "LinkButton")
                {
                    LinkButton link = (LinkButton)FindControl(control);
                    LinkButton link1 = (LinkButton)ControlFinder.FindControlRecursive(this, control);
                    if (link != null)
                    { link.Visible = false; }
                    if (link1 != null)
                    { link1.Visible = false; }
                }
            }
            catch (Exception ex) { }
        }
    }
    public string  getCTPartQuery(int userID)
    {
        string qry="";
        try{
        adminTableAdapters.tbl_secondary_rolesTableAdapter roles = new adminTableAdapters.tbl_secondary_rolesTableAdapter();
        admin.tbl_secondary_rolesDataTable tblroles = roles.GetRoleID(MySessionManager.CurrentUser.UserID);
        if (tblroles.Rows.Count > 0)
        {
            for (int i = 0; i < tblroles.Count; i++)
            {
                if (tblroles[i].datRoleID == 2)
                {
                    qry+="AND tbl_loan_application.datCreditTeamID="+ tblroles[i].datTeamID.ToString() +"";
                }
            }
        
        
        }
        }catch(Exception ex){qry="";}
        if (qry == null || qry == "")
        { qry = " AND 0=1 "; }
        return qry;
    }
}
