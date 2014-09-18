<%@ Control Language="C#" AutoEventWireup="true" CodeFile="pdc.ascx.cs" Inherits="controls_Fees" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Post Dated Cheques</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Post Dated Cheques</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Bank</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtBank"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Date
                        </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtDate" class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Cheque</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtchequeno"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Amount</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAmt"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                    <asp:CustomValidator ID="vPDC" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                        <hr style="margin: 1px" />
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>
                </fieldset>
                <hr />
                <asp:GridView CssClass="table table-striped" ID="gvFees" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="datID" DataSourceID="SqlDataSource3" OnRowDataBound="gvFees_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="datBank" HeaderText="Bank" SortExpression="datBank" />
                        <asp:BoundField DataField="datCheque" HeaderText="Cheque" SortExpression="datCheque" />
                        <asp:BoundField DataField="datAmount" HeaderText="Amount" SortExpression="datAmount" />
                        <asp:BoundField DataField="datCleared" HeaderText="Cleared" SortExpression="datCleared" />
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperEdit" runat="server" Text="Edit">
                                    <span class="glyphicon glyphicon-edit"> Edit </span>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperDelete" runat="server" Text="Delete">
                                    <span class="glyphicon glyphicon-remove"> Delete </span>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="GetPDC" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
</script>

