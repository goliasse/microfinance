using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

public partial class admin_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        mainDSTableAdapters.SetupDetailsTableAdapter setup = new mainDSTableAdapters.SetupDetailsTableAdapter();
        mainDS.SetupDetailsDataTable tblSetup = setup.GetSetupDetails(1);
        if (tblSetup.Rows.Count > 0)
        {
            lblCompany.InnerText = tblSetup[0].datCompanyname.ToString();
        }
        
        if (MySessionManager.CurrentUser== null)
        {
            Response.Redirect("~/logout.aspx");
        
        }
        this.lkbUsername.Text = MySessionManager.CurrentUser.UserFullName + " - " + MySessionManager.CurrentUser.UserRole;
    }
}
