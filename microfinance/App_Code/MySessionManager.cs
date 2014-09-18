using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for MySessionManager
/// </summary>
public class MySessionManager
{
	public MySessionManager()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void ClearMySessions()
    {
        HttpContext.Current.Session["AccountID"] = null;
        HttpContext.Current.Session["AccountNumber"] = null;
        HttpContext.Current.Session["ClientID"] = null;
        HttpContext.Current.Session["AppID"] = null;
    }
    public static void UnMySession(string name) 
    {
        HttpContext.Current.Session[name] = null;
    }

    public static string AccountNumber
    {
        get 
        {
            if (HttpContext.Current.Session["AccountNumber"] == null)
                return "";
            else
                return HttpContext.Current.Session["AccountNumber"].ToString(); 
        }
        set 
        {
            HttpContext.Current.Session["AccountNumber"] = value;
        }
    }

    public static bool IsLogedIn
    {
        get
        {
            if (HttpContext.Current.Session["IsLog"] == null)
                return false;
            else
                return Convert.ToBoolean(HttpContext.Current.Session["IsLog"]);
        }
        set
        {
            HttpContext.Current.Session["IsLog"] = value;
        }
    }

    public static string CurrentTab
    {
        get
        {
            if (HttpContext.Current.Session["CurrentTab"] == null)
                return "";
            else
                return HttpContext.Current.Session["CurrentTab"].ToString();
        }
        set
        {
            HttpContext.Current.Session["CurrentTab"] = value;
        }
    }
    public static string OpsTab
    {
        get
        {
            if (HttpContext.Current.Session["OpsTab"] == null)
                return "";
            else
                return HttpContext.Current.Session["OpsTab"].ToString();
        }
        set
        {
            HttpContext.Current.Session["OpsTab"] = value;
        }
    }
    public static object transactionTemp
    {
        get
        {
            if (HttpContext.Current.Session["transTemp"] == null)
                return null;
            else
                return HttpContext.Current.Session["transTemp"];
        }
        set
        {
            HttpContext.Current.Session["transTemp"] = value;
        }   
    }
    public static long AccountID
    {
        get 
        {
            if (HttpContext.Current.Session["AccountID"] == null)
                return 0;
            else
                return Convert.ToInt64(HttpContext.Current.Session["AccountID"]);
        }
        set 
        {
            HttpContext.Current.Session["AccountID"] = value;
        }
    }

    public static int ClientID
    {
        get
        {
            if (HttpContext.Current.Session["ClientID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["ClientID"]);
        }
        set
        {
            HttpContext.Current.Session["ClientID"] = value;
        }
    }

    public static int AppBranchID
    {
        get
        {
            if (HttpContext.Current.Session["AppBranchID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["AppBranchID"]);
        }
        set
        {
            HttpContext.Current.Session["AppBranchID"] = value;
        }
    }

    public static byte CMType
    {
        get
        {
            if (HttpContext.Current.Session["CMType"] == null)
                return 0;
            else
                return Convert.ToByte(HttpContext.Current.Session["CMType"]);
        }
        set
        {
            HttpContext.Current.Session["CMType"] = value;
        }
    }

    public static int AccountTypeID
    {
        get
        {
            if (HttpContext.Current.Session["AccountTypeID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["AccountTypeID"]);
        }
        set
        {
            HttpContext.Current.Session["AccountTypeID"] = value;
        }
    }

    public static SystemUser CurrentUser
    {
        get 
        {
            if (HttpContext.Current.Session["CurrentUser"] == null)
                return null;
            else
                return (SystemUser) HttpContext.Current.Session["CurrentUser"];
        }

        set
        {
            HttpContext.Current.Session["CurrentUser"] = value;
        }
    }
    public static int AppID
    {
        get
        {
            if (HttpContext.Current.Session["AppID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["AppID"]);
        }

        set
        {
            HttpContext.Current.Session["AppID"] = value;
        }
    }

    public static int CreditAccountListID
    {
        get
        {
            if (HttpContext.Current.Session["CreditAccountListID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["CreditAccountListID"]);
        }

        set
        {
            HttpContext.Current.Session["CreditAccountListID"] = value;
        }
    }

    public static int DebitAccountListID
    {
        get
        {
            if (HttpContext.Current.Session["DebitAccountListID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["DebitAccountListID"]);
        }

        set
        {
            HttpContext.Current.Session["DebitAccountListID"] = value;
        }
    }
    public static int InvAppID
    {
        get
        {
            if (HttpContext.Current.Session["InvAppID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["InvAppID"]);
        }
        set
        {
            HttpContext.Current.Session["InvAppID"] = value;
        }
    }
    public static string TempTranKey
    {
        get
        {
            if (HttpContext.Current.Session["TempTranKey"] == null)
            {
                HttpContext.Current.Session["TempTranKey"] = System.Guid.NewGuid().ToString();
            }

            return Convert.ToString(HttpContext.Current.Session["TempTranKey"]);
        }
        set
        {   
            if (HttpContext.Current.Session["TempTranKey"] != null)
            {
                FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter temTranEntry = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
                string curKey = Convert.ToString(HttpContext.Current.Session["TempTranKey"]);
                temTranEntry.DeleteTempTransactionEntriesByKey(curKey);
            }

            HttpContext.Current.Session["TempTranKey"] = value;
        }
    }



    public static string VchTypeName
    {
        get
        {
            if (HttpContext.Current.Session["VchTypeName"] == null)
            {
                return "";
            }

            return Convert.ToString(HttpContext.Current.Session["VchTypeName"]);
        }
        set
        {
            HttpContext.Current.Session["VchTypeName"] = value;
        }
    }

    public static int InvAccID
    {
        get
        {
            if (HttpContext.Current.Session["InvAccID"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["InvAccID"]);
        }
        set
        {
            HttpContext.Current.Session["InvAccID"] = value;
        }
    }

    public static int ProductRecommended
    {
        get
        {
            if (HttpContext.Current.Session["ProductRecommended"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["ProductRecommended"]);
        }
        set
        {
            HttpContext.Current.Session["ProductRecommended"] = value;
        }
    }



    public static int ApplicantType
    {
        get
        {
            if (HttpContext.Current.Session["ApplicantType"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["ApplicantType"]);
        }
        set
        {
            HttpContext.Current.Session["ApplicantType"] = value;
        }
    }

    public static double AmountRecommended
    {
        get
        {
            if (HttpContext.Current.Session["AmountRecomended"] == null)
                return 0;
            else
                return Utility.ConvertToDouble(HttpContext.Current.Session["AmountRecomended"].ToString());
        }

        set
        {
            HttpContext.Current.Session["AmountRecomended"] = value;
        }

    }
    public static int? skipAlert
    {
        get
        {
            if (HttpContext.Current.Session["alertskip"] == null)
                return 0;
            else
                return Convert.ToInt32(HttpContext.Current.Session["alertskip"]);
        }
        set
        {
            HttpContext.Current.Session["alertskip"] = value;
        }
    }
    public static decimal cash
    {
        get
        {
            if (HttpContext.Current.Session["cash"] == null)
                return 0;
            else
                return Convert.ToDecimal(HttpContext.Current.Session["cash"]);
        }
        set
        {
            HttpContext.Current.Session["cash"] = value;
        }
    }
    public static decimal bank
    {
        get
        {
            if (HttpContext.Current.Session["bank"] == null)
                return 0;
            else
                return Convert.ToDecimal(HttpContext.Current.Session["bank"]);
        }
        set
        {
            HttpContext.Current.Session["bank"] = value;
        }
    }
    public static int? BranchID
    {
        get
        {
            if (HttpContext.Current.Session["BranchID"] == null)
                return null;
            else
                return  (int) HttpContext.Current.Session["BranchID"];
        }
        set
        {
            HttpContext.Current.Session["BranchID"] = value;
        }
    }
    public static decimal amtDeductable
    {
        get
        {
            if (HttpContext.Current.Session["amtDeductable"] == null)
                return 0;
            else
                return Convert.ToDecimal(HttpContext.Current.Session["amtDeductable"]);
        }
        set
        {
            HttpContext.Current.Session["amtDeductable"] = value;
        }
    }
}
