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
using System.Globalization;

public partial class controls_ownership : System.Web.UI.UserControl
{
    public string type{ set; get; }
    public int id{ set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        ListItem LItem = new ListItem("--Select--", "0");
        ddlNationality.Items.Insert(0, LItem);
        ddlShord.Items.Insert(0, LItem);
        
        if (!(Request.QueryString["oedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["oedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadownership(id);
            }
        }
        else if (!(Request.QueryString["odelete"] == null))
        {
            string id = Request.QueryString["odelete"];
            util.deleteItem("tbl_ownership", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "odelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            CultureInfo ukCulture = new CultureInfo("en-GB");
            DateTime _dt = DateTime.Parse(txtbirthdate.Text, ukCulture);
            DateTime _dt1 = DateTime.Parse(txtDateOfAppointment.Text, ukCulture);

            try
            {
                LoanDSTableAdapters.OwnersTableAdapter tblOwners = new LoanDSTableAdapters.OwnersTableAdapter();
                if (!(type == "update"))
                {
                    tblOwners.InsertOwner(MySessionManager.ClientID,
                                           MySessionManager.AppID,
                                           txtfullname.Value.Trim(),
                                           _dt,
                                           txtAge.Text,
                                           ddlNationality.Text,
                                           txtcountryres.Value,
                                           txtEducationalBackground.Value,
                                           _dt1.ToShortDateString(),
                                           Convert.ToInt32(ddlShord.Text),
                                           txtpercentage.Value.Trim(),
                                           MySessionManager.CurrentUser.UserID);
                }
                else if (type == "update")
                {

                    tblOwners.UpdateOwner(MySessionManager.ClientID,
                                          MySessionManager.AppID,
                                          txtfullname.Value.Trim(),
                                          _dt,
                                          txtAge.Text,
                                          ddlNationality.Text,
                                          txtcountryres.Value,
                                          txtEducationalBackground.Value,
                                          _dt1.ToShortDateString(),
                                          Convert.ToInt32(ddlShord.Text),
                                          txtpercentage.Value.Trim(),
                                          MySessionManager.CurrentUser.UserID,
                                          id);

                }

                Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "oedit"));

            }
            catch(Exception ex)
            { }
        }
    }



    protected void gvOwnership_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvOwnership.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&oedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&odelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }

    }

    public void loadownership(int id)
    {
        LoanDSTableAdapters.OwnersTableAdapter owners = new LoanDSTableAdapters.OwnersTableAdapter();
        LoanDS.OwnersDataTable tblowners = owners.GetOwnerDetails(id);

        if (tblowners.Rows.Count > 0)
        {
            txtAge.Text = tblowners[0].datAge.ToString();
            txtbirthdate.Text = tblowners[0].datDateOfBirth.ToString("dd-MM-yyyy");
            txtcountryres.Value = tblowners[0].datResidence.ToString();
            txtDateOfAppointment.Text = tblowners[0].datAppointment.ToString();
            txtEducationalBackground.Value = tblowners[0].datEducation.ToString();
            txtfullname.Value = tblowners[0].datFullName.ToString();
            txtpercentage.Value = tblowners[0].datPercentage.ToString();
            if(Convert.ToInt32(tblowners[0].datNationality)>0){ ddlNationality.SelectedValue = tblowners[0].datNationality.ToString();}
            if (tblowners[0].datSHORD > 0) { ddlShord.SelectedValue = tblowners[0].datSHORD.ToString(); }        
        }
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {
        CultureInfo ukCulture = new CultureInfo("en-GB");
        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            //Type type;
            decimal m;
            int k;
            DateTime dt;
            if (txtfullname.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the Shareholder or Owner </p>"; }
            if ((!(int.TryParse(txtAge.Text, out k)))&&(k<17)) { args.IsValid = false; ErrorMessage += "<p> The shareholder  must be at least 18 years old"; }         
            if (!(DateTime.TryParse(txtbirthdate.Text, ukCulture, DateTimeStyles.None, out dt))) { args.IsValid = false; ErrorMessage += "<p> The birthdate is not in the correct format</p>"; }
            if (!(DateTime.TryParse(txtDateOfAppointment.Text, ukCulture, DateTimeStyles.None, out dt))) { args.IsValid = false; ErrorMessage += "<p> The date of appointment is not in the correct format</p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
    protected void ddlNationality_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlNationality.SelectedItem.Text = "Ghana")
        //{   }
    }
}
