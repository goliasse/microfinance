<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mainTransactions.ascx.cs"
    Inherits="controls_mainTransactions" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<script type="text/javascript" language="javascript">
    function loadRptModal(){
        $.blockUI({ message: $('.reportModal'), css: { width: '60%', margin:'45px auto',left:'20%',top:'55px' } }); 
    }
    
    function unloadRptModal(){
        $.unblockUI(); 
    }
</script>

<div class="row">

    <script type="text/javascript">
	$(document).ready(function(){
		$('#<%=txtDBvalue.ClientID %>').click(function() {
			$('#<%=txtDBvalue.ClientID %>').val("")
			$('#<%=txtCRvalue.ClientID %>').val("0.00")
		});
		
		$('#<%=txtCRvalue.ClientID %>').click(function() {
			$('#<%=txtCRvalue.ClientID %>').val("")
			$('#<%=txtDBvalue.ClientID %>').val("0.00")
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
                Financial Entry
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Transaction</h5>
                    </legend>
                    <div class="col-md-12">
                        <div>
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label class="control-label" for="optionsCheckbox">
                                        Client Name:</label></div>
                                <div class="col-lg-8">
                                    <span runat="server" id="lblClient"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label class="control-label" for="optionsCheckbox">
                                        Total Amt:</label></div>
                                <div class="col-lg-8">
                                    <span runat="server" id="lbltotalamt"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label class=" control-label" for="optionsCheckbox">
                                        Date:</label></div>
                                <div class="col-lg-8">
                                    <span runat="server" id="lbldate"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label class="col-lg-5control-label" for="optionsCheckbox">
                                        Branch:</label></div>
                                <div class="col-lg-8">
                                    <span runat="server" id="lblbranch"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-5 col-md-offset-4">
                                    <input type="button" value="View Statement" onclick="loadRptModal()" class="btn btn-xs btn-success" /></div>
                            </div>
                            <hr />
                        </div>
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
                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
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
                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
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
                                Debit</label>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDBvalue"
                                    value="0.00" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-4 control-label" for="optionsCheckbox">
                                Credit</label>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtCRvalue"
                                    value="0.00" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnSaveTransaction" class="btn btn-xs btn-success col-md-2 col-md-offset-2"
                                runat="server" Text="ADD" OnClick="btnSaveTransaction_Click" />
                        </div>
                        <hr />
                    </div>
                    <div class="col-md-12">
                        <asp:GridView ID="gvDisburseLoan" CssClass="table" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource3" DataKeyNames="datIndex" OnRowDataBound="gvDisburseLoan_RowDataBound1">
                            <Columns>
                                <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                                <asp:BoundField DataField="paymentmethod" HeaderText="Payment Method" SortExpression="paymentmethod" />
                                <asp:BoundField DataField="AccountName" HeaderText="Account Name" SortExpression="AccountName" />
                                <asp:BoundField DataField="datDebit" HeaderText="Debit" SortExpression="datDebit" />
                                <asp:BoundField DataField="datCredit" HeaderText="Credit" SortExpression="datCredit" />
                                <asp:BoundField DataField="datTotal" HeaderText="Total" SortExpression="datTotal" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hyperDelete" CssClass="btn btn-xs btn-success col-md-8" runat="server"
                                            Text="Delete">
                                        <i class="glyphicon glyphicon-remove"> </i> Delete 
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                            SelectCommand="GetTransactionDetailsAcc1" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="AccID" SessionField="AccountID" Type="Int32" />
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
                            <asp:Button ID="btnFinalize" class="btn btn-xs btn-success col-md-2" runat="server"
                                Text="SUBMIT" OnClick="btnFinalize_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    <div class="reportModal" style="display: none">
        <p>
            Client Statement</p>
        <hr />
        <div class="col-md-12">
            <p>
                <rsweb:ReportViewer ID="rvStatement" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Height="400px">
                    <LocalReport ReportPath="report\Loan Accounts\rClientStatement.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="LoanAccountDS_GetLoanAccount" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="LoanAccountDS_GetClientReportDetails" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" Name="LoanAccountDS_GetClientStatement" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" Name="mainDS_SetupDetails" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetSetupDetails" TypeName="mainDSTableAdapters.SetupDetailsTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetClientStatement" TypeName="LoanAccountDSTableAdapters.GetClientStatementTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AccountID" SessionField="AccountID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetClientReportDetails" TypeName="LoanAccountDSTableAdapters.GetClientReportDetailsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="AccID" SessionField="AccountID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetLoanAccount" TypeName="LoanAccountDSTableAdapters.GetLoanAccountTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter Name="ID" SessionField="AccountID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </p>
            <hr />
            <div class="col-lg-12">
                <input type="button" class="btn btn-xs btn-success col-md-3" value="Close" onclick="unloadRptModal()" />
               
            </div>
            <br style="clear: both" />
        </div>
    </div>
</div>
