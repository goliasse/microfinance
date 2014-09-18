<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="scheduledpayments.aspx.cs" Inherits="pages_scheduledpayments" Title="Scheduled Payments" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <p><h5><b>| Scheduled Payments | </b><small> Specify a period to see the clients 
        who are due to make payments. </small></h5></p>
    </div>
    <hr />
   <div class="col-md-10">
     <div class="panel panel-default">
        <div class="panel-heading" >
            <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b> 
                Scheduled Payments   </b></h6></div>
        </div>
        <div class="bootstrap-admin-panel-content">
            <div class="form-inline" role="form">
                  <div class="form-group">
                    <label class="sr-only" for="exampleInputEmail2">From Date</label>
                      <asp:TextBox ID="txtfromDate" CssClass="form-control input-sm my-picker" runat="server" Text="Enter starting date"></asp:TextBox>
                   
                  </div>
                  <div class="form-group">
                    <label class="sr-only" for="exampleInputPassword2">To Date</label>
                      <asp:TextBox ID="txtToDate" class="form-control input-sm my-picker" runat="server"  Text="Enter ending date"></asp:TextBox>
                  </div>
                  <div class="form-group">
                    <div class="col-md-12">
                         <asp:Button ID="btnSearch" CssClass="btn btn-xs btn-success col-lg-12" 
                             runat="server" Text="Search" onclick="btnSearch_Click" />
                    </div>
                  </div>
             </div>
            <hr style="margin:5px" />
            <br style="clear:both" />
             <div class="col-md-12" >
                 <p>
                    <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Client(s)"></asp:Label><span runat="server" id="noClients" class="badge pull-right"></span>
                </p>
                <hr />
                 <asp:GridView ID="gvClientPayment" 
                     CssClass="table table-bordered  table-condensed col-md-12" 
                     runat="server" AutoGenerateColumns="False" 
                     DataKeyNames="acc_id,cl_id" DataSourceID="SqlDataSource1" 
                     onrowdatabound="gvClientPayment_RowDataBound" AllowPaging="True" >
                     <Columns>
                         <asp:BoundField DataField="cl_name" HeaderText="Client Name" 
                             SortExpression="cl_name" />
                         <asp:BoundField DataField="AcNo" HeaderText="Account No." 
                             SortExpression="AcNo" />
                         <asp:BoundField DataField="theDate" HeaderText="Date" 
                             SortExpression="theDate" DataFormatString="{0:MMMM d, yyyy}" />
                         <asp:BoundField DataField="amount" HeaderText="Amount Due" 
                             SortExpression="amount" DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                             <ItemStyle HorizontalAlign="Right" />
                         </asp:BoundField>
                         <asp:BoundField DataField="out_st" HeaderText="Amt. Outstanding" 
                             SortExpression="out_st" DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                             <HeaderStyle HorizontalAlign="Center" />
                             <ItemStyle HorizontalAlign="Right" />
                         </asp:BoundField>
                         <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperAccountDetails" CssClass="btn btn-xs btn-success col-md-8" runat="server">
                                    <i class="glyphicon glyphicon-chevron-right pull-right"></i> Details
                                    </asp:HyperLink> 
                            </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                     <PagerStyle Font-Names="Times New Roman" />
                 </asp:GridView>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                     SelectCommand="GetSchedulePayments" SelectCommandType="StoredProcedure" 
                     onselected="SqlDataSource1_Selected">
                     <SelectParameters>
                         <asp:Parameter DbType="DateTime" DefaultValue="" Name="startDate" />
                         <asp:Parameter DbType="DateTime" DefaultValue="" Name="endDate" />
                     </SelectParameters>
                 </asp:SqlDataSource>
                 <br style="clear:both" />
             </div>
            <br style="clear:both" />
        </div>
      </div>
   </div>
   <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>
<%--   <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtToDate" runat="server" Format="dd/MM/yyyy">
    </asp:CalendarExtender>
    <asp:CalendarExtender ID="CalendarExtender2" TargetControlID="txtfromDate" runat="server" Format="dd/MM/yyyy">
    </asp:CalendarExtender>--%>
</asp:Content>

