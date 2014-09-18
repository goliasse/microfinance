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

public partial class controls_applicationtrails : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvApplication_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string enpValue = MyEncryption.Encrypt(this.gvApplication.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");

            HyperLink link = (HyperLink)e.Row.FindControl("HyperTrail");

            link.NavigateUrl = "~/pages/applicationtracker.aspx?id=" + enpValue;
        }
        
    }
}
