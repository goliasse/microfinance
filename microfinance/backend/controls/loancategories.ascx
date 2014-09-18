<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loancategories.ascx.cs" Inherits="controls_assets" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Loan Categories</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Loan Categories</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Categories</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtCategories" autocomplete="off" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Min. Days:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMinDays" autocomplete="off" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Max. Days</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMaxDays" autocomplete="off" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Performance</label>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="ddlPerformance" CssClass="form-control" runat="server">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Performing</asp:ListItem>
                            <asp:ListItem Value="2">Non-performing</asp:ListItem>
                        </asp:DropDownList>
                        <%--<input runat="server" type="text" class="form-control input-sm col-md-6" id="txtPerformance" autocomplete="off" >--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Provision Factor</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtPF" autocomplete="off" >
                    </div>
                </div>
                
                
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"  
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" 
                            onclick="btnSave_Click" />
                   </div>
                </div>
            </fieldset>
            <hr />
            
            <asp:GridView CssClass="table table-striped" ID="gvloanCat" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvloanCat_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datDescription" HeaderText="Category" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datMinDays" HeaderText="Min. Days" 
                        SortExpression="datMinDays" />
                    <asp:BoundField DataField="datMaxDays" HeaderText="Max. Days" 
                        SortExpression="datMaxDays" />
                    <asp:BoundField DataField="datProvisionFactor" HeaderText="Provision Factor" 
                        SortExpression="datProvisionFactor" />
                    <asp:BoundField DataField="datPerformance" HeaderText="Performance" 
                        SortExpression="datPerformance" />
                    <asp:TemplateField HeaderText="Action">
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
                SelectCommand="GetLoanCategories" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>