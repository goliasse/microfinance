<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FinJournal.ascx.cs" Inherits="controls_Finance_FinJournal" %>

<asp:Panel CssClass="panel panel-default bootstrap-admin-no-table-panel" runat ="server" ID="VchTypeSelPanel">
    <div class="panel-heading">
    <div class="col-md-12">
        <div class="form-group">
            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Select Journal Voucher Type:</label>
           <div class="col-lg-3">
                <asp:DropDownList ID="ddlVoucherType" runat ="server" CssClass="form-control " 
                          DataSourceID="dsVoucherTypes" DataTextField="datName" DataValueField="datName"></asp:DropDownList>
                <asp:SqlDataSource runat ="server" ID="dsVoucherTypes" 
                   ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                  SelectCommand="getVoucherTypeByType" SelectCommandType="StoredProcedure">
                  <SelectParameters>
                       <asp:Parameter DefaultValue="3" Name="Type" Type="Int32" />
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
                Journal Voucher <asp:Label ID="subVchName" runat ="server" ></asp:Label>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div id="dispInfo" class="form-horizontal">
                <fieldset>
                    <asp:SqlDataSource runat ="server" ID="InvestmentAccountsList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT tbl_investment_accounts.datID, tbl_investment_accounts.datInvestmentName, tbl_client.datClientName FROM tbl_investment_accounts INNER JOIN tbl_client ON tbl_investment_accounts.datClientID = tbl_client.datID" ></asp:SqlDataSource>
                                <asp:SqlDataSource runat ="server" ID="LoanAccountsList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT tbl_loan_accounts.datID, tbl_loan_accounts.datAccountNumber, tbl_loan_accounts.datClientFullName, tbl_client.datClientName FROM tbl_loan_accounts INNER JOIN tbl_client ON tbl_loan_accounts.datClientID = tbl_client.datID" ></asp:SqlDataSource>
                                <asp:SqlDataSource runat ="server" ID="SysLedgersList" 
                                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                    SelectCommand="SELECT datID, datDescription, datLedgerCode FROM sys_ledgers" ></asp:SqlDataSource>
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
                    </div>
                    <legend>
                        <h6>
                            Debit Entries</h6>
                    </legend>
                    <div class="form-group">
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Account</label>
                        <div class="col-lg-3">
                            <asp:DropDownList ID="ddlDebitAccountList" runat="server" 
                                CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Amount</label>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDebitAmount" runat="server" AutoCompleteType="Disabled" 
                                CssClass="form-control input-sm col-md-6"></asp:TextBox>
                        </div>
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Description</label>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDebitDescription" runat="server" 
                                AutoCompleteType="Disabled" CssClass="form-control input-sm col-md-6"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAddDebitEntry" runat="server" 
                            class="btn btn-xs btn-success col-md-1" onclick="btnAddDebitEntry_Click" 
                            Text="Add" />
                    </div>
                    <hr />
                    <legend>
                        <h6>
                            Credit Entries</h6>
                    </legend>
                    <div class="form-group">
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Account</label>
                        <div class="col-lg-3">
                            <asp:DropDownList ID="ddlCreditAccountList" runat="server" 
                                CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Amount</label>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtCreditAmount" runat="server" AutoCompleteType="Disabled" 
                                CssClass="form-control input-sm col-md-6"></asp:TextBox>
                        </div>
                        <label class="col-lg-1 control-label" for="optionsCheckbox">
                        Description</label>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtCreditDescription" runat="server" 
                                AutoCompleteType="Disabled" CssClass="form-control input-sm col-md-6"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAddCreditEntry" runat="server" 
                            class="btn btn-xs btn-success col-md-1" onclick="btnAddCreditEntry_Click" 
                            Text="Add" />
                    </div>
                    <hr />
                    <legend>
                        <h6>
                            List of Entries in Current Voucher</h6>
                    </legend>
                    <div class="col-md-12">
                        <%--<input type="hidden" id="counter" runat="server" />--%>
                        <asp:GridView ID="gvTranEntries" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-bordered" DataKeyNames="datID" 
                            DataSourceID="SqlDataSource1" OnRowDataBound="gvTranEntries_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="datAccountName" HeaderText="Account Name" 
                                    SortExpression="AccountName" />
                                <asp:BoundField DataField="datDebitAmount" HeaderText="Debit" 
                                    SortExpression="datDebitAmount" />
                                <asp:BoundField DataField="datCreditAmount" HeaderText="Credit" 
                                    SortExpression="datCreditAmount" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkDelete" runat="server" CommandName="itemId" 
                                            CssClass="btn btn-xs btn-success col-md-4" OnClick="deleteItem_Click" 
                                            Text="Delete">
                                            <i class="glyphicon glyphicon-remove"></i>Delete
                                            </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="GetTempTransactionsByEntryKey" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="entryKey" SessionField="TempTranKey" 
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <p>
                            <asp:TextBox runat="server" CssClass="pull right" 
                                Style="border: none">Credit</asp:TextBox>
                            <asp:TextBox runat="server" CssClass="pull right" 
                                Style="border: none">Debit</asp:TextBox>
                        <hr />
                            <label>
                            Total</label>
                            <asp:TextBox ID="lblCreditTotal" runat="server" CssClass="pull right" 
                                Style="border: none"></asp:TextBox>
                            <asp:TextBox ID="lblDebitTotal" runat="server" CssClass="pull right" 
                                Style="border: none"></asp:TextBox>
                        </p>
                        <hr />
                    </div>
                </fieldset></div>
            <div class="col-md-12">
                <div class="form-group center">
                    <asp:Button ID="btnFinalize" runat="server" 
                        class="btn btn-xs btn-success col-md-2" onclick="btnFinalize_Click" 
                        Text="SUBMIT" />
                </div>
            </div>
            </fieldset>
        </div>
    </div>
    </div>
</asp:Panel> 

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});    
</script>