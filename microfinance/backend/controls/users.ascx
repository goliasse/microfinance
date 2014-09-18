<%@ Control Language="C#" AutoEventWireup="true" CodeFile="users.ascx.cs" Inherits="backend_controls_users" %>
<div class="col-md-12">
<div class="col-md-12" >
   <asp:LinkButton ID="LinkButton1" PostBackUrl="~/backend/pages/users.aspx?page=newuser" CssClass="btn btn-xs btn-success col-md-2 pull-right" runat="server"> ADD USER </asp:LinkButton>
</div>
<hr />

<p><h7>List of System Users</h7></p>
<hr />
<div class="col-md-12">
    <asp:GridView ID="gvUsers"  CssClass="table table-striped table-bordered" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="datID,title,datSurname,datFirstnames" 
        DataSourceID="SqlDataSource1" onrowdatabound="gvUsers_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="User Name"></asp:TemplateField>
            <asp:BoundField DataField="datCellNumber" HeaderText="Mobile Number" 
                SortExpression="datCellNumber" />
            <asp:BoundField DataField="datLevel" HeaderText="Position" 
                SortExpression="datLevel" />
            <asp:BoundField DataField="datBranch" HeaderText="Branch" 
                SortExpression="datBranch" />
            <asp:TemplateField HeaderText="Roles">
                <ItemTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-xs btn-success col-md-12"  ID="hyperRoles" Text="Roles" ></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Access Rights">
                <ItemTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-xs btn-success col-md-10" ID="hyperAccess" Text="Access Rights" ><i class="pull-left glyphicon glyphicon-tasks"></i> 
                    Access Rights </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-xs btn-success col-md-12" ID="hyperUpdates" ><i class="pull-left glyphicon glyphicon-pencil" ></i>Edit</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:HyperLink runat="server" CssClass="btn btn-xs btn-success col-md-12" ID="hyperDeletes" ><i class="pull-left glyphicon glyphicon-remove" ></i>Delete</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="getUsers" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</div>

</div>