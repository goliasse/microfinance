<%@ Control Language="C#" AutoEventWireup="true" CodeFile="assets.ascx.cs" Inherits="controls_assets" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Assets</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Assets</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Asset Type</label>
                    <div class="col-lg-9">
                        <asp:DropDownList class="form-control" ID="ddlAssetType" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                            DataValueField="datID" AppendDataBoundItems="True">
                            <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_asset_types]">
                        </asp:SqlDataSource>
                       <%-- <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAssetType" autocomplete="off" readonly="readonly">--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Description </label>
                    <div class="col-lg-9">
                        <textarea runat=server id="txtDescription" class="form-control input-sm col-md-6"  style="height:80px"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Value</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtvalue" autocomplete="off" />
                    </div>
                </div>  
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"   class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            <hr />
            
            <asp:GridView CssClass="table table-striped table-bordered" ID="gvAsset" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvAsset_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Asset" HeaderText="Asset Type" 
                        SortExpression="Asset" />
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datValue" HeaderText="Value" 
                        SortExpression="datValue" DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Action">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"  Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i>  Edit 
                                </asp:HyperLink>                      
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"  Text="Delete">
                                    <i class="glyphicon glyphicon-remove"></i>  Delete 
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