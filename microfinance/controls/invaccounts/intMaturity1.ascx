<%@ Control Language="C#" AutoEventWireup="true" CodeFile="intMaturity1.ascx.cs" Inherits="controls_invaccounts_intMaturity1" %>

<script type="text/javascript">
   $(document).ready(function() {
		
	    $("#<%=datPercentage.ClientID %>").keyup(function(){
		$("#<%=datAmount.ClientID %>").val(($("#<%= dataccint.ClientID %>").val() * ($("#<%=datPercentage.ClientID %>").val() / 100)).toFixed(2))
		$("#<%=datInterest.ClientID %>").val(($("#<%=dataccint.ClientID %>").val() - ($("#<%=datAmount.ClientID  %>").val())).toFixed(2))
		

		});
	    $("#<%=datAmount.ClientID %>").keyup(function(){
		$("#<%=datPercentage.ClientID %>").val((($("#<%=datAmount.ClientID  %>").val()/$("#<%=dataccint.ClientID %>").val())*100).toFixed(2))
		$("#<%=datInterest.ClientID  %>").val(($("#<%=dataccint.ClientID %>").val() - ($("#datAmount").val())).toFixed(2))
		
		});
	});	
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Matured Interest Pay Out</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                        </h5>
                    </legend>
                    <div class="form-group">
                        <input type="hidden" runat="server" id="datID" />
                        <input type="hidden" runat="server" id="editskip" />
                        <label class="col-lg-4 control-label" for="typeahead">
                            Investment Name</label>
                        <div class="col-lg-8">
                            <label id="lblInvName" class="control-label" runat="server">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Investment Amount</label>
                        <div class="col-lg-8">
                            <input id="datprincipal"  type="hidden" runat="server"> 
                            <label id="lblInvAmt" class=" control-label" runat="server">
                            </label>
                        </div>
                    </div>
                    <div class="form-group"> 
                        <label class="col-lg-4 control-label" for="typeahead">
                            Accrued Interest</label>
                        <div class="col-lg-8">
                            <input id="dataccint" name="dataccint" type="hidden" runat="server"> 
                            <label id="lblaccruedInt" class="control-label" runat="server">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Interest Maturity Date</label>
                        <div class="col-lg-8">
                            <label id="lblValueDate" class="control-label" runat="server">
                            </label>
                        </div>
                    </div>
                    <p>
                        Penalty</p>
                    <hr />
                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Percentage</label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="datPercentage"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Amount</label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm " id="datAmount"
                                autocomplete="off" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Interest To Be Paid Out</label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm" id="datInterest"
                                autocomplete="off" readonly="readonly">
                        </div>
                    </div>
<%--                    <div class="form-group">
                        <label class="col-lg-4 control-label" for="typeahead">
                            Principal + Interest To Be Paid</label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="payout"
                                autocomplete="off" readonly="readonly">
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <asp:Button ID="btnSave" runat="server" Text="Save" 
                                CssClass="btn btn-xs btn-success col-md-3" onclick="btnSave_Click" />
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
