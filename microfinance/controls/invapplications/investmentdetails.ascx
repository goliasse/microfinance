<%@ Control Language="C#" AutoEventWireup="true" CodeFile="investmentdetails.ascx.cs"
    Inherits="controls_invapplications_investmentdetails" %>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Investment Details
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h6>
                            Investment Details</h6>
                    </legend>
                    <input type="hidden" id="type" runat="server" /> 
                    <input type="hidden" id="editskip" runat="server" /> 
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtName" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Type</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlType" class="form-control" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SqlDataSource1" DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_investment_types]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Investment Amount</label>
                        <div class="col-md-9 control-label">
                            <input type="text" id="txtInvestmentAmt" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Interest Rate per Annum</label>
                        <div class="col-md-9 control-label">
                            <input type="text" id="txtRatePerAnnum" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Terms</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlTerms" class="form-control" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value="-1">--Select --</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_terms]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Frequency of Interest</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlFrequencyInt" class="form-control" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_frequencies_investments]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Mode of Investment
                        </label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlModeOfInv" class="form-control" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SqlDataSource4" DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_payment_modes]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Source of Funds</label>
                        <div class="col-md-9">
                            <textarea id="txtFunds" cols="20" runat="server" class="input-sm form-control" rows="2"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Verified</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlVerifed" class="form-control" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SqlDataSource5" DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesno]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-9">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="Save"
                                OnClick="btnSave_Click" />
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
                            <td >
                            </td>
                            <td >
                            </td>
                            <td >
                            </td>
                        </tr>
                     </table>
               </div>
            </div>
        </div>
    </div>
</div>
