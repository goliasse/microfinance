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

public partial class backend_users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["page"]=="roles")
        {
            this.newuser1.Visible = false;
            this.users1.Visible = false;
            this.accessrights1.Visible = false;
            this.userroles1.Visible = true;
        }
        else if (Request.QueryString["page"] == "accessright")
        {
            this.newuser1.Visible = false;
            this.users1.Visible = false;
            this.accessrights1.Visible = true;
            this.userroles1.Visible = false;
        }
        else if (Request.QueryString["page"] == "newuser")
        {
            this.users1.Visible = false;
            this.newuser1.Visible = true;
            this.accessrights1.Visible = false;
            this.userroles1.Visible = false;
        }
        else if (Request.QueryString["page"] == "users")
        {
            this.users1.Visible = true;
            this.newuser1.Visible = false;
            this.accessrights1.Visible = false;
            this.userroles1.Visible = false;
        }
        else
        {
            this.users1.Visible = true;
            this.newuser1.Visible = false;
            this.accessrights1.Visible = false;
            this.userroles1.Visible = false;
        
        }
    }
}
