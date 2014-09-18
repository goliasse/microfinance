<%@ Control Language="C#" AutoEventWireup="true" CodeFile="paymentvoucher.ascx.cs"
    Inherits="controls_paymentvoucher" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Prepare Payment Voucher</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            <b>Prepare Payment Voucher</b></h5>
                    </legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Approved Amount</label>
                        <div class="col-lg-9">
                            <label runat="server" id="lblTotalAmt"></label>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <input type="hidden" runat="server" id="editskip" />
                        <input type="hidden" runat="server" id="editskip1" />
                        <label class="col-lg-3 control-label" for="typeahead">
                            Description</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDescription"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Amount
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAmount"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Reference</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtReference"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Payment Method</label>
                        <div class="col-lg-9">
                            <asp:DropDownList ID="ddlPaymetMode" CssClass="form-control" runat="server" DataSourceID="SqlDataSource3"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_payment_modes]"></asp:SqlDataSource>
                            <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtPaymentMethod" autocomplete="off">--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Branch</label>
                        <div class="col-lg-9">
                            <span runat="server" id="txtBranch"></span>
                            <%-- <input runat=server type="text" class="form-control input-sm col-md-6" id="Text1" autocomplete="off">--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                    <asp:CustomValidator ID="vPVEntry" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                        <hr style="margin: 1px" />
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>
                    <hr />
                    <div class="col-md-12">
                        <asp:GridView ID="gvPaymentVoucher" CssClass="table table-striped table-bordered"
                            runat="server" DataKeyNames="datID" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                            OnRowDataBound="gvPaymentVoucher_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                                <asp:BoundField DataField="datReference" HeaderText="Reference" SortExpression="datReference" />
                                <asp:BoundField DataField="datAmount" HeaderText="Amount" SortExpression="datAmount" />
                                <asp:BoundField DataField="feepayment" HeaderText="Payment Mode" SortExpression="feepayment" />
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-succes col-md-4 col-md-offset-1"
                                            Text="Edit">
                                <i class="glyphicon glyphicon-edit"> </i>  Edit
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hyperDelete" runat="server" Text="Delete" CssClass="btn btn-xs btn-succes col-md-4 col-md-offset-1">
                                <b class="glyphicon glyphicon-remove pull-left"> Delete </b>
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <hr />
                    <p>
                        <h5>
                            <b>Finalize Voucher</b></h5>
                    </p>
                    <div class="col-md-12">
                        <input id="FVID" type="hidden" runat="server" />
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Voucher No.:</label>
                            <div class="col-lg-9">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtVoucherNo"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Date</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtDate" class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Total Amount</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtTotalAmount" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Amount in Words:</label>
                            <div class="col-lg-9">
                                <textarea class="form-control input-sm col-md-6" id="txtAmtWords" runat="server"></textarea>
                            </div>
                        </div>
                        <asp:Button ID="btnFinalVoucher" Style="height: 25px; width: 15%" class="btn btn-xs btn-success"
                            runat="server" Text="SUBMIT" OnClick="btnFinalVoucher_Click" />
                    </div>
            </div>
            </fieldset> &nbsp;
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                SelectCommand="GetPaymentVoucher1" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="clientID" SessionField="ClientID" Type="Int32" DefaultValue="0" />
                    <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</div>
<div class="form-group" style="display:none">
                        <div class="col-md-10">
                            <asp:GridView ID="gvFees" CssClass="table col-md-10" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="datID" DataSourceID="SqlDataSource2">
                                <Columns>
                                    <asp:BoundField DataField="feetype" HeaderText="Fee Type" SortExpression="feetype" />
                                    <asp:BoundField DataField="datAmount" HeaderText="Amount" SortExpression="datAmount" />
                                    <asp:BoundField DataField="paymentmode" HeaderText="Payment Method" SortExpression="paymentmode" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="getLoanFees" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" Type="Int32" />
                                    <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
</script>

