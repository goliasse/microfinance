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

public partial class login : System.Web.UI.Page
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack)
            return;

        if (MySessionManager.IsLogedIn)
        {

            //TruSoftDBTableAdapters.tblAccountApplicationsTableAdapter acc = new TruSoftDBTableAdapters.tblAccountApplicationsTableAdapter();
            ////usersTableAdapters.
            //acc.ReleaseApplicationByUser(MySessionManager.CurrentUser.UserID);

        }

        if (Request.Cookies["MyCookie"] != null)
        {

            //TruSoftDBTableAdapters.tblSystemUsersTableAdapter user = new TruSoftDBTableAdapters.tblSystemUsersTableAdapter();

            //user.UpdateIsLogin(false, int.Parse(Request.Cookies["MyCookie"]["userid"]));

        }
        Session.Abandon();
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (this.IsValid)
        {



            SystemUser user = null;

            usersTableAdapters.validateUserLoginTableAdapter sysusers = new usersTableAdapters.validateUserLoginTableAdapter();
            users.validateUserLoginDataTable tbl = sysusers.validateUserLogin(this.txtUsername.Value.Trim(), this.txtPassword.Value.Trim());

            if (tbl.Rows.Count > 0)
            {
                bool islogin;

                if (tbl[0].IsdatIsSignedInNull() == false){islogin = Convert.ToBoolean(tbl[0].datIsSignedIn);}else{islogin = false;}


                if (!islogin)
                {
                    user = new SystemUser();

                    user.UserID = (int)tbl.Rows[0]["datID"];
                    user.BranchID = (int)tbl[0].datTeam;
                    MySessionManager.BranchID = tbl[0].datTeam;
                    //user.BranchName = tbl.Rows[0]["BranchName"].ToString();
                    //user.BranchCode = tbl.Rows[0]["BranchCode"].ToString();
                    user.RoleID = (int)tbl[0].datLevel;
                    user.UserRole = tbl[0].datPosition.ToString();
                    user.UserEmailaddress = tbl[0].datEmailAddress.ToString();
                    if (tbl[0].IsdatCreatTeamIDNull() == false){user.TeamID = tbl[0].datCreatTeamID;}else{  }
                    user.Username = tbl[0].datFirstnames.ToString() + " " +tbl[0].datSurname.ToString() ;
                    if (!tbl[0].IsdatFirstnamesNull())
                        user.UserFullName = tbl[0].datFirstnames;

                    if (!tbl[0].IsdatSurnameNull())
                        user.UserFullName = user.UserFullName + " " + tbl[0].datSurname;

                    MySessionManager.CurrentUser = user;
                    
                    Response.Redirect("~/pages/dashboard.aspx");
                }
                else
                {
                  
                }

            }
            else
            {

            }

            
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        Server.Transfer("~/login.aspx");
    }
    
}
