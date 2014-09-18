<%@ Control Language="C#" AutoEventWireup="true" CodeFile="contactperson.ascx.cs" Inherits="controls_invapplications_contactperson" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Contact Person(s)
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Contact Person(s)</h5></legend>
                     <input type="hidden" runat="server" id="editskip" />
                 <div class="form-group">
                    <label class="control-label col-md-3">Full Name</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtfullname" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                 </div>
                <div class="form-group">
                    <label class="control-label col-md-3">Mobile Number</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtMobileNumber" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                 </div>
                 <div class="form-group">
                    <label class="control-label col-md-3">Telephone Number</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtTelephoneNumber" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                 </div>
                 <div class="form-group">
                    <label class="control-label col-md-3">Email Address</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtEmailAddress" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                 </div>
                 <div class="form-group">
                    <label class="control-label col-md-3">Home Address</label>
                    <div class="col-md-9">
                        <textarea id="txtHomeAddress" class="form-control input-sm" runat="server" cols="20" rows="3"></textarea>
                    </div>
                 </div>
                 <div class="form-group">
                    <label class="control-label col-md-3">Fax Number</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtfax" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                 </div>
                 <div class="form-group">
                     <div class="col-md-12">
                        <asp:Button ID="btnSave" CssClass="btn btn-xs btn-success col-md-3" 
                             runat="server" Text="Save" onclick="btnSave_Click"  />
                     </div>
                 </div>
                 </fieldset>
            </div>
            <hr />
            <p>
                <asp:GridView ID="gvContactPerson" runat="server" 
                CssClass="table table-bordered" AutoGenerateColumns="False" 
                DataKeyNames="datID" DataSourceID="SqlDataSource1" 
                onrowdatabound="gvContactPerson_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="datFullname" HeaderText="Name" 
                            SortExpression="datFullname" />
                        <asp:BoundField DataField="datMobileNumber" HeaderText="Mobile No." 
                            SortExpression="datMobileNumber" />
                        <asp:BoundField DataField="datEmailAddress" HeaderText="Email" 
                            SortExpression="datEmailAddress" />
                        <asp:TemplateField HeaderText="Action">
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
                SelectCommand="GetInvContactPerson" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
           </p>
        </div>
    </div>
</div>