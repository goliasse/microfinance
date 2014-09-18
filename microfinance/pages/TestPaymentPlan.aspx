<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestPaymentPlan.aspx.cs" Inherits="pages_TestPaymentPlan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.0/jquery.js" ></script>
    <script type="text/javascript" >

		function roundUp(pid)
		{
			var pid= Math.round((pid)*100)/100;
			return pid;
		}
		
		function generateValue(mnths, per, amt,generated,firstdt)
		{
		    var pdate=new Date(firstdt);
			var pplan={};
			if(generated==false)
			{
			if(mnths>0)
			{
				var month = getMonthlyPayment(amt,per,mnths);
				//alert(month);
				amtOut=0;
				var type;
				for(var i=1;i<(mnths+1);i++)
				{

				    var BF;
					var IR_; 
					var L_IR; 
					var monthly;
					var amtOut_;
					if(i==1)
					{
					    //pdate = Date(.toString("dd/MM/yyyy"));
					    //alert(pdate);
						per= per;
						var _ir = amt * per/100;
						
						lir=amt+_ir;
						amtOut= (amt + _ir)-month;
						
						pplan[i]={0:amt, 1:_ir, 2:lir, 3:month, 4:amtOut};
						
						BF ="<span class='BF'>"+ roundUp(pplan[i][0]) +"</span>";
						IR_ = "<span class='IR'>"+ roundUp(pplan[i][1]) +"</span>";
						L_IR = "<span class='LIR'>"+ roundUp(pplan[i][2]) +"</span>";
					    monthly = "<input type='text' class='myInputs' onblur='recalculateplan()'  name='month"+i+"' value="+ roundUp(pplan[i][3]) +" />";
						
					    amtOut_ ="<span class='AO'>"+ roundUp(pplan[i][4]) +"</span>";
					    
						var htmlText=
						             "<tr><td>"+  pdate.getDate()+"/"+ setMyMnth((pdate.getMonth()+i))+"/"+pdate.getFullYear()
						            +"</td><td>"+ BF
									+"</td><td>"+ IR_
									+"</td><td>"+ L_IR
									+"</td><td>"+ monthly
									+"</td><td>"+ amtOut_
									+"</td></tr>";
					}
					else
					{
						if(!(amtOut < 0))
						{
							if(!(i==mnths))
							{
								var _ir = amtOut * per/100;
								lir=(amtOut+_ir);
								pplan[i]={0:amtOut, 1:_ir, 2:lir, 3:month, 4:amtOut};
								amtOut= (amtOut+_ir)-month;
								pplan[i][4]=amtOut;
								BF ="<span class='BF'>"+ roundUp(pplan[i][0]) +"</span>";
								IR_ = "<span class='IR'>"+ roundUp(pplan[i][1]) +"</span>";
								L_IR = "<span class='LIR'>"+ roundUp(pplan[i][2]) +"</span>";
								monthly = "<input type='text' class='myInputs' onblur='recalculateplan()'  name='month"+i+"' value="+ roundUp(pplan[i][3]) +" />";
								amtOut_ ="<span class='AO'>"+ roundUp(pplan[i][4]) +"</span>";
								
								
								
								var htmlText=
								         "<tr><td>"+  pdate.getDate()+"/"+setMyMnth((pdate.getMonth()+i))+"/"+pdate.getFullYear() 
								        +"</td><td>"+ BF
										+"</td><td>"+ IR_
										+"</td><td>"+ L_IR
										+"</td><td>"+ monthly
										+"</td><td>"+ amtOut_
										+"</td></tr>";
							}
							else
							{
								var _ir = amtOut * per/100;
								lir=(amtOut+_ir);
								month=lir;
								pplan[i]={0:amtOut, 1:_ir, 2:lir, 3:month, 4:amtOut};
								amtOut= (amtOut+_ir)-month;
								pplan[i][4]=amtOut;
								BF ="<span class='BF'>"+ roundUp(pplan[i][0]) +"</span>";
								IR_ = "<span class='IR'>"+ roundUp(pplan[i][1]) +"</span>";
								L_IR = "<span class='LIR'>"+ roundUp(pplan[i][2]) +"</span>";
								monthly = "<input type='text' class='myInputs' onblur='recalculateplan()'  name='month"+i+"' value="+ roundUp(pplan[i][3]) +" />";
								amtOut_ ="<span class='AO'>"+ roundUp(pplan[i][4]) +"</span>";
								
								
								
								
								var htmlText="<tr><td>"+ pdate.getDate()+"/"+setMyMnth((pdate.getMonth()+i))+"/"+pdate.getFullYear()
								        +"</td><td>"+ BF
										+"</td><td>"+ IR_
										+"</td><td>"+ L_IR
										+"</td><td>"+ monthly
										+"</td><td>"+ amtOut_
										+"</td></tr>";
							
							
							}
						}
					   else
					   {
					   
					   }
					}
					window['pplan']=pplan;
					$('#ppTable > tbody:last').append(htmlText);
						}
			
				}
			else{
			
				alert("Period less than zero")
			
			}
		
		
		
			}
			else
			{
				var _pplan=window['pplan'];
				var amtOut=0.0;
				var i=1;
				
				$('#ppTable tr').find('td input:text').each(function () {
					
					var value=parseInt($(this).val());
					
					if(!(isNaN(value)))
					{
						//alert(value);
						if(i==1)
						{
						var lir=_pplan[i][2];
						amtOut=lir-value;
						//alert(amtOut);	
						_pplan[i][4]=amtOut;
						_pplan[i][3]=value;
						
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
								  _pplan[i][3]=value;
								  amtOut=(_ir + amtOut)-value;
								  //alert(amtOut);
								  _pplan[i][4]=amtOut;
								}
								else
								{
								  _pplan[i][0]=amtOut;
								  
								  _ir= amtOut* per/100;
								  _pplan[i][1]=_ir;
								  _pplan[i][2]= (_ir + amtOut);
								  value=(amtOut + _ir);
								  _pplan[i][3]=value;
								  amtOut=(_ir + amtOut)-value;
								  //alert(amtOut);
								  _pplan[i][4]=amtOut;								
								 
								 }
								 
							  
							}
						
						
						}
							i++;
						}
				
				});
				$('#ppTable').find("tr:gt(0)").remove();
				var pdate = new Date(firstdt);
				for(key in _pplan)
				{  
				    
					//alert("Are you working?");
						BF ="<span class='BF'>"+ roundUp(_pplan[key][0]) +"</span>";
						IR_ = "<span class='IR'>"+ roundUp(_pplan[key][1]) +"</span>";
						L_IR = "<span class='LIR'>"+ roundUp(_pplan[key][2]) +"</span>";
					    monthly = "<input type='text' class='myInputs' onblur='recalculateplan()'  name='month"+i+"' value="+ roundUp(_pplan[key][3]) +" />";
					    amtOut_ ="<span class='AO'>"+ roundUp(_pplan[key][4]) +"</span>";
						
						    
						   var htmlText=
						        "<tr><td>"+ pdate.getDate()+"/"+setMyMnth((pdate.getMonth()+key))+"/"+pdate.getFullYear()
						        +"</td><td>"+ BF
					            +"</td><td>"+ IR_
								+"</td><td>"+ L_IR
								+"</td><td>"+ monthly
								+"</td><td>"+ amtOut_
								+"</td></tr>";
						
						
				
				
				
				
				
					$('#ppTable > tbody:last').append(htmlText);
				
					}
				
				
				
				
				window['pplan']=_pplan;
			
			
			}
			
		}
			
		function setMyMnth(pid)
		{
		 var mnth="";
		    if(pid==1)
		    { mnth="Jan";     }
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
    function recalculateplan()
	{
		 
		generateValue(5,15,1000,true,'1/2/2014');
	
	}
	
	$(function(){
		 
		generateValue(5,15,1000,false,'1/3/2014');
		
	})
	
	
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p> Payment Plan Table </p>
	<table  id="ppTable">
		<tr>
			    <td>Months</td>
				<td>Balance BF</td>
				<td>Interest</td>
				<td>Loan+Interest</td>
				<td>Monthly Payment</td>
				<td>Amt Outstanding</td>
		    <tr>	
	</table>
   <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
    </div>
    </form>
</body>
</html>
