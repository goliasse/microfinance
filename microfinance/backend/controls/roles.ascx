<%@ Control Language="C#" AutoEventWireup="true" CodeFile="roles.ascx.cs" Inherits="backend_controls_roles" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Roles</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Roles</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Role:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtrole" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Approval Limit:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtApprovalLimit" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Session Duration:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtSessionDuration" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Email Address:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEmailAddress" autocomplete="off">
                    </div>
                </div>
                
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" 
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            <hr />
            
            <asp:GridView CssClass="table table-striped" ID="gvRoles" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvRoles_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datDescription" HeaderText="Role" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datApprovalLimit" HeaderText="Approval Limit" 
                        SortExpression="datApprovalLimit" />
                    <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" 
                        SortExpression="datEmailAddress" />
                    <asp:BoundField DataField="datSessionDuration" HeaderText="Session Duration" 
                        SortExpression="datSessionDuration" />
                    <asp:TemplateField HeaderText="Edit">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server"  Text="Edit">
                                    <span class="glyphicon glyphicon-edit"> Edit </span>
                                </asp:HyperLink>
                             </ItemTemplate>
                      </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetRoles" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>