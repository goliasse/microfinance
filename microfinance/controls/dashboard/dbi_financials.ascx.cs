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

public partial class controls_dashboard_dbi_financials : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            mainDSTableAdapters.Dashboard_Interest_IncomeTableAdapter intincome = new mainDSTableAdapters.Dashboard_Interest_IncomeTableAdapter();
            mainDS.Dashboard_Interest_IncomeDataTable tblIntincome = intincome.GetData(DateTime.Now.AddMonths(-6).ToShortDateString(), DateTime.Now.ToShortDateString(), MySessionManager.CurrentUser.BranchID, 0, 0, 0);

            string myfinalDT = "[['Period','Interest Income'],";

            int l = 0;
            for (int i = 0; i < tblIntincome.Rows.Count; i++)
            {
                if (i == (tblIntincome.Rows.Count - 1))
                { myfinalDT += "['" + getMonth(Convert.ToInt32(tblIntincome[i].month)) + "'," + tblIntincome[i].InterestIncome + "]"; }
                else
                { myfinalDT += "['" + getMonth(Convert.ToInt32(tblIntincome[i].month)) + "'," + tblIntincome[i].InterestIncome + "],"; }

                l = l + 30;
            }
            myfinalDT += "]";

            this.data_ii.Value = myfinalDT;
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
