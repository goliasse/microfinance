<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="transactions.aspx.cs" Inherits="pages_transactions" Title="Transaction Entries" %>

<%@ Register src="../controls/clientTransactionsEntry.ascx" tagname="clientTransactionsEntry" tagprefix="uc1" %>

<%@ Register src="../controls/mainTransactions.ascx" tagname="mainTransactions" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <p><h4>Transactions Entries</h4><hr />
        </p>
    </div>
    <div class="col-md-10">
        <uc1:clientTransactionsEntry ID="clientTransactionsEntry1" runat="server" />
        <uc2:mainTransactions ID="mainTransactions1" runat="server" />
    </div>
</asp:Content>

