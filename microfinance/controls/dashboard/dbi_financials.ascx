<%@ Control Language="C#" AutoEventWireup="true" CodeFile="dbi_financials.ascx.cs" Inherits="controls_dashboard_dbi_financials" %>
    <script type="text/javascript">
      var jsVariable2 = <%= this.data_ii.Value %>;
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable(jsVariable2);
        var data1 = google.visualization.arrayToDataTable([
          ['Period', 'Fees'],
          ['May',       1000],
          ['June',      1170],
          ['July',      660 ],
          ['August',    1030],
          ['September', 945]
        ]);
        
//      var view1 = new google.visualization.DataView(data);
//      view1.setColumns([0, 
//                       { calc: "stringify",
//                         sourceColumn: 1,
//                         type: "string",
//                         role: "annotation" },
//                       2]
//                       );
        
        var options = {
          title: 'Interest Income For 6 months period',
          vAxis: {title: 'Amount',  titleTextStyle: {color: 'red'}}
        };
        
         var options1 = {
          title: 'Fees For 6 months period',
          vAxis: {title: 'Amount',  titleTextStyle: {color: 'red'}}
        };
        
        var chart = new google.visualization.ColumnChart(document.getElementById('interestincome'));
        chart.draw(data, options);
        
         var chart1 = new google.visualization.ColumnChart(document.getElementById('fees'));
        chart1.draw(data1, options1);
      }
</script>
<input type="hidden" runat="server" id="data_ii" />
<div class="row">
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Interest Income History </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="lblClientsPage" PostBackUrl="~/pages/reports.aspx?action=pii" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-12">
            <div id="interestincome"></div>
        </div>
            <label class="badge pull-right">The currency is Ghana cedis</label>
    </div>
 </div>
</div>

<%--<div class="row">
  <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Fees Income History  </div>
        <div class="pull-right"><span class="badge"><asp:LinkButton ID="LinkButton1" PostBackUrl="~/pages/reports.aspx?action=pii" style="color:White" runat="server">View More</asp:LinkButton></span></div>
    </div>
    <div class="bootstrap-admin-panel-content bootstrap-admin-no-table-panel-content collapse in">
        <div class="col-md-12">
            <div id="fees"></div>
        </div>
            <label class="badge pull-right">The currency is Ghana cedis</label>
    </div>
 </div>
    
</div>--%>