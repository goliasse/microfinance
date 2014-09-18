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

public partial class backend_controls_users : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = gvUsers.DataKeys[e.Row.RowIndex]["title"].ToString() + " " + gvUsers.DataKeys[e.Row.RowIndex]["datFirstnames"].ToString() + " " + gvUsers.DataKeys[e.Row.RowIndex]["datSurname"].ToString();
            string enpValue = MyEncryption.Encrypt(this.gvUsers.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");

            HyperLink accessright = (HyperLink)e.Row.FindControl("hyperAccess");
            accessright.NavigateUrl = "~/backend/pages/users.aspx?id=" + enpValue +"&page=accessright";

            HyperLink roles = (HyperLink)e.Row.FindControl("hyperRoles");
            roles.NavigateUrl = "~/backend/pages/users.aspx?id=" + enpValue+"&page=roles"; 

            HyperLink updates = (HyperLink)e.Row.FindControl("hyperUpdates");
            updates.NavigateUrl = "~/backend/pages/users.aspx?id=" + enpValue+"&page=updates";
        
        }
    }
}
