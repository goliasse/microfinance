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
using Microsoft.Reporting.WebForms;

public partial class controls_LoanReports_rptPBD : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.rvPBD.Visible = false;
    }
    protected void btnViewReport_Click(object sender, EventArgs e)
    {
        bindReport();
    }
    public void bindReport()
    {
        try
        {
            string name = "";
            try
            {
                usersTableAdapters.GetUserNameTableAdapter user = new usersTableAdapters.GetUserNameTableAdapter();
                users.GetUserNameDataTable tblUser = user.GetUserName(MySessionManager.CurrentUser.UserID);
                name = tblUser[0].name.ToString();
            }
            catch (Exception ex) { }

            this.rvPBD.Visible = true;
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime dt = DateTime.Parse(txtToDT.Text, ukCulture.DateTimeFormat);

            this.ObjectDataSource1.SelectParameters["BranchID"].DefaultValue = ddlBranch.SelectedValue;
            this.ObjectDataSource1.SelectParameters["category"].DefaultValue = ddlCategory.SelectedValue;
            this.ObjectDataSource1.SelectParameters["CMID"].DefaultValue = ddlct.SelectedValue;
            this.ObjectDataSource1.SelectParameters["date"].DefaultValue = dt.ToShortDateString();
            ReportParameter rp1 = new ReportParameter("Report_Date", DateTime.Now.ToString("dd-MM-yyyy"));
            ReportParameter rp3 = new ReportParameter("date", txtToDT.Text);
            ReportParameter rp2 = new ReportParameter("Report_Generator", name);
            rvPBD.LocalReport.SetParameters(new ReportParameter[] { rp1, rp2, rp3 });
            this.rvPBD.DataBind();
            this.rvPBD.LocalReport.Refresh();

        }
        catch (Exception ex) { }
    
    
    
    }
}
