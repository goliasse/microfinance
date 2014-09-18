using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;


public partial class controls_Finance_FinPayment : System.Web.UI.UserControl
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
                    Response.Redirect("~/pages/finance/finhome.aspx?panel=Payment&action=" + System.Guid.NewGuid().ToString());
                }
                catch (Exception ex) { }
                loadAccItems();
                transactionsPanel.Visible = true;
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
            transactionsPanel.Visible = false;
            VchPanel.Visible = false;
            VchTypeSelPanel.Visible = true;
            if (IsPostBack == false)
            {
                MySessionManager.TempTranKey = System.Guid.NewGuid().ToString();
            }
        }

    }

    protected void btnOpenAccount_Click(object sender, EventArgs e)
    {
        if (ListofCreditAccounts.Items.Count > 0) {
            int accid = Convert.ToInt32(ListofCreditAccounts.SelectedValue);
            FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vchTypes = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();
            FinancialDS.tbl_VoucherTypesDataTable vtypes = vchTypes.GetVoucherTypeByName(MySessionManager.VchTypeName);
            if (vtypes.Count > 0)
            {
                if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 1)
                {
                    InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter invAcc = new InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter();
                    InvestmentAccountDS.GetInvAccountDataTable invAccData = invAcc.GetInvAccount(accid);
                    if (invAccData.Count > 0)
                    {
                        lblInvestmentName.InnerText = invAccData[0].datInvestmentName;
                        lblapplicantName.InnerText = ListofCreditAccounts.SelectedItem.Text;
                        lblInvestmentAmount.InnerText = Convert.ToString(invAccData[0].datInvestmentAmount);

                    }

                }
                else if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 2)
                {
                    LoanAccountDSTableAdapters.GetLoanAccountTableAdapter lacc = new LoanAccountDSTableAdapters.GetLoanAccountTableAdapter();
                    LoanAccountDS.GetLoanAccountDataTable ltbl = lacc.GetLoanAccount(accid);
                    if (ltbl.Count > 0) {
                        lblInvestmentName.InnerText = ltbl[0].datClientFullName ;
                        lblapplicantName.InnerText = ListofCreditAccounts.SelectedItem.Text;
                        lblInvestmentAmount.InnerText = Convert.ToString(ltbl[0].datInitialAmount);
                    }
                }
            }

            transactionsPanel.Visible = true;
            VchPanel.Visible = true;
            VchTypeSelPanel.Visible = false;
            MySessionManager.TempTranKey = System.Guid.NewGuid().ToString();
            lblTotal.Text = "";
        }
        
    }

    protected void btnAddEntry_Click(object sender, EventArgs e)
    {
        try
        {
            int accid = Convert.ToInt32(ddlDebitAccountList.SelectedValue);
            string accname = Convert.ToString(ddlDebitAccountList.SelectedItem.Text);
            int paymenttype = Convert.ToInt32(ddlPaymentType.SelectedValue);
            string paymentmodename = Convert.ToString(ddlPaymentType.SelectedItem.Text);
            Decimal amount = Convert.ToDecimal(txtAmount.Text);
            String tempKey = MySessionManager.TempTranKey;

            FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vchTypes = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();
            FinancialDS.tbl_VoucherTypesDataTable vtypes = vchTypes.GetVoucherTypeByName(MySessionManager.VchTypeName);

            if (vtypes.Count > 0)
            {
                FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter tempTran = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
                tempTran.InsertTempTransaction(tempKey, accid, accname, MySessionManager.DebitAccountListID, 0, 0, amount, 0, paymenttype, paymentmodename, DateTime.Now,"","","","","","","","");
                gvTranEntries.DataBind();
                FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter getTotal = new FinancialDSTableAdapters.GetTempEntriesTotalsTableAdapter();
                FinancialDS.GetTempEntriesTotalsDataTable totEntries = getTotal.GetData(tempKey);

                lblTotal.Text = Convert.ToString(totEntries[0].TotalAmount);

            }

        }
        catch (Exception ex) { }
        transactionsPanel.Visible = true;
        VchPanel.Visible = true;
        VchTypeSelPanel.Visible = false;
        txtAmount.Text = "";
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
                ListofCreditAccounts.DataSourceID = "InvestmentAccountsList";
                ListofCreditAccounts.DataTextField = "datClientName";
                ListofCreditAccounts.DataValueField = "datID";
                ListofCreditAccounts.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 2)
            {
                ListofCreditAccounts.DataSourceID = "LoanAccountsList";
                ListofCreditAccounts.DataTextField = "datClientName";
                ListofCreditAccounts.DataValueField = "datID";
                ListofCreditAccounts.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datDebitAccountTypes) == 3)
            {
                ListofCreditAccounts.DataSourceID = "SysLedgersList";
                ListofCreditAccounts.DataTextField = "datDescription";
                ListofCreditAccounts.DataValueField = "datID";
                ListofCreditAccounts.DataBind();
            }

            if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 1)
            {
                ddlDebitAccountList.DataSourceID = "InvestmentAccountsList";
                ddlDebitAccountList.DataTextField = "datClientName";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 2)
            {
                ddlDebitAccountList.DataSourceID = "LoanAccountsList";
                ddlDebitAccountList.DataTextField = "datClientName";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
            }
            else if (Convert.ToInt32(vtypes[0].datCreditAccountTypes) == 3)
            {
                ddlDebitAccountList.DataSourceID = "SysLedgersList";
                ddlDebitAccountList.DataTextField = "datDescription";
                ddlDebitAccountList.DataValueField = "datID";
                ddlDebitAccountList.DataBind();
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

            lblTotal.Text = Convert.ToString(totEntries[0].TotalAmount);
        }
        catch (Exception ex) { }
        loadAccItems();
        transactionsPanel.Visible = true;
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
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMsg", "alert('Voucher Successfully Inserted')", true);
        }
    }




    private bool insertVoucher()
    {
        FinancialDSTableAdapters.InsertVoucherTableAdapter vch = new FinancialDSTableAdapters.InsertVoucherTableAdapter();
        FinancialDSTableAdapters.tbl_Ledger_EntriesTableAdapter led = new FinancialDSTableAdapters.tbl_Ledger_EntriesTableAdapter();
        FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter temp = new FinancialDSTableAdapters.tempTransaction_EntriesTableAdapter();
        FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter vType = new FinancialDSTableAdapters.tbl_VoucherTypesTableAdapter();


        FinancialDS.tempTransaction_EntriesDataTable entries = temp.GetTempTransactionsByEntryKey(MySessionManager.TempTranKey);
        if (entries.Count > 0)
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
                    decimal totAmount = 0;
                    foreach (FinancialDS.tempTransaction_EntriesRow entry in entries)
                    {
                        led.InsertLedgerEntry(entry.datAccountType, entry.datAccountID, Convert.ToDecimal(entry.datAmount),1, newid, "On Account", entry.datPaymentMode, "", "", "", "", "", "", "","","");
                        totAmount += entry.datAmount;
                    }

                    led.InsertLedgerEntry(vtypes[0].datCreditAccountTypes, Convert.ToInt32(ListofCreditAccounts.SelectedValue), Convert.ToDecimal(totAmount), 0, newid, "On Account", entries[0].datPaymentMode, "", "", "", "", "", "", "","","");
                    return true;
                }
                catch (Exception ex) { return false; }
            }
            else { return false; }

        }
        else { return false; }



    }
}
