<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Initiator.ascx.cs" Inherits="controls_Initiator" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Initiator(s)</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Initiator(s)</h5></legend>
                <input type="hidden" runat="server" id="editskip" />
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Full Name</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtfullname" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Position </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtPosition" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Mobile No.</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMobile" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Telephone No.</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtTelNo" autocomplete="off">
                    </div>
                </div> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Fax</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtFax" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Email Address</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtEmail" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Address</label>
                    <div class="col-lg-9">
                         <textarea runat=server id="txtAddress" class="form-control input-sm col-md-6"  style="height: 120px"></textarea>
                    </div>
                </div>             
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            
            <asp:GridView CssClass="table table-striped" ID="gvInitiator" runat="server" 
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="datID" 
                        onrowdatabound="gvInitiator_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datFullname" HeaderText="Full Name" 
                        SortExpression="datFullname" />
                    <asp:BoundField DataField="datPosition" HeaderText="Position" 
                        SortExpression="datPosition" />
                    <asp:BoundField DataField="datMobileNumber" HeaderText="Mobile Number" 
                        SortExpression="datMobileNumber" />
                    <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" 
                        SortExpression="datEmailAddress" />
                    <asp:TemplateField HeaderText="Edit">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server"  CssClass="btn btn-xs btn-success col-md-5" Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i>  Edit
                                </asp:HyperLink>                            
                                <asp:HyperLink ID="hyperDelete" runat="server"  CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"  Text="Delete">
                                    <i class="glyphicon glyphicon-remove"></i> Delete 
                                </asp:HyperLink>
                             </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetIntiator" SelectCommandType="StoredProcedure">
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