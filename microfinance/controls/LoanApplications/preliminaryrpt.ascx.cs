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

public partial class controls_preliminaryrpt : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!(this.editskip.Value=="2"))
        loadPreliminaryRpt();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.PreApprovalReportTableAdapter preApprovalRpt = new LoanDSTableAdapters.PreApprovalReportTableAdapter();
            LoanDS.PreApprovalReportDataTable tblpreApproval = preApprovalRpt.GetPreApprovalReport(MySessionManager.AppID, MySessionManager.ClientID);

            if (!(tblpreApproval.Rows.Count > 0))
            {
                preApprovalRpt.InsertPreApprovalReport(txtDescription.Value.Trim(),
                                                       MySessionManager.ClientID,
                                                       MySessionManager.AppID,
                                                       MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
            }
            else
            {
                int id = Convert.ToInt32(tblpreApproval[0].datID.ToString());
                preApprovalRpt.UpdatePreApprovalReport(txtDescription.Value.Trim(),
                                                       MySessionManager.ClientID,
                                                       MySessionManager.AppID,
                                                       1,
                                                       MySessionManager.CurrentUser.UserID,
                                                       id);
                this.editskip.Value = "1";
            }
        }
    }

    public void loadPreliminaryRpt()
    {
        LoanDSTableAdapters.PreApprovalReportTableAdapter preliminaryRpt = new LoanDSTableAdapters.PreApprovalReportTableAdapter();
        LoanDS.PreApprovalReportDataTable tblPreliminaryRpt = preliminaryRpt.GetPreApprovalReport(MySessionManager.AppID, MySessionManager.ClientID);
        if (tblPreliminaryRpt.Rows.Count > 0)
        {
            txtDescription.Value = Convert.ToString(tblPreliminaryRpt[0].datDescription);
        }
        this.editskip.Value = "2";
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
            if (txtDescription.Value == "") { args.IsValid = false; ErrorMessage += "<p> The prelimary report cannot be blank </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}

