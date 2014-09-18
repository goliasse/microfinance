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

public partial class controls_invapplications_beneficiaries : System.Web.UI.UserControl
{
    public string type{ set; get; }
    public int id{ set; get; }

    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["bedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["bedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadPersonalInformation(id);
            }
        }
        else if (!(Request.QueryString["bdelete"] == null))
        {
            string id = Request.QueryString["bdelete"];
            util.deleteItem("tbl_beneficiary", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "bdelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        // fetch the en-GB culture
        CultureInfo ukCulture = new CultureInfo("en-GB");
        // pass the DateTimeFormat information to DateTime.Parse
        DateTime dt = DateTime.Parse(txtBirthdate.Value, ukCulture.DateTimeFormat);
        InvestmentDSTableAdapters.GetBeneficiariesTableAdapter ben_ = new  InvestmentDSTableAdapters.GetBeneficiariesTableAdapter();
        if (!(type == "update"))
        {
            ben_.InsertBeneficiaries(Convert.ToInt32(ddlTitle.SelectedValue),
                                     txtfirstname.Value.Trim(),
                                     txtmiddlename.Value.Trim(),
                                     txtsurname.Value.Trim(),
                                     dt,
                                     txtOccupation.Value,
                                     Convert.ToInt32(ddlNo1.SelectedValue),
                                     txtidNo1.Value,
                                     Convert.ToInt32(txtpercentageshare.Value.Trim()),
                                     txtHomeTel.Value.Trim(),
                                     txtOffTel.Value.Trim(),
                                     txtMobile.Value.Trim(),
                                     txtEmail.Value.Trim(),
                                     txtPostalAddress.Value.Trim(),
                                     txtResAddress.Value.Trim(),
                                     MySessionManager.ClientID,
                                     MySessionManager.InvAppID);
                                       
        }
        else if (type == "update")
        {
            ben_.UpdateBeneficiaries(Convert.ToInt32(ddlTitle.SelectedValue),
                                     txtfirstname.Value.Trim(),
                                     txtmiddlename.Value.Trim(),
                                     txtsurname.Value.Trim(),
                                     dt,
                                     txtOccupation.Value,
                                     txtidNo1.Value,
                                     Convert.ToInt32(ddlNo1.SelectedValue),
                                     Convert.ToInt32(txtpercentageshare.Value.Trim()),
                                     txtHomeTel.Value.Trim(),
                                     txtOffTel.Value.Trim(),
                                     txtMobile.Value.Trim(),
                                     txtEmail.Value.Trim(),
                                     txtPostalAddress.Value.Trim(),
                                     txtResAddress.Value.Trim(),
                                     id);
        }


        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "bedit"));
    }

    public void loadPersonalInformation(int id)
    {
        try
        {
            InvestmentDSTableAdapters.GetBeneficiariesTableAdapter Ben_ = new  InvestmentDSTableAdapters.GetBeneficiariesTableAdapter();
            InvestmentDS.GetBeneficiariesDataTable tblBen_ = Ben_.GetBeneficiariesDetail(id);

            if (tblBen_.Rows.Count > 0)
            {
                this.editskip.Value = "2";
                if (tblBen_[0].IsdatTitleNull() == false) { ddlTitle.SelectedValue = tblBen_[0].datTitle.ToString(); }
                if (tblBen_[0].IsdatFirstnameNull() == false) { txtfirstname.Value = tblBen_[0].datFirstname.ToString(); }
                if (tblBen_[0].IsdatSurnameNull() == false) { txtsurname.Value = tblBen_[0].datSurname.ToString(); }
                if (tblBen_[0].IsdatMiddleNameNull() == false) { txtmiddlename.Value = tblBen_[0].datMiddleName.ToString(); }
                if (tblBen_[0].IsdatIDTypeNull() == false) { ddlNo1.SelectedValue = tblBen_[0].datIDType.ToString();}
                if (tblBen_[0].IsdatIDValueNull() == false) { txtidNo1.Value = tblBen_[0].datIDValue.ToString(); }
                if (tblBen_[0].IsdatDateOfBirthNull() == false) { txtBirthdate.Value = Convert.ToDateTime(tblBen_[0].datDateOfBirth.ToString()).ToString("dd-MM-yyyy"); }
                if (tblBen_[0].IsdatMobileNumberNull() == false) { txtMobile.Value = tblBen_[0].datMobileNumber.ToString(); }
                if (tblBen_[0].IsdatEmailAddressNull() == false) { txtEmail.Value = tblBen_[0].datEmailAddress.ToString(); }
                if (tblBen_[0].IsdatPostalAddressNull() == false) { txtPostalAddress.Value = tblBen_[0].datPostalAddress.ToString(); }
                if (tblBen_[0].IsdatResidentialAddressNull() == false) { txtResAddress.Value = tblBen_[0].datResidentialAddress.ToString(); }
                if (tblBen_[0].IsdatTelephoneResNull() == false) { txtHomeTel.Value = tblBen_[0].datTelephoneRes.ToString(); }
                if (tblBen_[0].IsdatTelephoneOffNull() == false) { txtOffTel.Value = tblBen_[0].datTelephoneOff.ToString(); }
                if (tblBen_[0].IsdatPercentageShareNull() == false) { txtpercentageshare.Value = tblBen_[0].datPercentageShare.ToString(); }
                if (tblBen_[0].IsdatOccupationNull() == false) { txtOccupation.Value = tblBen_[0].datOccupation.ToString(); }
            }
        }
        catch(Exception ex)
        {

        }

    }
    protected void gvBeneficiaries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvBeneficiaries.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&bedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&bdelete=" + enpValue;
            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }
    }
}
