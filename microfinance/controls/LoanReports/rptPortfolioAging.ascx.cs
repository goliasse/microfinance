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

public partial class controls_LoanReports_rptPortfolioAging : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.rvAging.Visible = false;
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


            this.rvAging.Visible = true;
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime fromDT = DateTime.Parse(txtDate.Text, ukCulture.DateTimeFormat);
            string dt = fromDT.ToShortDateString();

            this.ObjectDataSource2.SelectParameters["date"].DefaultValue = dt;
            this.ObjectDataSource2.SelectParameters["category"].DefaultValue =ddlCategory.SelectedValue.ToString();
            this.ObjectDataSource2.SelectParameters["Type"].DefaultValue = ddlPerformance.SelectedValue.ToString();
            this.ObjectDataSource2.SelectParameters["BranchID"].DefaultValue = ddlBranch.SelectedValue.ToString();
            this.ObjectDataSource2.SelectParameters["CMID"].DefaultValue = ddlct.SelectedValue.ToString();

            ReportParameter rp1 = new ReportParameter("Report_Date", DateTime.Now.ToString("dd-MM-yyyy"));
            ReportParameter rp3 = new ReportParameter("date", txtDate.Text);
            ReportParameter rp2 = new ReportParameter("Report_Generator", name);
            rvAging.LocalReport.SetParameters(new ReportParameter[] { rp1, rp2, rp3 });

            rvAging.DataBind();
            this.rvAging.LocalReport.Refresh();
        }
        catch (Exception ex) { }
    
    
    
    }
    //ObjectDataSource.
}
