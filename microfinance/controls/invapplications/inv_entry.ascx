<%@ Control Language="C#" AutoEventWireup="true" CodeFile="inv_entry.ascx.cs" Inherits="controls_invapplications_inv_entry" %>
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
                Investment Payout
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div id="dispInfo" class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                           Investment Payout</h5>
                    </legend>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Client Name:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lblClient">
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Total Amt:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lbltotalamt">
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Date:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lbldate">
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Branch:</label>
                            <div class="col-lg-8">
                                <label runat="server" id="lblbranch">
                                </label>
                            </div>
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-12">
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
                                <asp:DropDownList ID="ddlPaymentMode" CssClass="form-control " runat="server"
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
                                <asp:DropDownList ID="ddlAccount" CssClass="form-control" runat="server"
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
                            <asp:Button ID="btnSaveTransaction" 
                                class="btn btn-xs btn-success col-md-2" runat="server" Text="ADD" OnClick="btnSaveTransaction_Click" />
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-12">
                        <%--<input type="hidden" id="counter" runat="server" />--%>
                        <asp:GridView ID="gvInvEntry" CssClass="table table-bordered" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource3"  DataKeyNames="datIndex" 
                            onrowdatabound="gvInvEntry_RowDataBound">
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
                            SelectCommand="GetInvTempTransactions1" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
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
                            <asp:Button ID="btnFinalize" class="btn btn-xs btn-success col-md-2"
                                runat="server" Text="SUBMIT" OnClick="btnFinalize_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
