<%@ Control Language="C#" AutoEventWireup="true" CodeFile="invclientlist.ascx.cs"
    Inherits="controls_invapplications_invclientlist" %>

<script type="text/javascript" language="javascript">

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
    <asp:Label ID="lblHeading" runat="server" Style="font-weight: 700" Text="Number of Applications(s)"></asp:Label><span
        runat="server" id="noClients" class="badge pull-right"></span>
<asp:GridView ID="gvInvClients" CssClass="table table-bordered" runat="server" AutoGenerateColumns="False"
    DataSourceID="SqlDataSource1" OnRowDataBound="gvInvClients_RowDataBound" 
    DataKeyNames="datID">
    <Columns>
        <asp:BoundField DataField="datClientName" HeaderText="Client Name" SortExpression="datClientName" />
        <asp:BoundField DataField="datApplicationNumber" HeaderText="Application No" SortExpression="datApplicationNumber" />
       <%-- <asp:BoundField DataField="datApplicationStatus" HeaderText="Status" SortExpression="datApplicationStatus" />--%>
        <asp:BoundField DataField="type" HeaderText="Product" SortExpression="type" />
        <%-- %><asp:TemplateField HeaderText="Change Product">
            <ItemTemplate>
                <asp:DropDownList ID="ddlInvType" class="form-control" runat="server" AppendDataBoundItems="True"
                       DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                    <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                </asp:DropDownList>
                <asp:HyperLink ID="hyperAppTypeChange" CssClass="btn btn-xs btn-success col-md-5" runat="server">
                         <i class="glyphicon glyphicon-tasks pull-left"></i> Change
                </asp:HyperLink>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_investment_types]">
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:TemplateField> --%>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:HyperLink ID="hyperAppProcess" CssClass="btn btn-xs btn-success col-md-5" runat="server">
                         <i class="glyphicon glyphicon-tasks pull-left"></i> Open 
                </asp:HyperLink>
                <asp:HyperLink ID="HyperAlert" CssClass="btn btn-xs btn-info col-md-5 col-md-offset-1"
                    runat="server">        
                        <i class="glyphicon glyphicon-bell pull-left"></i> Alert
                </asp:HyperLink>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</p>
<hr />
<p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
        SelectCommand="SELECT tbl_investment_application.datID, tbl_investment_application.datClientName, tbl_investment_application.datApplicationNumber, opt_investment_types.datDescription AS type, tbl_investment_application.datApplicationStatus FROM opt_investment_types INNER JOIN tbl_investment_application ON opt_investment_types.datID = tbl_investment_application.datInvestmentType WHERE (tbl_investment_application.datTeamID = @branchID)"
        OnSelected="SqlDataSource1_Selected">
        <SelectParameters>
            <asp:Parameter Name="branchID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        UpdateCommand="UPDATE tbl_investment_application SET datInvestmentType = @type WHERE datID = @ID">
        <UpdateParameters>
            <asp:Parameter Name="type" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
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
                            runat="server" Text="Save" OnClick="btnSaveAlert_Click" />
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
