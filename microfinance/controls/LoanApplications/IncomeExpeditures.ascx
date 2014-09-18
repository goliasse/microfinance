<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IncomeExpeditures.ascx.cs"
    Inherits="controls_IncomeExpeditures" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<script type="text/javascript" language="javascript">
    
   	 $(document).ready(function(){
   	 	
		function unExpected(){
			$("#<%=txtUnExp.ClientID %>").val((($("#<%=txtRegularExpenses.ClientID %>").val()*$("#<%=txtUnexpected.ClientID %>").val())/100).toFixed(2))
		}
		
		function totalExpenses(){
			$("#<%=txtTotalExpenses.ClientID %>").val((Number($("#<%=txtRegularExpenses.ClientID %>").val())+ Number($("#<%=txtUnExp.ClientID %>").val())).toFixed(2))
		}	
		
		function netSurplus(){
			$("#<%=txtNet.ClientID %>").val((Number($("#<%=txtTotalIncome.ClientID %>").val())- Number($("#<%=txtTotalExpenses.ClientID %>").val())).toFixed(2))
		}			
		
		function addIncome(){
			$("#<%=txtTotalIncome.ClientID %>").val((Number($("#<%=txtBusinessSurplus.ClientID %>").val())+ Number($("#<%=txtOtherIncome.ClientID %>").val())+ Number($("#<%=txtIncome.ClientID %>").val())).toFixed(2))
			unExpected();
			totalExpenses();
			netSurplus();
		}		
		addIncome();		
		$("#<%=txtBusinessSurplus.ClientID %>").keyup(function(){addIncome()});
		$("#<%=txtIncome.ClientID %>").keyup(function(){addIncome()});
		$("#<%=txtOtherIncome.ClientID %>").keyup(function(){addIncome()});

		function addExpenses(){
			$("#<%=txtRegularExpenses.ClientID %>").val((	Number($("#<%=txtRentUtil.ClientID %>").val())+ 
								                            Number($("#<%=txtFood.ClientID %>").val()) +
								                            Number($("#<%=txtEducation.ClientID %>").val()) +
								                            Number($("#<%=txtStaff.ClientID %>").val()) +
								                            Number($("#<%=txtTransport.ClientID %>").val()) +
								                            Number($("#<%=txthealth.ClientID %>").val()) +
								                            Number($("#<%=txtEntertainment.ClientID %>").val()) +
								                            Number($("#<%=txtCharity.ClientID %>").val()) +
								                            Number($("#<%=txtPayment.ClientID %>").val()) +
								                            Number($("#<%=txtOthers.ClientID %>").val()) +
								                            Number($("#<%=txtClothing.ClientID %>").val()) 
								                            ).toFixed(2));
								                            unExpected();
								                            totalExpenses();
								                            netSurplus();
								
		}		
		addExpenses();
		$("#<%=txtRentUtil.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtFood.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtEducation.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtStaff.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtTransport.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txthealth.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtEntertainment.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtCharity.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtPayment.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtOthers.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtClothing.ClientID %>").keyup(function(){addExpenses()});
		$("#<%=txtUnexpected.ClientID %>").keyup(function(){
			unExpected();
			totalExpenses();
			netSurplus();
			});
			
	
    function calculateTotalIncome()
    {
        var bsurplus = Number($('#<%=txtBusinessSurplus.ClientID %>').val());
        var income = Number($('#<%=txtIncome.ClientID %>').val());
        var otherincome=Number($('#<%=txtOtherIncome.ClientID %>').val());
        
        if(!((isNaN(bsurplus))||(isNaN(income))||(isNaN(otherincome))))
        {
            var value = bsurplus+income+otherincome;
            $('#<%=txtTotalIncome.ClientID %>').val(value);
        }
        else
        {
            alert("One of the values is not in the correct format"); 
        }
     }
     function calculateNet()
     {
        var rentutil =Number($('#<%=txtRentUtil.ClientID %>').val());
        var food =Number($('#<%=txtFood.ClientID %>').val());
        var education =Number($('#<%=txtEducation.ClientID %>').val());
        var staff =Number($('#<%=txtStaff.ClientID %>').val());
        var transport =Number($('#<%=txtTransport.ClientID %>').val());
        var health =Number($('#<%=txthealth.ClientID %>').val());
        var clothing =Number($('#<%=txtClothing.ClientID %>').val());
        var entertainment =Number($('#<%=txtEntertainment.ClientID %>').val());
        var charity =Number($('#<%=txtCharity.ClientID %>').val());
        var payment =Number($('#<%=txtPayment.ClientID %>').val());
        var others =Number($('#<%=txtOthers.ClientID %>').val());
     if(!((isNaN(rentutil))||(isNaN(food))||(isNaN(education))||(isNaN(staff))||(isNaN(transport))||(isNaN(health))||(isNaN(clothing))||(isNaN(entertainment))||(isNaN(charity))||(isNaN(payment))||(isNaN(others))))
     {
        var ExpensesValue=rentutil+food+education+staff+transport+health+clothing+entertainment+charity+payment+others;
        $('#<%=txtRegularExpenses.ClientID %>').val(ExpensesValue);
     }
     
     }
     
     });  
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Income &amp; Expenditures</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admihgbn-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h6>
                            Income &amp; Expenditures</h6>
                    </legend>
                    <div class="col-md-6">
                        <p>
                            Income
                        </p>
                        <hr>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Business Surplus</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" onblur="calculateTotalIncome()"
                                    id="txtBusinessSurplus" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Income</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" onblur="calculateTotalIncome()"
                                    id="txtIncome" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Other Income</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" onblur="calculateTotalIncome()"
                                    id="txtOtherIncome" autocomplete="off">
                            </div>
                        </div>
                        <div style="height: 300px" class="form-group">
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Total Income</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtTotalIncome"
                                    autocomplete="off" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <p>
                            Expenditure
                        </p>
                        <hr>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Rent+Utilities</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" onblur="calculateNet()"
                                    id="txtRentUtil" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Food</label>
                            <div class="col-lg-7">
                                <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtFood" onblur="calculateNet()"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Education</label>
                            <div class="col-lg-7">
                                <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtEducation" onblur="calculateNet()"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Staff</label>
                            <div class="col-lg-7">
                                <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtStaff" onblur="calculateNet()"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Transport</label>
                            <div class="col-lg-7">
                                <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtTransport" onblur="calculateNet()"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Health</label>
                            <div class="col-lg-7">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txthealth" onblur="calculateNet()"
                                    runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Clothing</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtClothing"
                                    onblur="calculateNet()" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Entertainment</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEntertainment"
                                    onblur="calculateNet()" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Charity</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtCharity"
                                    onblur="calculateNet()" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Payments</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtPayment"
                                    onblur="calculateNet()" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Others</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtOthers"
                                    onblur="calculateNet()" autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Regular Expenses</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtRegularExpenses"
                                    autocomplete="off" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-5">
                                <h6>
                                    <strong><i>+<input runat="server" type="text" style="width: 50px;" id="txtUnexpected"
                                        autocomplete="off">% misc</i></strong></h6>
                            </div>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtUnExp"
                                    autocomplete="off" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                Total Expenses</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtTotalExpenses"
                                    autocomplete="off" readonly="readonly">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="optionsCheckbox">
                                NET MONTHLY SURPLUS</label>
                            <div class="col-lg-7">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNet"
                                    autocomplete="off" readonly="readonly">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <div class="col-lg-10">
                                <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"
                                    OnClick="btnSave_Click" />
                            </div>
                        </div>
                    </div>
                    <asp:CustomValidator ID="vOwnership" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <span class=" glyphicon glyphicon-warning-sign pull-left"></i>
                            <h6 class="text-center">
                                <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                            <hr style="margin: 1px" />
                            <p id="ErrMsg" runat="server">
                            </p>
                    </asp:CustomValidator>
                </fieldset>
            </div>
        </div>
    </div>
</div>
