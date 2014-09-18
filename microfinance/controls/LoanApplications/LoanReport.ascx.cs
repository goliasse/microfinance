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

public partial class controls_LoanReport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
            LoadLoanRpt();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.GetLoanReportTableAdapter LoanRpt = new LoanDSTableAdapters.GetLoanReportTableAdapter();
            LoanDS.GetLoanReportDataTable tblLoanRpt = LoanRpt.GetLoanReport(MySessionManager.AppID, MySessionManager.ClientID);

            if (!(tblLoanRpt.Rows.Count > 0))
            {
                LoanRpt.InsertLoanReport(txtDescription.Value.Trim(),
                                         MySessionManager.ClientID,
                                         MySessionManager.AppID,
                                         MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
            }
            else
            {
                int id = Convert.ToInt32(tblLoanRpt[0].datID.ToString());
                LoanRpt.UpdateLoanReport(txtDescription.Value.Trim(),
                                                       MySessionManager.ClientID,
                                                       MySessionManager.AppID);
                this.editskip.Value = "1";
            }
        }
    }

    public void LoadLoanRpt()
    { 
        LoanDSTableAdapters.GetLoanReportTableAdapter LoanRpt = new LoanDSTableAdapters.GetLoanReportTableAdapter ();
        LoanDS.GetLoanReportDataTable tblLoanRpt = LoanRpt .GetLoanReport(MySessionManager.AppID, MySessionManager.ClientID);
        if (tblLoanRpt .Rows.Count > 0)
        {
            txtDescription.Value = Convert.ToString(tblLoanRpt[0].datDescription);
        }
        this.editskip.Value = "2";
   
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
            if (txtDescription.Value == "") { args.IsValid = false; ErrorMessage += "<p> Please the report cannot be blank</p>"; }
          
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    } 
    
}

