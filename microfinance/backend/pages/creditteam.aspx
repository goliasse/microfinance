<%@ Page Language="C#" MasterPageFile="~/backend/MasterPage.master" AutoEventWireup="true" CodeFile="creditteam.aspx.cs" Inherits="backend_pages_creditteam" Title="Manage Credit Teams" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
    <p>
        <h4> Manage Credit Team </h4>
        <hr />
    </p>
        <div class="col-md-12">
            <div class="panel panel-default bootstrap-admin-no-table-panel">
            <div class="panel-heading">
                <div class="text-muted bootstrap-admin-box-title">                                                                                                               
                    Manage Users Credit Teams
                </div>
            </div>
            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                <input type="hidden" id="currentCT" runat="server" />
                <div class="col-md-12">
                    <h6><small>  Add Staff to Credit </small></h6>
                    <hr />
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-lg-2">
                                    <label> Staff</label>
                                </div>
                                <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlStaff" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2" 
                                        DataTextField="Name" DataValueField="datID" AppendDataBoundItems="True">
                                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                        SelectCommand="SELECT sys_users.datID, opt_titles.datDescription + '  ' + sys_users.datFirstnames + '  ' + sys_users.datSurname AS Name FROM sys_users INNER JOIN opt_titles ON sys_users.datTitle = opt_titles.datID
WHERE status=1">
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="col-lg-2">
                                    <label> Branch </label>
                                </div>
                                <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlBranch" CssClass="form-control" runat="server" DataSourceID="SqlDataSource4" 
                                        DataTextField="datDescription" DataValueField="datID" 
                                        AppendDataBoundItems="True" AutoPostBack="True">
                                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                        SelectCommand="SELECT [datID], [datDescription] FROM [tbl_teams]">
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-2">
                                    <label> Credit Team</label>
                                </div>
                                <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlCreditTeamID" CssClass="form-control" runat="server" DataSourceID="SqlDataSource3" 
                                        DataTextField="datDescription" DataValueField="datID" 
                                        AppendDataBoundItems="True">
                                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                        SelectCommand="SELECT [datID], [datDescription] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlBranch" Name="datTeamID" 
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <asp:Button ID="btnAddToCt" CssClass="btn btn-xs btn-success col-md-2" 
                                        runat="server" Text="SAVE" onclick="btnAddToCt_Click" />
                                </div>
                            </div>
                        </div>
                
                
                    <hr />
                </div>
               
                <div class="col-md-4">
                    <h5><small>Credit Teams</small></h5>
                    <hr/>
                    <asp:GridView ID="gvCt" CssClass="table table-condensed" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="datID" DataSourceID="SqlDataSource1" 
                        onrowdatabound="gvCt_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="datDescription" HeaderText="Credit Team" 
                                SortExpression="datDescription" />
                            <asp:TemplateField HeaderText="View Members">
                                <ItemTemplate>
                                   <asp:HyperLink ID="HyperViewCT" CssClass="btn btn-xs btn-success col-md-10" runat="server"><i class="glyphicon glyphicon-eye-open"></i>  
                                    View Members </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="SELECT [datID], [datDescription] FROM [sys_credit_teams]">
                    </asp:SqlDataSource>
                
                </div>
                <div class="col-md-8">
                    <h6><small><span id="ctName" runat="server"></span></small></h6>
                    <hr />
                    <asp:GridView ID="gvCtMembers" 
                        CssClass="table table-condensed table-bordered table-striped" runat="server" 
                        AutoGenerateColumns="False" DataKeyNames="datID,datTitle,datSurname,datFirstnames,datCreditTeamID,datSysUserID" 
                        DataSourceID="SqlDataSource5" onrowdatabound="gvCtMembers_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Member Name"></asp:TemplateField>
                            <asp:TemplateField HeaderText="Acttion" ItemStyle-HorizontalAlign="Center">
                                 <ItemTemplate>
                                   <asp:HyperLink ID="HyperCTEdit" CssClass="btn btn-xs btn-success col-md-5" runat="server"><i class="glyphicon glyphicon-edit"></i> 
                                     Update </asp:HyperLink>
                                   <asp:HyperLink ID="HyperCTDelete" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1" runat="server"><i class="glyphicon glyphicon-remove"></i>Remove </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                
        
        
              
                
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="GetCreditTeamMembers" SelectCommandType="StoredProcedure" 
                        >
                        <SelectParameters>
                            <asp:Parameter Name="ctID" Type="Int32" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                
                </div>
            <br />
            </div>
        </div>
        
        
        
        </div>
    </div>

</asp:Content>

