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

public partial class controls_invapplications_nextofkin : System.Web.UI.UserControl
{
    public string type{ set; get; }
    public int id{ set; get; }
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["nedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["nedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadNOK(id);
            }
        }
        else if (!(Request.QueryString["ndelete"] == null))
        {
            string id = Request.QueryString["ndelete"];
            util.deleteItem("tbl_next_of_kin", id);

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ndelete"));

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        InvestmentDSTableAdapters.GetInvNextOfKinTableAdapter nok = new InvestmentDSTableAdapters.GetInvNextOfKinTableAdapter();
            if (!(type == "update"))
            {
                
                nok.InsertInvNextOfKin(txtfullname.Value,
                                       MySessionManager.ClientID,
                                       MySessionManager.InvAppID,
                                       txtMobile.Value,
                                       txtHomeTel.Value,
                                       txtOfficeTel.Value,
                                       txtEmail.Value,
                                       txtAddress.Value,
                                       Convert.ToDecimal(txtpercentageshare.Value),
                                       MySessionManager.CurrentUser.UserID);
             }
            else if (type == "update")
            {
               //nok.
            }

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "nedit"));
        
    }
    protected void gvNextOfKin_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvNextOfKin.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&nedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&ndelete=" + enpValue;
            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
        
    }
    public void loadNOK(int id)
    {
        InvestmentDSTableAdapters.GetInvNextOfKinTableAdapter nok = new InvestmentDSTableAdapters.GetInvNextOfKinTableAdapter();
        InvestmentDS.GetInvNextOfKinDataTable  tblnok = nok.GetInvNextOfKinDetails(id);

        if (tblnok.Rows.Count > 0)
        {
            try
            {
                this.editskip.Value = "2";
                txtfullname.Value = tblnok[0].datFullName.ToString();
                txtHomeTel.Value = tblnok[0].datHomeTelephoneNumber.ToString();
                txtOfficeTel.Value = tblnok[0].datOfficeTelephoneNumber.ToString();
                txtMobile.Value = tblnok[0].datMobileNumber.ToString();
                txtpercentageshare.Value = tblnok[0].datPercentageShare.ToString();
                txtEmail.Value = tblnok[0].datEmailAddress.ToString();
                txtAddress.Value = tblnok[0].datAddress.ToString();
              // txtRelationship.Value = tblnok[0].datRelationship.ToString();

            }
            catch (Exception ex)
            {


            }
        }

    }
}
