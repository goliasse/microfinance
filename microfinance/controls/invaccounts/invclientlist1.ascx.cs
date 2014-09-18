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

public partial class controls_invapplications_invclientlist1 : System.Web.UI.UserControl
{
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

    protected void gvClients_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        mainDSTableAdapters.ClientTableAdapter client = new mainDSTableAdapters.ClientTableAdapter();

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
             int terms=0;
             InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter InvAcc = new InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter();
             InvestmentAccountDS.GetInvAccountDataTable tblInvAcc = InvAcc.GetInvAccount(Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex].Value));
             string enpValue = MyEncryption.Encrypt(this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString(), "12345678910");
             DateTime dt =DateTime.Parse(gvClients.DataKeys[e.Row.RowIndex]["datValueDate"].ToString());
             e.Row.Cells[0].Text = client.GetClientsName(Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex]["datClientID"].ToString())).ToString();
             e.Row.Cells[4].Text = util.displayValue("opt_investment_types", gvClients.DataKeys[e.Row.RowIndex]["datInvestmentType"].ToString());
             terms = Convert.ToInt32(util.displayValue("opt_terms", gvClients.DataKeys[e.Row.RowIndex]["datFrequencyOfInterestPayment"].ToString()));
             int freq = Convert.ToInt32(gvClients.DataKeys[e.Row.RowIndex]["datFrequencyOfInterestPayment"].ToString());
             Panel ItemBox = new Panel();
             ItemBox.Attributes.Add("id", "div" + this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString());
             ItemBox.Attributes.Add("id", "div" + this.gvClients.DataKeys[e.Row.RowIndex].Value.ToString());
             ItemBox.Attributes.Add("class", "ItemContainer");
             ItemBox.Style.Add("display", "none");
             string htmlContent = "<div class='col-md-9' style='padding-top:0'><label> Matured Interest(s) </label><br/>";
             if (tblInvAcc[0].dat30 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=30&val=" + tblInvAcc[0].dat30.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 30).ToString("dd/MM/yyyy") + "</a> <br/>";   
             }
             if (tblInvAcc[0].dat60 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=60&val=" + tblInvAcc[0].dat60.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 60).ToString("dd/MM/yyyy") + "</a> <br/>";
             }
             if (tblInvAcc[0].dat91 > 0 && freq == 2)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=91&val=" + tblInvAcc[0].dat91.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 90).ToString("dd/MM/yyyy") + "</a> <br/>";
             }
             if (tblInvAcc[0].dat121 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=121&val=" + tblInvAcc[0].dat121.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 121).ToString("dd/MM/yyyy") + "</a> <br/>";
             }
             if (tblInvAcc[0].dat151 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=151&val=" + tblInvAcc[0].dat151.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 151).ToString("dd/MM/yyyy") + "</a> <br/>";
             }
             if (tblInvAcc[0].dat182 > 0 && freq == 3)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=182&val=" + tblInvAcc[0].dat182.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 182).ToString("dd/MM/yyyy") + "</a> <br/>";
             }
             if (tblInvAcc[0].dat212 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=212&val=" + tblInvAcc[0].dat212.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 212).ToString("dd/MM/yyyy") + "  </a> <br/>";
             }
             if (tblInvAcc[0].dat242 > 0 && freq ==1)
             {
                 htmlContent += "<a href=../pages/invaccount/iinterestmaturity.aspx?id=" + enpValue + "&schID=242&val=" + tblInvAcc[0].dat242.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 242).ToString("dd/MM/yyyy") + "  </a> <br/>";
             }
             if (tblInvAcc[0].dat273 > 0 && freq == 2)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=273&val=" + tblInvAcc[0].dat273.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 273).ToString("dd/MM/yyyy") + "  </a> <br/>";
             }
             if (tblInvAcc[0].dat303 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=303&val=" + tblInvAcc[0].dat303.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 303).ToString("dd/MM/yyyy") + "  </a> <br/>";
             }
             if (tblInvAcc[0].dat333 > 0 && freq == 1)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=333&val=" + tblInvAcc[0].dat333.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 303).ToString("dd/MM/yyyy") + "  </a> <br/>";
             }
             if (tblInvAcc[0].dat364 > 0 && freq == 4)
             {
                 htmlContent += "<a href=../pages/invaccount/interestmaturity.aspx?id=" + enpValue + "&schID=364&val=" + tblInvAcc[0].dat364.ToString() + ">Int. Maturity for " + addDaysElapsed(dt, 364).ToString("dd/MM/yyyy") + "  </a> <br/>";
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
             
            //HyperLink clientProfile = (HyperLink)e.Row.FindControl("hyperClientProfile");
             //HyperLink Inv = (HyperLink)e.Row.FindControl("hyperInv");

        }
    }
    

    /// <summary>
    /// This functions add a number of days to a specified date and return that date
    /// </summary>
    /// <param name="date">The intial date</param>
    /// <param name="days">An Integer indicating the number of days to add</param>
    /// <returns>DateTime</returns> 
    public DateTime addDaysElapsed(DateTime date, int days)
    {
        DateTime dt=DateTime.Now;
        try
        {
            dt = date.AddDays(days);
        }
        catch (Exception ex) { }
        return dt;

    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noClients.InnerHtml = e.AffectedRows.ToString();
    }
}
