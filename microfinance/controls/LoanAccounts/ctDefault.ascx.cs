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

public partial class controls_LoanAccounts_ctDefault : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadComments(Convert.ToInt32(MySessionManager.AccountID));
    }

    public void LoadComments(int AccID)
    {
        LoanAccountDSTableAdapters.AccountCommentTableAdapter accComment = new LoanAccountDSTableAdapters.AccountCommentTableAdapter();
        LoanAccountDS.AccountCommentDataTable tblAccComment = accComment.GetAccountComment(AccID);

        foreach (LoanAccountDS.AccountCommentRow r in tblAccComment)
        {
            HtmlGenericControl myp = new HtmlGenericControl("p");
            HtmlGenericControl mypMessage = new HtmlGenericControl("blockquote");
            HtmlGenericControl myDiv = new HtmlGenericControl("div");
            myDiv.Attributes["class"] = " col-md-12 alert alert-info";
            myDiv.Style["padding"] = "4px";
            myp.InnerHtml = "<h5><i><b> " + r.datUser.ToString() + "</b>'s comment on " + r.modifiedDate.ToLongDateString() + "</i></h5>"
                           +"<hr style='margin:3px'/>";
            mypMessage.Attributes["class"] = "text-justify";
            mypMessage.InnerHtml="<p>" + r.datDescription.ToString()+"</p>";
            Literal myLine = new Literal();
            myLine.Text = "<hr style='margin:3px'/><br/>";
            myDiv.Controls.Add(myp);
            myDiv.Controls.Add(myLine);
            myDiv.Controls.Add(mypMessage);
            myDiv.Controls.Add(myLine);
            this.Comments.Controls.Add(myDiv);
        }
    }
}
