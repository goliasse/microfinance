<%@ Control Language="C#" AutoEventWireup="true" CodeFile="applicationtrail.ascx.cs" Inherits="controls_applicationtrail" %>
<div class="row"> 
<p><h5>Loan Application History</h5></p>
<hr />
    <div class="col-md-11">
        <asp:GridView ID="gvApplicationTrail" CssClass="table table-striped" runat="server" 
            AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="Stage" HeaderText="Stage" ReadOnly="True" 
                    SortExpression="Stage" />
                <asp:BoundField DataField="FromUser" HeaderText="Forwarded By" ReadOnly="True" 
                    SortExpression="FromUser" />
                <asp:BoundField DataField="ToUser" HeaderText="To" ReadOnly="True" 
                    SortExpression="ToUser" />
                <asp:BoundField DataField="datDate" HeaderText="Start Date" 
                    SortExpression="datDate" dataformatstring="{0:MMMM d, yyyy}" htmlencode="false" />
                <asp:BoundField DataField="datTime" HeaderText="End Date" 
                    SortExpression="datTime" dataformatstring="{0:MMMM d, yyyy}" htmlencode="false"/>
                <asp:BoundField DataField="datDuration" HeaderText="Duration" 
                    SortExpression="datDuration" />
            </Columns>
        </asp:GridView>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
            SelectCommand="GetApplicationTrails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
</div>