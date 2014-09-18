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

public partial class controls_Collaterals : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        //ListItem LItem = new ListItem("--Select--", "0");
        //ddlCollateralType.Items.Insert(0, LItem);
        //ddlSurity.Items.Insert(0, LItem);
        //ddlConfirmed.Items.Insert(0, LItem);

        //SqlDataSource4.SelectParameters[0].DefaultValue = MySessionManager.AppID.ToString();

        

        if (!(Request.QueryString["coledit"] == null))
        {
            try
            {

                type = "update";
                id = Convert.ToInt32(Request.QueryString["coledit"]);
                if (!(this.editskip.Value == "2"))
                {
                    loadCollateral(id);
                }
            }
            catch (Exception ex) { Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "coledit")); }
        }
        else if (!(Request.QueryString["coldelete"] == null))
        {
            string  id = Request.QueryString["coldelete"];
            util.deleteItem("tbl_collaterals", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "coldelete"));
        }


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            int isConfirmed = -1;
            if (ddlConfirmed.Text == "1" || ddlConfirmed.Text == "2")
            {
                isConfirmed = Convert.ToInt32(ddlConfirmed.SelectedValue);
            }


            LoanDSTableAdapters.CollateralTableAdapter collateral = new LoanDSTableAdapters.CollateralTableAdapter();

            if (!(type == "update"))
            {
                collateral.InsertCollateral(MySessionManager.ClientID,
                                             MySessionManager.AppID,
                                             Convert.ToInt32(ddlCollateralType.Text),
                                             txtDescription.Value,
                                             txtLocation.Value,
                                              Convert.ToDecimal(txtvalue.Value),
                                             Convert.ToInt32(ddlSurity.SelectedValue),
                                             txtContactPerson.Value,
                                             txtContactTel.Value,
                                             txtPhysicalAddress.Value,
                                             Convert.ToInt32(isConfirmed),
                                             null);
            }
            else if (type == "update")
            {
                collateral.updateCollateral(Convert.ToInt32(ddlCollateralType.Text),
                                            txtDescription.Value,
                                            txtLocation.Value,
                                            Convert.ToDecimal(txtvalue.Value),
                                            Convert.ToInt32(ddlSurity.SelectedValue),
                                            txtContactPerson.Value,
                                            txtContactTel.Value,
                                            txtPhysicalAddress.Value,
                                            Convert.ToInt32(isConfirmed),
                                            null,
                                            id);
            }

            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "coledit"));
        }
    }
    protected void gvCollateral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvCollateral.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&coledit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&coldelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
    public void loadCollateral(int id)
    {
        LoanDSTableAdapters.CollateralTableAdapter collateral = new LoanDSTableAdapters.CollateralTableAdapter();
        LoanDS.CollateralDataTable tblcol = collateral.GetCollateralDetails(id);

        if (tblcol.Rows.Count > 0)
        {
            txtContactPerson.Value = tblcol[0].datContactPerson.ToString();
            txtLocation.Value = tblcol[0].datLocation.ToString();
            txtDescription.Value = tblcol[0].datDescription;
            txtContactTel.Value = tblcol[0].datContactPersonTelephoneNumber.ToString();
            txtPhysicalAddress.Value = tblcol[0].datPhysicalAddress.ToString();
            txtvalue.Value = tblcol[0].datValue.ToString();
            try
            {
                ddlCollateralType.SelectedValue = tblcol[0].datCollateralTypeID.ToString();

                ddlCollateralType.SelectedIndex = ddlCollateralType.Items.IndexOf(ddlCollateralType.Items.FindByValue(tblcol[0].datCollateralTypeID.ToString()));
                if (Convert.ToInt32(tblcol[0].datConfirmed) > 0) { ddlConfirmed.SelectedValue = tblcol[0].datConfirmed.ToString(); }
                ddlSurity.ClearSelection();
               if(Convert.ToInt32(tblcol[0].datConfirmed)>0) ddlSurity.SelectedValue = tblcol[0].datSurety.ToString();
                //ddlSurity.SelectedIndex = ddlSurity.Items.IndexOf(ddlSurity.Items.FindByValue(tblcol[0].datSurety.ToString()));
            }
            catch (Exception ex) { }
             this.editskip.Value = "2";
        }
    }
    protected void SqlDataSource4_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            decimal m;
            if (Convert.ToInt32(ddlCollateralType.SelectedValue)<0) { args.IsValid = false; ErrorMessage += "<p> Choose a type of collateral </p>"; }
            if (Convert.ToInt32(ddlConfirmed.SelectedValue)<0) { args.IsValid = false; ErrorMessage += "<p> Choose an option for third party </p>"; }
            if (Decimal.TryParse(txtvalue.Value,out m) ){ args.IsValid = false; ErrorMessage += "<p> The value must be a decimal </p>"; }
            
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
