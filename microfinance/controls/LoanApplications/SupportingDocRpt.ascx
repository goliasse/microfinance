<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SupportingDocRpt.ascx.cs" Inherits="controls_SupportingDocRpt" %>
<div class="row " style="min-height:400px">
    <p><h5> Supporting Documents</h5> </p>
    <hr />
    <asp:GridView  class="well table table-striped table-bordered" ID="gvSupportingDocsRpt" 
        runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" 
            onrowupdated="gvSupportingDocsRpt_RowUpdated" >
        <Columns>
            <asp:BoundField DataField="datFileName" HeaderText="File  Name" 
                SortExpression="datFileName" />
            <asp:BoundField DataField="datDescription" HeaderText="Description" 
                SortExpression="datDescription" />
            <asp:BoundField DataField="datFilePath" HeaderText="Location" 
                SortExpression="datFilePath" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="getSupportingDocuments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                Type="Int32" />
            <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
<%--<asp:DropDownList ID="DropDownList1" runat="server" 
    DataSourceID="SqlDataSource2" DataTextField="datDescription" 
    DataValueField="datTeamID">
</asp:DropDownList>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
    SelectCommand="SELECT [datDescription], [datTeamID], [status] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="1" Name="datTeamID" SessionField="BranchID" 
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
--%>