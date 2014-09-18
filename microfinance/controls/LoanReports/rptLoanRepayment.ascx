<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rptLoanRepayment.ascx.cs" Inherits="controls_LoanReports_rptLoanRepayment" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <style type="text/css">
        .form-group{margin-bottom:0}
    </style>
 <h6><small>Loan Repayment Report</small></h6>
 <div class="col-md-12 alert alert-info" style="max-height:140px;min-height:80px">
        <p><b>Parameters</b><hr style="margin:3px"/></p>
        <br />
        <div class="form-horizontal">
            <div id="ctrlbranch" runat="server"  class="col-md-6 form-group">
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
            <div id="ctrlCT"  class="col-md-6 form-group">
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
            <div id="ctrlFromDT" runat="server"  class="col-md-6 form-group">
                <label class="col-md-5"> From Date:</label>
                <div class="col-md-7">
                    <asp:TextBox ID="txtFromDT" CssClass="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                </div>
            </div>
            <div id="ctrlToDT" runat="server"  class="col-md-6 form-group">
                <label class="col-md-5"> To Date:</label>
                <div class="col-md-7">
                    <asp:TextBox ID="txtToDT" CssClass="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
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
        <rsweb:ReportViewer ID="rvLoanRepayment" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" Height="400px" Width="100%">
            <LocalReport ReportPath="report\Loan Reports\rLoanRepayment.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                        Name="LoanReport_Report_Loan_Repayment" />
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                        Name="mainDS_SetupDetails" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>   
        
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetSetupDetails" 
            TypeName="mainDSTableAdapters.SetupDetailsTableAdapter">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetReport_Loan_Repayment" 
            TypeName="LoanReportTableAdapters.Report_Loan_RepaymentTableAdapter">
            <SelectParameters>
                <asp:Parameter DefaultValue="1/1/1900" Name="FromDT" Type="String" />
                <asp:Parameter DefaultValue="1/1/1900" Name="ToDT" Type="String" />
                <asp:ControlParameter ControlID="ddlBranch" Name="BranchID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlct" Name="CMID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        
    <hr />
    </div>
     <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>