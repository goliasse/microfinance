<%@ Control Language="C#" AutoEventWireup="true" CodeFile="clientlist.ascx.cs" Inherits="controls_clientlist" %>

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
    <asp:Label ID="lblHeading" runat="server" Style="font-weight: 700" Text="Pending of Loan Disbursements"></asp:Label>
    <asp:GridView ID="gvAccounts" runat="server" CssClass="table table-striped table-bordered"
        AutoGenerateColumns="False" Width="98%" OnRowDataBound="gvAccounts_RowDataBound"
        DataKeyNames="datID" DataSourceID="SqlDataSource1" AllowPaging="True" 
        >
        <PagerSettings Mode="NextPrevious" NextPageImageUrl="~/asset/images/right-26.png"
            PreviousPageImageUrl="~/asset/images/left-26.png" />
        <Columns>
            <asp:BoundField DataField="datClientName" HeaderText="Client Name" SortExpression="datClientName" />
            <asp:BoundField DataField="datApplicationNumber" HeaderText="Application Number"
                SortExpression="datApplicationNumber">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="datDescription" HeaderText="Loan Type" SortExpression="datDescription">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="datLoanAmount" HeaderText="Loan Amount" DataFormatString="{0:#,##0.00;(#,##0.00);0}"
                SortExpression="datLoanAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Review">
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action" Visible="True">
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
            <asp:BoundField DataField="datID" Visible="False" />
        </Columns>
        <PagerStyle Font-Bold="True" Font-Names="Times New Roman" Font-Size="11pt" Font-Underline="False"
            HorizontalAlign="Center" />
    </asp:GridView>
    <span
        runat="server" id="noClients" class="badge pull-right"></span>
</p>
<hr />
<p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
        SelectCommand="SELECT tbl_loan_application.datID,tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription, tbl_loan_application.datLoanAmount FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID"
        OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>
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
