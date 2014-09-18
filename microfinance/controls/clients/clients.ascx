<%@ Control Language="C#" AutoEventWireup="true" CodeFile="clients.ascx.cs" Inherits="controls_clients" %>
<%@ Register src="~/controls/clients/clientPortfolios.ascx" tagname="clientPortfolios" tagprefix="uc1" %>
<script type="text/javascript" language="javascript">
    function showinfo(pid)
    {
        $('.ItemContainer').css("display","none");
        $("#"+pid).css("display","block");    
       // alert('done');

      
    }

    function apply(pid)
    {
        $('#<%=ckey.ClientID %>').val(pid);
        $.blockUI({ message: $('#<%=popup123.ClientID %>'), css: { width: '400px'} }); 
        //form.submit();
      
        }
    function closeDialog()
    {
         $.unblockUI();
         window.location.href="../clients/clients.aspx";
    }
 $(document).ready(function() {
        
    $('#<%=btnApply.ClientID%>').click(function() {
      $.blockUI();
      $.ajax({
        type: "POST",
        url: "btnApply_Click",
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
<div runat="server" style="display:none;height:200px" id="popup123">
    <fieldset>
       <legend><h6>Apply For Product</h6></legend>
       <input type="hidden" runat="server" id="ckey" />             
     <div class="form-group">
            <label class="col-lg-4 control-label" for="typeahead">Select Product</label>
            <div class="col-lg-7">
                 <asp:DropDownList cssclass="form-control input-sm" ID="ddlProducts" runat="server" 
                    DataSourceID="SqlDataSource7" DataTextField="datDescription" 
                    DataValueField="datID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                     SelectCommand="SELECT [datID], [datDescription] FROM [opt_products]">
                </asp:SqlDataSource>
            </div>               
      </div>
      <br />
      <br />
      <br />
    <div class="form-group center">
           <div class="col-md-5">
                <asp:Button ID="btnApply" CssClass="btn btn-xs btn-success col-md-8" runat="server" Text="Apply" OnClick="btnApply_Click" />
           </div>        
           <div class="col-md-5">    
             <input type="button" ID="btnCancel" runat="server"  onclick="closeDialog();"
                   class="btn btn-xs btn-warning col-md-8" value="Cancel" 
                    />
           </div>
    </div>
    
    </div>
     </fieldset>
</div>
<p>
    <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Client(s)"></asp:Label><span runat="server" id="noClients" class="badge pull-right"></span>
</p>
<hr />
<br />
<p>
<input type="hidden" runat="server" name="selectedAppID" />
<input type="hidden" runat="server" name="selectedAccID" />
<asp:GridView ID="gvAccounts" CssClass="table  table-bordered table-condensed" 
        runat="server" AutoGenerateColumns="False"   Width="98%" 
        OnRowDataBound="gvAccounts_RowDataBound" DataSourceID="SqlDataSource1" DataKeyNames="datID"
        onselectedindexchanged="gvAccounts_SelectedIndexChanged" 
        AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="datClientName" HeaderText="Client"  
                SortExpression="datClientName" />
            <asp:BoundField DataField="datClientNumber" HeaderText="Client ID" 
                SortExpression="datEmailAddress" />
            <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" 
                SortExpression="datEmailAddress" />
            <asp:BoundField DataField="datMobileNumber1" HeaderText="Mobile Number" 
                SortExpression="datMobileNumber1" />
            <asp:TemplateField HeaderText="Client Profile">
                <ItemTemplate>
                    <asp:HyperLink ID="hyperClientProfile" CssClass="btn btn-xs btn-success" runat="server"   Text="Finalize">
                        <i class="glyphicon glyphicon-tasks pull-right"></i> Open 
                    </asp:HyperLink>
                    <%--<asp:LinkButton ID="mblViewClientProfile" PostBackUrl="~/pages/clientprofile.aspx" runat="server"><span class="glyphicon glyphicon-user">View</span></asp:LinkButton>--%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Select Client">
                <ItemTemplate>
                    <asp:HyperLink ID="hyperInv" runat="server" CssClass="btn btn-xs btn-success" Text="Finalize">
                        <i class="glyphicon glyphicon-plus pull-left"></i>  Products
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <PagerStyle Font-Names="Times New Roman" Font-Size="11pt" 
            HorizontalAlign="Center" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="SELECT DISTINCT datID, datClientNumber, datClientName, datEmailAddress, datMobileNumber1 FROM tbl_client" 
        OnSelected="SqlDataSource1_Selected">
    </asp:SqlDataSource>
</p>











