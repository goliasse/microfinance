<%@ Control Language="C#" AutoEventWireup="true" CodeFile="invaccounts.ascx.cs" Inherits="controls_clients_invaccounts" %>

<div class="col-md-12">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Client's Investment Accounts</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="clientInvAccountData">
                <Columns>
                    <asp:BoundField DataField="datInvestmentName" HeaderText="Investment Name" 
                        SortExpression="datInvestmentName" />
                    <asp:BoundField DataField="datApplicationNumber" HeaderText="Appl. Number" 
                        SortExpression="datApplicationNumber" />
                    <asp:BoundField DataField="datInvestmentType" HeaderText="Inv. Type" 
                        SortExpression="datInvestmentType" />
                    <asp:BoundField DataField="datInvestmentAmount" HeaderText="Inv. Amount" 
                        SortExpression="datInvestmentAmount" />
                    <asp:BoundField DataField="datInterestRatePerAnnum" HeaderText="Interest Rate" 
                        SortExpression="datInterestRatePerAnnum" />
                    <asp:BoundField DataField="datValueDate" HeaderText="Value Date" 
                        SortExpression="datValueDate" />
                </Columns>
            
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="clientInvAccountData"
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetClientInvAccounts" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>