<%@ Control Language="C#" AutoEventWireup="true" CodeFile="dbi_payments.ascx.cs" Inherits="controls_dashboard_dbi_payments" %>
    <script type="text/javascript">
      var jsVariable5 = <%= this.data_lnpay.Value %>;
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable(jsVariable5);
        
         var view = new google.visualization.DataView(data);
//      view.setColumns([0, 1,
//                       { calc: "stringify",
//                         sourceColumn: 1,
//                         type: "string",
//                         role: "annotation" },
//                       2]
//                       );
        
        var options = {
          title: 'Loans Collections For This Month',
          vAxis: {title: 'Amount',  titleTextStyle: {color: 'red'}}
        };
        
        var chart = new google.visualization.LineChart(document.getElementById('loancollection'));
        chart.draw(data, options);
      }
</script>
<input type="hidden" runat="server" id="data_lnpay" />
<div class="row">
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title"> Loans Repayment History </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="lblClientsPage" PostBackUrl="~/pages/reports.aspx?action=pso" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-12">
            <div id="loancollection"></div>
        </div>
    </div>
 </div>
</div>