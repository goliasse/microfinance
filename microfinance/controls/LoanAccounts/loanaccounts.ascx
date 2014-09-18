<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loanaccounts.ascx.cs" Inherits="controls_loanaccounts" %>
<div class="row">
<p style="margin:0">
    <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Account(s)"></asp:Label><span runat="server" id="noAccounts" class="badge pull-right"></span>
</p>
<hr style="margin:5px" />
<p>
    <asp:GridView ID="gvAccounts" CssClass="table table-striped table-bordered" 
        runat="server" AutoGenerateColumns="False" DataKeyNames="datID" 
        DataSourceID="SqlDataSource1" onrowdatabound="gvAccounts_RowDataBound1">
        <Columns>
            <asp:BoundField DataField="datClientFullName" HeaderText="Client Name" 
                SortExpression="datClientFullName" />
            <asp:BoundField DataField="datAccountNumber" HeaderText="Account Number" 
                SortExpression="datAccountNumber" />
            <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" 
                SortExpression="datEmailAddress" />
            <asp:BoundField DataField="loantype" HeaderText=" Loan Account Type" 
                SortExpression="loantype" />
            <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <asp:HyperLink ID="hyperInv" runat="server" CssClass="btn btn-xs btn-success col-md-10"  NavigateUrl='javascript:apply(<%# Eval("datID", "{0}") %>)' Text="Finalize">
                        <i class="glyphicon glyphicon-eye-open"></i> View 
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        
        
        SelectCommand="SELECT     tbl_loan_accounts.datID, tbl_loan_accounts.datClientFullName, tbl_loan_accounts.datAccountNumber, opt_loan_types.datDescription AS loantype, 
                      tbl_client.datEmailAddress
FROM         tbl_loan_accounts INNER JOIN
                      tbl_client ON tbl_loan_accounts.datClientID = tbl_client.datID INNER JOIN
                      opt_loan_types ON tbl_loan_accounts.datLoanType = opt_loan_types.datID" 
        onselected="SqlDataSource1_Selected">
    </asp:SqlDataSource>
</p>


</div>