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
using System.Globalization;

public partial class controls_invapplications_setValuedDate : System.Web.UI.UserControl
{
    bool editFlag = false;
    protected void Page_Load(object sender, EventArgs e)
    {

        paymentschedule();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try 
        {
            editFlag = true;
            CultureInfo ukCulture = new CultureInfo("en-GB");
            DateTime dt = DateTime.Parse(txtValue.Text, ukCulture);
            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter InvApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();
            InvApp.UpdateSetValueDate(dt, MySessionManager.InvAppID);


            paymentschedule();
        
        
        }
        catch (Exception ex) { }

    }
    //
    public void paymentschedule()
    {
        decimal amt = 0;
        decimal per = 0;
        DateTime dt = DateTime.Now;
        int term = 0, freq = 0, type = 0;
        try
        {

            InvestmentDSTableAdapters.GetInvestmentAppTableAdapter invApp = new InvestmentDSTableAdapters.GetInvestmentAppTableAdapter();

            InvestmentDS.GetInvestmentAppDataTable tblInvApp = invApp.GetInvestmentApp(MySessionManager.InvAppID);

            if (tblInvApp.Rows.Count > 0)
            {
                if (tblInvApp[0].IsdatInvestmentTypeNull() == false) { type = tblInvApp[0].datInvestmentType; }
                if (tblInvApp[0].IsdatInvestmentAmountNull() == false) { amt = tblInvApp[0].datInvestmentAmount; }
                if (tblInvApp[0].IsdatInterestRatePerAnnumNull() == false) {; per = tblInvApp[0].datInterestRatePerAnnum; }
                if (tblInvApp[0].IsdatTermsNull() == false) { term = tblInvApp[0].datTerms; }
                if (tblInvApp[0].IsdatFrequencyOfInterestPaymentNull() == false) { freq = Convert.ToInt32(tblInvApp[0].datFrequencyOfInterestPayment); }
                if (tblInvApp[0].IsdatValueDateNull() == false) { dt = tblInvApp[0].datValueDate; }                
                term = converrtterm(term);
                freq = convertfrequency(freq);
                CalculateIntPayment(term, freq, amt, per, dt);


            }

        }
        catch (Exception ex) { }

    }

    /// <summary>
    /// This converts the term into integer to be use in the function amount calculation and period
    /// </summary>
    /// <param name="frequency">The value of the frequency to be converted</param>
    /// <returns>int</returns>
    public int convertfrequency(int frequency)
    {
        int result = 0;
        if (frequency == 4)
        {
            result = 12;
        }
        if (frequency == 3)
        {
            result = 6;
        }
        if (frequency == 2)
        {
            result = 3;
        }
        if (frequency == 1)
        {
            result = 1;
        }
        return result;
    }


    /// <summary>
    /// This converts the term into integer to be use in the function amount calculation and period
    /// </summary>
    /// <param name="term">The value of the term to be converted</param>
    /// <returns>int</returns>
    public int converrtterm(int term)
    {
        int result = 0;
        if (term == 1)
        {
            result = 3;
        }
        if (term == 2)
        {
            result = 6;
        }
        if (term == 3)
        {
            result = 12;
        }
        return result;
    }

    /// <summary>
    /// This returns an array of the payment days.
    /// </summary>
    /// <param name="period">This is</param>
    /// <param name="type"></param>
    /// <returns>int array</returns>
    public int[] CalcPeriod(decimal period, int type)
    {
        int[] results = new int[1];
        //Default payment days for a 365 days term
        int[] monthly = new int[] { 30, 30, 31, 30, 30, 31, 30, 30, 31, 30, 31, 31 };
        int[] quarterly = new int[] { 91, 91, 91, 92 };
        int[] half = new int[] { 182, 183 };

        int days = Convert.ToInt32(type / period);

        if (period == 1)
        {
            results = new int[days];
            for (int i = 0; i < days; i++)
            { results[i] = monthly[i]; }
        }
        if (period == 3)
        {
            results = new int[days];
            for (int i = 0; i < days; i++)
            { results[i] = quarterly[i]; }
        }
        if (period == 6)
        {
            results = new int[days];
            for (int i = 0; i < days; i++)
            {
                results[i] = half[i];
            }
        }
        if (period == 12)
        {
            results = new int[days];
            for (int i = 0; i < days; i++)
            {
                results[i] = half[i];
            }
        }
        return results;
    }


    /// <summary>
    /// Function adds days to a certain date and returns the result.
    /// </summary>
    /// <param name="date">this is the date to add the days to</param>
    /// <param name="i">int numbers of days to add to date</param>
    /// <returns>DateTime</returns>
    public DateTime addDate(DateTime date, int i)
    {
        DateTime dt = date.AddDays(i);
        return dt;
    }

    /// <summary>
    /// This calculates the interest for every payment day
    /// </summary>
    /// <param name="frequency">The frequency of the  </param>
    /// <param name="term"></param>
    /// <param name="amt"></param>
    /// <param name="per"></param>
    /// <param name="valueDate"></param>
    /// <returns></returns>
    public string[,] amountcalculation(decimal frequency, int term, decimal amt, decimal per, DateTime valueDate)
    {
        string[,] results = new string[1, 0];
        //Gets the daily interest on the amount
        decimal DailyInt = (amt * (per / 100)) / 365;
        int[] period = CalcPeriod(frequency, term);

        DateTime date = addDate(valueDate, period[0]);

        results = new string[period.Length, 3];
        for (int i = 0; i < period.Length; i++)
        {

            results[i, 0] = date.ToShortDateString();
            results[i, 1] = period[i].ToString();
            results[i, 2] = (period[i] * DailyInt).ToString("c").Replace("$", "");
            if (i < period.Length)
            {
                date = addDate(date, period[i]);
            }
        }
        return results;
    }

    private void CalculateIntPayment(int terms, int freq, Decimal amt, decimal per, DateTime firstpaymentdate)
    {
        decimal totalAmt = 0;

        try
        {
            this.TABLE1.Rows.Clear();

            this.TABLE1.Rows.Add(new HtmlTableRow());
            HtmlTableRow row;



            DateTime firstdt = firstpaymentdate;

            string[,] data = amountcalculation(freq, terms, amt, per, firstdt);

            Label lblMonth1 = new Label();
            lblMonth1.Style["font-weight"] = "bold";
            lblMonth1.Text = firstdt.ToString("dd") + " " + firstdt.ToString("MMM") + " " + firstdt.ToString("yy");

            Label lbl;
            TextBox txt1;
            TextBox txt2;
            TextBox txt3;


            row = new HtmlTableRow();

            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());


            Label lbl1 = new Label();
            Label lbl2 = new Label();
            Label lbl3 = new Label();


            lbl1.Text = "Payment Date";
            lbl2.Text = "Days";
            lbl3.Text = "Interest";


            lbl1.Font.Bold = true;
            lbl2.Font.Bold = true;
            lbl3.Font.Bold = true;

            row.Cells[0].Controls.Add(lbl1);
            row.Cells[1].Controls.Add(lbl2);
            row.Cells[2].Controls.Add(lbl3);


            row.Cells[0].Align = "center";
            row.Cells[1].Align = "center";
            row.Cells[2].Align = "center";


            this.TABLE1.Rows.Add(row);



            for (int i = 0; i < data.GetLength(0); i++)
            {
                row = new HtmlTableRow();

                row.Cells.Add(new HtmlTableCell());
                row.Cells.Add(new HtmlTableCell());
                row.Cells.Add(new HtmlTableCell());

                txt1 = new TextBox();
                txt2 = new TextBox();
                txt3 = new TextBox();

                lbl = new Label();
                lbl.ID = "lblPaymentDates" + i.ToString();

                lbl.Text = Convert.ToDateTime(data[i, 0]).ToString("dd MMM yyyy");
                lbl.Style["font-weight"] = "bold";
                row.Cells[0].Controls.Add(lbl);

                txt1.ID = "txtDays" + i.ToString();
                txt1.CssClass = "BF" + i.ToString();
                txt1.Style["font-weight"] = "bold";
                txt1.Style["border"] = "none";
                txt1.Style.Add("text-align", "center");
                txt1.Style.Add("width", "100%");

                txt1.Text = data[i, 1].ToString();

                txt2.ID = "txtInterest" + i.ToString();
                txt2.CssClass = "_IR" + i.ToString();
                txt2.Style["font-weight"] = "bold";
                txt2.Style["border"] = "none";
                txt2.Style.Add("text-align", "right");
                txt2.Style.Add("width", "100%");
                txt2.Text = data[i, 2].ToString();
                totalAmt = totalAmt + Convert.ToDecimal(data[i, 2]);
                row.Cells[1].Controls.Add(txt1);
                row.Cells[2].Controls.Add(txt2);

                this.TABLE1.Rows.Add(row);

            }
            row = new HtmlTableRow();

            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());

            TextBox txtA = new TextBox();
            TextBox txtB = new TextBox();

            txtA.Text = "Total";
            txtA.ID = "txttotal";
            txtA.CssClass = "BF";
            txtA.Style["font-weight"] = "bold";
            txtA.Style["border"] = "none";
            txtA.Style.Add("text-align", "center");
            txtA.Style.Add("width", "100%");


            txtB.Text = totalAmt.ToString("C").Replace("$", "");

            txtB.ID = "txtTotalAmt";
            txtB.CssClass = "BF";
            txtB.Style["font-weight"] = "bold";
            txtB.Style["border"] = "none";
            txtB.Style.Add("text-align", "right");
            txtB.Style.Add("width", "100%");

            row.Cells[1].Controls.Add(txtA);
            row.Cells[2].Controls.Add(txtB);

            this.TABLE1.Rows.Add(row);

            if (editFlag == true)
            {
                //Record the values in the db
                InvestmentDSTableAdapters.GetInvScheduleTableAdapter InvSch = new InvestmentDSTableAdapters.GetInvScheduleTableAdapter();
                InvestmentDS.GetInvScheduleDataTable tblInvSch = InvSch.GetInvSchedule(MySessionManager.InvAppID);
                if (tblInvSch.Rows.Count > 0)
                {
                    InvSch.DeleteInvAccID(MySessionManager.InvAppID);
                }

                for (int i = 0; i < data.GetLength(0); i++)
                {
                    InvSch.InsertPaymentSch(MySessionManager.InvAppID,
                                            Convert.ToDateTime(data[i, 0]),
                                            Convert.ToInt32(data[i, 1]),
                                            Convert.ToDecimal(data[i, 2]),
                                            0,
                                            1
                                            );
                }

            }
        }
        catch (Exception ex) { }
    }
    
    
}
