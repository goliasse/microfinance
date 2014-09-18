<%@ Control Language="C#" AutoEventWireup="true" CodeFile="nationalities.ascx.cs" Inherits="controls_assets" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Area</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Area</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Area</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtArea" autocomplete="off" readonly="readonly">
                    </div>
                </div>
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" style="height:25px;width:15%" 
                            class="btn btn-xs btn-success" runat="server" Text="SAVE" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            <hr />
            
            <asp:GridView CssClass="table table-striped" ID="gvAsset" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvAsset_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Asset" HeaderText="Asset Type" 
                        SortExpression="Asset" />
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datValue" HeaderText="Value" 
                        SortExpression="datValue" />
                    <asp:TemplateField HeaderText="Edit">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server"  Text="Edit">
                                    <span class="glyphicon glyphicon-edit"> Edit </span>
                                </asp:HyperLink>
                             </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>                            
                                <asp:HyperLink ID="hyperDelete" runat="server"  Text="Delete">
                                    <span class="glyphicon glyphicon-remove"> Delete </span>
                                </asp:HyperLink>
                             </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="getAssets" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                        Type="Int32" />
                    <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>