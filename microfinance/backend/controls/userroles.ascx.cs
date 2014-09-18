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

public partial class backend_controls_userroles : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.lblUserName.InnerText = "";

        if (Request.QueryString["id"] != null)
        {
            int id = Convert.ToInt32(MyEncryption.Decrypt(Request.QueryString["id"],"123456789"));

            SqlDataSource2.SelectParameters["userID"].DefaultValue = id.ToString();
        
        
        
        }
    }
   
    protected void btnSaveRole_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(MyEncryption.Decrypt(Request.QueryString["id"], "123456789"));
                adminTableAdapters.tbl_secondary_rolesTableAdapter role = new adminTableAdapters.tbl_secondary_rolesTableAdapter();
                int? ct = null;
                if(ddlCreditTeam.SelectedValue!="0")
                { ct = Convert.ToInt32(ddlCreditTeam.SelectedValue); }
                role.Insert(id,
                            Convert.ToInt32(ddlPosition.SelectedValue),
                            ddlPosition.SelectedItem.Text,
                            ct,
                            Convert.ToInt32(ddlBranch.SelectedValue)
                            );


            }

        }
        catch (Exception ex) { }
    }

}
