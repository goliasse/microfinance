<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loanaccounts.ascx.cs" Inherits="controls_clients_loanaccounts" %>

<div class="col-md-12">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Client's Loan Accounts</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="clientLoanAccountData" OnRowDataBound = "GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datAccountNumber" HeaderText="Account Number" 
                        SortExpression="datAccountNumber" />
                    <asp:BoundField DataField="datApplicationID" HeaderText="Application ID" 
                        SortExpression="datApplicationID" />
                    <asp:BoundField DataField="datTeamID" HeaderText="Assigned Team" 
                        SortExpression="datTeamID" />
                    <asp:BoundField DataField="datStartDate" HeaderText="Start Date" 
                        SortExpression="datStartDate" />
                    <asp:BoundField DataField="datEndDate" HeaderText="End Date" 
                        SortExpression="datEndDate" />
                    <asp:BoundField DataField="datInterestRate" HeaderText="Interest Rate" 
                        SortExpression="datInterestRate" />
                    <asp:BoundField DataField="datInitialAmount" HeaderText="Initial Amount" 
                        SortExpression="datInitialAmount" />
                    <asp:BoundField DataField="datOutstandingAmount" 
                        HeaderText="Outstanding Amount" SortExpression="datOutstandingAmount" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="showStatusLog" runat="server" CssClass="btn btn-xs btn-success"><i class="glyphicon glyphicon-tasks pull-right"></i>Status Log &nbsp; &nbsp;</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="clientLoanAccountData"
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetClientLoanAccounts" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>