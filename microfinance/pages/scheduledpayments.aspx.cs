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

public partial class pages_scheduledpayments : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        
        if (Page.IsPostBack == false)
        {
            try
            {
                SqlDataSource1.SelectParameters[0].DefaultValue = DateTime.Now.ToShortDateString();
                SqlDataSource1.SelectParameters[1].DefaultValue = DateTime.Now.AddDays(7).ToShortDateString();
                gvClientPayment.DataBind();
            }
            catch (Exception ex) { }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime fromDT = DateTime.Parse(txtfromDate.Text, ukCulture.DateTimeFormat);
            DateTime ToDT = DateTime.Parse(txtToDate.Text, ukCulture.DateTimeFormat);

            SqlDataSource1.SelectParameters[0].DefaultValue = fromDT.ToShortDateString();
            SqlDataSource1.SelectParameters[1].DefaultValue = ToDT.ToShortDateString();
            gvClientPayment.DataBind();
        }
        catch (Exception ex) { ShowMessageBox("Date range provide is incorrect"); }
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml = e.AffectedRows.ToString();
    }
    protected void gvClientPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            //HyperLink Loan = (HyperLink)e.Row.FindControl("hyperLoan");
            HyperLink AcDetails = (HyperLink)e.Row.FindControl("HyperAccountDetails");

            string enpValue = MyEncryption.Encrypt(this.gvClientPayment.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");

            //Loan.NavigateUrl = "~/pages/clients.aspx?product=loan&id=" + enpValue;
            AcDetails.NavigateUrl = "~/pages/loanaccountdetails.aspx?id=" + enpValue + "";
        
        
        }
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
