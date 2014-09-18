<%@ Control Language="C#" AutoEventWireup="true" CodeFile="declaration.ascx.cs" Inherits="controls_declaration" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Declaration</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in"
            style="padding: 4px 2px">
            <div class="col-md-12">
                <hr />
                <rsweb:ReportViewer ID="rvPreagreement" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Height="400px">
                    <LocalReport ReportPath="report\declaration.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                                Name="ReportDS_GetSetupDetails" />
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                                Name="ReportDS_GetRptClientProfile" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetClientProfile" 
                    TypeName="ReportDSTableAdapters.GetRptClientProfileTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="clientID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetSetupDetails" 
                    TypeName="ReportDSTableAdapters.GetSetupDetailsTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
            <hr />
        </div>
    </div>
</div>
