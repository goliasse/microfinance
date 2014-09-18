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

public partial class controls_riskReport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
            loadRiskReport();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.GetRiskReportTableAdapter riskRpt = new LoanDSTableAdapters.GetRiskReportTableAdapter();
            LoanDS.GetRiskReportDataTable tblRiskReport = riskRpt.GetRiskReport(MySessionManager.AppID, MySessionManager.ClientID);

            if (!(tblRiskReport.Rows.Count > 0))
            {
                riskRpt.InsertRiskReport(txtDescription.Value.Trim(),
                                         MySessionManager.ClientID,
                                         MySessionManager.AppID,
                                         MySessionManager.CurrentUser.UserID);
                this.editskip.Value = "1";
            }
            else
            {
                int id = Convert.ToInt32(tblRiskReport[0].datID.ToString());
                riskRpt.UpdateRiskReport(txtDescription.Value.Trim(),
                                         MySessionManager.CurrentUser.UserID,
                                         id);
                this.editskip.Value = "1";
            }
        }
    }

    public void loadRiskReport()
    {
        LoanDSTableAdapters.GetRiskReportTableAdapter riskRpt = new LoanDSTableAdapters.GetRiskReportTableAdapter();
        LoanDS.GetRiskReportDataTable tblRiskRpt = riskRpt.GetRiskReport(MySessionManager.AppID, MySessionManager.ClientID);
        if (tblRiskRpt.Rows.Count > 0)
        {
            txtDescription.Value = tblRiskRpt[0].datDescription.ToString();
            this.editskip.Value = "2";
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
}
