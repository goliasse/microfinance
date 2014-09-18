<%@ Control Language="C#" AutoEventWireup="true" CodeFile="creditinformation.ascx.cs" Inherits="controls_creditinformation" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Credit Information </div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Credit Information </h5></legend>
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Creditor </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtcreditor" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Description</label>
                    <div class="col-lg-9">
                        <textarea runat=server id="txtDescription" class="form-control input-sm col-md-6" style="height:80px"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Credit Value </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtcreditvalue" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Monthly Repayment</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMonthlyRepayment" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="txtMobile">Outstanding Amount</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtOutstandingamt" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="txtMobile">Issue Date</label>
                    <div class="col-lg-9">
                       <%-- <input runat=server type="text" class="form-control input-sm col-md-6" id="txtIssueDate" autocomplete="off">--%>
                        <asp:TextBox ID="txtIssueDate"  runat="server" class="form-control input-sm col-md-6 my-picker"  ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="txtMobile">Expiry Date</label>
                    <div class="col-lg-9">
                        <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtExpiryDate" autocomplete="off" />--%>
                        <asp:TextBox ID="txtExpiryDate" class="form-control input-sm col-md-6 my-picker" runat="server" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-9">
                        <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                        <%--<button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
                <asp:CustomValidator ID="vCreditInformation" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                  <p id="ErrMsg" runat="server"></p>
                </asp:CustomValidator>
            </fieldset>
            
        <hr />  
        <asp:GridView CssClass="table table-striped table-bordered" ID="gvCreditinformation" runat="server"  DataKeyNames="datID"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" 
                onrowdatabound="gvCreditinformation_RowDataBound">
            <Columns>
                <asp:BoundField DataField="datCreditor" HeaderText="Creditor" 
                    SortExpression="datCreditor" />
                <asp:BoundField DataField="datCreditValue" HeaderText="Credit Value" 
                    SortExpression="datCreditValue" />
                <asp:BoundField DataField="datMonthlyObligation" 
                    HeaderText="Monthly Obligation" SortExpression="datMonthlyObligation" />
                <asp:BoundField DataField="datOutstanding" HeaderText="Outstanding" 
                    SortExpression="datOutstanding" />
                 <asp:TemplateField HeaderText="Action">
                         <ItemTemplate>
                             <asp:HyperLink ID="hyperEdit" runat="server"  CssClass="btn btn-xs btn-success col-md-5"  Text="Edit">
                                <i class="glyphicon glyphicon-pencil"></i> Edit 
                            </asp:HyperLink>                    
                            <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"  Text="Delete">
                                <i class="glyphicon glyphicon-remove"></i>  Delete 
                            </asp:HyperLink>
                         </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetCreditInformation" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                        Type="Int32" />
                    <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        
    </div>
  </div>
</div>
 <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
         
         function checkDateInterval()
         {
            var startdate =$('#<%=txtIssueDate.ClientID %>').val();
            alert(startdate);
            var endtate = $('#<%=txtExpiryDate.ClientID %>').val();
            if(startdate !=null)
            {
                if(endtate != null)
                {
            var dt = new Date(startdate);
            alert(dt.getTime());
                    if( (new Date(startdate).getTime() > new Date(endtate).getTime()))
                    {
                        alert("Date Issued cannot be greater that the expiry date ");
                    }
                    else{ return; }
                }
                else{ /*alert("Provide a valid expiry date");*/}
            }
             else{ /* alert("Provide a valid issue date");*/ }
         
         }
 </script>