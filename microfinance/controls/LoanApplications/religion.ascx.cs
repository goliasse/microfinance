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

public partial class controls_religion : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(this.editskip.Value == "2"))
        {
             loadReligion();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.ReligionDetailsTableAdapter religionDetails = new LoanDSTableAdapters.ReligionDetailsTableAdapter();
            int ID = getReligionID();
            if (ID > 0)
            {

                religionDetails.UpdateReligionDetails(Convert.ToInt32(ddlReligion.SelectedValue),
                                                     txtPlaceOfWorship.Value.Trim(),
                                                     txtNameOfLeader.Value.Trim(),
                                                     txtTel.Value.Trim(),
                                                     txtPhysicalAddress.Value.Trim(),
                                                     MySessionManager.AppID,
                                                     MySessionManager.ClientID
                                                     );
                this.editskip.Value = "1";



            }
            else
            {
                religionDetails.InsertReligionDetails(MySessionManager.AppID,
                                                       MySessionManager.ClientID,
                                                       Convert.ToInt32(ddlReligion.SelectedValue),
                                                       txtPlaceOfWorship.Value.Trim(),
                                                       txtNameOfLeader.Value.Trim(),
                                                       txtTel.Value.Trim(),
                                                       txtPhysicalAddress.Value.Trim());
                this.editskip.Value = "1";
            }
        }
    }
    public  int getReligionID()
    {
        int ID;
        LoanDSTableAdapters.ReligionDetailsTableAdapter religionDetails = new LoanDSTableAdapters.ReligionDetailsTableAdapter();
        LoanDS.ReligionDetailsDataTable tblReligionDetails = religionDetails.GetReligionDetails(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblReligionDetails.Rows.Count > 0)
            ID = int.Parse(tblReligionDetails[0].datID.ToString());
        else
            ID = 0;

        return ID; 
    }
    public void loadReligion()
    {

        LoanDSTableAdapters.ReligionDetailsTableAdapter religionDetails = new LoanDSTableAdapters.ReligionDetailsTableAdapter();
        LoanDS.ReligionDetailsDataTable tblReligionDetails = religionDetails .GetReligionDetails (MySessionManager .AppID, MySessionManager .ClientID);

        if (tblReligionDetails.Rows.Count > 0)
        {
            try
            {
                txtNameOfLeader.Value = tblReligionDetails[0].datLeader.ToString();
                txtPhysicalAddress.Value = tblReligionDetails[0].datPhysicalAddress.ToString();
                txtTel.Value = tblReligionDetails[0].datTelephoneNumber.ToString();

                if(tblReligionDetails[0].datReligionID>0){ddlReligion.SelectedValue = tblReligionDetails[0].datReligionID.ToString();}
                txtPlaceOfWorship .Value = tblReligionDetails[0].datPlaceOfWorship.ToString();
                this.editskip.Value = "2";
            }
            catch
            {} 
        }
    }

    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            Type type;
            decimal m;
            int k;
            DateTime dt;
            if (txtPlaceOfWorship.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the place of worship </p>"; }
            if (txtNameOfLeader.Value == "") { args.IsValid = false; ErrorMessage += "<p> Provide the name of the leader </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
