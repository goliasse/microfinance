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

public partial class controls_LoanAccounts_ctStatement : System.Web.UI.UserControl
{
    decimal total;
    protected void Page_Load(object sender, EventArgs e)
    {
        total = 0;
        this.todaysDate.InnerText = DateTime.Now.ToLongDateString();
    }
    protected void gvStatement_RowDataBound(object sender, GridViewRowEventArgs e)
    {  
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = (e.Row.RowIndex+1).ToString();
            try
            {
                if (Convert.ToDecimal(e.Row.Cells[3].Text) > 0)
                {
                    total = total - Convert.ToDecimal(e.Row.Cells[3].Text);

                }
                else if (Convert.ToDecimal(e.Row.Cells[3].Text) < 0)
                { 
                    total = total - (-1 * (Convert.ToDecimal(e.Row.Cells[3].Text)));
                    e.Row.Cells[3].Text = (-1 * (Convert.ToDecimal(e.Row.Cells[3].Text))).ToString();
                }
                else { e.Row.Cells[3].Text = ""; }
            }
            catch (Exception ex) { e.Row.Cells[3].Text = ""; }
            try
            {

                if (Convert.ToDecimal(e.Row.Cells[4].Text) > 0)
                {
                    e.Row.Cells[4].Text= e.Row.Cells[4].Text.ToString();
                    total = total + Convert.ToDecimal(e.Row.Cells[4].Text);
                }
                else { e.Row.Cells[4].Text = ""; }
            }
            catch (Exception ex)
            {
                e.Row.Cells[4].Text = ""; 
            }

            e.Row.Cells[5].Text = total.ToString("C").Replace("$","");

        }
    }
    //protected void btnPrintRpt_Click(object sender, EventArgs e)
    //{

    //}
    //protected void btnClose_Click(object sender, EventArgs e)
    //{

    //}
  
}
