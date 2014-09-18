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

public partial class controls_dashboard_dbi_databar : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            mainDSTableAdapters.Dashboard_DisbursementTableAdapter disb = new mainDSTableAdapters.Dashboard_DisbursementTableAdapter();
            mainDS.Dashboard_DisbursementDataTable tblDisb = disb.GetData(DateTime.Now.AddMonths(-6).ToShortDateString(), DateTime.Now.ToShortDateString(), MySessionManager.CurrentUser.BranchID, 0);
            string myfinalDT = "[['Period','Amount Disbursed'],";

            int l = 0;
            for (int i = 0; i < tblDisb.Rows.Count; i++)
            {
                if (i == (tblDisb.Rows.Count - 1))
                { myfinalDT += "['" + "week" + tblDisb[i].week + "'," + tblDisb[i].DisbursedAmt + "]"; }
                else
                { myfinalDT += "['" + "week" + tblDisb[i].week + "'," + tblDisb[i].DisbursedAmt + "],"; }

                l = l + 30;
            }
            myfinalDT += "]";

            this.data_disb.Value = myfinalDT;


            mainDSTableAdapters.Dashboard_Disbursement1TableAdapter disb1 = new mainDSTableAdapters.Dashboard_Disbursement1TableAdapter();
            mainDS.Dashboard_Disbursement1DataTable tblDisb1 = disb1.GetData(DateTime.Now.AddMonths(-1).ToShortDateString(), DateTime.Now.ToShortDateString(), MySessionManager.CurrentUser.BranchID, 0);
            string myfinalDT1 = "";

            if (tblDisb1.Rows.Count > 0)
            {
                try
                {
                    myfinalDT1 = "[['Period','Amount Disbursed'],";

                    //int l = 0;
                    for (int i = 0; i < tblDisb1.Rows.Count; i++)
                    {

                        if (i == (tblDisb1.Rows.Count - 1))
                        {
                            DateTime datDay = Convert.ToDateTime(tblDisb1[i].date.ToString());
                            myfinalDT1 += "['" +  datDay.Day+"/"+datDay.Month + "'," + tblDisb1[i].DisbursedAmt + "]"; 
                        }
                        else
                        {
                            DateTime datDay = Convert.ToDateTime(tblDisb1[i].date.ToString());
                            myfinalDT1 += "['" + datDay.Day + "/" + datDay.Month + "'," + tblDisb1[i].DisbursedAmt + "],"; 
                        }

                        l = l + 30;
                    }
                    myfinalDT1 += "]";
                }
                catch (Exception ex) { myfinalDT1 = ""; }

            }
            if (myfinalDT1.Length == 0)
            { myfinalDT = "No Data"; }

            this.data_disb1.Value = myfinalDT1;
        }
        catch (Exception ex) { }
        
    }
    public string getMonth(int i)
    {
        if (i == 1) { return "January"; }
        else if (i == 2) { return "Febuary"; }
        else if (i == 3) { return "March"; }
        else if (i == 4) { return "April"; }
        else if (i == 5) { return "May"; }
        else if (i == 6) { return "June"; } 
        else if (i == 7) { return "July"; }
        else if (i == 8) { return "August"; }
        else if (i == 9) { return "September"; }
        else if (i == 10) { return "October"; }
        else if (i == 11) { return "November"; }
        else if (i == 12) { return "December"; }
        else { return ""; }
    }
}
