<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loanaccounts.ascx.cs" Inherits="backend_controls_loanaccounts" %>
<div class="row">
<p style="margin:0">
    <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Account(s)"></asp:Label><span runat="server" id="noAccounts" class="badge pull-right"></span>
</p>
<hr />
<p>
    <asp:GridView ID="gvAccounts" CssClass="table table-striped table-bordered" 
        runat="server" AutoGenerateColumns="False" DataKeyNames="datID" 
        DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="datClientFullName" HeaderText="Client" 
                SortExpression="datClientFullName" />
            <asp:BoundField DataField="datAccountNumber" HeaderText="Account Number" 
                SortExpression="datAccountNumber" />
            <asp:BoundField DataField="datOutstandingAmount" HeaderText="Outstanding Amt." 
                SortExpression="datOutstandingAmount" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                <asp:HyperLink ID="hyperAppProcess" runat="server"><span class="glyphicon glyphicon-tasks"> Open </span></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="SELECT datID, datClientFullName, datAccountNumber, datOutstandingAmount FROM tbl_loan_accounts WHERE (datTeamID = @branchID)">
        <SelectParameters>
            <asp:SessionParameter Name="branchID" SessionField="CurrentUser.BranchID" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>


</div>