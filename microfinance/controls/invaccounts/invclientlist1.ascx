<%@ Control Language="C#" AutoEventWireup="true" CodeFile="invclientlist1.ascx.cs"
    Inherits="controls_invapplications_invclientlist1" %>

<script type="text/javascript" language="javascript">
    function showinfo(pid)
    {
        $('.ItemContainer').css("display","none");
        $("#"+pid).css("display","block");    
       // alert('done');
    }
    
    function loadAlertPop(pid)
    {
        $('#<%=appID.ClientID %>').val(pid);
        $.blockUI({ message: $('#<%=myAlertPopUp.ClientID %>'), css: {width: '50%',padding:'5px'} });
    }
    $(document).ready(function() {   
        $('#<%=btnSaveAlert.ClientID%>').click(function() {
          $.blockUI();
          $.ajax({
            type: "POST",
            url: "btnSaveAlert_Click",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(msg) {
                $.unblockUI();
              }
            });
         });
    });
</script>

<p style="margin: 0">
    <asp:Label ID="lblHeading" runat="server" Style="font-weight: 700" Text="Number of Investment(s)"></asp:Label><span
        runat="server" id="noClients" class="badge pull-right"></span>
</p>
<hr />
<div runat="server" class="" id="myAlertPopUp" style="display: none">
    <input type="hidden" id="appID" runat="server" />
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Alert Message
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <form class="form-horizontal">
            <fieldset>
                <legend>Alert Message</legend>
                <div class="form-group">
                    <div class="col-lg-12">
                        <textarea runat="server" style="height: 100px" class="form-control input-sm" id="alertmsg"> </textarea>
                    </div>
                </div>
                <br style="clear: both" />
                <hr />
                <div class="form-group">
                    <div class="col-md-12">
                        <asp:Button ID="btnSaveAlert" Style="width: 15%" CssClass="btn btn-xs btn-primary"
                            runat="server" Text="Save" />
                        <asp:Button class="btn btn-xs btn-default" ID="btnClose" OnClientClick="location.reload();"
                            runat="server" Text="Button" />
                        <%--<button  style="width:15%"  type="reset">Close</button>--%>
                    </div>
                </div>
            </fieldset>
            </form>
        </div>
    </div>
</div>
<asp:GridView ID="gvClients" runat="server" AutoGenerateColumns="False" 
    CssClass="table table-bordered" DataKeyNames="datID,datClientID,datInvestmentType,datTerms,datFrequencyOfInterestPayment,datValueDate"
    DataSourceID="SqlDataSource1" OnRowDataBound="gvClients_RowDataBound">
    <Columns>
        <asp:TemplateField HeaderText="Client "></asp:TemplateField>
        <asp:BoundField DataField="datInvestmentName" HeaderText="Investment Name" 
            SortExpression="datInvestmentName" >
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="datApplicationNumber" HeaderText="Application No." 
            SortExpression="datApplicationNumber" >
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="datDaysOver" HeaderText="Days Elapsed" 
            SortExpression="datDaysOver" >
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="Investment Type">
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:HyperLink ID="hyperAppSubmit" CssClass="btn btn-xs btn-success col-md-5" runat="server">
                         <i class="glyphicon glyphicon-tasks pull-left"></i> Submit 
                </asp:HyperLink>
                <asp:HyperLink ID="HyperAlert" CssClass="btn btn-xs btn-info col-md-5 col-md-offset-1"
                    runat="server">        
                        <i class="glyphicon glyphicon-bell pull-left"></i> Alert
                </asp:HyperLink>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
    
    SelectCommand="SELECT datID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datTerms, datValueDate, datDaysOver, datFrequencyOfInterestPayment FROM tbl_investment_accounts WHERE (datDaysOver &gt;= 30) AND (datTeamID = @branch)" 
    onselected="SqlDataSource1_Selected">
    <SelectParameters>
        <asp:Parameter Name="branch" />
    </SelectParameters>
</asp:SqlDataSource>

