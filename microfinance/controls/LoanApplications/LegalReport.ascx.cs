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

public partial class controls_Legal : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
            loadLegalReport();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.LegalReportTableAdapter legalRpt = new LoanDSTableAdapters.LegalReportTableAdapter();
        LoanDS.LegalReportDataTable tblLegalReport = legalRpt.GetData(MySessionManager.AppID, MySessionManager.ClientID);

        if (!(tblLegalReport.Rows.Count > 0))
        {
            legalRpt.InsertLegalReport(txtDescription.Value.Trim(),
                                       MySessionManager.ClientID,
                                       MySessionManager.AppID,
                                       MySessionManager.CurrentUser.UserID);
            this.editskip.Value = "1";
        }
        else
        {
            int id = Convert.ToInt32(tblLegalReport[0].datID.ToString());
            legalRpt.UpdateLegalReport(txtDescription.Value.Trim(),
                                       MySessionManager.CurrentUser.UserID,
                                       id);
            this.editskip.Value = "1";
        }
    }
    public void loadLegalReport()
    {
        LoanDSTableAdapters.LegalReportTableAdapter legalRpt = new LoanDSTableAdapters.LegalReportTableAdapter();
        LoanDS.LegalReportDataTable tblLegalRpt = legalRpt.GetData(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblLegalRpt.Rows.Count > 0)
        {
            txtDescription.Value = tblLegalRpt[0].datDescription.ToString();
            this.editskip.Value = "2";
        }
    
    
    
    
    }

}
