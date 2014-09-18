using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Runtime.InteropServices;

/// <summary>
/// Summary description for Utility
/// </summary>
public class Utility
{
	public Utility()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static readonly string connectionString = ConfigurationManager.ConnectionStrings["sa365ConnectionString1"].ToString();

    public static string exelUploadFiles = "UploadedFiles/";

    //public static readonly string connectionString3 = ConfigurationManager.ConnectionStrings["TrueSoftDBConnectionString3"].ToString();
    //public static readonly string connectionString4 = ConfigurationManager.ConnectionStrings["TrueSoftDBConnectionString4"].ToString();
    public static string CheckDllValue(CheckBox chk)
    {
        if (chk.Checked)
            return "Yes";
        else
            return "No";
    
    }

    public static bool GetDllValue(string  value)
    {
        if(value == "Yes")
            return true;
        else
            return false;

    }


    //public static readonly string access_connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\\My Projects\\unisoft 2003.mdb;User Id=admin;Password=;";


    //public static void GetClientDetail_Access()
    //{
    //    SqlConnection conn = new SqlConnection(Utility.access_connectionString);
    //    SqlCommand cmd = new SqlCommand();
    //    cmd.Connection = conn;
    //    cmd.CommandText = "select * from client";
    //    cmd.CommandType = CommandType.Text;

    //    SqlDataReader r;
    //    conn.Open();

    //    r = cmd.ExecuteReader();

    //    if (r.HasRows)
    //    {
    //        if (r.Read())
    //        {

    //        }
    //        r.Close();
    //        conn.Close();
    //    }



    //}


    public static int ExecuteMyQuery(string query, CommandType ct)
    {

        SqlConnection conn = new SqlConnection(Utility.connectionString);
        SqlCommand cmd = new SqlCommand();
        int r =0;
        cmd.Connection = conn;
        cmd.CommandText = query;
        cmd.CommandType = ct;

        try
        {
            conn.Open();
            r = cmd.ExecuteNonQuery();
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally {
            conn.Close();
        }

        return r;


    }

    public static string GetScoreSheetScore(long accid)
    {
        
        DataTable tbl = new DataTable();
        Utility.ManageScoreSheet(tbl);

        

        SqlConnection conn = new SqlConnection(Utility.connectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;
        cmd.CommandText = "GetScoreSheet";
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader r;

        //MySessionManager.AccountID = 27;

        byte rtype2 = 0;

        if (MySessionManager.CMType == 3)
            rtype2 = 2;
        else
            rtype2 = MySessionManager.CMType;

        cmd.Parameters.Add(new SqlParameter("@AccountID", accid));
        cmd.Parameters.Add(new SqlParameter("@rtype", 3));
        cmd.Parameters.Add(new SqlParameter("@rtype2", 3));


        string ClientType = String.Empty;
        string BusinessType = String.Empty;
        string YearsInBusiness = String.Empty;
        string EmpMang = String.Empty;
        string EmpSkilled = String.Empty;
        string EmpUnSkilled = String.Empty;
        string FinancialStatement = String.Empty;
        string ResidenceOwnershipType = String.Empty;
        string PropertyType = String.Empty;
        string ValueOFVehicle = String.Empty;
        string OtherCollateral = String.Empty;
        string CollateralCover = String.Empty;
        string BankAccount = String.Empty;
        string PastRecordWithUT = String.Empty;
        string OtherIncome = String.Empty;
        string ICR = String.Empty;
        string DSR = String.Empty;







        conn.Open();

        r = cmd.ExecuteReader();

        if (r.HasRows)
        {
            if (r.Read())
            {
                //pastRecord = r[0].ToString();
                //ValueOFResidence = r[2].ToString();
                //ValueOFOffice = r[1].ToString();
                //ValueOFVehicle = r[3].ToString();
                //ClientType = r[4].ToString();
                //BusinessType = r[5].ToString();
                //YearsInBusiness = r[6].ToString();
                //EmpMang = r[7].ToString();
                //EmpSkilled = r[8].ToString();
                //EmpUnSkilled = r[9].ToString();
                //FinancialStatement = r[10].ToString();
                //BankAccount = r[11].ToString();
                //OtherIncome = r[12].ToString();
                //PastRecordWithUT = r[13].ToString();


                ClientType = r[0].ToString();
                BusinessType = r[1].ToString();
                YearsInBusiness = r[2].ToString();
                EmpMang = r[3].ToString();
                EmpSkilled = r[4].ToString();
                EmpUnSkilled = r[5].ToString();
                FinancialStatement = r[6].ToString();
                ResidenceOwnershipType = r[7].ToString();
                PropertyType = r[8].ToString();
                ValueOFVehicle = r[9].ToString();
                OtherCollateral = r[10].ToString();
                CollateralCover = r[11].ToString();
                BankAccount = r[12].ToString();
                PastRecordWithUT = r[13].ToString();
                OtherIncome = r[14].ToString();
                ICR = r[15].ToString();
                DSR = r[16].ToString();




            }



            r.Close();
            conn.Close();



            ScoreSheetSelection_Score obj;


            obj = GetSelection_Points(1, ClientType);
            tbl.Rows[0][3] = obj.selection;
            tbl.Rows[0][4] = obj.score;

            obj = GetSelection_Points(2, BusinessType);
            tbl.Rows[1][3] = obj.selection;
            tbl.Rows[1][4] = obj.score;

            obj = GetSelection_Points(3, YearsInBusiness);
            tbl.Rows[2][3] = obj.selection;
            tbl.Rows[2][4] = obj.score;


            obj = GetSelection_Points(4, EmpMang);
            tbl.Rows[4][3] = obj.selection;
            tbl.Rows[4][4] = obj.score;


            obj = GetSelection_Points(5, EmpSkilled);
            tbl.Rows[5][3] = obj.selection;
            tbl.Rows[5][4] = obj.score;


            obj = GetSelection_Points(6, EmpUnSkilled);
            tbl.Rows[6][3] = obj.selection;
            tbl.Rows[6][4] = obj.score;


            obj = GetSelection_Points(7, FinancialStatement);
            tbl.Rows[7][3] = obj.selection;
            tbl.Rows[7][4] = obj.score;


            obj = GetSelection_Points(8, ResidenceOwnershipType);
            tbl.Rows[8][3] = obj.selection;
            tbl.Rows[8][4] = obj.score;

            obj = GetSelection_Points(9, PropertyType);
            tbl.Rows[9][3] = obj.selection;
            tbl.Rows[9][4] = obj.score;

            obj = GetSelection_Points(10, ValueOFVehicle);
            tbl.Rows[10][3] = obj.selection;
            tbl.Rows[10][4] = obj.score;


            obj = GetSelection_Points(11, OtherCollateral);
            tbl.Rows[11][3] = obj.selection;
            tbl.Rows[11][4] = obj.score;

            obj = GetSelection_Points(12, CollateralCover);
            tbl.Rows[12][3] = obj.selection;
            tbl.Rows[12][4] = obj.score;

            obj = GetSelection_Points(13, BankAccount);
            tbl.Rows[13][3] = obj.selection;
            tbl.Rows[13][4] = obj.score;

            obj = GetSelection_Points(14, PastRecordWithUT);
            tbl.Rows[14][3] = obj.selection;
            tbl.Rows[14][4] = obj.score;

            obj = GetSelection_Points(15, OtherIncome);
            tbl.Rows[15][3] = obj.selection;
            tbl.Rows[15][4] = obj.score;

            obj = GetSelection_Points(16, ICR);
            tbl.Rows[16][3] = obj.selection;
            tbl.Rows[16][4] = obj.score;

            obj = GetSelection_Points(17, DSR);
            tbl.Rows[17][3] = obj.selection;
            tbl.Rows[17][4] = obj.score;


            //this.gvScoresheet.DataSource = tbl;
            //this.gvScoresheet.DataBind();

            int totscore = 0;
            string score = "";
            foreach (DataRow row in tbl.Rows)
            {
                //row.Cells[4].Text
                score = row[4].ToString();
                if (score != "")
                    totscore += int.Parse(score);
            }

            //Label lbl = (Label)this.gvScoresheet.FooterRow.FindControl("lblTotalScore");
            //lbl.Text = totscore.ToString();

            decimal per = (totscore * 100) / 168;


            return per.ToString() + "%";
            //this.lblPercentage.Text = "dasd";




        }
        else
        {
            r.Close();
            conn.Close();

            return "";
        }
    }

    public static string GetRowColor(int rtype)
    {
        string color = string.Empty;

        if (rtype == 1)
            color = "#ffcc33";
        else if (rtype == 2)
            color = "#99ff00";
        else if (rtype == 3)
            color = "#00ccff";

        return color;

    }
    
    public static double ConvertToDouble(string val)
    {
        double rtn;

        double.TryParse(val, System.Globalization.NumberStyles.Currency, null, out rtn);

        return rtn;
    
    }

    public static decimal ConvertToDecimal(string val)
    {
        decimal rtn;

        decimal.TryParse(val, System.Globalization.NumberStyles.Currency, null, out rtn);

        return rtn;

    }

    public static string GetVoucherNo()
    {
        System.Text.StringBuilder str = new System.Text.StringBuilder();
        //str.Append("UTC");

        bool strCount = true;

        while (strCount)
        {

            str.Append(DateTime.Now.Hour.ToString("0#"));
            str.Append(DateTime.Now.ToString("yy"));
            str.Append(DateTime.Now.Minute.ToString("0#"));
            str.Append(DateTime.Now.Day.ToString("0#"));
            str.Append(DateTime.Now.Month.ToString("0#"));
            str.Append(DateTime.Now.Second.ToString("0#"));
            //str.Append(DateTime.Now.Millisecond.ToString("0#"));


            if (str.ToString().Length == 12)
            {
                strCount = false;
                break;
            }
            else
            {
                str.Remove(0, str.Length);
            }

        }
        //Return "UTC" & Date.Now.Hour & Date.Now.Year & Date.Now.Minute & Date.Now.Day & Date.Now.Month & Date.Now.Second

        return "PV" + str.ToString();

    }

    public static void ShowMessageBox(string message, System.Web.UI.Page page)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        page.RegisterStartupScript("MessageBox", sJavaScript);
    }

    public static string GetUrlByRole(string role)
    {
       

        if (role == "Front Desk")
            return "~/dashboard/";
        else if (role == "Project Officer")
            return "~/dashboard.aspx";
        else if (role == "Branch Manager")
            return "~/dashboard/";
        else if (role == "Credit Manager")
            return "~/dashboard/";
        else if (role == "Investment Officer")
            return "~/dashboard/";
        else if (role == "Head Of Investments")
            return "~/dashboard/";
        else if (role == "Finance Officer")
            return "~/dashboard/";
        else if (role == "Cashier")
            return "~/dashboard/";
        else if (role == "Head Office Cashier")
            return "~/dashboard/";
        else if (role == "Finance Manager")
            return "~/dashboard/";
        else if (role == "Financial Controller")
            return "~/dashboard/";
        else if (role == "Investment Manager")
            return "~/dashboard/";
        else if (role == "Central Credit Team")
            return "~/dashboard/";
        else if (role == "Finacle Team")
            return "~/dashboard/";
        else if (role == "CEO")
        {
            MySessionManager.CurrentUser.BranchID = 0;
            return "~/dashboard/";
        }
        else if (role == "COO" || role == "Area Manager" || role == "General Manager" || role == "RISK")
        {
            //MySessionManager.CurrentUser.BranchID = 0;
            return "~/dashboard/";
        }
        else
            return String.Empty;
    }

    //public static void SetReadOnlyTextBoxValue(ControlCollection ctrls, System.Web.HttpRequest request)
    //{
    //    if (ctrls != null)
    //    {
    //        foreach (Control ctrl in ctrls)
    //        {
    //            if (ctrl.HasControls())
    //            {
    //                SetReadOnlyTextBoxValue(ctrl.Controls, request);
    //            }
    //            TextBox txt = ctrl as TextBox;
    //            if (txt != null && txt.ReadOnly && request.Form[txt.ID] != null)
    //            {
    //                txt.Text = request.Form[txt.ID];
    //            }
    //        }
    //    }
    //}

    public static string GetAccountNumber(string code)
    {
        
        
        System.Text.StringBuilder str = new System.Text.StringBuilder();


        bool strCount = true;

        while (strCount)
        {


            str.Append(code);
            str.Append("--");
            str.Append(DateTime.Now.Hour.ToString("0#"));
            str.Append(DateTime.Now.ToString("yy"));
            str.Append(DateTime.Now.Minute.ToString("0#"));
            str.Append(DateTime.Now.Day.ToString("0#"));
            str.Append(DateTime.Now.Month.ToString("0#"));
            str.Append(DateTime.Now.Second.ToString("0#"));
            

            if (str.ToString().Length == 15)
            {
                strCount = false;
                break;
            }
            else
            {
                str.Remove(0, str.Length);
            }

        }
        
        
        
        
        
        

        return str.ToString();

    }

    public static string GetInvestmentRedirectUrl()
    {
        if (MySessionManager.AccountTypeID == 10)
            return "~\\CommonPages\\ViewIndividualInvestmentInformation.aspx";
        else if (MySessionManager.AccountTypeID == 11)
            return "~\\CommonPages\\ViewJointInvestmentInformation.aspx";
        else if (MySessionManager.AccountTypeID == 12)
            return "~\\CommonPages\\ViewInstitutionalInvestmentInformation.aspx";
        else if (MySessionManager.AccountTypeID == 13)
            return "~\\CommonPages\\ViewInTrustInvestmentInformation.aspx";
        else
            return "";
    }


    public static string GetNextMonth(string month)
    {
        string rmonth = string.Empty;

        string year = string.Empty;
        string m = string.Empty;
        
        try
        {
             year = month.Substring(3);
             m = month.Substring(0, 3);

            if (m == "Jan")
                rmonth = "Feb";
            else if (m == "Feb")
                rmonth = "Mar";
            else if (m == "Mar")
                rmonth = "Apr";
            else if (m == "Apr")
                rmonth = "May";
            else if (m == "May")
                rmonth = "Jun";
            else if (m == "Jun")
                rmonth = "Jul";
            else if (m == "Jul")
                rmonth = "Aug";
            else if (m == "Aug")
                rmonth = "Sep";
            else if (m == "Sep")
                rmonth = "Oct";
            else if (m == "Oct")
                rmonth = "Nov";
            else if (m == "Nov")
                rmonth = "Dec";
            else if (m == "Dec")
            {
                rmonth = "Jan";

                if (year == "06")
                    year = "07";
                 else if (year == "07")
                    year = "08";
                else if (year == "08")
                    year = "09";
                else if (year == "09")
                    year = "10";
                else if (year == "10")
                    year = "11";
                else if (year == "11")
                    year = "12";
            }
        }
        catch (Exception e)
        {
            throw e;
        }


        return rmonth + year;


    }
    #region HiddenCodes

    //private static  ScoreSheetSelection_Score GetSelection_Points(int type, string value)
    //{

    //    ScoreSheetSelection_Score obj = new ScoreSheetSelection_Score();

    //    if (type == 1)
    //    {
    //        //if (value != "")
    //        //{
    //        //    if (int.Parse(value) == 0)
    //        //    {
    //        //        obj.selection = "No Track Record";
    //        //        obj.score = "0";
    //        //    }
    //        //    else if (int.Parse(value) == 1 || int.Parse(value) == 2)
    //        //    {
    //        //        obj.selection = "1 or 2 Previous Good loan";
    //        //        obj.score = "7";
    //        //    }
    //        //    else if (int.Parse(value) >= 3)
    //        //    {
    //        //        obj.selection = "3 or More Previous Good loan";
    //        //        obj.score = "10";
    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    obj.selection ="";
    //        //    obj.score = "";
    //        //}
    //    }
    //    else if (type == 2)
    //    {
    //        if (value != "")
    //        {

    //            string[] str = value.Split('|');

    //            decimal price = decimal.Parse(str[0]);
    //            int otype = int.Parse(str[1]);


    //            //decimal val = Convert.ToDecimal(value);

    //            if (otype == 1)
    //            {

    //                if (price >= 50000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "10";
    //                }
    //                else if (price >= 20000 || price < 50000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "7";
    //                }
    //                else if (price < 20000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "5";
    //                }
    //            }
    //            else if (otype == 2)
    //            {
    //                if (price >= 50000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "5";
    //                }
    //                else if (price >= 20000 || price < 50000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "3";
    //                }
    //                else if (price < 20000)
    //                {
    //                    obj.selection = price.ToString("C");
    //                    obj.score = "1";
    //                }
    //            }

    //        }
    //    }
    //    else if (type == 3)
    //    {
    //        if (value != "")
    //        {

    //            string[] str = value.Split('|');

    //            decimal price = decimal.Parse(str[0]);
    //            string rooms = str[1];


    //            //decimal val = Convert.ToDecimal(value);

    //            if (rooms == "5 Room Office")
    //            {

    //                obj.selection = "5 Room Office";//price.ToString("C");
    //                obj.score = "10";

    //            }
    //            else if (rooms == "3 - 5 Room Office")
    //            {

    //                obj.selection = "3 - 5 Room Office";//price.ToString("C");
    //                obj.score = "7";

    //            }
    //            else if (rooms == "1 - 3 Room Office")
    //            {

    //                obj.selection = "1 - 3 Room Office";//price.ToString("C");
    //                obj.score = "4";

    //            }
    //            else if (rooms == "No Office")
    //            {

    //                obj.selection = "No Office";//price.ToString("C");
    //                obj.score = "0";

    //            }

    //        }
    //    }
    //    else if (type == 4)
    //    {
    //        if (value != "")
    //        {
    //            decimal val = Convert.ToDecimal(value);

    //            if (val >= 15000)
    //            {
    //                obj.selection = val.ToString("C");
    //                obj.score = "10";
    //            }
    //            else if (val >= 8000 || val < 15000)
    //            {
    //                obj.selection = val.ToString("C");
    //                obj.score = "8";
    //            }
    //            else if (val >= 4000 || val < 8000)
    //            {
    //                obj.selection = val.ToString("C");
    //                obj.score = "6";
    //            }
    //            else if (val >= 2000 || val < 4000)
    //            {
    //                obj.selection = val.ToString("C");
    //                obj.score = "4";
    //            }
    //            else if (val < 2000)
    //            {
    //                obj.selection = val.ToString("C");
    //                obj.score = "2";
    //            }



    //        }
    //        else
    //        {
    //            obj.selection = "No Car";
    //            obj.score = "0";
    //        }
    //    }
    //    else if (type == 5)
    //    {
    //        if (value == "Limited Liability")
    //        {
    //            obj.selection = "Limited Liability";
    //            obj.score = "10";
    //        }
    //        else if (value == "Partnership")
    //        {
    //            obj.selection = "Partnership";
    //            obj.score = "5";
    //        }
    //        else if (value == "Sole Proprietor")
    //        {
    //            obj.selection = "Sole Proprietor";
    //            obj.score = "3";
    //        }
    //        else if (value == "Individual")
    //        {
    //            obj.selection = "Individual";
    //            obj.score = "3";
    //        }
    //    }
    //    else if (type == 6)
    //    {
    //        if (value == "Supplier With Good LPO")
    //        {
    //            obj.selection = "Supplier With Good LPO";
    //            obj.score = "10";
    //        }
    //        else if (value == "Importer With Goods At Port")
    //        {
    //            obj.selection = "Importer With Goods At Port";
    //            obj.score = "10";
    //        }
    //        else if (value == "Specific Merchant With Shop")
    //        {
    //            obj.selection = "Specific Merchant With Shop";
    //            obj.score = "7";
    //        }
    //        else if (value == "General Trader/Merchant With Shop")
    //        {
    //            obj.selection = "General Trader/Merchant With Shop";
    //            obj.score = "5";
    //        }

    //    }
    //    else if (type == 7)
    //    {
    //        if (value == "Less Than 2 Years")
    //        {
    //            obj.selection = "Less Than 2 Years";
    //            obj.score = "4";
    //        }
    //        else if (value == "2 Years - 5 Years")
    //        {
    //            obj.selection = "2 Years - 5 Years";
    //            obj.score = "6";
    //        }
    //        else if (value == "5 Years - 10 Years")
    //        {
    //            obj.selection = "5 Years - 10 Years";
    //            obj.score = "8";
    //        }
    //        else if (value == "10 Years+")
    //        {
    //            obj.selection = "10 Years+";
    //            obj.score = "10";
    //        }
    //    }
    //    else if (type == 8)
    //    {
    //        obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
    //        obj.score = "0";
    //    }
    //    else if (type == 9)
    //    {
    //        obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
    //        obj.score = "0";
    //    }
    //    else if (type == 10)
    //    {
    //        obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
    //        obj.score = "0";
    //    }
    //    else if (type == 11)
    //    {
    //        if (value != "" || value != null)
    //        {
    //            if (value == "5+ Years Audited Accounts Availble")
    //            {
    //                obj.selection = "5+ Years Audited Accounts Availble";
    //                obj.score = "10";
    //            }
    //            else if (value == "3+ Years Audited Accounts Availble")
    //            {
    //                obj.selection = "3+ Years Audited Accounts Availble";
    //                obj.score = "9";
    //            }
    //            else if (value == "UnAudited Accounts Availble")
    //            {
    //                obj.selection = "UnAudited Accounts Availble";
    //                obj.score = "5";
    //            }
    //            else if (value == "Book keeping records")
    //            {
    //                obj.selection = "Book keeping records";
    //                obj.score = "5";
    //            }
    //            else if (value == "No Accounts Availble")
    //            {
    //                obj.selection = "No Accounts Availble";
    //                obj.score = "0";
    //            }
    //        }
    //        else
    //        {
    //            obj.selection = "Null";
    //            obj.score = "0";
    //        }
    //    }
    //    else if (type == 12)
    //    {
    //        if (value != string.Empty)
    //        {

    //            //                <asp:ListItem>Active Bank Account</asp:ListItem>
    //            //<asp:ListItem>Dormant Bank Account</asp:ListItem>
    //            //<asp:ListItem>No Bank Account</asp:ListItem>

    //            if (value == "Active Bank Account")
    //            {
    //                obj.selection = value;
    //                obj.score = "10";
    //            }
    //            else if (value == "Dormant Bank Account")
    //            {
    //                obj.selection = value;
    //                obj.score = "3";
    //            }
    //            else if (value == "No Bank Account")
    //            {
    //                obj.selection = value;
    //                obj.score = "0";
    //            }


    //        }
    //    }
    //    else if (type == 13)
    //    {
    //        //if (int.Parse(value) == 0)
    //        //{
    //        //    obj.selection = "Other source of income (" + value + ")";
    //        //    obj.score = "0";
    //        //}
    //        //else if (int.Parse(value) == 1)
    //        //{
    //        //    obj.selection = "Other source of income (" + value + ")";
    //        //    obj.score = "5";
    //        //}
    //        //else if (int.Parse(value) == 2)
    //        //{
    //        //    obj.selection = "Other source of income (" + value + ")";
    //        //    obj.score = "7";
    //        //}
    //        //else if (int.Parse(value) >= 3)
    //        //{
    //        //    obj.selection = "Other source of income (" + value + ")";
    //        //    obj.score = "10";
    //        //}


    //        if (value != string.Empty)
    //        {

    //            //                <asp:ListItem>No Alternate Source</asp:ListItem>
    //            //<asp:ListItem>1 Source</asp:ListItem>
    //            //<asp:ListItem>2 Sources</asp:ListItem>
    //            //<asp:ListItem>3 Sources</asp:ListItem>


    //            if (value == "No Alternate Source")
    //            {
    //                obj.selection = value;
    //                obj.score = "0";
    //            }
    //            else if (value == "1 Source")
    //            {
    //                obj.selection = value;
    //                obj.score = "7";
    //            }
    //            else if (value == "2 Sources")
    //            {
    //                obj.selection = value;
    //                obj.score = "5";
    //            }
    //            else if (value == "3 Sources")
    //            {
    //                obj.selection = value;
    //                obj.score = "10";
    //            }

    //        }
    //        else
    //            obj.score = "0";




    //    }
    //    else if (type == 14)
    //    {
    //        if (value != string.Empty)
    //        {

    //            if (value == "No Track Record With UT")
    //            {
    //                obj.selection = value;
    //                obj.score = "0";
    //            }
    //            else if (value == "Good Reference with Good Old Client(s)")
    //            {
    //                obj.selection = value;
    //                obj.score = "5";
    //            }
    //            else if (value == "1 or 2 Previous Good Loans")
    //            {
    //                obj.selection = value;
    //                obj.score = "7";
    //            }
    //            else if (value == "3 Previous Good Loans")
    //            {
    //                obj.selection = value;
    //                obj.score = "10";
    //            }


    //        }
    //    }


    //    return obj;


    //}

    private static ScoreSheetSelection_Score GetSelection_Points(int type, string value)
    {

        ScoreSheetSelection_Score obj = new ScoreSheetSelection_Score();

        if (type == 1)
        {
            //if (value != "")
            //{
            //    if (int.Parse(value) == 0)
            //    {
            //        obj.selection = "No Track Record";
            //        obj.score = "0";
            //    }
            //    else if (int.Parse(value) == 1 || int.Parse(value) == 2)
            //    {
            //        obj.selection = "1 or 2 Previous Good loan";
            //        obj.score = "7";
            //    }
            //    else if (int.Parse(value) >= 3)
            //    {
            //        obj.selection = "3 or More Previous Good loan";
            //        obj.score = "10";
            //    }
            //}
            //else
            //{
            //    obj.selection = "";
            //    obj.score = "";
            //}

            if (value == "Limited Liability")
            {
                obj.selection = "Limited Liability";
                obj.score = "10";
            }
            else if (value == "Partnership")
            {
                obj.selection = "Partnership";
                obj.score = "5";
            }
            else if (value == "Sole Proprietor")
            {
                obj.selection = "Sole Proprietor";
                obj.score = "3";
            }
            else if (value == "Individual")
            {
                obj.selection = "Individual";
                obj.score = "3";
            }


        }
        else if (type == 2)
        {
            if (value != "")
            {

                if (value == "AGRICULTURE, FORESTRY & FISHERIES")
                {
                    obj.selection = value;
                    obj.score = "1";

                }
                else if (value == "CIVIL WORKS")
                {
                    obj.selection = value;
                    obj.score = "5";
                }
                else if (value == "TRANSPORT & HEAVY EQUIPMENT")
                {
                    obj.selection = value;
                    obj.score = "4";
                }
                else if (value == "IMPORT/EXPORT/WAREHOUSING")
                {
                    obj.selection = value;
                    obj.score = "6";
                }
                else if (value == "COMMERCE & FINANCING")
                {
                    obj.selection = value;
                    obj.score = "8";
                }
                else if (value == "TOURISM / ENTERTAINMENT")
                {
                    obj.selection = value;
                    obj.score = "6";
                }
                else if (value == "MANUFACTURING & PRODUCTION")
                {
                    obj.selection = value;
                    obj.score = "4";
                }
                else if (value == "EDUCATION & RESEARCH")
                {
                    obj.selection = value;
                    obj.score = "5";
                }
                else if (value == "MARKETING & ADVERTISING")
                {
                    obj.selection = value;
                    obj.score = "4";
                }
                else if (value == "INFORMATION, TELECOMMUNICATION & TECHNOLOGY (ICT)")
                {
                    obj.selection = value;
                    obj.score = "3";
                }
                else if (value == "HEALTH")
                {
                    obj.selection = value;
                    obj.score = "6";
                }

            }
            else
            {
                obj.selection = "None";
                obj.score = "0";
            }
        }
        else if (type == 3)
        {
            if (value != "")
            {

                if (value == "Less Than 2 Years")
                {
                    obj.selection = "Less Than 2 Years";
                    obj.score = "4";
                }
                else if (value == "2 Years - 5 Years")
                {
                    obj.selection = "2 Years - 5 Years";
                    obj.score = "6";
                }
                else if (value == "5 Years - 10 Years")
                {
                    obj.selection = "5 Years - 10 Years";
                    obj.score = "8";
                }
                else if (value == "10 Years+")
                {
                    obj.selection = "10 Years+";
                    obj.score = "10";
                }

            }
            else
            {
                obj.selection = "None";
                obj.score = "0";
            }




        }
        else if (type == 4) //Management
        {

            if (value != string.Empty)
            {


                if (Utility.ConvertToDecimal(value) >= 6)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "10";

                }
                else if (Utility.ConvertToDecimal(value) < 5 || Utility.ConvertToDecimal(value) > 3)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "8";

                }

                else if (Utility.ConvertToDecimal(value) < 2 || Utility.ConvertToDecimal(value) > 1)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "4";

                }
                else
                {
                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }


        }
        else if (type == 5) //Skilled
        {
            if (value != string.Empty)
            {

                if (Utility.ConvertToDecimal(value) >= 6)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "10";

                }
                else if (Utility.ConvertToDecimal(value) < 5 || Utility.ConvertToDecimal(value) > 3)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "8";

                }

                else if (Utility.ConvertToDecimal(value) < 2 || Utility.ConvertToDecimal(value) > 1)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "4";

                }
                else
                {
                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }
        else if (type == 6) //Unskilled
        {

            if (value != string.Empty)
            {
                if (Utility.ConvertToDecimal(value) >= 11)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "10";

                }
                else if (Utility.ConvertToDecimal(value) < 10 || Utility.ConvertToDecimal(value) > 6)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "6";

                }
                else if (Utility.ConvertToDecimal(value) < 5 || Utility.ConvertToDecimal(value) > 3)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "4";

                }

                else if (Utility.ConvertToDecimal(value) < 2 || Utility.ConvertToDecimal(value) > 1)
                {

                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "2";

                }
                else
                {
                    obj.selection = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + value;
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }




            //if (value == "Supplier With Good LPO")
            //{
            //    obj.selection = "Supplier With Good LPO";
            //    obj.score = "10";
            //}
            //else if (value == "Importer With Goods At Port")
            //{
            //    obj.selection = "Importer With Goods At Port";
            //    obj.score = "10";
            //}
            //else if (value == "Specific Merchant With Shop")
            //{
            //    obj.selection = "Specific Merchant With Shop";
            //    obj.score = "7";
            //}
            //else if (value == "General Trader/Merchant With Shop")
            //{
            //    obj.selection = "General Trader/Merchant With Shop";
            //    obj.score = "5";
            //}

        }
        else if (type == 7)
        {


            if (value != "" || value != null)
            {
                if (value == "5+ Years Audited Accounts Availble")
                {
                    obj.selection = "5+ Years Audited Accounts Availble";
                    obj.score = "10";
                }
                else if (value == "3+ Years Audited Accounts Availble")
                {
                    obj.selection = "3+ Years Audited Accounts Availble";
                    obj.score = "9";
                }
                else if (value == "UnAudited Accounts Availble")
                {
                    obj.selection = "UnAudited Accounts Availble";
                    obj.score = "5";
                }
                else if (value == "Book keeping records")
                {
                    obj.selection = "Book keeping records";
                    obj.score = "5";
                }
                else if (value == "No Accounts Availble")
                {
                    obj.selection = "No Accounts Availble";
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "None";
                obj.score = "0";
            }

        }
        else if (type == 8) //ResidenceOwnershipType
        {
            if (value.Trim() == "Owner")
            {
                obj.selection = value;
                obj.score = "10";
            }
            else if (value.Trim() == "Rented")
            {
                obj.selection = value;
                obj.score = "5";
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }
        else if (type == 9) //Property Type
        {
            if (value == "Own Property with registered documents")
            {
                obj.selection = value;
                obj.score = "10";
            }
            else if (value == "Own Property with partially registered documents")
            {
                obj.selection = value;
                obj.score = "7";
            }
            else if (value == "Third Party (Surety)")
            {
                obj.selection = value;
                obj.score = "5";
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }
        else if (type == 10) //Value of vehicle
        {


            if (value != "")
            {
                decimal val = Convert.ToDecimal(value);

                if (val >= 15000)
                {
                    obj.selection = val.ToString("C");
                    obj.score = "10";
                }
                else if (val >= 8000 || val < 15000)
                {
                    obj.selection = val.ToString("C");
                    obj.score = "8";
                }
                else if (val >= 4000 || val < 8000)
                {
                    obj.selection = val.ToString("C");
                    obj.score = "6";
                }
                else if (val >= 2000 || val < 4000)
                {
                    obj.selection = val.ToString("C");
                    obj.score = "4";
                }
                else if (val < 2000)
                {
                    obj.selection = val.ToString("C");
                    obj.score = "2";
                }



            }
            else
            {
                obj.selection = "None";
                obj.score = "0";
            }


        }
        else if (type == 11) //OtherCollateral
        {
            if (value == "UT Investment")
            {
                obj.selection = value;
                obj.score = "10";
            }
            else if (value == "UT Shares")
            {
                obj.selection = value;
                obj.score = "5";
            }
            else if (value == "Other Financial Instruments")
            {
                obj.selection = value;
                obj.score = "5";
            }
            else if (value == "Stocks")
            {
                obj.selection = value;
                obj.score = "3";
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }
        else if (type == 12) //Collateral Cover
        {
            if (value != string.Empty)
            {

                string[] str = value.Split('|');

                decimal cover = Utility.ConvertToDecimal(str[0]) / Utility.ConvertToDecimal(str[1]);

                obj.selection = cover.ToString();
                obj.score = "0";
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }

        }
        else if (type == 13)
        {

            if (value != string.Empty)
            {

                //                <asp:ListItem>Active Bank Account</asp:ListItem>
                //<asp:ListItem>Dormant Bank Account</asp:ListItem>
                //<asp:ListItem>No Bank Account</asp:ListItem>

                if (value == "Active Bank Account")
                {
                    obj.selection = value;
                    obj.score = "10";
                }
                else if (value == "Dormant Bank Account")
                {
                    obj.selection = value;
                    obj.score = "3";
                }
                else if (value == "No Bank Account")
                {
                    obj.selection = value;
                    obj.score = "0";
                }


            }
            else
            {

            }





        }
        else if (type == 14)
        {
            if (value != string.Empty)
            {

                //if (value == "0")
                //{
                //    obj.selection = "No Track Record";
                //    obj.score = "0";
                //}
                //else if (value == "Good Reference with Good Old Client(s)")
                //{
                //    obj.selection = value;
                //    obj.score = "5";
                //}
                //else if (value == "1 or 2 Previous Good Loans")
                //{
                //    obj.selection = value;
                //    obj.score = "7";
                //}
                //else if (value == "3 Previous Good Loans")
                //{
                //    obj.selection = value;
                //    obj.score = "10";
                //}


                string[] str = value.Split('|');

                if (str[1] == "Fair")
                {
                    obj.selection = str[0] + " Fair loans";
                    obj.score = "2";
                }
                else if (str[1] == "Good")
                {
                    if (int.Parse(str[0]) >= 3)
                    {
                        obj.selection = str[0] + " Previous Good loans";
                        obj.score = "10";
                    }
                    else if (int.Parse(str[0]) <= 2)
                    {
                        obj.selection = str[0] + " Previous Good loans";
                        obj.score = "7";
                    }
                }


            }
            else
            {
                obj.selection = "No Track Record";
                obj.score = "0";
            }
        }
        else if (type == 15)
        {

            if (value != string.Empty)
            {

                //                <asp:ListItem>No Alternate Source</asp:ListItem>
                //<asp:ListItem>1 Source</asp:ListItem>
                //<asp:ListItem>2 Sources</asp:ListItem>
                //<asp:ListItem>3 Sources</asp:ListItem>


                if (value == "No Alternate Source")
                {
                    obj.selection = value;
                    obj.score = "0";
                }
                else if (value == "1 Source")
                {
                    obj.selection = value;
                    obj.score = "7";
                }
                else if (value == "2 Sources")
                {
                    obj.selection = value;
                    obj.score = "5";
                }
                else if (value == "3 Sources")
                {
                    obj.selection = value;
                    obj.score = "10";
                }

            }
            else
            {
                obj.selection = "None";
                obj.score = "0";
            }
        }
        else if (type == 16)
        {

            if (value != string.Empty)
            {

                if (Utility.ConvertToDecimal(value) > 2)
                {
                    obj.selection = value;
                    obj.score = "10";
                }
                else if (Utility.ConvertToDecimal(value) == 2)
                {
                    obj.selection = value;
                    obj.score = "8";
                }
                else if (Utility.ConvertToDecimal(value) < 2)
                {
                    obj.selection = value;
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }
        else if (type == 17)
        {
            if (value != string.Empty)
            {

                if (Utility.ConvertToDecimal(value) <= 0.30M)
                {
                    obj.selection = value + "%";
                    obj.score = "10";
                }
                else if (Utility.ConvertToDecimal(value) >= 0.31M && Utility.ConvertToDecimal(value) <= 0.40M)
                {
                    obj.selection = value + "%";
                    obj.score = "8";
                }
                else if (Utility.ConvertToDecimal(value) >= 0.41M && Utility.ConvertToDecimal(value) <= 0.50M)
                {
                    obj.selection = value + "%";
                    obj.score = "3";
                }
                else if (Utility.ConvertToDecimal(value) > 0.50M)
                {
                    obj.selection = value + "%";
                    obj.score = "0";
                }
                else
                {
                    obj.selection = "none";
                    obj.score = "0";
                }
            }
            else
            {
                obj.selection = "none";
                obj.score = "0";
            }
        }


        return obj;


    }
    private static void ManageScoreSheet(DataTable tbl)
    {


        tbl.Columns.Add("S.No");
        tbl.Columns.Add("Attributes");
        tbl.Columns.Add("Max Points");
        tbl.Columns.Add("Selection");
        tbl.Columns.Add("Score");


        DataRow r = tbl.NewRow();

        r[0] = "1.";
        r[1] = "TYPE OF CLIENT";
        r[2] = "10";
        //r[0] = "Type of Client";
        //r[0] = "Type of Client";

        tbl.Rows.Add(r);

        r = tbl.NewRow();

        r[0] = "2.";
        r[1] = "TYPE OF BUSINESS";
        r[2] = "10";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "3.";
        r[1] = "NUMBER OF YEARS IN BUSINESS";
        r[2] = "10";


        tbl.Rows.Add(r);




        r = tbl.NewRow();

        r[0] = "4.";
        r[1] = "NUMBERS OF PERSONNEL";
        //r[2] = "10";


        tbl.Rows.Add(r);

        r = tbl.NewRow();

        r[0] = "";
        r[1] = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1. MANAGEMENT";
        r[2] = "10";


        tbl.Rows.Add(r);

        r = tbl.NewRow();

        r[0] = "";
        r[1] = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2. SKILLED";
        r[2] = "10";


        tbl.Rows.Add(r);

        r = tbl.NewRow();

        r[0] = "";
        r[1] = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3. UNSKILLED";
        r[2] = "10";


        tbl.Rows.Add(r);





        r = tbl.NewRow();


        r[0] = "5.";
        r[1] = "EXAMINATION OF COMPANY DOCUMENT";

        //r[2] = "10";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "";
        r[1] = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1. ACCOUNT BOOKS";
        r[2] = "12";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "";
        r[1] = "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1. COMPANY REGISTRED DOCUMENTS";
        r[2] = "7";


        tbl.Rows.Add(r);



        r = tbl.NewRow();


        r[0] = "6.";
        r[1] = "FINANCIAL STATEMENT";
        r[2] = "10";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "7.";
        r[1] = "INTEREST COVER RATIO (ICR)";
        r[2] = "20";


        tbl.Rows.Add(r);



        r = tbl.NewRow();

        r[0] = "8.";
        r[1] = "BANK ACCOUNT";
        r[2] = "10";


        tbl.Rows.Add(r);



        r = tbl.NewRow();

        r[0] = "9.";
        r[1] = "OTHER SOURCE OF INCOME";
        r[2] = "10";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "10.";
        r[1] = "VALUE OF RESIDENCE";
        r[2] = "10";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "11";
        r[1] = "VALUE OF VEHICLE";
        r[2] = "10";


        tbl.Rows.Add(r);



        r = tbl.NewRow();

        r[0] = "12.";
        r[1] = "VALUE OF OFFICE PREMISES";
        r[2] = "20";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "13.";
        r[1] = "COLLATERAL TYPE";
        r[2] = "25";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "14.";
        r[1] = "COLLATERAL COVER";
        r[2] = "25";


        tbl.Rows.Add(r);


        r = tbl.NewRow();

        r[0] = "15.";
        r[1] = "PAST RECORD WITH UT";
        r[2] = "10";


        tbl.Rows.Add(r);









    }
    
    #endregion

    //  My Codes  

    public string alert()
    {
        string msg = "";
        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        try
        {
            msg = loanApp.GetAlertMessage(MySessionManager.AppID, MySessionManager.ClientID).ToString();
        }
        catch (Exception ex)
        {
            msg = "";
        }
        return msg;

    }
    public string alert1()
    {
        string msg = "";
        InvestmentDSTableAdapters.GetAlertTableAdapter InvApp = new InvestmentDSTableAdapters.GetAlertTableAdapter();
        try
        {
            msg = InvApp.GetAlertMessage(MySessionManager.InvAppID).ToString();
        }
        catch (Exception ex)
        {
            msg = "";
        }
        return msg;

    }
    

    public void UpdateApplicationStatus(string Status, int currentAppStatus)
    {
        InsertAppTrail();
        if (Status == "Forward Application")
        {
            mainDSTableAdapters .opt_application_statusTableAdapter AppStatus = new mainDSTableAdapters.opt_application_statusTableAdapter ();
            int nextID =Convert.ToInt32(AppStatus.getNextStageID(currentAppStatus));
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(nextID,MySessionManager.AppID);
            loanApps.UpdateReviewStatus(null, MySessionManager.AppID);
            setAppMoveDetails(nextID, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);

        }
        if (Status == "Forward Application To Approval")
        {
            //mainDSTableAdapters.opt_application_statusTableAdapter AppStatus = new mainDSTableAdapters.opt_application_statusTableAdapter();
            //int nextID = Convert.ToInt32(AppStatus.getNextStageID(currentAppStatus));
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(7, MySessionManager.AppID);
            loanApps.UpdateReviewStatus(null, MySessionManager.AppID);
            setAppMoveDetails(7, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Decline Application")
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateApplicationRejection(17, currentAppStatus, MySessionManager.AppID);
            setAppMoveDetails(17, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Forward To Risk")
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(5, MySessionManager.AppID);
            setAppMoveDetails(5, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Forward To Legal")
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(6, MySessionManager.AppID);
            setAppMoveDetails(6, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Forward To Credit Team")
        {
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(4, MySessionManager.AppID);
            loanApps.UpdateReviewStatus(null, MySessionManager.AppID);
            setAppMoveDetails(4, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Send Back For Review")
        {
            int appstatus = currentAppStatus - 1;
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(appstatus, MySessionManager.AppID);
            loanApps.UpdateReviewStatus(true, MySessionManager.AppID);
            setAppMoveDetails(appstatus, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);

        }
        else if (Status == "Send Back For Review To Appraisal")
        {
            int appstatus =4;
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(appstatus, MySessionManager.AppID);
            loanApps.UpdateReviewStatus(true, MySessionManager.AppID);
            setAppMoveDetails(appstatus, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }
        else if (Status == "Forward to Approved Loans")
        {
            int appstatus = 12;
            LoanDSTableAdapters.LoanApplicationsTableAdapter loanApps = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
            loanApps.UpdateAppStatus(appstatus, MySessionManager.AppID);
            loanApps.UpdateReviewStatus(null, MySessionManager.AppID);
            setAppMoveDetails(appstatus, DateTime.Now, MySessionManager.CurrentUser.UserID, MySessionManager.AppID);
        }

        else if (Status == "Forward to COO")
        { 
        
        
        
        
        }

    }

    public string displayValue(string table, string conditionValue)
    {
        string query = "SELECT datDescription FROM " + table + " WHERE datID ='" + conditionValue + "'";
        SqlConnection conn = new SqlConnection(Utility.connectionString);
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;
        string  r = "";
        cmd.Connection = conn;
        cmd.CommandText = query;
        cmd.CommandType = CommandType.Text ;

        try
        {
            conn.Open();
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                r = reader[0].ToString();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }

        return r;
      }

    public string RemoveQueryStringByKey(string url, string key)
    {
        var uri = new Uri(url);

        // this gets all the query string key value pairs as a collection
        var newQueryString = HttpUtility.ParseQueryString(uri.Query);

        // this removes the key if exists
        newQueryString.Remove(key);

        // this gets the page path from root without QueryString
        string pagePathWithoutQueryString = uri.GetLeftPart(UriPartial.Path);

        return newQueryString.Count > 0
            ? String.Format("{0}?{1}", pagePathWithoutQueryString, newQueryString)
            : pagePathWithoutQueryString;
    }

    public void deleteItem(string table, string id)
    {
        string query = "DELETE FROM " + table + " WHERE datID ='" + id + "'";
        SqlConnection conn = new SqlConnection(Utility.connectionString);
        SqlCommand cmd = new SqlCommand();
        
        cmd.Connection = conn;
        cmd.CommandText = query;
        cmd.CommandType = CommandType.Text;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    //public void setDropdownlist(DropDownList ddl,string value)
    //{
    //    if (value == "")
    //    {
    //        ListItem Litem = new ListItem("--Select--","0");
    //        ddl.Items.Add(Litem);
    //        //ddl.DataBind();
    //    }
    //    else
    //    {
    //        ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(value));
    //    }
    //}
    
    public void InsertAppTrail()
    {

        LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
        LoanDS.LoanApplicationsDataTable tblLoanApp = loanApp.GetLoanApplication(MySessionManager.AppID.ToString());
        int pastUser = Convert.ToInt32(loanApp.GetPreviousUsersID(MySessionManager.AppID)); 

        TimeSpan  TimeDiff =(DateTime.Now - tblLoanApp[0].datMoveTime);
        string moveTime = TimeDiff.Days + " days " + TimeDiff.Hours + " hours" + TimeDiff.Minutes + " minutes and " + TimeDiff.Seconds+" seconds"; 
        int stage = Convert.ToInt32(loanApp.getApplicationStatus(MySessionManager.AppID));

        try
        {
            LoanDSTableAdapters.ApplicationTrailTableAdapter AppTrail = new LoanDSTableAdapters.ApplicationTrailTableAdapter();
            AppTrail.InsertAppTrail(MySessionManager.AppID,
                                    pastUser,
                                    MySessionManager.CurrentUser.UserID,
                                    tblLoanApp[0].datMoveTime,
                                    stage,
                                    moveTime);


            loanApp.SetNewUserAndTime(MySessionManager.CurrentUser.UserID, DateTime.Now, MySessionManager.AppID);
        }
        catch (Exception ex) { }
    }

    /// <summary>
    /// This functions add a number of days to a specified date and return that date
    /// </summary>
    /// <param name="date">The intial date</param>
    /// <param name="days">An Integer indicating the number of days to add</param>
    /// <returns>DateTime</returns> 
    public DateTime addDaysElapsed(DateTime date, int days)
    {
        DateTime dt = DateTime.Now;
        try
        {
            dt = date.AddDays(days);
        }
        catch (Exception ex) { }
        return dt;

    }
    public bool setAppMoveDetails(int newStatus,DateTime ctime,int UserID,int AppID)
    {
        string query = "UPDATE tbl_loan_application SET datStatusChangedDate" + newStatus.ToString() + " = @ctime, datStatusChangedBy" + newStatus.ToString() + " = @userid WHERE datID = @appID";
        SqlConnection conn = new SqlConnection(Utility.connectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;
        cmd.CommandText = query;
        cmd.Parameters.AddWithValue("ctime",ctime);
        cmd.Parameters.AddWithValue("userid",UserID );
        cmd.Parameters.AddWithValue("appID", AppID);

        cmd.CommandType = CommandType.Text;
        bool res = true;
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            
            res = false;
        }
        finally
        {
            conn.Close();
        }
        return res ;
    }
}

public class ScoreSheetSelection_Score
{
    public string selection = "";
    public string score = "";
}


