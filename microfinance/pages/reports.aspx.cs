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

public partial class pages_report : System.Web.UI.Page
{
    public string reporttype { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["action"] != null)
        {toggleTab("reportcontainer");}
        else { if (reporttype == null) { toggleTab("reportcontrol"); } }
   
    }


    public void toggleTab(string tab)
    {
        if (tab == "reportcontrol")
        {
            this.ReportsCtrl1.Visible = true;
            this.ReportContainer1.Visible = false;
        }
        else if (tab == "reportcontainer")
        {
            this.ReportsCtrl1.Visible = false;
            this.ReportContainer1.Visible = true;
        }
    
    
    }
}
