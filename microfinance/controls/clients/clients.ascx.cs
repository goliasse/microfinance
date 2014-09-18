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
using System.Web.Services;

public partial class controls_clients : System.Web.UI.UserControl
{
    public string id{set;get; }
    public string query{set;get;}

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void gvAccounts_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml = e.AffectedRows.ToString();
    }
    protected void gvAccounts_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
            HyperLink clientProfile = (HyperLink)e.Row.FindControl("hyperClientProfile");
            HyperLink Inv = (HyperLink)e.Row.FindControl("hyperInv");

            string enpValue = MyEncryption.Encrypt(this.gvAccounts.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");

            clientProfile.NavigateUrl = "~/pages/clients/clienthome.aspx?id=" + enpValue;
            Inv.NavigateUrl = "javascript:apply('" + enpValue+"')";
        }
    }

    public void refreshData()
    {
        if (query.Length > 0)
        {
            SqlDataSource1.SelectCommand = query;
            gvAccounts.DataBind();

        }
    }
    protected void btnApply_Click(object sender, EventArgs e)
    {

        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
        
        string EncID = this.ckey.Value;
            //Request.QueryString["id"];
        int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
        int cType = Convert.ToInt32(client.GetClientType(DecID));
        if (ddlProducts.SelectedValue == "1")
        {
            int lType=0;
            if (cType == 1) { lType = 1; } else if (cType == 2) { lType = 2; } else if (cType == 3) { lType = 4; }
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            string clientname = client.GetClientsName(DecID).ToString();
           
            loanApp.InsertNewApplication(DecID,
                                         clientname,
                                         lType,
                                         MySessionManager.CurrentUser.BranchID,
                                         MySessionManager.CurrentUser.UserID);
            ShowMessageBox("Loan Application for " + clientname + " submited successfully");
        }
        else if(ddlProducts.SelectedValue=="2")
        {
             string clientname = client.GetClientsName(DecID).ToString();
           
             InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invapp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
             invapp.InsertInvestmentApplication(DecID,
                                                clientname,
                                                1,
                                                MySessionManager.CurrentUser.BranchID);
             ShowMessageBox("Investment Application for " + clientname + " submited successfully");
        
        
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}
