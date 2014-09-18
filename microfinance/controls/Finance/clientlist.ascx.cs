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

public partial class controls_clientlist : System.Web.UI.UserControl
{
    public string type{set;get;}
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack)
            return;
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml =  e.AffectedRows.ToString();
    }
    protected void gvAccounts_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string enpValue = MyEncryption.Encrypt(this.gvAccounts.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");
            
            HyperLink link = (HyperLink)e.Row.FindControl("hyperAppProcess");
                if (type == "initialassesment")
                {
                    link.NavigateUrl = "~/pages/loanapplication/initialassesment.aspx?id=" + enpValue;
                }
                if (type  == "preapproved")
                {
                    link.NavigateUrl = "~/pages/loanapplication/preapproved.aspx?id=" + enpValue;
                    }
                else if (type == "appraisals")
                {
                    link.NavigateUrl = "~/pages/loanapplication/appraisals.aspx?id=" + enpValue;
                }
                else if (type == "approval")
                {
                    link.NavigateUrl = "~/pages/loanapplication/approvals.aspx?id=" + enpValue;
                    }
                else if (type == "approvedloans")
                {
                    link.NavigateUrl = "~/pages/loanapplication/approvedloans.aspx?id=" + enpValue;
                }
                else if (type == "review")
                {
                    link.NavigateUrl = "~/pages/loanapplication/review.aspx?id=" + enpValue;
                }
                else if (type == "disbursement")
                {
                    link.NavigateUrl = "~/pages/finance/disbursement.aspx?id=" + enpValue;
                }
                else if (type == "risk")
                {
                    link.NavigateUrl = "~/pages/loanapplication/risk.aspx?id=" + enpValue;
                }
                else if (type == "legal")
                {
                    link.NavigateUrl = "~/pages/loanapplication/legal.aspx?id=" + enpValue;
                }
                HyperLink AlertLink = (HyperLink)e.Row.FindControl("hyperAlert");
                AlertLink.NavigateUrl = "javascript:loadAlertPop('" + enpValue + "')";

                if (setReview(Convert.ToInt32(this.gvAccounts.DataKeys[e.Row.RowIndex].Value.ToString())))
                { e.Row.Cells[4].Text = "<i class='glyphicon glyphicon-ok'></i>"; }
                else
                { }
        }
    }

    public void refreshData(string sql)
    {
        try
        {
            SqlDataSource1.SelectCommand = sql;
            gvAccounts.DataBind();
        }
        catch (Exception ex) { }
    
        }

    protected void btnSaveAlert_Click(object sender, EventArgs e)
    {
        string EncID = appID.Value.Trim();
        int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        loanApp.saveAlert(alertmsg.Value, 
                          DecID);
    }
    public bool setReview(int appid)
    {
        bool review=false;
        try
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            review = Convert.ToBoolean(loanApp.GetReviewStatus(appid));
        }
        catch (Exception ex) { }
        return review;
    
    }
    
}
