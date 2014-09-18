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

public partial class controls_Auditors : System.Web.UI.UserControl
{

    public string type{ set; get; }
    public int id{ set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        ListItem LItem = new ListItem("--Select--", "0");
       // ddlAuditors_solicitors.Items.Insert(0, LItem);

        if (!(Request.QueryString["auedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["auedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadAuditors(id);
            }
        }
        else if (!(Request.QueryString["audelete"] == null))
        {
            string id = Request.QueryString["audelete"];
            util.deleteItem("tbl_auditors", id);

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "audelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.AuditorsTableAdapter auditors = new LoanDSTableAdapters.AuditorsTableAdapter();
            if (!(type == "update"))
            {
                auditors.InsertAuditor(MySessionManager.ClientID,
                                       MySessionManager.AppID,
                                       txtName.Value.Trim(),
                                       txtAddress.Value.Trim(),
                                       Convert.ToInt32(ddlAuditors_solicitors.Text),
                                       MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
            }
            else if (type == "update")
            {


                auditors.UpdateAuditors(txtName.Value.Trim(),
                                       txtAddress.Value.Trim(),
                                       Convert.ToInt32(ddlAuditors_solicitors.Text),
                                       id);

                this.editskip.Value = "1";

            }

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "auedit"));

        }
    }

    public void loadAuditors(int ID)
    {
        LoanDSTableAdapters.AuditorsTableAdapter auditors = new LoanDSTableAdapters.AuditorsTableAdapter();
        LoanDS.AuditorsDataTable tblAuditors = auditors.GetAuditors(MySessionManager.ClientID, MySessionManager.AppID);
        if (tblAuditors.Rows.Count > 0)
        {
            txtName.Value = tblAuditors[0].datAuditorName.ToString();
            txtAddress.Value = tblAuditors[0].datAddress.ToString();
            if (tblAuditors[0].datAORS > 0) { ddlAuditors_solicitors.SelectedValue = tblAuditors[0].datAORS.ToString(); }
            this.editskip.Value = "2";
        }
    
    }
    protected void gvAuditors_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvAuditors.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&auedit=" + enpValue; 
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&audelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;
        }
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            decimal m;
            int k;
            DateTime dt;
            if (txtName.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the auditor or solicitor </p>"; }
            if (txtAddress.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the auditor or solicitor </p>"; }
            if (Convert.ToInt32(ddlAuditors_solicitors.SelectedValue)<0) { args.IsValid = false; ErrorMessage += "<p> Choose one of the options auditor or solicitor </p>"; }
           
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }

}
