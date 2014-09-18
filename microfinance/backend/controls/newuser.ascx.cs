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

public partial class backend_controls_newuser : System.Web.UI.UserControl
{
    public string type { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            usersTableAdapters.UsersTableAdapter user = new usersTableAdapters.UsersTableAdapter();

            if (type == "update")
            {
                user.updateUser(ddlTitle.SelectedValue,
                                txtsurname.Value,
                                txtfirstname.Value,
                                Convert.ToDateTime(txtBirthdate.Text),
                                txtMobileNo.Value.Trim(),
                                txtEmail.Value.Trim(),
                                "",
                                "",
                                Convert.ToInt32(ddlTeam.SelectedValue),
                                Convert.ToInt32(ddlDesignation.SelectedValue),
                                txtPosition.Value.Trim());



            }
            else
            {
                user.InsertUser(ddlTitle.SelectedValue,
                                txtsurname.Value,
                                txtfirstname.Value,
                                Convert.ToDateTime(txtBirthdate.Text),
                                txtEmail.Value.Trim(),
                                txtMobileNo.Value.Trim(),
                                DateTime.Now,
                                GeneratePassword(DateTime.Now),
                                "",
                                Convert.ToInt32(ddlTeam.SelectedValue),
                                Convert.ToInt32(ddlDesignation.SelectedValue),
                                txtPosition.Value,
                                1);

            }
        }
        catch (Exception ex) { }

    }
    public void loadUser(int userID)
    {
        try
        {
            usersTableAdapters.GetSpecificUserTableAdapter User = new usersTableAdapters.GetSpecificUserTableAdapter();
            users.GetSpecificUserRow tblUser = User.GetSpecificUser(userID)[0];

            txtBirthdate.Text = tblUser.datDateOfBirth.ToShortDateString();
            txtfirstname.Value = tblUser.datFirstnames.ToString();
            txtsurname.Value = tblUser.datSurname.ToString();
            txtEmail.Value = tblUser.datEmailAddress.ToString();
            if (tblUser.datTitle != "0") { ddlTitle.SelectedValue = tblUser.datTitle.ToString(); }
            if (tblUser.datTeam > 0) { ddlTeam.SelectedValue = tblUser.datTeam.ToString(); }
        }
        catch (Exception ex) { }
    }

    public string GeneratePassword(DateTime date)
    {
        string password;

        password = "Def." + date.Month.ToString() + "n" + date.Second.ToString();

        return password;
    
    
    
    }
}
