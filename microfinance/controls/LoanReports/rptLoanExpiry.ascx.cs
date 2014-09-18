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
using System.Globalization;

public partial class controls_LoanReports_rptLoanExpiry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.rvLoanExpiry.Visible = false;
    }
    protected void btnViewReport_Click(object sender, EventArgs e)
    {
        bindReport();
    }

    public void bindReport()
    {
        try
        {
            this.rvLoanExpiry.Visible = true;
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime fromDT = DateTime.Parse(txtFromDT.Text, ukCulture.DateTimeFormat);
            DateTime toDT = DateTime.Parse(txtToDT.Text, ukCulture.DateTimeFormat);

            this.ObjectDataSource1.SelectParameters["FromDT"].DefaultValue = fromDT.ToShortDateString();
            this.ObjectDataSource1.SelectParameters["ToDT"].DefaultValue = toDT.ToShortDateString();
            this.ObjectDataSource1.SelectParameters["BranchID"].DefaultValue = ddlBranch.SelectedValue.ToString();
            this.ObjectDataSource1.SelectParameters["CMID"].DefaultValue = ddlct.SelectedValue.ToString();
            rvLoanExpiry.DataBind();
            this.rvLoanExpiry.LocalReport.Refresh();
        }
        catch (Exception ex) { }
    
    }
  
}
