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

public partial class controls_invapplications_advise : System.Web.UI.UserControl
{
   
    protected void Page_Load(object sender, EventArgs e)
    {

        loadAdvise();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            InvestmentDSTableAdapters.GetAdviseTableAdapter advise = new InvestmentDSTableAdapters.GetAdviseTableAdapter();
            //Invest.GetRiskReportDataTable tblRiskReport = riskRpt.GetRiskReport(MySessionManager.AppID, MySessionManager.ClientID);

         
                advise.InsertAdvise("Initial Interview",
                                    MySessionManager.ClientID,
                                    MySessionManager.InvAppID,
                                    txtDescription.Value.Trim(),
                                    MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
                Response.Redirect(Request.RawUrl);
           
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
            if (txtDescription.Value == "") { args.IsValid = false; ErrorMessage += "<p> The risk report cannot be blank </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
    public void loadAdvise()
    {
        usersTableAdapters.GetUserNameTableAdapter user = new usersTableAdapters.GetUserNameTableAdapter();
        InvestmentDSTableAdapters.GetAdviseTableAdapter advise = new InvestmentDSTableAdapters.GetAdviseTableAdapter();
        InvestmentDS.GetAdviseDataTable tblAdvise =advise.GetAdvise(MySessionManager.InvAppID, MySessionManager.ClientID);
        if (tblAdvise.Rows.Count > 0)
        {
            foreach (InvestmentDS.GetAdviseRow r in tblAdvise)
            {
                //txtDescription.Value = tblAdvise[0].datDescription.ToString();
                HtmlGenericControl myp = new HtmlGenericControl("p");
                HtmlGenericControl mypMessage = new HtmlGenericControl("blockquote");
                HtmlGenericControl myDiv = new HtmlGenericControl("div");
                myDiv.Attributes["class"] = " col-md-12 alert alert-info";
                myDiv.Style["padding"] = "4px";
                myp.InnerHtml = "<h5><span> Stage:" + r.datStage.ToString() + "</span><br/><i>   <b> " + user.Getuser(r.userID).ToString() +"</b>'s comment on " + r.modifiedDate.ToLongDateString() + "</i></h5>"
                               + "<hr style='margin:3px'/>";
                mypMessage.Attributes["class"] = "text-justify";
                mypMessage.InnerHtml = "<p>" + r.datDescription.ToString() + "</p>";
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
}
