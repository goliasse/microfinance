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

public partial class controls_dashboard_dbi_payments : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime startDate = Convert.ToDateTime(DateTime.Now.Month.ToString() + "/1/" + DateTime.Now.Year.ToString());
            DateTime endDate = Convert.ToDateTime(DateTime.Now.Month.ToString() + "/" + DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString() + "/" + DateTime.Now.Year.ToString());
            mainDSTableAdapters.Dashboard_Loan_AmountTableAdapter colAmt = new mainDSTableAdapters.Dashboard_Loan_AmountTableAdapter();
            mainDS.Dashboard_Loan_AmountDataTable tblColAmt = colAmt.GetData(startDate, endDate);
            mainDSTableAdapters.Dashboard_Expected_AmountTableAdapter expAmt = new mainDSTableAdapters.Dashboard_Expected_AmountTableAdapter();
            mainDS.Dashboard_Expected_AmountDataTable tblExpAmt = expAmt.GetData(startDate, endDate);
            //string[][] myTable = new string[5][3];
            //                                   {{"Week 1","0","0"},
            //                                   {"Week 2","0","0"},
            //                                   {"Week 3","0","0"},
            //                                   {"Week 4","0","0"},
            //                                   {"Week 5","0","0"}};

            string[][] myTable = new string[][]
        {
            new string[] {"Week 1","100", "500"},
            new string[] {"Week 2","1500", "1200"},
            new string[] {"week 3", "2500", "1100"},
            new string[] {"week 4", "1900", "2100"},
            new string[] {"week 5", "0", "0"}
        };

            if (tblColAmt.Rows.Count > 0)
            {

                for (int i = 0; i < tblColAmt.Rows.Count; i++)
                {
                    try
                    {
                        int index = tblColAmt[i].NoWeek;
                        myTable[index][2] = tblColAmt[i].AmtReceived.ToString();
                    }
                    catch (Exception ex) { }

                }
            }//if



            if (tblExpAmt.Rows.Count > 0)
            {

                for (int i = 0; i < tblExpAmt.Rows.Count; i++)
                {
                    try
                    {
                        int index = tblExpAmt[i].NoWeek;
                        myTable[index][1] = tblExpAmt[i].ExpectedAmt.ToString();
                    }
                    catch (Exception ex) { }

                }//for

            }//if

            string myfinalDT = "[['Period','Expected Amount','Amount Collected'],";

            for (int i = 0; i < 5; i++)
            {
                if (i == 4)
                { myfinalDT += "['" + myTable[i][0] + "'," + myTable[i][1] + "," + myTable[i][2] + "]"; }
                else
                { myfinalDT += "['" + myTable[i][0] + "'," + myTable[i][1] + "," + myTable[i][2] + "],"; }


            }//for

            myfinalDT += "]";

            this.data_lnpay.Value = myfinalDT;
        }
        catch (Exception ex) { }
        }
    }