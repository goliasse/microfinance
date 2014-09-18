using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_clients_pendingloans : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            HyperLink logstatus = (HyperLink)e.Row.FindControl("showStatusLog");
            string enpValue = MyEncryption.Encrypt(this.GridView1.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");
            logstatus.NavigateUrl = "~/pages/clients/clienthome.aspx?loanAppid=" + enpValue;
            
        }
    }
}
