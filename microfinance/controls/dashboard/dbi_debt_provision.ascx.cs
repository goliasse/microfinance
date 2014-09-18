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

public partial class controls_dashboard_dbi_debt_provision : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            mainDSTableAdapters.Dashboard_PBDTableAdapter disb = new mainDSTableAdapters.Dashboard_PBDTableAdapter();
            mainDS.Dashboard_PBDDataTable tblDisb = disb.GetData(DateTime.Now.AddMonths(-1).ToShortDateString(), MySessionManager.CurrentUser.BranchID, 0, 0);
            string myfinalDT = "[['Category','Provision Amount'],";

            for (int i = 0; i < tblDisb.Rows.Count; i++)
            {
                if (i == (tblDisb.Rows.Count - 1))
                { myfinalDT += "['" + tblDisb[i].datCategory + "'," + tblDisb[i].provision + "]"; }
                else
                { myfinalDT += "['" + tblDisb[i].datCategory + "'," + tblDisb[i].provision + "],"; }
            }
            myfinalDT += "]";

            this.data_debt.Value = myfinalDT;
            //this.data_debt1.Value = mailerman;
        }
        catch (Exception ex) { }
        try
        {
            mainDSTableAdapters.Dashboard_PBDTableAdapter disb1 = new mainDSTableAdapters.Dashboard_PBDTableAdapter();
            mainDS.Dashboard_PBDDataTable tblDisb1 = disb1.GetData(DateTime.Now.AddDays(-1).ToShortDateString(), MySessionManager.CurrentUser.BranchID, 0, 0);
            string myfinalDT1 = "[['Category','Provision Amount'],";

            for (int i = 0; i < tblDisb1.Rows.Count; i++)
            {
                if (i == (tblDisb1.Rows.Count - 1))
                { myfinalDT1 += "['" + tblDisb1[i].datCategory + "'," + tblDisb1[i].provision + "]"; }
                else
                { myfinalDT1 += "['" + tblDisb1[i].datCategory + "'," + tblDisb1[i].provision + "],"; }
            }
            myfinalDT1 += "]";

            this.data_debt1.Value = myfinalDT1;
        }
        catch (Exception ex) { }
    }
}
