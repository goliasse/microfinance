<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rptFinancialAging.ascx.cs" Inherits="controls_LoanReports_rptFinancialAging" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<style type="text/css">
    .form-group{margin-bottom:0}
</style>
 <h6><small>Financial Aging Report</small></h6>
 <div class="col-md-12 alert alert-info" style="max-height:140px;min-height:80px">
        <p><b>Parameters</b><hr style="margin:3px"/></p>
        <br />
        <div class="form-horizontal">
            <div id="ctrlbranch" runat="server"  class="col-md-4 form-group">
                <label class="col-md-5"> Branch</label>
                <div class="col-md-7">
                    <asp:DropDownList ID="ddlBranch" class="form-control" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="SqlDataSource2" 
                        DataTextField="datDescription" DataValueField="datID" AutoPostBack="True" >
                        <asp:ListItem Value="0">--All--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="SELECT [datID], [datDescription] FROM [tbl_teams]">
                    </asp:SqlDataSource>
                </div>
            </div>
            <div id="ctrlCT"  class="col-md-4 form-group">
                <label class="col-md-5"> Credit Team</label>
                <div class="col-md-7">
                    <asp:DropDownList ID="ddlct" class="form-control" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="SqlDataSource1" 
                        DataTextField="datDescription" DataValueField="datID">
                        <asp:ListItem Value="0">--All--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="SELECT [datDescription], [datID] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlBranch" Name="datTeamID" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
            <div id="ctrlCategory"  class="col-md-4 form-group">
                <label class="col-md-5"> Category</label>
                <div class="col-md-7">
                    <asp:DropDownList ID="ddlCategory" class="form-control" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="SqlDataSource1" 
                        DataTextField="datDescription" DataValueField="datID">
                        <asp:ListItem Value="0">--All--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="SELECT [datDescription], [datID] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlBranch" Name="datTeamID" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
             <div id="ctrlPerforming"  class="col-md-4 form-group">
                <label class="col-md-5"> Performance</label>
                <div class="col-md-7">
                    <asp:DropDownList ID="ddlPerformance" class="form-control" runat="server" 
                        AppendDataBoundItems="True" DataSourceID="SqlDataSource1" 
                        DataTextField="datDescription" DataValueField="datID">
                        <asp:ListItem Value="0">--All--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="SELECT [datDescription], [datID] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlBranch" Name="datTeamID" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
             <div id="ctrlDate" runat="server"  class="col-md-4 form-group">
                <label class="col-md-5"> Date:</label>
                <div class="col-md-7">
                    <asp:TextBox ID="txtDate" CssClass="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                </div>
            </div>
             <div id="crtlViewBtn" runat="server"  class="col-md-12 form-group">
                <div class="col-md-7">
                    <asp:Button ID="btnViewReport" CssClass="btn btn-xs btn-success col-md-3" 
                        runat="server" Text="View Report" onclick="btnViewReport_Click" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-12" style="min-height:500px">
    <hr style="margin:3px" />
        <rsweb:ReportViewer ID="rvAging" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" Width="100%" Height="400px" ZoomMode="PageWidth">
            <LocalReport ReportPath="report\Loan Reports\rFinancialAging.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1"  Name="LoanReport_Report_Financial_Aging" />
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                        Name="mainDS_SetupDetails" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>    
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server"  
            SelectMethod="GetSetupDetails" 
            TypeName="mainDSTableAdapters.SetupDetailsTableAdapter" 
            OldValuesParameterFormatString="original_{0}">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            SelectMethod="GetReport_Financial_Aging" 
            TypeName="LoanReportTableAdapters.Report_Financial_AgingTableAdapter" 
            OldValuesParameterFormatString="original_{0}">
            <SelectParameters>
                <asp:Parameter Name="date" Type="String" />
                <asp:ControlParameter ControlID="ddlBranch" Name="BranchID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlct" Name="CMID"  PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlPerformance" Name="Type"   PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlCategory" Name="category"  PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    <hr />
    </div>
     <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>
<%--<asp:CalendarExtender  runat="server" TargetControlID="txtDate" Format="dd/MM/yyyy">
</asp:CalendarExtender>--%>