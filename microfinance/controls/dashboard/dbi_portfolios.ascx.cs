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

public partial class controls_dashboard_dbi_portfolios : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            mainDSTableAdapters.Dashboard_Loan_CategoriesTableAdapter lnCat = new mainDSTableAdapters.Dashboard_Loan_CategoriesTableAdapter();
            mainDS.Dashboard_Loan_CategoriesDataTable tblLnCat = lnCat.GetData(DateTime.Now.AddDays(-1).ToShortDateString(), 0, 0);
            // ShowMessageBox(tblLnCat[0].ToString());

            string myfinalDT = "";

            for (int i = 0; i < tblLnCat.Rows.Count; i++)
            {
                if (i == 0)
                {

                    myfinalDT = "[['Period','Amount in Category'],";
                }
                if (i == (tblLnCat.Rows.Count - 1))
                { myfinalDT += "['" + tblLnCat[i].Categories.ToString() + "'," + tblLnCat[i].amount.ToString() + "]"; }
                else
                { myfinalDT += "['" + tblLnCat[i].Categories.ToString() + "'," + tblLnCat[i].amount.ToString() + "],"; }

            }
            myfinalDT += "]";
            this.data_lnCat.Value = myfinalDT;



            string myfinalDT1 = "";
            mainDS.Dashboard_Loan_CategoriesDataTable tblLnCat1 = lnCat.GetData(DateTime.Now.AddMonths(-1).ToShortDateString(), 0, 0);

            if (tblLnCat1.Rows.Count > 0)
            {
                for (int i = 0; i < tblLnCat1.Rows.Count; i++)
                {
                    if (i == 0)
                    {

                        myfinalDT1 = "[['Period','Amount in Category'],";
                    }
                    if (i == (tblLnCat1.Rows.Count - 1))
                    { myfinalDT1 += "['" + tblLnCat1[i].Categories.ToString() + "'," + tblLnCat1[i].amount.ToString() + "]"; }
                    else
                    { myfinalDT1 += "['" + tblLnCat1[i].Categories.ToString() + "'," + tblLnCat1[i].amount.ToString() + "],"; }

                }
                myfinalDT1 += "]";
                this.data_lnCat1.Value = myfinalDT1;
            }
            else
            {
                myfinalDT1 = "";
                this.data_lnCat1.Value = myfinalDT1;
            }
        }
        catch (Exception ex) { }
       
    }
    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
}

