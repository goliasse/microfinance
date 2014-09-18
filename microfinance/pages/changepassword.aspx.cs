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

public partial class pages_changepassword : System.Web.UI.Page
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            usersTableAdapters.GetSpecificUserTableAdapter user = new usersTableAdapters.GetSpecificUserTableAdapter();
            users.GetSpecificUserRow tblUser = user.GetSpecificUser(MySessionManager.CurrentUser.UserID)[0];

            lblName.InnerHtml = "<b>" + util.displayValue("opt_titles", tblUser.datTitle) + tblUser.datFirstnames.ToString() + "  " + tblUser.datSurname.ToString() + "</b>";
            lblEmail.InnerHtml = "<b>" + tblUser.datEmailAddress.ToString() + "</b>";
            lblCellNumber.InnerHtml = "<b>"+ tblUser.datCellNumber.ToString() +"</b>";


        }
        catch (Exception ex) { }
    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        try
        {
            usersTableAdapters.GetSpecificUserTableAdapter user = new usersTableAdapters.GetSpecificUserTableAdapter();
            users.GetSpecificUserRow tblUser = user.GetSpecificUser(MySessionManager.CurrentUser.UserID)[0];

            if (tblUser.datPassword == txtOldPassword.Text)
            {
                if (txtNewPassword.Text == txtConfirmPassword.Text)
                {
                    usersTableAdapters.UsersTableAdapter userData = new usersTableAdapters.UsersTableAdapter();
                    userData.UpdatePassword(txtNewPassword.Text,
                                            MySessionManager.CurrentUser.UserID);
                }
                else
                { ShowMessageBox("The password provided and the Confirmed password does not match"); }
            }
            else 
            {
                ShowMessageBox("The Old password is incorrect");            
            }
        }
        catch (Exception ex) { }

    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }

}
