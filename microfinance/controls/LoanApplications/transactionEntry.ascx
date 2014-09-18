<%@ Control Language="C#" AutoEventWireup="true" CodeFile="transactionEntry.ascx.cs"
    Inherits="controls_transactionEntry" %>
<style type="text/css">
   
</style>
<div class="row">

    <script type="text/javascript" language="javascript">
	$(document).ready(function(){
		$('#<%=txtDBvalue.ClientID %>').click(function() {
			$('#<%=txtDBvalue.ClientID %>').val("")
		});
	 var value=parseFloat($('#<%=lblTotal.ClientID %>').val());
	// alert(value);
	 if(((!(value))&&(value==0)))
	 {
	    $('#<%=btnFinalize.ClientID %>').css("display","block");
	 
	 }
	 else
	 {
	     $('#<%=btnFinalize.ClientID %>').css("display","none"); 
	 }
	  
	});	
    </script>

    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Diburse Loan
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div id="dispInfo" class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Disburse Loan</h5>
                    </legend>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Client Name:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lblClient"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Total Amt:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lbltotalamt"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Date:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lbldate"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Branch:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lblbranch"></label>
                            </div>
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-12">
                        <p>
                            Payment Structure</p>
                        <asp:GridView ID="GridView1" CssClass=" table table-bordered" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource4">
                            <Columns>
                                <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                                <asp:BoundField DataField="datAmount" HeaderText="Amount" SortExpression="datAmount" />
                                <asp:BoundField DataField="paymentmethod" HeaderText="Payment Method" SortExpression="paymentmethod" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                            SelectCommand="SELECT tbl_payment_vouchers.datDescription, tbl_payment_vouchers.datAmount, opt_fee_payment_modes.datDescription AS paymentmethod FROM opt_fee_payment_modes INNER JOIN tbl_payment_vouchers ON opt_fee_payment_modes.datID = tbl_payment_vouchers.datFeePaymentID WHERE (tbl_payment_vouchers.datApplicationID = @AppID) AND (tbl_payment_vouchers.datClientID = @ClientID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="AppID" SessionField="AppID" />
                                <asp:SessionParameter Name="ClientID" SessionField="ClientID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <hr />
                        <br style="clear: both" />
                    </div>
                    <div class="col-md-12">
                        <input id="editskip" type="hidden" runat="server" />
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Description</label>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDescription"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="typeahead">
                                Payment Mode</label>
                            <div class="col-lg-8">
                                <asp:DropDownList ID="ddlPaymentMode" CssClass="form-control input-sm" runat="server"
                                    DataSourceID="SqlDataSource1" DataTextField="datDescription" DataValueField="datID"
                                    AppendDataBoundItems="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_payment_modes]"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Account</label>
                            <div class="col-lg-8">
                                <asp:DropDownList ID="ddlAccount" CssClass="form-control input-sm" runat="server"
                                    DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID"
                                    AppendDataBoundItems="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM sys_ledgers WHERE (datVisible = @datVisible) AND (datProduct = @datProduct OR datProduct = @datProduct2) ORDER BY datLedgerCode">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="1" Name="datVisible" />
                                        <asp:Parameter DefaultValue="1" Name="datProduct" />
                                        <asp:Parameter DefaultValue="3" Name="datProduct2" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Amount</label>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDBvalue"
                                    value="0.00" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnSaveTransaction" Style="height: 23px; width: 15%; margin-left: 80px"
                                class="btn btn-xs btn-success" runat="server" Text="ADD" OnClick="btnSaveTransaction_Click" />
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-12">
                        <%--<input type="hidden" id="counter" runat="server" />--%>
                        <asp:GridView ID="gvDisburseLoan" CssClass="table" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource3" OnRowDataBound="gvDisburseLoan_RowDataBound" DataKeyNames="datIndex">
                            <Columns>
                                <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                                <asp:BoundField DataField="paymentmethod" HeaderText="Payment Method" SortExpression="paymentmethod" />
                                <asp:BoundField DataField="AccountName" HeaderText="Account Name" SortExpression="AccountName" />
                                <asp:BoundField DataField="datDebit" HeaderText="Debit" SortExpression="datDebit" />
                                <asp:BoundField DataField="datCredit" HeaderText="Credit" SortExpression="datCredit" />
                                <asp:BoundField DataField="datTotal" HeaderText="Total" SortExpression="datTotal" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-12"
                                            Text="Delete">
                                        <i class="glyphicon glyphicon-remove"></i>  Delete 
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                            SelectCommand="GetTransactionDetails1" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="AppID" SessionField="AppID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <p>
                            <label>
                                Total</label>
                            <asp:TextBox CssClass="pull right" Style="border: none" ID="lblTotal" runat="server"
                                OnTextChanged="lblTotal_TextChanged"></asp:TextBox>
                        </p>
                        <hr />
                    </div>
                    <div class="col-md-12">
                        <div class="form-group center">
                            <asp:Button ID="btnFinalize" Style="height: 23px; width: 15%;" class="btn btn-xs btn-success"
                                runat="server" Text="SUBMIT" OnClick="btnFinalize_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
