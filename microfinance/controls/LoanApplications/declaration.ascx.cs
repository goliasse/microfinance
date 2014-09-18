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

public partial class controls_declaration : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            this.ObjectDataSource2.SelectParameters["ClientID"].DefaultValue = loanApp.getClientID(MySessionManager.AppID).ToString();
            this.rvPreagreement.DataBind();
            this.rvPreagreement.LocalReport.Refresh();
          
        }
        catch (Exception ex) { }
    }
}
