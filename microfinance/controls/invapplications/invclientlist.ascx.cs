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

public partial class controls_invapplications_invclientlist : System.Web.UI.UserControl
{
    public string type { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {

        SqlDataSource1.SelectParameters["branchID"].DefaultValue = MySessionManager.CurrentUser.BranchID.ToString();
        gvInvClients.DataBind();
       
    }
    protected void btnSaveAlert_Click(object sender, EventArgs e)
    {
        string EncID = appID.Value.Trim();
        int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));

       InvestmentDSTableAdapters.GetAlertTableAdapter InvApp = new InvestmentDSTableAdapters.GetAlertTableAdapter();
        InvApp.SaveInvAlert(alertmsg.Value,
                            DecID);
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml = e.AffectedRows.ToString();
    }


    protected void gvInvClients_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            HyperLink link = (HyperLink)e.Row.FindControl("HyperAppProcess");
             if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string enpValue = MyEncryption.Encrypt(gvInvClients.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");
                if (type == "initInterview")
                {
                    link.NavigateUrl = "~/pages/invapplication/initInterview.aspx?id=" + enpValue;
                    
                }
                if (type == "receipt")
                {
                    link.NavigateUrl = "~/pages/invapplication/receipt.aspx?id=" + enpValue;
                }
                else if (type == "certification")
                {
                    link.NavigateUrl = "~/pages/invapplication/certification.aspx?id=" + enpValue;
                }
                else if (type == "approved")
                {
                    link.NavigateUrl = "~/pages/invapplication/approved.aspx?id=" + enpValue;
                }
                else if (type == "intMaturity")
                {
                    link.NavigateUrl = "~/pages/invapplication/interestmaturity.aspx?id=" + enpValue;
                }
                else if (type == "invMaturity")
                {
                    link.NavigateUrl = "~/pages/invapplication/review.aspx?id=" + enpValue;
                }
                else if (type == "matured")
                {
                    link.NavigateUrl = "~/pages/invapplication/matured.aspx?id=" + enpValue;
                }
               
                HyperLink AlertLink = (HyperLink)e.Row.FindControl("hyperAlert");
                AlertLink.NavigateUrl = "javascript:loadAlertPop('" + enpValue + "')";

                if (setReview(Convert.ToInt32(this.gvInvClients.DataKeys[e.Row.RowIndex].Value.ToString())))
                { e.Row.Cells[4].Text = "<i class='glyphicon glyphicon-ok'></i>"; }
                else
                { }
            }
        }
        catch (Exception ex) { }

    }
    /// <summary>
    /// Clear the old data in the gridview and populate it based on the query submitted
    /// </summary>
    /// <param name="sql"></param>
    public void refreshData(string sql)
    {
        try
        {
            SqlDataSource1.SelectCommand = sql;
            gvInvClients.DataBind();
        }
        catch (Exception ex) { }

    }
    public bool setReview(int appid)
    {
        bool review = false;
        //try
        //{
        //    LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        //    review = Convert.ToBoolean(loanApp.GetReviewStatus(appid));
        //}
        //catch (Exception ex) { }
        return review;

    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

}
