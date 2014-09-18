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

public partial class registration : System.Web.UI.Page
{
   string clientType="";
    protected void Page_Load(object sender, EventArgs e)
    {
        CompanyClient1.Visible = false;
        Enterprise1.Visible = false;
        IndividualClient10.Visible = false;

    }
    protected void rdbInvidual_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbInvidual.Checked == true)
        {
            clientType = "Individual";
            CompanyClient1.Visible=false;
            Enterprise1.Visible = false;
            IndividualClient10.Visible = true;
            
            //this.LoadTypeControl.Controls.Add();
            
                }
    }
    protected void rdbEntreprise_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbEntreprise.Checked == true)
        {
            clientType = "Entreprise";
            CompanyClient1.Visible = false;
            Enterprise1.Visible = true;
            IndividualClient10.Visible = false;

            //this.LoadTypeControl.Controls.Add();

        }
    }
    protected void rdbCompany_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbCompany.Checked == true)
        {
            clientType = "Company";
            CompanyClient1.Visible = true;
            Enterprise1.Visible = false;
            IndividualClient10.Visible = false;

            //this.LoadTypeControl.Controls.Add();

        }
    }
}
