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
//using System.Numeric;
using Microsoft.VisualBasic;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class controls_PaymentPlan : System.Web.UI.UserControl
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        Utility util = new Utility();

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(Convert.ToString(MySessionManager.AppID));
        if (tblLoanApp.Rows.Count > 0)
        {
            if (!(this.editskip.Value == "2"))
            {
                if (tblLoanApp[0].IsdatDurationNull()==false){ txtperiod.Text = tblLoanApp[0].datDuration.ToString(); }
                 if (tblLoanApp[0].IsdatInterestRateNull()==false){txtinterestrate.Text = tblLoanApp[0].datInterestRate.ToString();}
                 if (tblLoanApp[0].IsdatInterestRateTypeNull() == false) { txtinterestrateType.Text = util.displayValue("opt_interest_rate_types", tblLoanApp[0].datInterestRateType.ToString()); }
                 if (tblLoanApp[0].IsdatFirstPaymentDateNull() == false) { txtfirstpaymentdate.Text = tblLoanApp[0].datFirstPaymentDate.ToString("dd-MM-yyyy"); }
                txtFrequency.Text = util.displayValue("opt_frequencies", tblLoanApp[0].datFrequency.ToString());
                if (tblLoanApp[0].IsdatLoanAmountNull() == false) { txtprincipal.Text = tblLoanApp[0].datLoanAmount.ToString(); }
                this.editskip.Value = "2";
                int mnths = Convert.ToInt32(tblLoanApp[0].datDuration.ToString());
                double per = Convert.ToDouble(tblLoanApp[0].datInterestRate.ToString());
                double amt = Convert.ToDouble(tblLoanApp[0].datLoanAmount.ToString());
                try
                {
                    GenerateMonths(mnths, DateTime.Parse(txtfirstpaymentdate.Text));
                }
                catch (Exception ex) { }
                
            }
            else 
            {
                int mnths = Convert.ToInt32(txtperiod.Text);
                double per = Convert.ToDouble(txtinterestrate.Text);
                double amt = Convert.ToDouble(txtprincipal.Text);
                try
                {
                    GenerateMonths(mnths, DateTime.Parse(txtfirstpaymentdate.Text));
                }
                catch (Exception ex) { }
                
            }
        }
    }

    private void GenerateMonths(int months,DateTime firstpaymentdate)
    {
        this.TABLE1.Rows.Clear();

        this.TABLE1.Rows.Add(new HtmlTableRow());
        HtmlTableRow row;


        DateTime firstdt = firstpaymentdate;

        Label lblMonth1 = new Label();
        lblMonth1.Style["font-weight"] = "bold";
        lblMonth1.Text = firstdt.ToString("dd") +" "+ firstdt.ToString("MMM") +" "+ firstdt.ToString("yy");

        Label lbl;
        TextBox txt1;
        TextBox txt2;
        TextBox txt3;
        TextBox txt4;
        TextBox txt5;
        TextBox txt6;


        //AjaxControlToolkit.FilteredTextBoxExtender ftext1;
        //AjaxControlToolkit.FilteredTextBoxExtender ftext2;
        //AjaxControlToolkit.FilteredTextBoxExtender ftext3;
        //AjaxControlToolkit.FilteredTextBoxExtender ftext4;
        //AjaxControlToolkit.FilteredTextBoxExtender ftext5;


        row = new HtmlTableRow();

        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());
        row.Cells.Add(new HtmlTableCell());

        Label lbl1 = new Label();
        Label lbl2 = new Label();
        Label lbl3 = new Label();
        Label lbl4 = new Label();
        Label lbl5 = new Label();
        Label lbl6 = new Label();


        lbl1.Text = "Balance BF";
        lbl2.Text = "Interest";
        lbl3.Text = "Loan + Interest";
        lbl4.Text = "Monthly Payment";
        lbl5.Text = "Amt. Outstanding";
        lbl6.Text = "Principal Component";

        lbl1.Font.Bold = true;
        lbl2.Font.Bold = true;
        lbl3.Font.Bold = true;
        lbl4.Font.Bold = true;
        lbl5.Font.Bold = true;
        lbl6.Font.Bold = true;


        row.Cells[1].Controls.Add(lbl1);
        row.Cells[2].Controls.Add(lbl3);
        row.Cells[3].Controls.Add(lbl2);
        row.Cells[4].Controls.Add(lbl6);
        row.Cells[5].Controls.Add(lbl4);
        row.Cells[6].Controls.Add(lbl5);

        row.Cells[1].Align = "center";
        row.Cells[2].Align = "center";
        row.Cells[3].Align = "center";
        row.Cells[4].Align = "center";
        row.Cells[5].Align = "center";
        row.Cells[6].Align = "center";

        this.TABLE1.Rows.Add(row);



        for (int i = 1; i <= months; i++)
        {
            row = new HtmlTableRow();

            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());
            row.Cells.Add(new HtmlTableCell());


            txt1 = new TextBox();
            txt2 = new TextBox();
            txt3 = new TextBox();
            txt4 = new TextBox();
            txt5 = new TextBox();
            txt6 = new TextBox();

            //ftext1 = new AjaxControlToolkit.FilteredTextBoxExtender();
            //ftext2 = new AjaxControlToolkit.FilteredTextBoxExtender();
            //ftext3 = new AjaxControlToolkit.FilteredTextBoxExtender();
            //ftext4 = new AjaxControlToolkit.FilteredTextBoxExtender();
            //ftext5 = new AjaxControlToolkit.FilteredTextBoxExtender();




            //ftext1.ValidChars = "0123456789.,₵";
            //ftext2.ValidChars = "0123456789.,₵";
            //ftext3.ValidChars = "0123456789.,₵";
            //ftext4.ValidChars = "0123456789.,₵";
            //ftext5.ValidChars = "0123456789.,₵";


            lbl = new Label();
            lbl.ID = "lblMonth" + i.ToString();

            lbl.Text = firstdt.ToString("dd") + firstdt.AddMonths(i - 1).ToString("MMM") + firstdt.AddMonths(i - 1).ToString("yy");
            lbl.Style["font-weight"] = "bold";
            row.Cells[0].Controls.Add(lbl);


            txt1.Width = new Unit(80);
            txt1.ID = "txtMonth" + i.ToString() + "_BalanceBF";
            txt1.CssClass = "BF" + i.ToString();
            txt1.Style["font-weight"] = "bold";
            txt1.Style["border"] = "none";
            txt1.Style.Add("text-align", "right");
          

            txt2.Width = new Unit(80);
            txt2.ID = "txtMonth" + i.ToString() + "_IR";
            txt2.CssClass= "_IR" + i.ToString();
            txt2.Style["font-weight"] = "bold";
            txt2.Style["border"] = "none";
            txt2.Style.Add("text-align", "right");
            


            txt3.Width = new Unit(80);
            txt3.ID = "txtMonth" + i.ToString() + "_Monthly";
            txt3.Attributes.Add("class","monthly" + i.ToString()+"  myInputs");
            txt3.Attributes.Add("onblur", "recalculateplan()");
            txt3.Style["font-weight"] = "bold";
            txt3.Style.Add("text-align", "right");

            txt4.Width = new Unit(80);
            txt4.ID = "txtMonth" + i.ToString() + "_Outstanding";
            txt4.CssClass = "Outstanding" + i.ToString();
            txt4.Style["font-weight"] = "bold";
            txt4.Style["border"] = "none";
            txt4.Style.Add("text-align", "right");
           

            txt5.Width = new Unit(80);
            txt5.ID = "txtMonth" + i.ToString() + "_CalculatedIR";
            txt5.CssClass =  "CalculatedIR"+ i.ToString();
            txt5.Attributes.Add("readonly", "readonly");
            txt5.Style["font-weight"] = "bold";
            txt5.Style["border"] = "none";
            txt5.Style.Add("text-align", "right");

            txt6.Width = new Unit(80);
            txt6.ID = "txtMonth" + i.ToString() + "_PrincComp";
            txt6.CssClass = "_PrincComp" + i.ToString();
            txt6.Attributes.Add("readonly", "readonly");
            txt6.Style["font-weight"] = "bold";
            txt6.Style["border"] = "none";
            txt6.Style.Add("text-align", "right");


            //ftext1.TargetControlID = txt1.ID;
            //ftext2.TargetControlID = txt2.ID;

            //ftext3.TargetControlID = txt3.ID;
            //ftext4.TargetControlID = txt4.ID;
            //ftext5.TargetControlID = txt5.ID;

            row.Cells[1].Controls.Add(txt1);
            row.Cells[2].Controls.Add(txt5);
            row.Cells[3].Controls.Add(txt2);
            row.Cells[4].Controls.Add(txt6);
            row.Cells[5].Controls.Add(txt3);
            row.Cells[6].Controls.Add(txt4);


            //row.Cells[1].Controls.Add(ftext1);
            //row.Cells[2].Controls.Add(ftext2);
            //row.Cells[4].Controls.Add(ftext3);
            //row.Cells[5].Controls.Add(ftext4);
            //row.Cells[3].Controls.Add(ftext5);
            //row.Cells[6].Controls.Add(ftext6);


            this.TABLE1.Rows.Add(row);

        }

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        this.editskip.Value = "1";
    }
   
    public void AddPaymentPlan()
    {
        LoanDSTableAdapters.PaymentPlanTableAdapter plan = new LoanDSTableAdapters.PaymentPlanTableAdapter();

        LoanDS.PaymentPlanDataTable tbl = new LoanDS.PaymentPlanDataTable();

        LoanDS.PaymentPlanRow datarow;


        long AppID = MySessionManager.AppID;



        int i = 0;

        DeletePaymentPlan();

        foreach (HtmlTableRow row in this.TABLE1.Rows)
        {

            string labelstring = "lblMonth";

            string newlbl = labelstring + i.ToString();
            Control ctrl = null;


            if (i > 1)
            {
                if (row.Cells.Count > 0)
                    ctrl = row.Cells[1].Controls[0];
            }
            if (ctrl != null)
            {
                if (i > 1)
                {

                   datarow = tbl.NewPaymentPlanRow();



                    datarow.datApplicationID  = MySessionManager .AppID;
                    datarow.datMonth = Convert.ToDateTime(((Label)row.Cells[0].Controls[0]).Text);
                    datarow.datMonthIndex = Convert.ToInt32(i - 1);
                    datarow.datMonthlyPayment = Utility.ConvertToDecimal(((TextBox)row.Cells[5].Controls[0]).Text);
                    datarow.datOutstanding = Utility.ConvertToDecimal(((TextBox)row.Cells[6].Controls[0]).Text);
                    datarow.datInterest1 = Utility.ConvertToDecimal(((TextBox)row.Cells[3].Controls[0]).Text);
                    datarow.datBalanceBF = Utility.ConvertToDecimal(((TextBox)row.Cells[1].Controls[0]).Text);
                    datarow.datPrincipalComponent = Utility.ConvertToDecimal(((TextBox)row.Cells[5].Controls[0]).Text) - Utility.ConvertToDecimal(((TextBox)row.Cells[3].Controls[0]).Text);
                    tbl.Rows.Add(datarow);

                    plan.InsertPaymentPlan( Convert.ToDateTime(datarow.datMonth),
                                            Convert.ToDecimal(datarow.datBalanceBF),
                                            Convert.ToDecimal(datarow.datInterest1),
                                            Convert.ToDecimal(datarow.datMonthlyPayment),
                                            Convert.ToDecimal("0.0"),
                                            Convert.ToDecimal(datarow.datPrincipalComponent.ToString()),
                                            Convert.ToDecimal(datarow.datOutstanding.ToString()),
                                            MySessionManager.AppID,
                                            Convert.ToInt32(datarow.datMonthIndex.ToString()));


                }
            }

            i++;

            
        }



    }

    public void UpdatePaymentPlan(string AppID)
    {
        SqlCommand cmd = new SqlCommand();
        SqlCommand cmd2;
        SqlConnection conn = new SqlConnection(Utility.connectionString);
        byte cmtype = 3;

        cmd.CommandText = "delete tblBLPaymentPlan where accountid=" + AppID + "";
        cmd.Connection = conn;
        cmd.CommandType = CommandType.Text;
        SqlTransaction tran = null;


        try
        {

            conn.Open();

            tran = conn.BeginTransaction();
            cmd.Transaction = tran;



            cmd.ExecuteNonQuery();


            int i = 0;

            foreach (HtmlTableRow row in this.TABLE1.Rows)
            {

                string labelstring = "lblMonth";

                string newlbl = labelstring + i.ToString();
                Control ctrl = null;


                if (i > 1)
                {
                    if (row.Cells.Count > 0)
                        ctrl = row.Cells[1].Controls[0];
                }
                if (ctrl != null)
                {
                    if (i > 1)
                    {


                        #region obsolete

                        //datarow.AccountID = accountid;
                        //datarow.MonthName = ((Label)row.Cells[0].Controls[0]).Text;
                        //datarow.MonthIndex = Convert.ToByte(i - 1);
                        //datarow.Repayment = Utility.ConvertToDouble(((TextBox)row.Cells[4].Controls[0]).Text).ToString();
                        //datarow.AmountOutstanding = Utility.ConvertToDouble(((TextBox)row.Cells[5].Controls[0]).Text).ToString();
                        //datarow.Ir = Utility.ConvertToDecimal(((TextBox)row.Cells[2].Controls[0]).Text);
                        //datarow.BalanceBF = Utility.ConvertToDecimal(((TextBox)row.Cells[1].Controls[0]).Text);
                        //datarow.Loan_Interest = Utility.ConvertToDecimal(((TextBox)row.Cells[3].Controls[0]).Text);
                        //datarow.RType = cmtype; 
                        #endregion

                        LoanDSTableAdapters.PaymentPlanTableAdapter plan = new LoanDSTableAdapters.PaymentPlanTableAdapter();
                        plan.InsertPaymentPlan(Convert.ToDateTime(((Label)row.Cells[0].Controls[0]).Text),
                                               Convert.ToDecimal(Utility.ConvertToDecimal(((TextBox)row.Cells[1].Controls[0]).Text)),
                                               Utility.ConvertToDecimal(((TextBox)row.Cells[2].Controls[0]).Text),
                                               Utility.ConvertToDecimal(((TextBox)row.Cells[2].Controls[0]).Text),
                                               Convert.ToDecimal ("0"),
                                               Utility.ConvertToDecimal(((TextBox)row.Cells[3].Controls[0]).Text),
                                               Utility.ConvertToDecimal(((TextBox)row.Cells[5].Controls[0]).Text),
                                               MySessionManager.AppID,
                                               Convert.ToInt32(((Label)row.Cells[0].Controls[0]).Text)
                                               );








                    }
                }

                i++;
            }

        }
        catch (Exception ex)
        {
            tran.Rollback();
        }
        finally
        {
            conn.Close();
        }



    }


    private void DeletePaymentPlan()
    {
        try
        {
            LoanDSTableAdapters.PaymentPlanTableAdapter plan = new LoanDSTableAdapters.PaymentPlanTableAdapter();
            plan.Delete_PaymentPlan (MySessionManager.AppID);
        }
        catch 
        { }
    }


    //private void CalculateAPR()
    //{
    //    double ir = 0;
    //    double monthly;
    //    double outstanding = 0;

    //    for (int i = 1; i < this.TABLE1.Rows.Count; i++)
    //    {

    //        Control ctrl = null;
    //        HtmlTableRow row = this.TABLE1.Rows[i];

    //        if (i > 1)
    //        {
    //            if (row.Cells.Count > 0)
    //                ctrl = row.Cells[1].Controls[0];

    //        }

    //        if (ctrl != null)
    //        {


    //            ir += Utility.ConvertToDouble(((TextBox)row.Cells[2].Controls[0]).Text);
    //            outstanding += Utility.ConvertToDouble(((TextBox)row.Cells[5].Controls[0]).Text);
    //            //((TextBox)row.Cells[2].Controls[0]).Text = ir.ToString("C");
    //        }
    //    }

    //    int month = 0;

    //    if (Convert.ToBoolean(Session["PPGenerated"]))
    //    {
    //        month = Convert.ToInt32(Session["month_SL"]);
    //    }
    //    else
    //    {
    //        month = Convert.ToInt32(ViewState["month"]);
    //    }

    //    double percent = 0;

    //    if (Convert.ToBoolean(Session["PPGenerated"]))
    //    {
    //        percent = Convert.ToDouble(Session["percent_SL"]);
    //    }
    //    else
    //    {
    //        percent = Convert.ToDouble(ViewState["percent"]);
    //    }

    //    //double amountApproved = double.Parse(this.lblAmountApproved.Text, NumberStyles.Currency);
    //    double amount = 0;

    //    if (Convert.ToBoolean(Session["PPGenerated"]))
    //    {
    //        amount = Convert.ToDouble(Session["amount_SL"]);
    //    }
    //    else
    //    {
    //        amount = Convert.ToDouble(ViewState["amount"]);
    //    }

    //    outstanding = (outstanding) / month;

    //    //this.lblAverageOut.Text = outstanding.ToString("C");
    //    //this.lblTotalInterest.Text = ir.ToString("C");


    //    decimal commitmentFee = 0;
    //    decimal legalFee = 0;
    //    decimal processingFee = 0;
    //    decimal adminFee = 0;

    //    decimal totalCost = 0;

    //    ////commitmentFee = Utility.ConvertToDecimal(this.lblCommmitmentFee.Text);
    //    ////legalFee = Utility.ConvertToDecimal(this.lblLegalFee.Text);
    //    ////processingFee = Utility.ConvertToDecimal(this.lblProcessingFee.Text);
    //    ////adminFee = Utility.ConvertToDecimal(this.lblAdminFee.Text);

    //    //totalCost = commitmentFee + legalFee + processingFee + adminFee + Convert.ToDecimal(ir);

    //    //totalCost = LoanFeeViewCtrl1.GetAprFee() + Convert.ToDecimal(ir);

    //    //totalCost = LoanFeesCtrl1.GetAprFee() + Convert.ToDecimal(ir);


    //    //this.lblTotalCost.Text = totalCost.ToString("C");


    //    decimal apr = 0;

    //    decimal temp = decimal.Divide(month, 12) * Convert.ToDecimal(outstanding);


    //    if (totalCost > 0 && temp > 0)
    //    {
    //        apr = decimal.Divide(totalCost, temp) * 100;
    //        //(totalCost / temp) * 100;
    //    }

    //    //this.lblAPR.Text = apr.ToString("f") + "%";




    //}


    protected void btnEditPlanValues_Click1(object sender, EventArgs e)
    {
   
    }
   
    protected void btnSavePlan_Click(object sender, EventArgs e)
    {
        AddPaymentPlan();
        this.editskip.Value  = "3";

    }
    public double[,] loadpplanValues(int AppID)
    {
        

        LoanDSTableAdapters.PaymentPlanTableAdapter pplan = new LoanDSTableAdapters.PaymentPlanTableAdapter();
        LoanDS.PaymentPlanDataTable tblpplan = pplan.GetPaymentPlan(AppID);

        double[,] pplanValue  = new double[tblpplan.Rows.Count, 5];
        try
        {
            if (tblpplan.Rows.Count > 0)
            {
                for (int i = 0; i < tblpplan.Rows.Count; i++)
                {

                    pplanValue[i,0] =  Convert.ToDouble(tblpplan[i].datBalanceBF.ToString());
                    pplanValue[i, 1] = Convert.ToDouble(tblpplan[i].datInterest1.ToString());
                    pplanValue[i, 2] = Convert.ToDouble(tblpplan[i].datPrincipalComponent.ToString());
                    pplanValue[i, 3] = Convert.ToDouble(tblpplan[i].datMonthlyPayment.ToString());
                    pplanValue[i, 4] = Convert.ToDouble(tblpplan[i].datOutstanding.ToString());
                               
                }



            }
            else 
            { 
              
            
            
            }
        }
        catch(Exception ex)
        {}


        return pplanValue;
    
    }
}


