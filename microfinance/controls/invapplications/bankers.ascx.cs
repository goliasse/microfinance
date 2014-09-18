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

public partial class controls_invapplications_bankers : System.Web.UI.UserControl
{
    public string type { set; get; }
    public int id { set; get; }
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!(Request.QueryString["bedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["bedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadBankers(id);
            }
        }
        else if (!(Request.QueryString["bdelete"] == null))
        {
            string id = Request.QueryString["bdelete"];
            util.deleteItem("tblBankers", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "bdelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        InvestmentDSTableAdapters.GetInvBankersTableAdapter bankers = new InvestmentDSTableAdapters.GetInvBankersTableAdapter();
        if (!(type == "update"))
        {
            bankers.InsertInvBankers(MySessionManager.ClientID,
                                     MySessionManager.InvAppID,
                                     txtbank.Value.Trim(),
                                     txtAcName.Value.Trim(),
                                     txtbranch.Value.Trim(),
                                     ddlType.Text,
                                     txtAcNo.Value.Trim(),
                                     1,
                                     MySessionManager.CurrentUser.UserID);
        }
        else if (type == "update")
        {

            // Request.QueryString[]
            bankers.UpdateInvBankers(txtbank.Value.Trim(),
                                     txtAcName.Value.Trim(),
                                     txtbranch.Value.Trim(),
                                     ddlType.Text,
                                     txtAcNo.Value.Trim(),
                                     1,
                                     MySessionManager.CurrentUser.UserID,
                                     id);
        }
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "bedit"));
    }
    protected void gvBanker_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvBanker.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&bedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&bdelete=" + enpValue;


            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
    public string loadBankers(int id)
    {
        type = "update";

        try
        {
            LoanDSTableAdapters.BankersTableAdapter bankers = new LoanDSTableAdapters.BankersTableAdapter();
            LoanDS.BankersDataTable tblBankers = bankers.GetBankerDetails(id);

            if (tblBankers.Rows.Count > 0)
            {
                txtAcName.Value = tblBankers[0].datAccountName.ToString();
                txtAcNo.Value = tblBankers[0].datAccountNo.ToString();
                txtbank.Value = tblBankers[0].datBank.ToString();
                txtbranch.Value = tblBankers[0].datBranch.ToString();
                try
                {
                    ddlType.SelectedValue = tblBankers[0].datAccountType.ToString();
                }
                catch (Exception ex) { }
                //ddlType.SelectedIndex = ddlType.Items.IndexOf(ddlType.Items.FindByValue(tblBankers[0].datAccountType.ToString()));

            }
            this.editskip.Value = "2";
        }
        catch (Exception ex)
        {
            Console.Write(ex.Message);

        }
        return "";
    }
}
