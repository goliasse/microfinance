<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FinReceipt.ascx.cs" Inherits="controls_Finance_FinReceipt" %>


<asp:Panel CssClass="panel panel-default bootstrap-admin-no-table-panel" runat ="server" ID="VchTypeSelPanel">
    <div class="panel-heading">
    <div class="col-md-12">
        <div class="form-group">
            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Select Receipt Voucher Type:</label>
           <div class="col-lg-3">
                <asp:DropDownList ID="ddlVoucherType" runat ="server" CssClass="form-control " 
                          DataSourceID="dsVoucherTypes" DataTextField="datName" DataValueField="datName"></asp:DropDownList>
                <asp:SqlDataSource runat ="server" ID="dsVoucherTypes" 
                   ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                  SelectCommand="getVoucherTypeByType" SelectCommandType="StoredProcedure">
                  <SelectParameters>
                       <asp:Parameter DefaultValue="1" Name="Type" Type="Int32" />
                  </SelectParameters>
                </asp:SqlDataSource>
            </div>  
            <asp:Button ID="btnOpenVoucher" class="btn btn-xs btn-success col-md-2" 
                                runat="server" Text="GO" onclick="btnOpenVoucher_Click"/>       
        </div>
    </div>
    <hr />
    </div> 
</asp:Panel>

<asp:Panel runat="server" ID="VchPanel" class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">
                Receipt Voucher <asp:Label ID="subVchName" runat ="server" ></asp:Label>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div id="dispInfo" class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                           Select Client Account</h5>
                    </legend>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-lg-2 control-label" for="optionsCheckbox">
                                Account Name/No.:</label>
                            <div class="col-lg-8">
                                <asp:DropDownList runat ="server" CssClass="form-control " 
                                    ID="ListofCreditAccounts"></asp:DropDownList>
                                <asp:SqlDataSource runat ="server" ID="InvestmentAccountsList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT tbl_investment_accounts.datID, tbl_investment_accounts.datInvestmentName, tbl_client.datClientName FROM tbl_investment_accounts INNER JOIN tbl_client ON tbl_investment_accounts.datClientID = tbl_client.datID" ></asp:SqlDataSource>
                                <asp:SqlDataSource runat ="server" ID="LoanAccountsList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT tbl_loan_accounts.datID, tbl_loan_accounts.datAccountNumber, tbl_loan_accounts.datClientFullName, tbl_client.datClientName FROM tbl_loan_accounts INNER JOIN tbl_client ON tbl_loan_accounts.datClientID = tbl_client.datID" ></asp:SqlDataSource>
                                <asp:SqlDataSource runat ="server" ID="SysLedgersList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT datID, datDescription, datLedgerCode FROM sys_ledgers" ></asp:SqlDataSource>
                                
                            </div>
                            <asp:Button ID="btnOpenAccount" class="btn btn-xs btn-success col-md-2" 
                                runat="server" Text="OPEN" onclick="btnOpenAccount_Click" />
                        </div>
                        <hr />
                    </div>
                    <asp:Panel runat ="server" ID ="transactionsPanel">  
                        <div class="col-md-12 alert alert-info" style="padding: 8px">
                            <a class="close" data-dismiss="alert" href="#">×</a> <span>Client Information</span>
                            <hr style="margin: 2px 0; color: White" />
                            <div class="col-md-4">
                                <span class="text-warning">Client Name:</span> <span id="lblapplicantName" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Amount:</span> <span id="lblInvestmentAmount"
                                    runat="server"></span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Name:</span> <span id="lblInvestmentName" runat="server">
                                </span>
                                <br />
                            </div>
                        </div>
                        <hr />
                    <legend>
                        <h6>
                           Voucher Info</h6>
                    </legend>
                    <div class="col-md-12">
                        <br style="clear: both" />
                    </div>
                    <div class="col-md-12">
                        <input id="editskip" type="hidden" runat="server" />
                        <div class="form-group">
                        <label class="col-md-2 control-label">
                            Date</label>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtDate" CssClass="form-control input-sm my-picker" runat="server"></asp:TextBox>
                            </label>
                        </div>
                        <label class="col-lg-2 control-label" for="optionsCheckbox">
                                Description
                            </label>
                            <div class="col-lg-6">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNarration"
                                    autocomplete="off">
                            </div>
                        </div>
                        <hr />
                        <legend>
                        <h6>
                           Transaction Entries</h6>
                        </legend>
                        <div class="form-group">
                            <label class="col-lg-1 control-label" for="optionsCheckbox">
                                Account</label>
                            <div class="col-lg-3">
                                <asp:DropDownList ID="ddlDebitAccountList" CssClass="form-control" runat="server">
                                </asp:DropDownList>
                            </div>
                            <label class="col-lg-2 control-label" for="typeahead">
                                Payment Mode</label>
                            <div class="col-lg-2">
                                <asp:DropDownList ID="ddlPaymentType" CssClass="form-control " runat="server"
                                    DataSourceID="SqlDataSource3" DataTextField="datDescription" DataValueField="datID"
                                    AppendDataBoundItems="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_payment_modes]"></asp:SqlDataSource>
                            </div>
                            <label class="col-lg-1 control-label" for="optionsCheckbox">
                                Amount</label>
                            <div class="col-lg-2">
                            <asp:TextBox runat ="server" ID ="txtAmount"  CssClass="form-control input-sm col-md-6" AutoCompleteType="Disabled" ></asp:TextBox>
       
                            </div>
                            <asp:Button ID="btnAddEntry" class="btn btn-xs btn-success col-md-1" 
                                runat="server" Text="Add" onclick="btnAddEntry_Click"/>
                            
                        </div>
                        <hr />
                        <legend>
                        <h6>
                           List of Entries in Current Voucher</h6>
                        </legend>
                    <div class="col-md-12">
                        <%--<input type="hidden" id="counter" runat="server" />--%>
                        <asp:GridView ID="gvTranEntries" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" DataKeyNames="datID" DataSourceID="SqlDataSource1" OnRowDataBound="gvTranEntries_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="datAccountName" HeaderText="Account Name" 
                                        SortExpression="AccountName" />
                                    <asp:BoundField DataField="datPaymentModeName" HeaderText="Payment Mode" 
                                        SortExpression="PaymentMode" />
                                    <asp:BoundField DataField="datAmount" HeaderText="Amount" SortExpression="datAmount" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton runat ="server" ID="LinkDelete" OnClick="deleteItem_Click" CommandName="itemId" CssClass="btn btn-xs btn-success col-md-4" Text="Delete">
                                            <i class="glyphicon glyphicon-remove"></i>Delete
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                            SelectCommand="GetTempTransactionsByEntryKey" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="entryKey" SessionField="TempTranKey" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <p>
                            <label>
                                Total</label>
                            <asp:TextBox CssClass="pull right" Style="border: none" ID="lblTotal" runat="server"></asp:TextBox>
                        </p>
                        <hr />
                    </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group center">
                            <asp:Button ID="btnFinalize" class="btn btn-xs btn-success col-md-2"
                                runat="server" Text="SUBMIT" onclick="btnFinalize_Click" />
                        </div>
                    </div>
                    </asp:Panel>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Panel> 

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});    
</script>