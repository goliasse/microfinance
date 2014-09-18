using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

public partial class main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        mainDSTableAdapters.SetupDetailsTableAdapter setup = new mainDSTableAdapters.SetupDetailsTableAdapter();
        mainDS.SetupDetailsDataTable tblSetup = setup.GetSetupDetails(1);
        if (tblSetup.Rows.Count > 0) 
        {
            lblCompany.InnerText = tblSetup[0].datCompanyname.ToString();
        }
        try
        {
            if (MySessionManager.CurrentUser.BranchID <= 0)
                Response.Redirect("~/login.aspx");
        }
        catch
        {
            Response.Redirect("~/login.aspx");
        }

        this.lkbUsername.Text = MySessionManager.CurrentUser.UserFullName + " - " + MySessionManager.CurrentUser.UserRole;

        if (MySessionManager.CurrentUser.RoleID != 1)
        {
            this.settings.Visible = false;
        }
        else
        { settings.Visible = true; }
        setCountApps();
        setMenuList();
    }

    //Write Functions to set the Available to a user when login
    public void setMenuList()
    {
        bool exist = false;
        mainDSTableAdapters.GetMenuItemsTableAdapter menuItem = new mainDSTableAdapters.GetMenuItemsTableAdapter();
        mainDS.GetMenuItemsDataTable tblmenuItem = menuItem.GetMenuItems(MySessionManager.CurrentUser.UserID);
        mainDSTableAdapters.GetAllMenuItemsTableAdapter menu = new mainDSTableAdapters.GetAllMenuItemsTableAdapter();
        mainDS.GetAllMenuItemsDataTable tblmenu = menu.GetData();
        foreach (mainDS.GetAllMenuItemsRow r in tblmenu)
        {
            DataRow[] lr;
            DataTable l;

            lr =tblmenuItem.Select("datControlName='" + r.datControlName.ToString()+"'");
                if (lr.Length >0)
                {
                    exist = true;
                    setControl(exist, r.datControlName, r.datControlType);
                }
                else { 
                    exist = false;
                    setControl(exist,r.datControlName,r.datControlType);
                }
                

            }
        }
    
    public void setControl(bool exist, string control, string type)
    {
        if (exist)
        {
            try
            {
                if (type == "LinkButton")
                {
                    LinkButton link1 = (LinkButton) ControlFinder.FindControlRecursive(this, control);
                    link1.Visible = true;
                }
            }
            catch (Exception ex) { }
        }
        else
        {
            try
            {
                if (type == "LinkButton")
                {
                    LinkButton link1 = (LinkButton)ControlFinder.FindControlRecursive(this, control);
                    if (link1 != null)
                    { link1.Visible = false; }
                }
            }
            catch (Exception ex) { }
        }
    }
    public void setCountApps()
    {

        mainDSTableAdapters.NotificationCountTableAdapter notifs = new mainDSTableAdapters.NotificationCountTableAdapter();
        mainDS.NotificationCountRow notifcounts = notifs.NotificationCount(MySessionManager.CurrentUser.BranchID, MySessionManager.CurrentUser.UserID,MySessionManager.CurrentUser.TeamID)[0];

        this.clientinfo.InnerHtml = notifcounts.client.ToString();
         this.invaccinfo.InnerHtml = notifcounts.InvAccounts.ToString();
        this.invappinfo.InnerHtml = notifcounts.invapplications.ToString();
        this.laonappinfo.InnerHtml = notifcounts.loanApplication.ToString();
        this.loanaccinfo.InnerHtml = notifcounts.loanaccount.ToString();
        this.schpayinfo.InnerText = notifcounts.scheduledPayment.ToString();
            }
}
