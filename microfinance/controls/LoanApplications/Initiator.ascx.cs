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

public partial class controls_Initiator : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["iedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["iedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadInitiator(id);
            }
        }
        else if (!(Request.QueryString["idelete"] == null))
        {
            string id =Request.QueryString["idelete"];
            util.deleteItem("tbl_contact_person", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "idelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.IntiatorTableAdapter initiator = new LoanDSTableAdapters.IntiatorTableAdapter();
        if (!(type == "update"))
        {
            initiator.InsertInitiator(MySessionManager.AppID,
                                       MySessionManager.ClientID,
                                       txtfullname.Value.Trim(),
                                       txtPosition.Value,
                                       txtMobile.Value.Trim(),
                                       txtTelNo.Value.Trim(),
                                       txtEmail.Value.Trim(),
                                       txtFax.Value.Trim(),
                                       txtAddress.Value.Trim());
        }
        else if (type == "update")
        {
            initiator.UpdateInitiator(id,
                                      txtfullname.Value.Trim(),
                                      txtPosition.Value,
                                      txtMobile.Value.Trim(),
                                      txtTelNo.Value.Trim(),
                                      txtEmail.Value.Trim(),
                                      txtAddress.Value.Trim(),
                                      txtFax.Value.Trim() );
        }
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "iedit"));
    }
    /// <summary>
    /// This functions loads the record of an initiator to be edited
    /// </summary>
    /// <param name="ID">The ID of the initiator</param>
    public void loadInitiator(int ID)
    {
        try
        {
            LoanDSTableAdapters.IntiatorTableAdapter initiator = new LoanDSTableAdapters.IntiatorTableAdapter();
            LoanDS.IntiatorDataTable tblInitiator = initiator.GetIntiator(MySessionManager.ClientID, MySessionManager.AppID);
            if (tblInitiator.Rows.Count > 0)
            {
                txtfullname.Value = tblInitiator[0].datFullname.ToString();
                txtPosition.Value = tblInitiator[0].datPosition.ToString();
                txtMobile.Value = tblInitiator[0].datMobileNumber.ToString();
                txtFax.Value = tblInitiator[0].datFaxNumber.ToString();
                txtEmail.Value = tblInitiator[0].datMobileNumber.ToString();
                txtAddress.Value = tblInitiator[0].datEmailAddress.ToString();
                txtTelNo.Value = tblInitiator[0].datTelephoneNumber.ToString();
                this.editskip.Value = "2";
            }
        }
        catch (Exception ex) { }

    }

    protected void gvInitiator_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvInitiator.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&iedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&idelete=" + enpValue;
            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
}
