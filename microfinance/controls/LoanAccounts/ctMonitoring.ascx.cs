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

public partial class controls_LoanAccounts_ctMonitoring : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadComments(Convert.ToInt32(MySessionManager.AccountID));
    }
    protected void btnSaveComments_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            try
            {
                LoanAccountDSTableAdapters.AccountCommentTableAdapter accComment = new LoanAccountDSTableAdapters.AccountCommentTableAdapter();
                accComment.InsertAccountComment(txtComment.Value.Trim(),
                                                Convert.ToInt32(MySessionManager.AccountID),
                                                MySessionManager.CurrentUser.UserID);
            }
            catch (Exception ex) { }
        }
    }

    public void LoadComments(int AccID)
    {

        LoanAccountDSTableAdapters.AccountCommentTableAdapter accComment = new LoanAccountDSTableAdapters.AccountCommentTableAdapter();
        LoanAccountDS.AccountCommentDataTable tblAccComment = accComment.GetAccountComment(AccID);

        foreach (LoanAccountDS.AccountCommentRow r in tblAccComment)
        {
            HtmlGenericControl myp = new HtmlGenericControl("p");
            HtmlGenericControl mypMessage = new HtmlGenericControl("div");
            HtmlGenericControl myDiv = new HtmlGenericControl("div");
            myDiv.Attributes["class"] = "";
            myp.InnerHtml = "<h6>" + r.datUser.ToString()+"'s Comment on"+ r.modifiedDate.ToLongDateString() + "</h6>";
            mypMessage.InnerText=r.datDescription.ToString();
            Literal myLine = new Literal();
            myLine.Text = "<hr/><br/>";
            myDiv.Controls.Add(myp);
            myDiv.Controls.Add(myLine);
            myDiv.Controls.Add(mypMessage);
            myDiv.Controls.Add(myLine);
         //  this.Comments.Controls.Add(myDiv);
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
            if (txtComment.Value == "") { args.IsValid = false; ErrorMessage += "<p> The comment cannot be blank </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
