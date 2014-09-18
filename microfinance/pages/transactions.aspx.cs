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

public partial class pages_transactions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["action"] == "entry")
        {
         this.clientTransactionsEntry1.Visible =false;
         this.mainTransactions1.Visible = true;      
        }
        else 
        {
            this.mainTransactions1.Visible = false;
            this.clientTransactionsEntry1.Visible = true;
        
        }
    }
}
