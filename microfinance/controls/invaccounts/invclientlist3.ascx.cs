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

public partial class controls_invaccounts_invclientlist3 : System.Web.UI.UserControl
{
    mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            SqlDataSource1.SelectParameters["branch"].DefaultValue = MySessionManager.CurrentUser.BranchID.ToString();
            gvClients.DataBind();
        }
        catch (Exception ex) { }
    }

    /// <summary>
    /// The Interest rate maturity list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvClients_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try 
        {
            InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter Hist = new InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter();
            InvestmentAccountDS.GetHistoricAccountDataTable tblHist = Hist.GetHistoricAccount(Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex].Value),1);
            string enpValue = MyEncryption.Encrypt(this.gvClients.DataKeys[e.Row.RowIndex]["datAccountID"].ToString(), "12345678910");
            DateTime dt = DateTime.Parse(gvClients.DataKeys[e.Row.RowIndex]["datValueDate"].ToString());
            e.Row.Cells[0].Text = client.GetClientsName(Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex]["datClientID"].ToString())).ToString();
            e.Row.Cells[4].Text = util.displayValue("opt_investment_types", gvClients.DataKeys[e.Row.RowIndex]["datInvestmentType"].ToString());
            int freq = Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex]["datFrequencyOfInterestPayment"].ToString());
            Panel ItemBox = new Panel();
            ItemBox.Attributes.Add("id", "div" + this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString());
            ItemBox.Attributes.Add("id", "div" + this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString());
            ItemBox.Attributes.Add("class", "ItemContainer");
            ItemBox.Style.Add("display", "none");
            string htmlContent = "<div class='col-md-9' style='padding-top:0'><label> Matured Interest(s) </label><br/>";

            if (tblHist[0].dat30 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=30&val=" + tblHist[0].dat30.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 30).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat60 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=60&val=" + tblHist[0].dat60.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 60).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat91 > 0 && freq == 2)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=91&val=" + tblHist[0].dat91.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 90).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat121 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=121&val=" + tblHist[0].dat121.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 121).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat151 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=151&val=" + tblHist[0].dat151.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 151).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat182 > 0 && freq == 3)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=181&val=" + tblHist[0].dat182.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 182).ToString("dd/MM/yyyy") + "</a> <br/>";
            }
            if (tblHist[0].dat212 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=212&val=" + tblHist[0].dat212.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 212).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            if (tblHist[0].dat242 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=242&val=" + tblHist[0].dat242.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 242).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            if (tblHist[0].dat273 > 0 && freq == 2)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=273&val=" + tblHist[0].dat273.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 273).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            if (tblHist[0].dat303 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=303&val=" + tblHist[0].dat303.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 303).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            if (tblHist[0].dat333 > 0 && freq == 1)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=333&val=" + tblHist[0].dat333.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 303).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            if (tblHist[0].dat364 > 0 && freq == 4)
            {
                htmlContent += "<a href=../pages/invaccount/matured.aspx?id=" + enpValue + "&action=int&schID=364&val=" + tblHist[0].dat364.ToString() + ">Int. Maturity for " + util.addDaysElapsed(dt, 364).ToString("dd/MM/yyyy") + "  </a> <br/>";
            }
            htmlContent += "</div>";

            Literal ItemContent = new Literal();
            ItemContent.Text = htmlContent;
            ItemBox.Controls.Add(ItemContent);

            HyperLink hyp = new HyperLink();
            hyp.NavigateUrl = "javascript:showinfo('div" + this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString() + "')";
            hyp.Text = e.Row.Cells[0].Text;
            e.Row.Cells[0].Controls.Add(hyp);
            e.Row.Cells[0].Controls.Add(ItemBox);
        }
        catch (Exception ex) { }
    }

    /// <summary>
    /// The Investment Maturity list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvInvClients_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    /// <summary>
    /// The roll over maturity list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvRollClients_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}
