<%@ Control Language="C#" AutoEventWireup="true" CodeFile="pendinginvestments.ascx.cs" Inherits="controls_clients_pendinginvestments" %>

<div class="col-md-12">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Client's Pending Investment Applications</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="clientInvAppData">
                <Columns>
                    <asp:BoundField DataField="datApplicationNumber" HeaderText="App. Number" 
                        SortExpression="datApplicationNumber" />
                    <asp:BoundField DataField="datInvestmentType" HeaderText="Inv. Type" 
                        SortExpression="datInvestmentType" />
                    <asp:BoundField DataField="datInvestmentAmount" HeaderText="Amount" 
                        SortExpression="datInvestmentAmount" />
                    <asp:BoundField DataField="datInterestRatePerAnnum" HeaderText="Interest Rate" 
                        SortExpression="datInterestRatePerAnnum" />
                    <asp:BoundField DataField="datApplicationStatus" HeaderText="Status" 
                        SortExpression="datApplicationStatus" />
                </Columns>
            
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="clientInvAppData"
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetClientInvApps" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>