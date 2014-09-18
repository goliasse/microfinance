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

public partial class backend_controls_accessrights : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        #region QueryString
        if (Request.QueryString["id"] == null)
        {
        }
        else
        {
            string EncID = Request.QueryString["id"];
            int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
            this.userID.Value = DecID.ToString();
        }
        
        #endregion
      
        Panel seperator = new Panel();

        adminTableAdapters.GetAccessCodesTableAdapter AccessCodes = new adminTableAdapters.GetAccessCodesTableAdapter();
        admin.GetAccessCodesDataTable tblAccessCodes = AccessCodes.GetAccessMenuTypes();
        foreach(admin.GetAccessCodesRow tbl in tblAccessCodes)
        {
            Panel  menuDiv = new Panel();
            HtmlGenericControl menuHdrDiv = new HtmlGenericControl("div");
            HtmlGenericControl menuContDiv = new HtmlGenericControl("div");
            menuDiv.ID = "menu_"+tbl.datType.ToString();
            menuHdrDiv.InnerHtml ="<p><h5><small> "+ tbl.datType.ToString() +" </small></h5><hr style='margin:5px'/></p>";

            admin.GetAccessCodesDataTable tblAccessData = AccessCodes.GetAccessCodes(tbl.datType.ToString());
            foreach(admin.GetAccessCodesRow tbl1  in tblAccessData)
            {
                
                CheckBox chk1 = new CheckBox();
                chk1.ID = "chk_" + tbl1.datID.ToString();
                chk1.CssClass = "checkbox";
                chk1.Text = tbl1.datDescription.ToString();
                HtmlGenericControl formgroupDiv = new HtmlGenericControl("div");
              
                formgroupDiv.Attributes["class"] = "form-group";
              
                formgroupDiv.Controls.Add(chk1);
                menuContDiv.Controls.Add(formgroupDiv);
            }
            menuDiv.Controls.Add(menuHdrDiv);
            menuDiv.Controls.Add(menuContDiv);

            this.mainContainer.Controls.Add(menuDiv);
        }
        if (this.userID.Value != "")
        {
            LoadCheckItems(Convert.ToInt32(this.userID.Value));
        }
    }
    protected void btnSaveRight_Click(object sender, EventArgs e)
    {
        adminTableAdapters.GetAllAccessRightsTableAdapter AccessRights = new adminTableAdapters.GetAllAccessRightsTableAdapter();
        int userID=Convert.ToInt32(this.userID.Value );

        AccessRights.DeleteAccessRights(userID);
        try
        {
            adminTableAdapters.GetAccessCodesTableAdapter AcessCodeData = new adminTableAdapters.GetAccessCodesTableAdapter();
            admin.GetAccessCodesDataTable  tblAcessCodeData = AcessCodeData.GetEveryAccessCode();
            
            foreach(admin.GetAccessCodesRow tbl in tblAcessCodeData)
            {
                int? myControlID = null;
                string ClientID = "chk_" + tbl.datID.ToString();
                
                CheckBox ChkBox = (CheckBox) FindControl(ClientID);

                if(!(ChkBox==null))
                {
                    if (ChkBox.Checked == true)
                    { 
                        AccessRights.InsertUsersAccessRights(userID,
                                                             tbl.datID,
                                                             MySessionManager.CurrentUser.UserID);
                    }
                }  
            }                                    
        }
        catch (Exception ex) { }
    }


    public void LoadCheckItems(int userid)
    {

        mainDSTableAdapters.GetMenuItemsTableAdapter menuItem = new mainDSTableAdapters.GetMenuItemsTableAdapter();
        mainDS.GetMenuItemsDataTable tblmenuItem = menuItem.GetMenuItems(userid);

        foreach (mainDS.GetMenuItemsRow r in tblmenuItem)
        {
            try
            {
                CheckBox chk = (CheckBox)FindControl("chk_" + r.datCode.ToString());
                if (chk != null)
                {
                    chk.Checked = true;
                }
            }
            catch (Exception ex) { }
        
        
        
        }
    
    
    
    
    
    }
}
