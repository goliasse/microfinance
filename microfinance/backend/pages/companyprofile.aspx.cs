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

public partial class backend_pages_companyprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack == false)
        {
            loadCompany();
        
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        try 
        {
            string fileName = fuLogo.PostedFile.FileName;

            int fileLength = fuLogo.PostedFile.ContentLength;

            byte[] imageBytes = new byte[fileLength];

            fuLogo.PostedFile.InputStream.Read(imageBytes, 0, fileLength);
       
        mainDSTableAdapters.SetupDetailsTableAdapter company = new mainDSTableAdapters.SetupDetailsTableAdapter();
        mainDS.SetupDetailsDataTable tblCompany = company.GetSetupDetails(1);
            if(tblCompany.Rows.Count>0)
            {
                company.UpdateSetupDetails(txtCompany.Value,
                                           txtpostalAddress.Value,
                                           txtEmail.Value,
                                           txtTelNo.Value,
                                           txtlocation.Value,
                                           txtWebsite.Value,
                                           imageBytes,
                                           1);
            
            }
            else
            {
                company.InsertSetupDetails(txtCompany.Value,
                                           txtpostalAddress.Value,
                                           txtEmail.Value,
                                           txtTelNo.Value,
                                           txtlocation.Value,
                                           txtWebsite.Value,
                                           imageBytes);
            }

        }
        catch (Exception ex) { }

    }
    public void loadCompany()
    {
        mainDSTableAdapters.SetupDetailsTableAdapter company = new mainDSTableAdapters.SetupDetailsTableAdapter();
        mainDS.SetupDetailsDataTable tblCompany = company.GetSetupDetails(1);
        try
        {
            if (tblCompany.Rows.Count > 0) 
            {
                txtCompany.Value = tblCompany[0].datCompanyname.ToString();
                txtEmail.Value = tblCompany[0].datEmail.ToString();
                txtlocation.Value = tblCompany[0].datLocation.ToString();
                txtpostalAddress.Value = tblCompany[0].datAddresss.ToString();
                txtTelNo.Value = tblCompany[0].datTelephoneNumber.ToString();
                txtWebsite.Value = tblCompany[0].datWebsite.ToString();
               // picLogo.ImageUrl=
            }
        }
        catch (Exception ex) { }
    }
}
