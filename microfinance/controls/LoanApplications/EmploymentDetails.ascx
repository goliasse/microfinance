<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmploymentDetails.ascx.cs" Inherits="controls_EmploymentDetails" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<script type="text/javascript">
    
    function calcDisposable()
    {
        var mthIncome = parseFloat($('#<%=txtmonthly.ClientID %>').val());
        var otherIncome= parseFloat($('#<%=txtOtherincome.ClientID %>').val());
        var exp = parseFloat($('#<%=txtMonthlyExpenditure.ClientID %>').val());
        if(isNaN(otherIncome))
        {  
            otherIncome =0;
        }
        if(isNaN(mthIncome))
        {
            mthIncome=0;
        }
        if(isNaN(exp))
        {
            exp=0;
        }
        if((!(isNaN(mthIncome)))||(!(isNaN(otherIncome)))||(!(isNaN(exp))))
        {
            var value=parseFloat((mthIncome+otherIncome)-exp).toFixed(2);
            $('#<%=txtDisposableIncome.ClientID %>').val(value);        
            }
        else{
            alert("Please values are not in the correct format");
             }
    
    
    }


</script>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Employment Details </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Employment Details</h5></legend>
                    <input type="hidden" runat="server" id="editskip" /> 
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Company Name </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtcompanyname" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Physical Address </label>
                        <div class="col-lg-8">
                             <textarea runat=server id="txtPhysicalAddress" class="form-control input-sm col-md-6"  style=" height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Position </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtposition" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">StaffID </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtStaff" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Date of Employment </label>
                        <div class="col-lg-8">  
                            <asp:TextBox ID="txtEmploymentDate"  class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone Number </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtTel" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Fax Number </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtFaxNumber"  autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Monthly Income </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtmonthly" onblur="calcDisposable()" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Other Income </label>
                        <div class="col-lg-8">
                             <input runat=server type="text" class="form-control input-sm col-md-6" id="txtOtherincome" onblur="calcDisposable()" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Monthly Expenditure </label>
                        <div class="col-lg-8">
                             <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMonthlyExpenditure" onblur="calcDisposable()" autocomplete="off" />
                        </div>
                    </div>
                   <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Disposable Income </label>
                        <div class="col-lg-8">
                             <input runat=server type="text" Placeholder="Amount in Ghana Cedis" class="form-control input-sm col-md-6" id="txtDisposableIncome" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10">
                            <asp:Button ID="btnSave" 
                                class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" 
                                onclick="btnSave_Click" />
                            
                       </div>
                    </div>
                </fieldset>
                 <asp:CustomValidator ID="vEmploymentDetails" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                  <p id="ErrMsg" runat="server"></p>
                 </asp:CustomValidator>
            </div>
        </div>
      </div>
</div>
    <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>
<%--<asp:CalendarExtender TargetControlID="txtEmploymentDate" ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy">
</asp:CalendarExtender>--%>