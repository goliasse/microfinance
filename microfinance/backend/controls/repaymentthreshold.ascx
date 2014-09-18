<%@ Control Language="C#" AutoEventWireup="true" CodeFile="repaymentthreshold.ascx.cs" Inherits="controls_area" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Repayment Thresholds</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Repayment Threshold</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Description:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDescription" autocomplete="off" >
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Max Limit:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMaxLimit" autocomplete="off" >
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Min Limit:</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMinLimit" autocomplete="off" >
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
            
            <asp:GridView CssClass="table table-striped" ID="gvRT" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvRT_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datMax" HeaderText="Max. Limit" 
                        SortExpression="datMax" />
                    <asp:BoundField DataField="datMin" HeaderText="Min. Limit" 
                        SortExpression="datMin" />
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
                SelectCommand="GetOptRepaymentThreshold" 
                SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>