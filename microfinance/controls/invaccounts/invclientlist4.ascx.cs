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

public partial class controls_invaccounts_invclientlist4 : System.Web.UI.UserControl
{
    public string type { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }


    /// <summary>
    /// This function populates the gridview based on the query supplied
    /// </summary>
    /// <param name="sql">The query to executed for the population of the gridview</param>
    public void refreshData(string sql)
    {
        try
        {
            SqlDataSource1.SelectCommand = sql;
            gvClients.DataBind();
        }
        catch (Exception ex) { }

    }
    protected void SqlDataSource1_Selected1(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml = e.AffectedRows.ToString();
    }
}
