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

public partial class backend_pages_creditteam : System.Web.UI.Page
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        {
            Response.Redirect("~/logout.aspx");
        }
        try
        {
            if (Request.QueryString["ctid"] != null)
            {
                currentCT.Value = Request.QueryString["ctid"];

                SqlDataSource5.SelectParameters[0].DefaultValue = currentCT.Value;
                gvCtMembers.DataSourceID = "SqlDataSource5";
                gvCtMembers.DataBind();

                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    if (Request.QueryString["action"] =="edit")
                    {
                        try
                        {
                            adminTableAdapters.GetCreditTeamMembersTableAdapter ctMembers = new adminTableAdapters.GetCreditTeamMembersTableAdapter();
                            admin.GetCreditTeamMembersDataTable tblCTMembers = ctMembers.GetCTMemberDetails(id);
                            if(tblCTMembers.Rows.Count > 0)
                            {
                                ddlStaff.SelectedValue = tblCTMembers[0].datSysUserID.ToString();
                                ddlBranch.SelectedValue = tblCTMembers[0].branchID.ToString();
                                ddlCreditTeamID.SelectedValue = tblCTMembers[0].datCreditTeamID.ToString();
                            }
                        }
                        catch(Exception ex){}
                    }
                    else if (Request.QueryString["action"] == "delete")
                    {
                        adminTableAdapters.GetCreditTeamMembersTableAdapter ctMembers = new adminTableAdapters.GetCreditTeamMembersTableAdapter();
                        ctMembers.DeleteCTMember(id);
                        ShowMessageBox("A member has been removed from the team");
                    }
                
                }
            }
        }
        catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ctid")); }
    }
    protected void btnAddToCt_Click(object sender, EventArgs e)
    {
        try 
        {
            adminTableAdapters.GetCreditTeamMembersTableAdapter ctMember = new adminTableAdapters.GetCreditTeamMembersTableAdapter();
            ctMember.InsertCreditTeamMember(Convert.ToInt32(ddlCreditTeamID.SelectedValue),
                                            Convert.ToInt32(ddlStaff.SelectedValue));
            ShowMessageBox("New credit team member added");
        }
        catch (Exception ex) { }
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }

    protected void gvCt_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            HyperLink link = (HyperLink)e.Row.FindControl("HyperViewCT");
            string enpValue = this.gvCt.DataKeys[e.Row.RowIndex].Value.ToString();
            string urlpath = "~/backend/pages/creditteam.aspx?ctid=" + enpValue;
            link.NavigateUrl = urlpath;
        }
    }
    protected void gvCtMembers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = util.displayValue("opt_titles", gvCtMembers.DataKeys[e.Row.RowIndex]["datTitle"].ToString()) + " " + gvCtMembers.DataKeys[e.Row.RowIndex]["datFirstnames"].ToString() + " " + gvCtMembers.DataKeys[e.Row.RowIndex]["datSurname"].ToString();
            string enpValue = this.gvCtMembers.DataKeys[e.Row.RowIndex].Value.ToString();

            HyperLink edit = (HyperLink)e.Row.FindControl("HyperCTEdit");
            edit.NavigateUrl = "~/backend/pages/creditteam.aspx?id=" + enpValue + "&ctid=" + currentCT.Value +"&action=edit";

            HyperLink delete = (HyperLink)e.Row.FindControl("HyperCTDelete");
            delete.NavigateUrl = "~/backend/pages/creditteam.aspx?id=" + enpValue + "&ctid=" + currentCT.Value +"&action=delete";

        }
    }
    
   
}
