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

public partial class pages_applicationtracker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"]==null)
        {
            this.applicationtrails1.Visible = true;
            this.applicationtrail1.Visible = false;
        }
        else 
        {
            if (Request.QueryString["id"].Length > 0)
            {
                this.applicationtrail1.Visible = true;
                this.applicationtrails1.Visible = false;
                string EncID = Request.QueryString["id"];
                int DecID = Convert.ToInt32(MyEncryption.Decrypt(EncID, "12345678910"));
                MySessionManager.AppID = DecID;
            }
        }
    }
}
