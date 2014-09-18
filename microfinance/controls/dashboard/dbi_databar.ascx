<%@ Control Language="C#" AutoEventWireup="true" CodeFile="dbi_databar.ascx.cs" Inherits="controls_dashboard_dbi_databar" %>
    <script type="text/javascript">
     var jsLoanDisb = <%= this.data_disb.Value %>;
     var jsLoanDisb1 = <%= this.data_disb1.Value %>;
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
       
        var options = {
          title: 'Disbursed Loans',
          vAxis: {title: 'Amount Disbursed',  titleTextStyle: {color: 'red'}}
        };

         var data = google.visualization.arrayToDataTable(jsLoanDisb);
      
        var data1 = google.visualization.arrayToDataTable(jsLoanDisb1);

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data1, options); 
        var chart1 = new google.visualization.ColumnChart(document.getElementById('chart_div1'));
        chart1.draw(data, options);
      }
</script>
<input type="hidden" runat="server" id="data_disb" />
<input type="hidden" runat="server" id="data_disb1" />
<div class="row">
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Disbursed Loans </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="lblClientsPage" PostBackUrl="~/pages/reports.aspx?action=disbursement" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-6">
            <div id="chart_div"></div>
        </div>
        <div class="col-md-6">
            <div id="chart_div1"></div>
        </div>
        <label class="badge pull-right">The currency is Ghana cedis</label>
    </div>
 </div>
</div>