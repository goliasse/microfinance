<%@ Control Language="C#" AutoEventWireup="true" CodeFile="invclientlist3.ascx.cs"
    Inherits="controls_invaccounts_invclientlist3" %>
    
<script type="text/javascript" language="javascript">
    function showinfo(pid)
    {
        $('.ItemContainer').css("display","none");
        $("#"+pid).css("display","block");    
       // alert('done');
    }
</script>
<div class="col-md-12">



    <%--Start Interest Rate Tab--%>
    <p style="margin: 0">
        <asp:Label ID="lblHeading" runat="server" Style="font-weight: 700" Text="Number of Investment(s)"></asp:Label><span
            runat="server" id="noClients" class="badge pull-right"></span>
    </p>
    <hr />
    <asp:GridView ID="gvClients" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1" OnRowDataBound="gvClients_RowDataBound" 
        DataKeyNames="datID,datClientID,datInvestmentType,datValueDate,datFrequencyOfInterestPayment,datAccountID">
        <Columns>
            <asp:TemplateField HeaderText="Client Name"></asp:TemplateField>
            <asp:BoundField DataField="datInvestmentName" HeaderText="Investment Name" SortExpression="datInvestmentName" />
            <asp:BoundField DataField="datApplicationNumber" HeaderText="Application  No." SortExpression="datApplicationNumber" />
            <asp:BoundField DataField="datDaysOver" HeaderText="Days Elapsed" SortExpression="datDaysOver" />
            <asp:TemplateField HeaderText="Investment Type"></asp:TemplateField>
            <asp:TemplateField HeaderText="Action"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
        
        SelectCommand="SELECT datID, datAccountID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datInvestmentAmount, datDaysOver, datValueDate, datFrequencyOfInterestPayment FROM tbl_historic_accounts2 WHERE (datPaymentStatus = 2) AND (datTeamID = @branch)">
        <SelectParameters>
            <asp:Parameter Name="branch" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--End Interest Rate Tab--%>

   <%--Start Investment Tab--%>
    <asp:GridView ID="gvInvClients" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="datID" DataSourceID="SqlDataSource2" 
        onrowdatabound="gvInvClients_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Client Name"></asp:TemplateField>
            <asp:BoundField DataField="datInvestmentName" HeaderText="datInvestmentName" 
                SortExpression="datInvestmentName" />
            <asp:BoundField DataField="datApplicationNumber" HeaderText="Application No." 
                SortExpression="datApplicationNumber" />
            <asp:BoundField DataField="datInvestmentType" HeaderText="Investment Type" 
                SortExpression="datInvestmentType" />
            <asp:BoundField DataField="datDaysOver" HeaderText="Days Elapsed" 
                SortExpression="datDaysOver" />
            <asp:BoundField DataField="datInvestmentAmount" HeaderText="Investment Amount" 
                SortExpression="datInvestmentAmount" />
            <asp:TemplateField HeaderText="Action"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        
        SelectCommand="SELECT datID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datInvestmentAmount, datValueDate, datDaysOver FROM tbl_investment_accounts WHERE (datActiveAccountStatus = 4) AND (datTeamID = @branch)">
        <SelectParameters>
            <asp:Parameter Name="branch" />
        </SelectParameters>
    </asp:SqlDataSource>
   <%--End Investment Tab--%>
    
   <%--Start Investment Tab--%>
    <asp:GridView ID="gvRollClients" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="datID" DataSourceID="SqlDataSource3" 
        onrowdatabound="gvRollClients_RowDataBound">
        <Columns>
            <asp:BoundField DataField="datClientName" HeaderText="Client Name" 
                SortExpression="datClientName" />
            <asp:BoundField DataField="datApplicationNumber" HeaderText="Account No" 
                SortExpression="datApplicationNumber" />
            <asp:BoundField DataField="datInvestmentType" HeaderText="Product" 
                SortExpression="datInvestmentType" />
            <asp:BoundField DataField="datInvestmentAmount" HeaderText="Amount" 
                SortExpression="datInvestmentAmount" />
            <asp:TemplateField HeaderText="Action"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="SELECT datID, datInvestmentName, datApplicationNumber, datClientID, datClientName, datInvestmentType, datInvestmentAmount FROM tbl_investment_application WHERE (datTeamID = @branch) AND (datApplicationStatus = 10)">
        <SelectParameters>
            <asp:Parameter Name="branch" />
        </SelectParameters>
    </asp:SqlDataSource>
   <%--End Investment Tab--%>
</div>
