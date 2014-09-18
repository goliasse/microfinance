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

public partial class controls_comments : System.Web.UI.UserControl
{
    Utility util = new Utility();
    public int id { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
            loadComments();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            string stage = util.displayValue("opt_application_status", loanApp.getApplicationStatus(MySessionManager.AppID).ToString());
            string role = util.displayValue("opt_levels", MySessionManager.CurrentUser.RoleID.ToString());
            string appStage = util.displayValue("opt_application_status", loanApp.getApplicationStatus(MySessionManager.AppID).ToString());
            LoanDSTableAdapters.CommentsTableAdapter comments = new LoanDSTableAdapters.CommentsTableAdapter();
            LoanDS.CommentsDataTable tblComments = comments.GetSpecificComments(MySessionManager.AppID, MySessionManager.ClientID, appStage);

            if (!(tblComments.Rows.Count > 0))
            {
                comments.InsertComment(role,
                                       stage,
                                       txtDescription.Value.Trim(),
                                       MySessionManager.ClientID,
                                       MySessionManager.AppID,
                                       MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
            }
            else
            {
                int id = Convert.ToInt32(tblComments[0].datID.ToString());
                comments.UpdateComment(txtDescription.Value.Trim(),
                                               id);
                this.editskip.Value = "1";
            }
        }
            
    }

    public void loadComments()
    {
        LoanDSTableAdapters.CommentsTableAdapter comments = new LoanDSTableAdapters.CommentsTableAdapter();
        LoanDS.CommentsDataTable tblComments = comments.GetComments(MySessionManager.AppID, MySessionManager.ClientID);
        LoanDSTableAdapters.LoanApplicationsTableAdapter  loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();

        if (tblComments.Rows.Count > 0)
        {
            string appStage = util.displayValue("opt_application_status", loanApp.getApplicationStatus(MySessionManager.AppID).ToString());
            string stage="";
            foreach(LoanDS.CommentsRow r in tblComments)
            {
                stage = r.datStage;
                if (stage == appStage)
                {
                    id = r.datID;
                    txtDescription.Value =r.datDescription.ToString();
                }
            }
            this.editskip.Value = "2";
        }
    }
    
    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            Type type;
            decimal m;
            int k;
            DateTime dt;
            if (txtDescription.Value == "") { args.IsValid = false; ErrorMessage += "<p> The comment cannot be blank </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}

