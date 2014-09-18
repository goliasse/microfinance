<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentPlan.ascx.cs" Inherits="controls_PaymentPlan" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<% 
    double[,] pplanVal = loadpplanValues(MySessionManager.AppID);
    if (pplanVal.Length > 0)
    {
        if (this.editskip.Value == "1")
        {

        }
        else
            this.editskip.Value = "3";
    }
    var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
%>

<script type="text/javascript" language="javascript">
    function setEdit()
    {
        $('#<%=txtperiod.ClientID %>').attr('readonly',false);
        $('#<%=txtinterestrate.ClientID %>').attr('readonly',false);
        $('#<%=txtprincipal.ClientID %>').attr('readonly',false);
        $('#<%=txtfirstpaymentdate.ClientID %>').attr('readonly',false);
        $('#<%=txtinterestrateType.ClientID %>').css('display','none');
        $('#<%=ddlinterestrateType.ClientID %>').css('display','block');
        $('#<%=txtFrequency.ClientID %>').css('display','none');
        $('#<%=ddlFrequency.ClientID %>').css('display','block');
        $('#<%=btnEditPlanValues.ClientID %>').css('display','block');
    }
    function roundUp(pid)
		{
			var pid= Math.round((pid)*100)/100;
			return parseFloat(pid).toFixed(2);
		}
		
		function generateValue(mnths, per, amt,generated)
		{
		    
		    
			var pplan={};
			if(generated==false)
			{
			if(mnths>0)
			{
				var month = getMonthlyPayment(amt,per,mnths);
				amtOut=0;
				for(var i=1;i<(mnths+1);i++)
				{
     
				    var BF;
					var IR_; 
					var L_IR; 
					var monthly;
					var amtOut_;
					if(i==1)
					{					
						per= per;
						var _ir = amt * per/100;			
						var lir = (parseFloat(amt) + parseFloat(_ir));
						amtOut= lir - month;
						var prin=(month-_ir);
						pplan[i]={0:amt, 1:_ir, 2:lir, 3:prin, 4:month,  5:amtOut};
						
					}
					else
					{
						if(!(amtOut < 0))
						{
							if(!(i==mnths))
							{
								var _ir = amtOut * per/100;
								lir=(amtOut+_ir);
								var prin=(month-_ir);
								pplan[i]={0:amtOut, 1:_ir, 2:lir,3:prin, 4:month, 5:amtOut};
								amtOut= (amtOut+_ir)-month;
								pplan[i][5]=amtOut;
							   
							}
							else
							{
								var _ir = amtOut * per/100;
								lir=(amtOut+_ir);
								month=lir;
								var prin=(month-_ir);
								pplan[i]={0:amtOut, 1:_ir, 2:lir, 3:prin, 4:month, 5:amtOut};
								amtOut= (amtOut+_ir)-month;
								pplan[i][5]=amtOut;
							
							}
						}
					   else
					   {
					   
					   }
					}
					
			    var totalpayment=0.0;
			    var deductvalue;
				for(key in pplan)
				{  
				  
					 $(".BF"+key).val(roundUp(pplan[key][0]));
					 $("._IR"+key).val(roundUp(pplan[key][1]));
					 $(".CalculatedIR"+key).val(roundUp(pplan[key][2]));
					 $(".monthly"+key).val(roundUp(pplan[key][4]));
					 $(".Outstanding"+key).val(roundUp(pplan[key][5]));
					 $("._PrincComp"+key).val(roundUp(pplan[key][3]));
					 deductvalue =roundUp(pplan[key][4]);
					 totalpayment=totalpayment +parseFloat(roundUp(pplan[key][4])); 
					}
					totalpayment = totalpayment -deductvalue;
					
					 var lnPrincipal =parseFloat($('#<%=txtprincipal.ClientID %>').val());
					 var lninterest=roundUp(totalpayment-lnPrincipal);
					 $('#<%=txtTotalInterest.ClientID %>').val(roundUp(lninterest)); 
					$('#<%=txtTotalPayment.ClientID %>').val(roundUp(totalpayment));
					$('#<%=txtAveragePayment.ClientID %>').val(roundUp((totalpayment/mnths)));
					window['pplan']=pplan;
						}
				}
			else{
			
				alert("Period less than zero")
			            }
		
		
		
			}
			else
			{
			    //alert(window['pplan']);
				var _pplan=window['pplan'];
				alert(_pplan[1][2]);
				
				var amtOut=0.0;
				var i=1;
				
				$('#<%=TABLE1.ClientID %>  tr').find('.myInputs').each(function () {
					
					var value=parseFloat($(this).val());
					//alert(value);
					if(!(isNaN(value)))
					{
						
						if(i==1)
						{
						
						var lir=_pplan[i][2];
						amtOut=lir-value;
						_pplan[i][5]=amtOut;
						_pplan[i][3]=value-_pplan[i][1];
						_pplan[i][4]=value;
						
						}
						else
						{
							if(i<(mnths+1))
							{
								if(!(i==mnths))
								{
								  _pplan[i][0]=amtOut;
								  _ir= amtOut* per/100;
								  _pplan[i][1]=_ir;
								  _pplan[i][2]= (_ir + amtOut);
								  _pplan[i][3]=value-_ir;
								  _pplan[i][4]=value;
								  amtOut=(_ir + amtOut)-value;
								  _pplan[i][5]=amtOut;
								}
								else
								{
								  _pplan[i][0]=amtOut;
								  
								  _ir= amtOut* per/100;
								  _pplan[i][1]=_ir;
								  if((_ir + amtOut)>0)
								  {
								  _pplan[i][2]= (_ir + amtOut);
								  }
								  else
								  {
								    var rpplan=window['pplan'];
								    reveersepopulate(rpplan,mnths);
								    alert("This is a faulty payment plan");
								    //exit();
								  }
								  value=(amtOut + _ir);
								  _pplan[i][4]=value;
								  amtOut=(_ir + amtOut)-value;
								  _pplan[i][3]=value-_ir;
								  _pplan[i][5]=amtOut;								
								 
								 } 
							}
						}
							i++;
						}
				});
				
				var totalpayment=0.0;
				var deductvalue;
				for(key in _pplan)
				{  
				     
				     $(".BF"+key).val(roundUp(_pplan[key][0]));
					 $("._IR"+key).val(roundUp(_pplan[key][1]));
					 $(".CalculatedIR"+key).val(roundUp(_pplan[key][2]));
					 $(".monthly"+key).val(roundUp(_pplan[key][4]));
					 $(".Outstanding"+key).val(roundUp(_pplan[key][5]));
					 $("._PrincComp"+key).val(roundUp(_pplan[key][3]));
					 deductvalue = parseFloat(roundUp(_pplan[key][4]));
					 totalpayment=totalpayment +parseFloat(roundUp(_pplan[key][4])); 			
					}
					totalpayment=totalpayment - deductvalue;
					 var lnPrincipal =parseFloat($('#<%=txtprincipal.ClientID %>').val());
					 var lninterest=roundUp(totalpayment-lnPrincipal);
					 $('#<%=txtTotalInterest.ClientID %>').val(roundUp(lninterest)); 
					$('#<%=txtTotalPayment.ClientID %>').val(roundUp(totalpayment));
					$('#<%=txtAveragePayment.ClientID %>').val(roundUp((totalpayment/mnths)));
				//alert(_pplan)
				window['pplan']=_pplan;
			
			
			}
			
		}
		
		function reveersepopulate(pplan,mnths)
		{
		  var totalpayment=0.0;
		  var deductvalue;
		    for(key in pplan)
				{  
				     $(".BF"+key).val(roundUp(pplan[key][0]));
					 $("._IR"+key).val(roundUp(pplan[key][1]));
					 $(".CalculatedIR"+key).val(roundUp(pplan[key][2]));
					 $(".monthly"+key).val(roundUp(pplan[key][4]));
					 $(".Outstanding"+key).val(roundUp(pplan[key][5]));
					 $("._PrincComp"+key).val(roundUp(pplan[key][3]));
					 deductvalue = roundUp(pplan[key][4]);
					 totalpayment=totalpayment +parseFloat(roundUp(pplan[key][4])); 			
					}
					totalpayment=totalpayment - deductvalue;
					 var lnPrincipal =parseFloat($('#<%=txtprincipal.ClientID %>').val());
					 var lninterest=roundUp(totalpayment-lnPrincipal);
					$('#<%=txtTotalInterest.ClientID %>').val(roundUp(lninterest)); 
					$('#<%=txtTotalPayment.ClientID %>').val(roundUp(totalpayment));
					$('#<%=txtAveragePayment.ClientID %>').val(roundUp((totalpayment/mnths)));
				
				window['pplan']=pplan;
		}	
		
		
		function setMyMnth(pid)
		{
		    var mnth="";
		    if(pid==1)
		    { mnth="Jan";}
		    else if(pid==2)
		    { mnth="Feb";}
		    else if(pid==3)
		    {mnth="Mar";}
		    else if(pid==4)
		    {mnth="Apr";}
		    else if(pid==5)
		    {mnth="May";}
		    else if(pid==6)
		    {mnth="Jun";}
		    else if(pid==7)
		    {mnth="Jul";}
		    else if(pid==8)
		    {mnth="Aug";}
		    else if(pid==9)
		    {mnth="Sep";}
		    else if(pid==10)
		    {mnth="Oct";}
            else if(pid==11)
		    {mnth="Nov";}
		    else if(pid==12)
		    {mnth="Dec";}
            return mnth;
		}
		function getMonthlyPayment(prin,ir,period)
		{		
			var principal = prin;
			var interest = ir;
			var term = period;
			var n = term * 1;
			var r = interest/(100);
			var p = (principal * r * Math.pow((1+r),n))/(Math.pow((1+r),n)-1);
			var prin = Math.round(p*100)/100;
		
			return prin;
		
	        }
	$(function(){
       
       
		    var generatedPlan ={};
		    generatedPlan =(<%= serializer.Serialize(pplanVal) %>);
		    window['generatedpplan'] =generatedPlan;
		    var v= $('#<%=editskip.ClientID %>').val();
		   // alert(v);
		
	    if(!(v == "2"))
        {
        
	        var mnths= $('#<%=txtperiod.ClientID %>').val();
	        var per= $('#<%=txtinterestrate.ClientID %>').val();
	        var amt= $('#<%=txtprincipal.ClientID %>').val();
	        var mypplan = window['generatedpplan'];
		    //if($('#<%=editskip.ClientID %>').val()=="3")
		    //alert(mypplan);
		    if((!(mypplan==null))&&(1))
		    {
		            if(!($('#<%=editskip.ClientID %>').val()=="1"))
		            {
		                populateTable(mypplan);
		                }
		            else
		            {
		                generateValue(mnths,per,amt,false);
		            }   
		      }
		    }
		    else
		    {
		        var mnths= $('#<%=txtperiod.ClientID %>').val();
	            var per= $('#<%=txtinterestrate.ClientID %>').val();
	            var amt= $('#<%=txtprincipal.ClientID %>').val();
		        generateValue(mnths,per,amt,false);
		    }
		
	
		
	})
	
	
</script>

<script type="text/javascript" language="javascript" src="../asset/js/xtrafunctions.js"></script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Payment Plan</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Repayment Schedule</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <input type="hidden" runat="server" id="populateTable" />
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Period</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtperiod" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Interest Rate</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtinterestrate" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Prinicipal</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtprincipal" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                First Payment Date</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtfirstpaymentdate" runat="server"
                                    ReadOnly></asp:TextBox>
                                <%-- <asp:CalendarExtender TargetControlID="txtfirstpaymentdate"  ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server"></asp:CalendarExtender>--%>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Interest Rate Type</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtinterestrateType" runat="server"
                                    ReadOnly></asp:TextBox>
                                <asp:DropDownList ID="ddlinterestrateType" CssClass="form-control input-sm col-md-6"
                                    Style="display: none" runat="server" DataSourceID="SqlDataSource1" DataTextField="datDescription"
                                    DataValueField="datID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_interest_rate_types]">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group" style="display: none">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Frequency</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtFrequency" runat="server"
                                    ReadOnly></asp:TextBox>
                                <asp:DropDownList ID="ddlFrequency" CssClass="form-control input-sm col-md-6" Style="display: none"
                                    runat="server" DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_frequencies]"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Total Interest</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtTotalInterest" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Total Payment</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtTotalPayment" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label" for="typeahead">
                                Average Payment</label>
                            <div class="col-lg-5">
                                <asp:TextBox CssClass="form-control input-sm col-md-6" ID="txtAveragePayment" runat="server"
                                    ReadOnly></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-10">
                        <%--<button type="button" value="Edit" class="btn btn-xs btn-success"  onclick="javascript:setEdit()" ></button>--%>
                        <div class="col-md-3">
                            <input type="button" class="btn btn-xs btn-primary" style="display: none; width: 80px;"
                                onclick="setEdit()" value="Edit" />
                        </div>
                        <div class="col-md-4">
                            <asp:Button ID="btnEditPlanValues" runat="server" Style="display: none; width: 100px"
                                class="btn btn-xs btn-primary" Text="Update Values" OnClick="btnEditPlanValues_Click1" />
                        </div>
                    </div>
                </fieldset>
            </div>
            <br />
            <p style="margin: 0">
                Repayment Schedule
            </p>
            <hr />
            <div class="col-md-12">
                <table class="table table-bordered col-lg-12" id="TABLE1" runat="server">
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
            <br style="clear: both" />
            <hr />
            <div class="col-md-12">
                <div class="col-md-3">
                    <asp:Button ID="btnReset" CssClass="btn btn-xs btn-primary col-md-12" runat="server"
                        Text="Reset" OnClick="btnReset_Click" />
                </div>
                <div class="col-md-6">
                    <asp:Button ID="btnSavePlan" runat="server" CssClass="btn btn-xs btn-success col-md-6"
                        Text="Save Payment Plan" OnClick="btnSavePlan_Click" />
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" language="javascript">
    function recalculateplan()
	{
		var mnths= $('#<%=txtperiod.ClientID %>').val();
	    var per= $('#<%=txtinterestrate.ClientID %>').val();
	    var amt= $('#<%=txtprincipal.ClientID %>').val();
		var fdt=$('#<%=txtfirstpaymentdate.ClientID %>').val(); 
		generateValue(mnths,per,amt,true,fdt);
	
	}
	function populateTable(gplan)
	{
	    var pplan= {};
	    var i=0;
	    var j=1;
	    var amt,lir, ir,prin, monthly, amtOut;
	    for(key in gplan)
	    { 
	    //alert(j)
	        if(i==0)
	        {     
	            amt=gplan[key];
	            
	            i=i+1;
	        }
	        else if(i==1)
	        {
	            ir=gplan[key];
	             i=i+1;
	        }
	        else if(i==2)
	        {
	             prin=gplan[key];
	             i=i+1;
	        }
	        else if(i==3)
	        {
	             monthly=gplan[key]; 
	              i=i+1; 
	        }
	        else if(i==4)
	        {
	             amtOut=gplan[key];
	              i=0;  
	              lir=amt-ir;       
	              pplan[j]={0:amt, 1:ir, 2:lir,3:prin, 4:monthly, 5:amtOut};
	              j=j+1;   
	        }    
	    }
	   // alert(pplan.toLocaleString());
	    window['pplan']=pplan;
	    
	    var totalpayment=0.0;
	    for(key in pplan)
		{  
				
					 $(".BF"+key).val(roundUp(pplan[key][0]));
					 $("._IR"+key).val(roundUp(pplan[key][1]));
					 $(".CalculatedIR"+key).val(roundUp(pplan[key][2]));
					 $(".monthly"+key).val(roundUp(pplan[key][4]));
					 $(".Outstanding"+key).val(roundUp(pplan[key][5]));
					 $("._PrincComp"+key).val(roundUp(pplan[key][3]));
					 totalpayment=totalpayment +parseFloat(roundUp(pplan[key][4])); 
					}
					 var lnPrincipal =parseFloat($('#<%=txtprincipal.ClientID %>').val());
					 var lninterest=roundUp(totalpayment-lnPrincipal);
					 $('#<%=txtTotalInterest.ClientID %>').val(roundUp(lninterest)); 
					$('#<%=txtTotalPayment.ClientID %>').val(roundUp(totalpayment));
					$('#<%=txtAveragePayment.ClientID %>').val(roundUp((totalpayment/(j-1))));
					//window['pplan']=pplan;
					
	}
</script>

