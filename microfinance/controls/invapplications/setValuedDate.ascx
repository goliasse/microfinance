<%@ Control Language="C#" AutoEventWireup="true" CodeFile="setValuedDate.ascx.cs"
    Inherits="controls_invapplications_setValuedDate" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<div class="row">

    <script type="text/javascript" language="javascript">
    function loadRptModal(){
        $.blockUI({ message: $('.reportModal'), css: { width: '60%', margin:'45px auto',left:'20%',top:'55px' } }); 
    }
    
    function unloadRptModal(){
        $.unblockUI(); 
    }
    </script>

    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Set Value Date
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal" id>
                <fieldset>
                    <legend>
                        <h6>
                            Set Value Date</h6>
                    </legend>
                    <hr />
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Value Date</label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtValue" CssClass="form-control input-sm my-picker" runat="server"></asp:TextBox>
                            </label>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:Button ID="btnSave" CssClass="btn btn-success btn-xs col-md-3" runat="server"
                                Text="Save" OnClick="btnSave_Click" />
                            <input type="button" class="btn btn-success btn-xs col-md-3 col-md-offset-1" value="Print Certificate"
                                onclick="loadRptModal()" />
                            <%--<asp:Button ID="btnPrintCert" CssClass="btn btn-success btn-xs col-md-3 col-md-offset-1" runat="server"
                                Text="Print Certificate" />--%>
                        </div>
                    </div>
                </fieldset>
            </div>
            <hr />
            <div id="dispPayment" class="col-md-12">
                <h5>
                    Interest Payment Schedule</h5>
                <div class="col-md-12">
                    <table class="table table-bordered col-lg-12" id="TABLE1" runat="server">
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="reportModal" style="display: none">
        <p>
            Investment Certificate</p>
        <hr />
        <div class="col-md-12">
            <p>
                <rsweb:reportviewer id="rvStatement" runat="server" font-names="Verdana" font-size="8pt"
                    width="100%" height="400px">
                <LocalReport ReportPath="report\InvestmentReports\InvCert.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                            Name="ReportDS_GetSetupDetails" />
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                            Name="ReportDS1_tbl_investment_application" />
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" 
                            Name="ReportDS1_tbl_investment_application1" />
                    </DataSources>
                </LocalReport>
                </rsweb:reportviewer>
            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetPatchUpInvApp" 
                TypeName="ReportDS1TableAdapters.tbl_investment_application1TableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="datInvestmentAmount" Type="Decimal" />
                </InsertParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetRptInvestmentDetails" 
                TypeName="ReportDS1TableAdapters.tbl_investment_applicationTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetSetupDetails" 
                TypeName="ReportDSTableAdapters.GetSetupDetailsTableAdapter">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            </p>
            <hr />
            <div class="col-lg-12">
                <input type="button" class="btn btn-xs btn-success col-md-3" value="Close" onclick="unloadRptModal()" />
                <%-- <asp:Button ID="btnClose"  CssClass="btn btn-xs btn-success col-md-3" 
                    runat="server" Text="Close" onclick="btnClose_Click" />--%>
            </div>
            <br style="clear: both" />
        </div>
    </div>
    <br style="clear: both" />
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});    
</script>

