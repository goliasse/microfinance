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
using System.Globalization;

public partial class pages_postdatedcheque : System.Web.UI.Page
{
    public int id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null)
        {
            try
            {
                 id = Convert.ToInt32(Request.QueryString["ID"]);
                if (id < 0)
                {
                    this.pdcList.Visible = true;
                    this.editPDC.Visible = false;
                }
                else
                {
                    if (Request.QueryString["type"] == "change")
                    {
                        if (this.editskip.Value != "2") { loadPDC(id); }
                        this.pdcList.Visible = false;
                        this.editPDC.Visible = true;
                    }
                    else 
                    {
                        if (clearCheque(id) == true)
                        {
                            this.pdcList.Visible = true;
                            this.editPDC.Visible = false;
                        }
                        else
                        {
                            this.pdcList.Visible = true;
                            this.editPDC.Visible = false;
                        }
                    }
                }
            }
            catch (Exception ex) { }
        }
        else { 
                this.editPDC.Visible = false;
                this.pdcContainer.Visible = true;
                }
        
        try
        {
            DateTime dt = DateTime.Now.GetFirstDayOfWeek();
            DateTime Enddt = DateTime.Now.GetLastDayOfWeek();

            SqlDataSource1.SelectParameters["startDate"].DefaultValue = dt.ToShortDateString();
            SqlDataSource1.SelectParameters["endDate"].DefaultValue = Enddt.ToShortDateString();
            SqlDataSource1.SelectParameters["branch"].DefaultValue = "1";
            gvPDC.DataBind();
        }
        catch (Exception ex) { }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            // fetch the en-GB culture
            CultureInfo ukCulture = new CultureInfo("en-GB");
            // pass the DateTimeFormat information to DateTime.Parse
            DateTime dt = DateTime.Parse(txtfromDate.Text, ukCulture.DateTimeFormat);
            DateTime Enddt = DateTime.Parse(txtToDate.Text, ukCulture.DateTimeFormat);

            //DateTime dt = DateTime.Parse(txtfromDate.Text);
            //DateTime Enddt = DateTime.Parse(txtToDate.Text);

            SqlDataSource1.SelectParameters["startDate"].DefaultValue = dt.ToShortDateString();
            SqlDataSource1.SelectParameters["endDate"].DefaultValue = Enddt.ToShortDateString();
            SqlDataSource1.SelectParameters["branch"].DefaultValue = "1";
            gvPDC.DataBind();
        }
        catch (Exception ex) { ShowMessageBox(ex.Message); }
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.noCheques.InnerHtml = e.AffectedRows.ToString();
    }

    protected void ShowMessageBox(string message)
    {
        string sJavaScript = "<script language=javascript>\n";
        sJavaScript += "alert('" + message + "');\n";
        sJavaScript += "</script>";
        this.Page.RegisterStartupScript("MessageBox", sJavaScript);
    }
    protected void gvPDC_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int c_status = Convert.ToInt32(e.Row.Cells[5].Text);

            if (c_status == 1) { e.Row.Cells[5].Text = "Cleared"; } else if (c_status == 2) { e.Row.Cells[5].Text = "Return To Drawer"; } else if (c_status == 0) { e.Row.Cells[5].Text = "Not Cleared"; }
            HyperLink clear = (HyperLink)e.Row.FindControl("hyperClear");
            HyperLink change = (HyperLink)e.Row.FindControl("hyperChange");
            HyperLink rd = (HyperLink)e.Row.FindControl("hyperRD");

            string enpValue = this.gvPDC.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?id=" + enpValue+"&type=change";
            string urlpath1 = HttpContext.Current.Request.Url.AbsoluteUri + "?id=" + enpValue + "&type=rd";

            string urlpathDel = "javascript:clearPDC(" + enpValue + ")"; //HttpContext.Current.Request.Url.AbsoluteUri + "&id=" + enpValue + "&type=clear";
            rd.NavigateUrl = urlpath1;
            change.NavigateUrl = urlpath;
            clear.NavigateUrl = urlpathDel;

        }
    }
    public void loadPDC(int id)
    {
        LoanDSTableAdapters.PDCTableAdapter pdc = new LoanDSTableAdapters.PDCTableAdapter();
        LoanDS.PDCDataTable tblPDC = pdc.GetPDCDetails(id);

        if (tblPDC.Rows.Count > 0)
        {

            txtAmt.Value = tblPDC[0].datAmount.ToString();
            txtchequeno.Value = tblPDC[0].datCheque.ToString();
            txtBank.Value = tblPDC[0].datBank.ToString();
            txtDate.Text = tblPDC[0].datDate.ToString("dd-MM-yyyy");
            this.editskip.Value = "2";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        LoanDSTableAdapters.PDCTableAdapter pdc = new LoanDSTableAdapters.PDCTableAdapter();
        CultureInfo ukCulture = new CultureInfo("en-GB");
        // pass the DateTimeFormat information to DateTime.Parse
        DateTime dt = DateTime.Parse(txtDate.Text, ukCulture.DateTimeFormat);

        pdc.UpdatePDC1(txtBank.Value.Trim(),
                      dt,
                      txtchequeno.Value.Trim(),
                      Convert.ToDecimal(txtAmt.Value.Trim()),
                      1,
                      id);
        
    }
    public bool clearCheque(int id) 
    {
        bool cleared = false;
        try 
        {
            LoanDSTableAdapters.PDCTableAdapter pdc = new LoanDSTableAdapters.PDCTableAdapter();
            pdc.UpdateClearedCheque(1, id);
            ShowMessageBox("Cheque has been cleared successfully");
            cleared = true;
        }
        catch (Exception ex) { ShowMessageBox("Error!! Cheque was  not cleared"); }


        return cleared;
    }
}

