<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InitialInterview.ascx.cs"
    Inherits="controls_InitialInterview" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %> --%>

<script type="text/javascript" language="javascript">
     function HideShowBusiness()
     {
           var ddl=$('#<%= ddlLoanType.ClientID %>').val();
           
           if(ddl==1||ddl==4||ddl==5)
           {
             $('#<%= loantypePanel.ClientID %>').css("display","none"); 
                    }
           else if(ddl==2 || ddl==3)
           {
               $('#<%= loantypePanel.ClientID %>').css("display","block");
           
                 }
     
            }
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Intial Interview
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Intial Interview</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <input type="hidden" runat="server" id="appCode" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Loan Type
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control" ID="ddlLoanType" runat="server" DataSourceID="SqlDataSource3"
                                DataTextField="datDescription" onchange="HideShowBusiness()" DataValueField="datID"
                                AppendDataBoundItems="True">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_loan_types]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div runat="server" id="loantypePanel" style="display: none">
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">
                                Nature Of Bussiness
                            </label>
                            <div class="col-lg-9">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNatureOfBusiness"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">
                                Type Of Business
                            </label>
                            <div class="col-lg-9">
                                <asp:DropDownList CssClass="form-control" ID="ddlTypeOfBusiness" runat="server" DataSourceID="SqlDataSource1"
                                    DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="true">
                                    <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_business_types]"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">
                                Number of Years</label>
                            <div class="col-lg-9">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNoYrs"
                                    autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Ave. Monthly Income
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAveMonthlyIncome"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Loan Purpose
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control" ID="ddlloanpurpose" runat="server" DataSourceID="SqlDataSource4"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_loan_purpose]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Loan Amount
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtLoanAmount"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Duration [Months]
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDuration"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Interest Rate
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-5" id="txtInterestrate"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Proposed First Repayment Date
                        </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtFirstPaymentDate" class="form-control input-sm col-md-6 my-picker"
                                AutoCompleteType="None" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div style="display: none" class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Frequency
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control" ID="ddlFrequency" runat="server" DataSourceID="SqlDataSource6"
                                DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_frequencies]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Interest Rate Type
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control" ID="ddlInterestRate" runat="server" DataSourceID="SqlDataSource5"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_interest_rate_types]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="col-lg-10">
                        <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="Update"
                            OnClick="btnSave_Click" />
                    </div>
                    <div class="col-md-12">
                        <asp:CustomValidator ID="vOwnership" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                            ErrorMessage="">
                            <h6 class="text-center">
                                <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                            <hr style="margin: 1px" />
                            <p id="ErrMsg" runat="server">
                            </p>
                        </asp:CustomValidator>
                    </div>
            </div>
        </div>
        </fieldset>
    </div>
</div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});    
</script>

