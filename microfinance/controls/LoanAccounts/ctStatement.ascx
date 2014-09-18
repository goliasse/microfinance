<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctStatement.ascx.cs" Inherits="controls_LoanAccounts_ctStatement" %>
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
   <div class="panel panel-default bootstrap-admin-no-table-panel">
       <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Client Statement</div>
       </div>
       <div class="col-lg-12">
       <p><h6><b> Client's  Account Statement  as at <span id="todaysDate" runat="server"></span></b></h6>
                
       <p class="pull-right"><i><small>All amount in GH cedis</small></i></p>
       <hr />
      <div class="col-md-12">
            <asp:GridView ID="gvStatement" CssClass="table" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="ft_datID" DataSourceID="SqlDataSource1" 
                    onrowdatabound="gvStatement_RowDataBound" >
                    <Columns>
                        <asp:TemplateField></asp:TemplateField>
                        <asp:BoundField DataField="ft_datemodified" HeaderText="Date" 
                            SortExpression="ft_datemodified" DataFormatString="{0:MMMM d, yyyy}" />
                        <asp:BoundField DataField="ft_datDescription" HeaderText="Description" 
                            SortExpression="ft_datDescription" />
                        <asp:BoundField DataField="ft_datDebitAmount" HeaderText="Debit" 
                            SortExpression="ft_datDebitAmount" />
                        <asp:BoundField DataField="ft_datCreditAmount" HeaderText="Credit" 
                            SortExpression="ft_datCreditAmount" />
                        <asp:TemplateField HeaderText="Balance"></asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                    SelectCommand="GetClientStatement" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="AccountID" SessionField="AccountID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br style="clear:both" />
            <hr />
            <div class="col-md-12">
                <input type="button" class="btn btn-xs btn-success col-md-3" value="Print"  onclick="loadRptModal()" />
                <%--<asp:Button ID="btnPrintRpt"  CssClass="btn btn-xs btn-success col-md-3"
                    runat="server" Text="Print"  OnClientClick="loadRptModal()" />--%>
            </div>
            <br />
            <br />
       </div>
    </div>
    <div class="reportModal" style="display:none">
    <p>Client Statement</p>
    <hr />
        <div class="col-md-12">
        <p>
            <rsweb:ReportViewer ID="rvStatement" runat="server" Font-Names="Verdana" 
                Font-Size="8pt"  Width="100%" Height="400px">
                <LocalReport ReportPath="report\Loan Accounts\rClientStatement.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                            Name="LoanAccountDS_GetLoanAccount" />
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                            Name="LoanAccountDS_GetClientReportDetails" />
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" 
                            Name="LoanAccountDS_GetClientStatement" />
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" 
                            Name="mainDS_SetupDetails" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetSetupDetails" 
                TypeName="mainDSTableAdapters.SetupDetailsTableAdapter">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetClientStatement" 
                TypeName="LoanAccountDSTableAdapters.GetClientStatementTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="AccountID" SessionField="AccountID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetClientReportDetails" 
                TypeName="LoanAccountDSTableAdapters.GetClientReportDetailsTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="AccID" SessionField="AccountID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetLoanAccount" 
                TypeName="LoanAccountDSTableAdapters.GetLoanAccountTableAdapter" >
                <SelectParameters>
                    <asp:SessionParameter Name="ID" SessionField="AccountID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            </p>
            <hr />
            <div class="col-lg-12">
                <input type="button" class="btn btn-xs btn-success col-md-3" value="Close"  onclick="unloadRptModal()" />
               <%-- <asp:Button ID="btnClose"  CssClass="btn btn-xs btn-success col-md-3" 
                    runat="server" Text="Close" onclick="btnClose_Click" />--%>
            </div>
            <br style="clear:both" />
        </div>
    </div>
    <br style="clear:both" />
</div>