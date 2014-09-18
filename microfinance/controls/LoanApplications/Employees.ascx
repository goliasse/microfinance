<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Employees.ascx.cs" Inherits="controls_Employees" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<script type="text/javascript" language="javascript">
    function AccumulateValue()
    {
       var value1=Number($('#<%=txtManagement.ClientID %>').val()); 
       var value2=Number($('#<%=txtSkilled.ClientID %>').val());
       var value3=Number($('#<%=txtunskilled.ClientID %>').val()); 
       var value4=Number($('#<%=txtCasual.ClientID %>').val()); 
                
      if(!((isNaN(value1))||(isNaN(value2))||(isNaN(value3))||(isNaN(value4))))
      {
             tot=0;
             var tot=tot+value1+value2+value3+value4;
             $('#<%= txtTotal.ClientID %>').val(tot);
        }
    }
   
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Employees</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Employees</h5>
                    </legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Management</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" onblur="AccumulateValue()" class="form-control input-sm col-md-6"
                                id="txtManagement" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Skilled
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" onblur="AccumulateValue()" class="form-control input-sm col-md-6"
                                id="txtSkilled" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Unskilled</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" onblur="AccumulateValue()" class="form-control input-sm col-md-6"
                                id="txtunskilled" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Casual</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" onblur="AccumulateValue()" class="form-control input-sm col-md-6"
                                id="txtCasual" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Total Employees</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtTotal"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                </fieldset>
                <hr />
                <asp:CustomValidator ID="vEmployee" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
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
</div>
