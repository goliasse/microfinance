using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class controls_Finance_FinJournal : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["action"] != null)
        {
            if (Request.QueryString["action"] == "deleteItem")
            {
                try
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter tempTran = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
                    tempTran.DeleteTempTransactionEntry(id);
                    Response.Redirect("~/pages/finance/finhome.aspx?panel=Journal&action=" + System.Guid.NewGuid().ToString());
                }
                catch (Exception ex) { }
                loadAccItems();
                VchPanel.Visible = true;
                VchTypeSelPanel.Visible = false;
            }
            else if (Request.QueryString["action"] == "addItem")
            {
                VchTypeSelPanel.Visible = false;
            }
        }

        else
        {
            VchPanel.Visible = false;
            VchTypeSelPanel.Visible = true;
            if (IsPostBack == false)
            {
                MySessionManager.TempTranKey = System.Guid.NewGuid().ToString();
            }
        }

    }

    

    protected void gvTranEntries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        LinkButton link = (LinkButton)e.Row.FindControl("LinkDelete");
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            link.CommandArgument = gvTranEntries.DataKeys[e.Row.RowIndex].Value.ToString();
        }
    }

    protected void btnOpenVoucher_Click(object sender, EventArgs e)
    {
        if (ddlVoucherType.Items.Count > 0)
        {
            VchPanel.Visible = true;
            MySessionManager.VchTypeName = ddlVoucherType.SelectedValue.ToString();
            subVchName.Text = " - " + MySessionManager.VchTypeName;
            loadAccItems();
            VchTypeSelPanel.Visible = false;
        }
    }
    private void loadAccItems()
    {
        FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vchTypes = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();
        FinancialDS.tbl_VoucherTypesDataTable vtypes = vchTypes.GetVoucherTypeByName(MySessionManager.VchTypeName);

        if (vtypes.Count > 0)
        {
            txtNarration.Value = vtypes[0].datDefaultNarration;
            MySessionManager.CreditAccountListID = Convert.ToInt32(vtypes[0].datCreditAccountTypes);
            MySessionManager.DebitAccountListID = Convert.ToInt32(vtypes[0].datDebitAccountTypes);
            if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 1)
            {
                ddlDebitAccountList.DataSourceID = "InvestmentAccountsList";
                ddlDebitAccountList.DataTextField = "datClientName";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 2)
            {
                ddlDebitAccountList.DataSourceID = "LoanAccountsList";
                ddlDebitAccountList.DataTextField = "datClientName";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 3)
            {
                ddlDebitAccountList.DataSourceID = "SysLedgersList";
                ddlDebitAccountList.DataTextField = "datDescription";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
            }

            if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 1)
            {
                ddlCreditAccountList.DataSourceID = "InvestmentAccountsList";
                ddlCreditAccountList.DataTextField = "datClientName";
                ddlCreditAccountList.DataValueField = "datID";
                ddlCreditAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 2)
            {
                ddlCreditAccountList.DataSourceID = "LoanAccountsList";
                ddlCreditAccountList.DataTextField = "datClientName";
                ddlCreditAccountList.DataValueField = "datID";
                ddlCreditAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 3)
            {
                ddlCreditAccountList.DataSourceID = "SysLedgersList";
                ddlCreditAccountList.DataTextField = "datDescription";
                ddlCreditAccountList.DataValueField = "datID";
                ddlCreditAccountList.DataBind();
            }
        }
    }



    protected void deleteItem_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton link = (LinkButton)sender;

            int id = Convert.ToInt32(link.CommandArgument);
            FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter tempTran = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
            tempTran.DeleteTempTransactionEntry(id);
            gvTranEntries.DataBind();
            FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter getTotal = new FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter();
            FinancialDS.GetTempEntriesTotalsDataTable totEntries = getTotal.GetData(MySessionManager.TempTranKey);

            lblDebitTotal.Text = Convert.ToString(totEntries[0].TotalDebit);
            lblCreditTotal.Text = Convert.ToString(totEntries[0].TotalCredit);
        }
        catch (Exception ex) { }
        loadAccItems();
        VchPanel.Visible = true;
        VchTypeSelPanel.Visible = false;
    }



    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        if (insertVoucher())
        {
            VchPanel.Visible = true;
            MySessionManager.VchTypeName = ddlVoucherType.SelectedValue.ToString();
            subVchName.Text = " - " + MySessionManager.VchTypeName;
            loadAccItems();
            VchTypeSelPanel.Visible = false;
            MySessionManager.TempTranKey = System.Guid.NewGuid().ToString();
            txtNarration.Value = "";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMsg", "alert('Voucher Successfully Inserted')", true);
        }
        else {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMsg", "alert('Enable to pass Voucher')", true);
        }
    }




    private bool insertVoucher()
    {
        FinancialDSTableAdapters.InsertVoucherTableAdapter vch = new FinancialDSTableAdapters.InsertVoucherTableAdapter();
        FinancialDSTableAdapters.tbl_Ledger_EntriesTableAdapter led = new FinancialDSTableAdapters.tbl_Ledger_EntriesTableAdapter();
        FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter temp = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
        FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vType = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();


        FinancialDS.tempTransaction_EntriesDataTable entries = temp.GetTempTransactionsByEntryKey(MySessionManager.TempTranKey);
        FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter getTotal = new FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter();
        FinancialDS.GetTempEntriesTotalsDataTable totEntries = getTotal.GetData(MySessionManager.TempTranKey);
        if (entries.Count > 0 & totEntries[0].TotalDebit == totEntries[0].TotalCredit)
        {
            DateTime vchDate = DateTime.Now;
            try
            {
                CultureInfo ukCulture = new CultureInfo("en-GB");
                vchDate = DateTime.Parse(txtDate.Text, ukCulture);
            }
            catch (Exception ex) { }
            string VchType = MySessionManager.VchTypeName;
            string vchNarration = txtNarration.Value;
            string vchNumber = "";
            int vchIsPostDated = 0;
            int vchIsOptional = 0;
            FinancialDS.tbl_VoucherTypesDataTable vtypes = vType.GetVoucherTypeByName(VchType);
            if (vtypes.Count > 0)
            {
                try
                {
                    vchNumber = vtypes[0].datPrefix + " " + vtypes[0].datSuffix;
                    int newid = Convert.ToInt32(vch.InsertVoucher(vchDate, VchType, vchNumber, vchNarration, vchIsPostDated, vchIsOptional, 0, DateTime.Now, DateTime.Now, Convert.ToInt32(MySessionManager.CurrentUser.UserID), 0)[0].vchNewID);
                    foreach (FinancialDS.tempTransaction_EntriesRow entry in entries)
                    {
                        led.InsertLedgerEntry(entry.datAccountType, entry.datAccountID, Convert.ToDecimal(entry.datAmount),entry.datIsCredit, newid, "On Account",0, "", "", "", "", "", "", "", "", "");
                    }
                    return true;
                }
                catch (Exception ex) { return false; }
            }
            else { return false; }

        }
        else { return false; }



    }
    protected void btnAddDebitEntry_Click(object sender, EventArgs e)
    {
        try
        {
            int accid = Convert.ToInt32(ddlDebitAccountList.SelectedValue);
            string accname = Convert.ToString(ddlDebitAccountList.SelectedItem.Text);
            Decimal amount = Convert.ToDecimal(txtDebitAmount.Text);
            String tempKey = MySessionManager.TempTranKey;

            FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vchTypes = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();
            FinancialDS.tbl_VoucherTypesDataTable vtypes = vchTypes.GetVoucherTypeByName(MySessionManager.VchTypeName);

            if (vtypes.Count > 0)
            {
                FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter tempTran = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
                tempTran.InsertTempTransaction(tempKey, accid, accname, MySessionManager.DebitAccountListID, amount , 0,amount, 0, 0, "", DateTime.Now, "", "", "", "", "", "", "", "");
                gvTranEntries.DataBind();
                FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter getTotal = new FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter();
                FinancialDS.GetTempEntriesTotalsDataTable totEntries = getTotal.GetData(tempKey);

                lblDebitTotal.Text = Convert.ToString(totEntries[0].TotalDebit);
                lblCreditTotal.Text = Convert.ToString(totEntries[0].TotalCredit);

            }

        }
        catch (Exception ex) { }
        VchPanel.Visible = true;
        VchTypeSelPanel.Visible = false;
        txtDebitAmount.Text = "";
    }
    protected void btnAddCreditEntry_Click(object sender, EventArgs e)
    {
        try
        {
            int accid = Convert.ToInt32(ddlCreditAccountList.SelectedValue);
            string accname = Convert.ToString(ddlCreditAccountList.SelectedItem.Text);
            Decimal amount = Convert.ToDecimal(txtCreditAmount.Text);
            String tempKey = MySessionManager.TempTranKey;

            FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vchTypes = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();
            FinancialDS.tbl_VoucherTypesDataTable vtypes = vchTypes.GetVoucherTypeByName(MySessionManager.VchTypeName);

            if (vtypes.Count > 0)
            {
                FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter tempTran = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
                tempTran.InsertTempTransaction(tempKey, accid, accname, MySessionManager.DebitAccountListID, 0,amount ,amount, 1, 0, "", DateTime.Now, "", "", "", "", "", "", "", "");
                gvTranEntries.DataBind();
                FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter getTotal = new FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter();
                FinancialDS.GetTempEntriesTotalsDataTable totEntries = getTotal.GetData(tempKey);

                lblDebitTotal.Text = Convert.ToString(totEntries[0].TotalDebit);
                lblCreditTotal.Text = Convert.ToString(totEntries[0].TotalCredit);

            }

        }
        catch (Exception ex) { }
        
        VchPanel.Visible = true;
        VchTypeSelPanel.Visible = false;
        txtCreditAmount.Text = "";
    }
}
