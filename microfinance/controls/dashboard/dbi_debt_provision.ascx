<%@ Control Language="C#" AutoEventWireup="true" CodeFile="dbi_debt_provision.ascx.cs" Inherits="controls_dashboard_dbi_debt_provision" %>
<%--<script type="text/javascript" src="https://www.google.com/jsapi"></script>--%>
<script type="text/javascript">
//try{
      var jsDebt = <%= this.data_debt.Value %>;
      var jsDebt1= <%= this.data_debt1.Value %>;
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart()
       {
        var data = google.visualization.arrayToDataTable(jsDebt);
        
         var data1 = google.visualization.arrayToDataTable(jsDebt1);
           
           var options1 = {
          title: 'Loan categorization For Last Month'
        };
         var options2 = {
          title: 'Loan categorization For This Month'
        };
        
        var chart1 = new google.visualization.PieChart(document.getElementById('1dpmths'));
        var chart2 = new google.visualization.PieChart(document.getElementById('2dpmths'));
 
        chart1.draw(data, options1);
        chart2.draw(data1, options2); 
      }
      
   // }catch(err){}
</script>
<div class="row">
  <input type="hidden" runat="server" id="data_debt1" />
  <input type="hidden" runat="server" id="data_debt" />
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title"> Debt Provision For Each Category Of Loans </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="lblClientsPage" PostBackUrl="~/pages/reports.aspx?action=pso" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-6">
            <div id="1dpmths"></div>
        </div>
        <div class="col-md-6">
            <div id="2dpmths"></div>
        </div>
        
    </div>
 </div>
</div>