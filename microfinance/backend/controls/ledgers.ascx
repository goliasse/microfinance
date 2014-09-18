<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ledgers.ascx.cs" Inherits="controls_assets" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Ledgers</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Ledgers</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                 <div class="form-group">
                    <label class="col-lg-4 control-label" for="">Description</label>
                    <div class="col-lg-8">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtDescription" autocomplete="off" />
                    </div>
                </div> 
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="">Code</label>
                    <div class="col-lg-8">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtcode" autocomplete="off" />
                    </div>
                </div>  
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="typeahead">Product</label>
                    <div class="col-lg-8">
                        <asp:DropDownList class="form-control" ID="ddlProduct" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                            DataValueField="datID" AppendDataBoundItems="True">
                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_products]" >
                        </asp:SqlDataSource>
                       
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="typeahead">Category</label>
                    <div class="col-lg-8">
                            <asp:DropDownList class="form-control" ID="ddlCategory" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_finance_acc_types]">
                            </asp:SqlDataSource>
                           <%-- <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAssetType" autocomplete="off" readonly="readonly">--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="typeahead">Apply Interest:</label>
                    <div class="col-lg-8">
                       <div class="checkbox">
                          <label>
                              <asp:CheckBox ID="chkInterestApplied" runat="server" /><%--<input type="checkbox" runat="server" id="chkInterestApplied" value="">--%>
                          </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="typeahead">Show In Client Statement</label>
                    <div class="col-lg-8">
                           <div class="checkbox">
                          <label>
                           <%-- <input type="checkbox" runat="server" id="chkClientStatement1" value="">--%>
                              <asp:CheckBox ID="chkClientStatement" runat="server" />
                          </label>
                        </div>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-4 control-label" for="typeahead">Treat As Fee</label>
                    <div class="col-lg-8">
                         <div class="checkbox">
                          <label>
                           <%-- <input type="checkbox" runat="server" id="chkFees" value="">--%>
                             <asp:CheckBox ID="chkFees" runat="server" />
                          </label>
                        </div>  
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-4 control-label" for="optionsCheckbox">Make Visible</label>
                    <div class="col-lg-8">
                        <div class="checkbox">
                          <label>
                            <%--<input type="checkbox" runat="server" id="chkVisible" value="">--%>
                            <asp:CheckBox ID="chkVisible" runat="server" />
                          </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" 
                            class="btn btn-xs btn-success col-md-4" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            <hr />
        </div>
            <div class="col-md-12">
            <asp:GridView CssClass="table table-condensed table-bordered" style="width:100%" ID="gvLedger" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource2" onrowdatabound="gvLedger_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datLedgerCode" HeaderText="Code" 
                        SortExpression="datLedgerCode" />
                    <asp:BoundField DataField="datProduct" HeaderText="Product" 
                        SortExpression="datProduct" />
                    <asp:BoundField DataField="datCategory" HeaderText="Category" 
                        SortExpression="datCategory" />
                    <asp:BoundField DataField="datInterest" HeaderText="Interest" 
                        SortExpression="datInterest" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datClientStatement" HeaderText=" Statement" 
                        SortExpression="datClientStatement" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datFee" HeaderText="Fee" 
                        SortExpression="datFee" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datVisible" HeaderText="Visibility" 
                        SortExpression="datVisible" />
                    <asp:TemplateField>
                        <ItemTemplate>
                           <asp:HyperLink ID="hyperEdit" runat="server" class="btn btn-xs btn-success col-md-12" Text="Edit">
                             <i class="glyphicon glyphicon-pencil"></i>  Edit 
                           </asp:HyperLink>
                       </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
           </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                
                
            
                    SelectCommand="SELECT datID, datDescription, datLedgerCode, dbo.getOptFinCategories(datCategory) AS datCategory, datClientStatement, datInterest, dbo.getOptProduct(datProduct) AS datProduct, datFee, datVisible FROM sys_ledgers">
            </asp:SqlDataSource>
        
    </div>
  </div>
</div>