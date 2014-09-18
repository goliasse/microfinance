<%@ Control Language="C#" AutoEventWireup="true" CodeFile="dbi_portfolios.ascx.cs" Inherits="controls_dashboard_dbi_portfolios" %>
    <script type="text/javascript">
    try{
         var jsVariable4 = <%= this.data_lnCat.Value %>;
         var jsVariable4a = <%= this.data_lnCat1.Value %>;

          google.load("visualization", "1", {packages:["corechart"]});
          google.setOnLoadCallback(drawChart);
          function drawChart() {
         
         
         if(!(jsVariable4==null)){
          var data2 = google.visualization.arrayToDataTable(jsVariable4);
          var options1 = {
              title: 'Loan categorization For This Month'
            };   
            var chart1 = new google.visualization.PieChart(document.getElementById('2mths'));
            chart1.draw(data2, options1);
            }
          if(jsVariable4a!=""){
            var data1 = google.visualization.arrayToDataTable(jsVariable4a);
             var options2 = {
              title: 'Loan categorization For Last Month'
            };
            var chart2 = new google.visualization.PieChart(document.getElementById('1mths'));
            chart2.draw(data1, options2);
            }
          }
      }catch(err){}
</script>
<input type="hidden" runat="server" id="data_lnCat1" />
<input type="hidden" runat="server" id="data_lnCat" />
<div class="row">
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title"> Loans Categories History </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="lblClientsPage" PostBackUrl="~/pages/reports.aspx?action=psr" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-6">
            <div id="1mths"></div>
        </div>
        <div class="col-md-6">
            <div id="2mths"></div>
        </div>
        
    </div>
 </div>
</div>