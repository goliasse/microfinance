<%@ Control Language="C#" AutoEventWireup="true" CodeFile="userroles.ascx.cs" Inherits="backend_controls_userroles" %>
<div class="col-md-12">
    <p>
        <h5> Assign Roles to the Users of the System </h5>
        <hr />
            <label id="lblUserName" runat="server"></label>
        <hr />
    </p>
    <div class="form-horizontal">
        <div class="form-group">
            <label class="col-md-3"> Position </label>
            <div class="col-md-9">
                <asp:DropDownList ID="ddlPosition" CssClass="input-sm form-control" 
                    runat="server" AppendDataBoundItems="True" 
                    DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                    DataValueField="datID">
                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_levels]">
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3"> Branch </label>
            <div class="col-md-9">
                <asp:DropDownList ID="ddlBranch" CssClass="input-sm form-control" 
                    runat="server" AppendDataBoundItems="True" AutoPostBack=true
                    DataSourceID="SqlDataSource4" DataTextField="datDescription" 
                    DataValueField="datID">
                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                    SelectCommand="SELECT [datID], [datDescription] FROM [tbl_teams]">
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3"> Credit Team </label>
            <div class="col-md-9">
                <asp:DropDownList ID="ddlCreditTeam" CssClass="input-sm form-control" 
                    runat="server" AppendDataBoundItems="True" 
                    DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                    DataValueField="datID">
                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                    
                    SelectCommand="SELECT [datID], [datDescription] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlBranch" DefaultValue="0" Name="datTeamID" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="form-group">   
            <div class="col-md-12">
                <asp:Button ID="btnSaveRole" 
                    CssClass="btn btn-xs btn-success col-md-3  pull-right" runat="server" 
                    Text="Role" onclick="btnSaveRole_Click" />
            </div>
        </div>
    </div>
    <hr />
    <asp:GridView ID="gvUsersRole" CssClass="table table-bordered table-condensed" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="position" HeaderText="Position" 
                SortExpression="position" />
            <%--<asp:BoundField DataField="role" HeaderText="role" SortExpression="role" />--%>
            <asp:BoundField DataField="branch" HeaderText="Branch" 
                SortExpression="branch" />
            <asp:BoundField DataField="creditteam" HeaderText="Credit Team" 
                SortExpression="creditteam" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        
        SelectCommand="SELECT tbl_secondary_roles.datPosition AS position, opt_levels.datDescription AS role, tbl_teams.datDescription AS branch, dbo.getOptCreditTeam(tbl_secondary_roles.datTeamID) AS creditteam FROM tbl_secondary_roles INNER JOIN opt_levels ON tbl_secondary_roles.datRoleID = opt_levels.datID INNER JOIN tbl_teams ON tbl_secondary_roles.datBranchID = tbl_teams.datID WHERE (tbl_secondary_roles.datUserID = @userID)">
        <SelectParameters>
            <asp:Parameter Name="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div>
    
    
    
    </div>
</div>
