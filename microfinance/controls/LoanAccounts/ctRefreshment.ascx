<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctRefreshment.ascx.cs" Inherits="controls_LoanAccounts_ctRefreshment" %>
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title"><h7><b> Account Refreshment</b></h7></div>
        </div>
        <div class="bootstrap-admin-panel-content">
            <div class="form-horizontal">
            <h4><small>Provide the new parameters for refreshing account</small></h4>
            <hr />
                <div class="form-group">
                    <label class="col-md-3">Loan Type</label>
                    <div class="col-md-8">
                        <asp:DropDownList ID="ddlLoanType" CssClass="form-control input-sm" 
                            runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" 
                            DataTextField="datDescription" DataValueField="datID">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_loan_types]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Loan Amount</label>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtLoanAmount" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Duration</label>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtDuration"  CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Interest Rate</label>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtIntRate"   CssClass="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">First Payment Date</label>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtFirstPaymentDate"  CssClass="form-control input-sm my-picker" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Interest Rate Type</label>
                    <div class="col-md-8">
                        <asp:DropDownList ID="ddlInterestRateType"  CssClass="form-control input-sm" 
                            runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2" 
                            DataTextField="datDescription" DataValueField="datID">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datDescription], [datID] FROM [opt_interest_rate_types]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">New Credit Team</label>
                    <div class="col-md-8">
                        <asp:DropDownList ID="ddlCT"  CssClass="form-control input-sm" runat="server" 
                            AppendDataBoundItems="True" DataSourceID="SqlDataSource3" 
                            DataTextField="datDescription" DataValueField="datID">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [sys_credit_teams]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <asp:Button ID="btnSaveNewApplication" 
                            CssClass="btn btn-xs btn-success col-md-4" runat="server" 
                            Text="Start Account Refreshment" onclick="btnSaveNewApplication_Click" />
                    </div>
                </div>
            </div>
            <hr />
            <div class="col-md-12">
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-xs btn-success col-md-4" Text="Complete Account Refreshment" />
            </div>
            <br  style="clear:both"/>
        </div>  
    </div>
</div>
<%--<asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtFirstPaymentDate" Format="dd/MM/yyyy" runat="server">
</asp:CalendarExtender>--%>
