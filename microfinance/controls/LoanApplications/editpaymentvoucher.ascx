<%@ Control Language="C#" AutoEventWireup="true" CodeFile="editpaymentvoucher.ascx.cs" Inherits="controls_paymentvoucher" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Prepare Payment Voucher</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5><b>Prepare Payment  Voucher</b></h5></legend>
                <div class="form-group">
                     <label class="col-lg-3 control-label" for="typeahead">Approved Amount</label>
                    <div class="col-lg-9">
                        <label runat="server"  id="lblTotalAmt"></label>
                    </div>
                </div>
                <hr />
                <div class="form-group">
                    <input type="hidden" runat="server" id="editskip" /> 
                    <input type="hidden" runat="server" id="editskip1" />
                    <label class="col-lg-3 control-label" for="typeahead">Description</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtDescription" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Amount </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtAmount" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Reference</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtReference" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Payment Method</label>
                    <div class="col-lg-9">
                        <asp:DropDownList CssClass="form-control"  ID="ddlPaymetMode" runat="server" 
                            DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                            DataValueField="datID" AppendDataBoundItems="True"  >
                            <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_fee_payment_modes] ORDER BY [datDescription]">
                        </asp:SqlDataSource>
                        <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtPaymentMethod" autocomplete="off">--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Branch</label>
                    <div class="col-lg-9">
                    <span runat="server" id="txtBranch"></span>
                       <%-- <input runat=server type="text" class="form-control input-sm col-md-6" id="Text1" autocomplete="off">--%>
                    </div>
                </div>                
                <div class="form-group">
                <div class="col-lg-10" >
                        <asp:Button ID="btnSave" style="height:25px;width:15%" 
                            class="btn btn-xs btn-success" runat="server" Text="ADD" onclick="btnSave_Click" 
                             />
                </div>
                </div>
             <hr />                
            <asp:GridView  ID="gvPaymentVoucher" CssClass="table table-striped table-bordered" 
                            runat="server" DataKeyNames="datID" 
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource1" onrowdatabound="gvPaymentVoucher_RowDataBound" 
                            >
                <Columns>
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:BoundField DataField="datReference" HeaderText="Reference" 
                        SortExpression="datReference" />
                    <asp:BoundField DataField="datAmount" HeaderText="Amount" 
                        SortExpression="datAmount" />
                    <asp:BoundField DataField="feepayment" HeaderText="Payment Mode" 
                        SortExpression="feepayment" />
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
            <hr />
            <p><h5><b>Finalize Voucher</b></h5></p>
            <div class="col-md-12">
            <input id="FVID" type="hidden" runat="server" />
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Voucher No.:</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtVoucherNo" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="">Date</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtDate" class="form-control input-sm col-md-6 my-picker"  runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Total Amount</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtTotalAmount" class="form-control input-sm col-md-6"  runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Amount in Words:</label>
                    <div class="col-lg-9">
                        <textarea class="form-control input-sm col-md-6" id="txtAmtWords" runat="server"></textarea>
                    </div>
                </div>
                 <asp:Button ID="btnFinalVoucher" style="height:25px;width:15%" 
                            class="btn btn-xs btn-success" runat="server" Text="SUBMIT" onclick="btnFinalVoucher_Click" 
                             />
            </div>
      </div>
 </fieldset>
            
                &nbsp;
            
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                    SelectCommand="GetPaymentVoucher1" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="clientID" SessionField="ClientID" Type="Int32" 
                            DefaultValue="0" />
                        <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" 
                            DefaultValue="0" />
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
                            <asp:BoundField DataField="feetype" HeaderText="Fee Type" 
                                SortExpression="feetype" />
                            <asp:BoundField DataField="datAmount" HeaderText="Amount" 
                                SortExpression="datAmount" />
                            <asp:BoundField DataField="paymentmode" HeaderText="Payment Method" 
                                SortExpression="paymentmode" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="getLoanFees" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="AppID" SessionField="AppID" 
                                Type="Int32" />
                            <asp:SessionParameter DefaultValue="0" Name="clientID" SessionField="ClientID" 
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    </div>
                </div>
   <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>
<%--<asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtDate">
</asp:CalendarExtender>--%>
