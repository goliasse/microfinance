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

public partial class controls_assets : System.Web.UI.UserControl
{
    public string type
    { set; get; }
    public int id
    { set; get; }

    Utility util = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Request.QueryString["ledit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["ledit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadLegders(id);
            }
        }
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int clientstatement=0;
        int fee=0;
        int interest=0;
        int visible=0;

        if (chkInterestApplied.Checked == true)
        {interest=1;}
        if (chkClientStatement.Checked == true)
        {clientstatement=1;}
        if (chkVisible.Checked == true)
        { visible = 1; }
        if (chkFees.Checked == true)
        { fee  = 1; }
        try
        {
            adminTableAdapters.LegdersTableAdapter ledger = new adminTableAdapters.LegdersTableAdapter();
            if (!(type == "update"))
            {
                ledger.InsertLedgers(txtDescription.Value,
                                     txtcode.Value,
                                     Convert.ToInt32(ddlCategory.SelectedValue),
                                     interest,
                                     Convert.ToInt32(ddlProduct.SelectedValue),
                                     fee,
                                     visible,
                                     clientstatement);
            }
            else if (type == "update")
            {
                ledger.UpdateLedger(txtDescription.Value,
                                     txtcode.Value,
                                     Convert.ToInt32(ddlCategory.SelectedValue),
                                     interest,
                                     Convert.ToInt32(ddlProduct.SelectedValue),
                                     fee,
                                     visible,
                                     clientstatement,
                                     id);
            }
        }
        catch (Exception ex) { }
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ledit"));
    }

    public void loadLegders(int id)
    {
        try
        {
            adminTableAdapters.LegdersTableAdapter ledger = new adminTableAdapters.LegdersTableAdapter();
            admin.LegdersDataTable tblLedger = ledger.GetLedger(id);
            if (tblLedger.Rows.Count > 0)
            {
                txtDescription.Value = tblLedger[0].datDescription.ToString();
                txtcode.Value = tblLedger[0].datLedgerCode.ToString();
                if (tblLedger[0].IsdatCategoryNull() == false)
                { ddlCategory.SelectedValue = tblLedger[0].datCategory.ToString(); }
                if (tblLedger[0].IsdatProductNull() == false)
                { ddlProduct.SelectedValue = tblLedger[0].datProduct.ToString(); }
                if (tblLedger[0].IsdatProductNull() == false)
                { ddlCategory.SelectedValue = tblLedger[0].datProduct.ToString(); }
                if (tblLedger[0].IsdatInterestNull() == false && tblLedger[0].datInterest > 0)
                { chkInterestApplied.Checked = true; }
                if (tblLedger[0].IsdatFeeNull() == false && tblLedger[0].datFee > 0)
                { chkFees.Checked = true; }
                if (tblLedger[0].IsdatVisibleNull() == false && tblLedger[0].datVisible > 0)
                { chkVisible.Checked = true; }
                if (tblLedger[0].IsdatClientStatementNull() == false && tblLedger[0].datClientStatement > 0)
                { chkClientStatement.Checked = true; }
            }

        }
        catch (Exception ex) { }
        }

    protected void gvLedger_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                int interest = Convert.ToInt32(e.Row.Cells[4].Text);
                if (interest > 0)
                {e.Row.Cells[4].Text = "<i class='glyphicon glyphicon-eye-open' ><i>";}
                else { e.Row.Cells[4].Text = "<i class='glyphicon glyphicon-eye-close' ><i>"; }

                int clientstatement = Convert.ToInt32(e.Row.Cells[5].Text);
                if (clientstatement == 6 || clientstatement == 1)
                { e.Row.Cells[5].Text = "<i class='glyphicon glyphicon-eye-open' ><i>"; }
                else { e.Row.Cells[5].Text = "<i class='glyphicon glyphicon-eye-close' ><i>"; }

                int fee = Convert.ToInt32(e.Row.Cells[6].Text);
                if (fee >0)
                { e.Row.Cells[6].Text = "<i class='glyphicon glyphicon-eye-open' ><i>"; }
                else { e.Row.Cells[6].Text = "<i class='glyphicon glyphicon-eye-close' ><i>"; }

                int visible = Convert.ToInt32(e.Row.Cells[7].Text);
                if (visible > 0)
                { e.Row.Cells[7].Text = "<i class='glyphicon glyphicon-eye-open' ><i>"; }
                else { e.Row.Cells[7].Text = "<i class='glyphicon glyphicon-eye-close' ><i>"; }
            
            }
            catch (Exception ex) { }

            //HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvLedger.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "?ledit=" + enpValue;
            // string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&asdelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            // delete.NavigateUrl = urlpathDel;
        }
    }
}
