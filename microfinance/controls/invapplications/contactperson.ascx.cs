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

public partial class controls_invapplications_contactperson : System.Web.UI.UserControl
{
    
    public string type { set; get;}
    public int id{set;get;}
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///This block of code checks request to edit or delete an item
        if (!(Request.QueryString["cpedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["cpedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadContactPerson(id);
            }
        }
        else if (!(Request.QueryString["cpdelete"] == null))
        {
            string id = Request.QueryString["cpdelete"];
            util.deleteItem("tbl_contact_person", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "cpdelete"));
        }
        
    }
    /// <summary>
    /// To save and Update the record of the contact person
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSave_Click(object sender, EventArgs e)
    {

        InvestmentDSTableAdapters.GetInvContactPersonTableAdapter contactperson = new InvestmentDSTableAdapters.GetInvContactPersonTableAdapter();
        if (type != "update")
        {      
            contactperson.InsertContactPerson(MySessionManager.ClientID,
                                              txtfullname.Text,
                                              txtMobileNumber.Text,
                                              txtTelephoneNumber.Text,
                                              txtEmailAddress.Text,
                                              txtHomeAddress.Value,
                                              txtfax.Text,
                                              MySessionManager.InvAppID);
        }
        else if(type=="update") 
        {
           contactperson.UpdateContactPerson(txtfullname.Text,
                                             txtMobileNumber.Text,
                                             txtTelephoneNumber.Text,
                                             txtEmailAddress.Text,
                                             txtfax.Text,
                                             txtHomeAddress.Value,
                                             MySessionManager.CurrentUser.UserID,
                                             id);
        }
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "cpedit"));
    }
    /// <summary>
    /// To load the record of the contact person to be edited
    /// </summary>
    /// <param name="?">The ID of the contact person</param>
    public void loadContactPerson(int id)
    {
        try
        {
            InvestmentDSTableAdapters.GetInvContactPersonTableAdapter cp = new InvestmentDSTableAdapters.GetInvContactPersonTableAdapter();
            InvestmentDS.GetInvContactPersonDataTable tblcp = cp.GetContactPersonDetails(id);
            if (tblcp.Rows.Count > 0)
            {
                txtfullname.Text = tblcp[0].datFullname.ToString();
                txtMobileNumber.Text = tblcp[0].datMobileNumber.ToString();
                txtfax.Text = tblcp[0].datFaxNumber.ToString();
                txtEmailAddress.Text = tblcp[0].datMobileNumber.ToString();
                txtHomeAddress.Value = tblcp[0].datEmailAddress.ToString();
                txtTelephoneNumber.Text = tblcp[0].datTelephoneNumber.ToString();
                this.editskip.Value = "2";
            }

        
        
        }
        catch(Exception ex){}
    }
    protected void  gvContactPerson_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvContactPerson.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&cpedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&cpdelete=" + enpValue;
            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
}
