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
/// Summary description for SystemUser
/// </summary>
public class SystemUser
{
	public SystemUser()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int _userID = 0;
    public int UserID
    {
        get { return this._userID; }
        set { this._userID = value; }
    }

    private int _branchID = 0;
    public int BranchID
    {
        get { return this._branchID; }
        set { this._branchID = value; }
    }

    private int _teamID = 0;
    public int TeamID
    {
        get { return this._teamID; }
        set { this._teamID = value; }
    }

    private string _branchName = String.Empty;
    public string BranchName
    {
        get { return this._branchName; }
        set { this._branchName = value; }
    }

    private string _branchCode = String.Empty;
    public string BranchCode
    {
        get { return this._branchCode; }
        set { this._branchCode = value; }
    }


    private string _userName = String.Empty;
    public string Username
    {
        get { return this._userName; }
        set { this._userName = value; }
    }


    private string _userEmailaddress = String.Empty;
    public string UserEmailaddress
    {
        get { return this._userEmailaddress; }
        set { this._userEmailaddress = value; }
    }

    private string _userRole = String.Empty;
    public string UserRole
    {
        get { return this._userRole; }
        set { this._userRole = value; }
    }

    private int _roleID = 0;
    public int RoleID
    {
        get { return this._roleID; }
        set { this._roleID = value; }
    }

    //private int _teamID = 0;
    //public int TeamID
    //{
    //    get { return this._teamID; }
    //    set { this._teamID = value; }
    //}

    private string _homePage = String.Empty;
    public string HomePage
    {
        get { return this._homePage; }
        set { this._homePage = value; }
    }
    private string _userFullName = string.Empty;
    public string UserFullName
    {
        get { return this._userFullName; }
        set { this._userFullName = value; }
    }



}
