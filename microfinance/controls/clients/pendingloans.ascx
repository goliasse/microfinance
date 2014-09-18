<%@ Control Language="C#" AutoEventWireup="true" CodeFile="pendingloans.ascx.cs" Inherits="controls_clients_pendingloans" %>

<div class="col-md-12">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Client's Pending Loan Applications</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="clientLoanAppData" OnRowDataBound ="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datApplicationNumber" HeaderText="App. Number" 
                        SortExpression="datApplicationNumber" />
                    <asp:BoundField DataField="datApplicationDate" HeaderText="App. Date" 
                        SortExpression="datApplicationDate" />
                    <asp:BoundField DataField="datLoanType" HeaderText="Loan Type" 
                        SortExpression="datLoanType" />
                    <asp:BoundField DataField="datLoanAmount" HeaderText="Amount" 
                        SortExpression="datLoanAmount" />
                    <asp:BoundField DataField="datInterestRate" HeaderText="Int. Rate" 
                        SortExpression="datInterestRate" />
                    <asp:BoundField DataField="datApplicationStatus" HeaderText="Status" 
                        SortExpression="datApplicationStatus" />
                    <asp:CheckBoxField DataField="datReviewed" HeaderText="Reviewed" 
                        SortExpression="datReviewed" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="showStatusLog" runat="server" CssClass="btn btn-xs btn-success"><i class="glyphicon glyphicon-tasks pull-right"></i>Status Log &nbsp; &nbsp;</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="clientLoanAppData"
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetClientLoanApps" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="ClientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>