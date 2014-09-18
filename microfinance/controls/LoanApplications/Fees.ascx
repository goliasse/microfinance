<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Fees.ascx.cs" Inherits="controls_Fees" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<script type="text/javascript" language="javascript">
    function calcpercent()
    {
       var amt=$('#<%=txtLoanAmt.ClientID %>').val();
       var percent=$('#<%= txtPercentage.ClientID %>').val(); 
      if(!((isNaN(amt)||(isNaN(percent)))))
      {
        var value=parseFloat((percent/100)*amt).toFixed(2);
        $('#<%=txtAmt.ClientID %>').val(value);
            }
    }
    function calcamt()
    {
        var lnamt=$('#<%=txtLoanAmt.ClientID %>').val();
        var amt=$('#<%= txtAmt.ClientID %>').val();
        if(!((isNaN(lnamt)||(isNaN(amt)))))
        {       
             var value=parseFloat((amt/lnamt)*100).toFixed(2);
             $('#<%= txtPercentage.ClientID %>').val(value);
        }
    
    }
</script>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Fees</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Fees</h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Loan Amount</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtLoanAmt" autocomplete="off" readonly="readonly">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Fee </label>
                    <div class="col-lg-9">
                        <%--<asp:ComboBox CssClass="chzn-single" ID="ComboBox1" runat="server">
                        </asp:ComboBox>--%>
                        <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txttelno" autocomplete="off">--%>
                        <asp:DropDownList cssclass="form-control" ID="ddlFee" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_fee_types]">
                       </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="">Percentage</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" onblur="calcpercent()" class="form-control input-sm col-md-6" id="txtPercentage" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Amount</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" onblur="calcamt()" class="form-control input-sm col-md-6" id="txtAmt" autocomplete="off">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="txtMobile">Payment Method</label>
                    <div class="col-lg-9">
                        <asp:DropDownList cssclass="form-control" ID="ddlPaymentMode" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_fee_payment_modes]">
                       </asp:SqlDataSource>
                    </div>
                </div>
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                   </div>
                </div>
                <asp:CustomValidator ID="vFees" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                   <p id="ErrMsg" runat="server"></p>
                </asp:CustomValidator>
            </fieldset>
           <hr />
            <asp:GridView CssClass="table table-striped" ID="gvFees" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource3" onrowdatabound="gvFees_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="feetype" HeaderText="Fee Type" 
                        SortExpression="feetype" />
                    <asp:BoundField DataField="paymentmode" HeaderText="Payment Method" 
                        SortExpression="paymentmode" />
                    <asp:BoundField DataField="datPercentage" HeaderText="Percentage" 
                        SortExpression="datPercentage" />
                    <asp:BoundField DataField="datAmount" HeaderText="Amount" 
                        SortExpression="datAmount" />
                    <asp:TemplateField HeaderText="Action">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"  Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i> Edit
                                </asp:HyperLink>                   
                                <asp:HyperLink ID="hyperDelete" runat="server"  CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1" Text="Delete">
                                    <i class="glyphicon glyphicon-remove"> </i> Delete
                                </asp:HyperLink>
                             </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="getLoanFees" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                        Type="Int32" />
                    <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <hr />
            <p><label>Updated Loan Amount: </label><asp:TextBox ID="txtUpdatedLoanAmt" CssClass="pull right" style="border:none" runat="server"></asp:TextBox> </p>
            <p><label>Update Amount to be disbursed:</label><asp:TextBox ID="txtUpddateDisburseAmt" CssClass="pull right" style="border:none" runat="server"></asp:TextBox></p>
            <hr />
        </div>
    </div>
  </div>
</div>