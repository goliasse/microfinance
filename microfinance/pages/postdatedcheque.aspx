<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="postdatedcheque.aspx.cs" Inherits="pages_postdatedcheque" Title="Post Dated Cheques" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <p><h5><b>| Post Dated Cheques | </b><small> List of post dated cheques from 
        clients  </small></h5></p>
    </div>
    <hr />
    <div class="col-md-10">
         <div id="pdcList" runat="server" class="panel panel-default">
            <div class="panel-heading" >
                <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b><span id="pdcTitle" runat="server">
                    Post Dated Cheques</span></b></h6></div>
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
                         <asp:Button ID="btnSearch" CssClass="btn btn-xs btn-success col-md-12" 
                             runat="server" Text="Search" onclick="btnSearch_Click" />
                    </div>
                  </div>
             </div>
            <hr style="margin:5px" />
            <br style="clear:both" />
            <div id="pdcContainer" runat="server">
                <p>
                    <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Cheque(s) Due"></asp:Label><span runat="server" id="noCheques" class="badge pull-right"></span>
                </p>
                <hr />
                    <asp:GridView ID="gvPDC" CssClass="table table-bordered table-condensed" runat="server" 
                        AutoGenerateColumns="False" DataKeyNames="datID,datCleared" 
                    DataSourceID="SqlDataSource1" onrowdatabound="gvPDC_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="datClientName" HeaderText="Client" 
                                SortExpression="datClientName" />
                            <asp:BoundField DataField="datBank" HeaderText="Bank" 
                                SortExpression="datBank" />
                            <asp:BoundField DataField="datDate" DataFormatString="{0:MMMM d, yyyy}" 
                                HeaderText="Date" SortExpression="datDate">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datCheque" HeaderText="Cheque" 
                                SortExpression="datCheque">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datAmount" 
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}" HeaderText="Amount" 
                                SortExpression="datAmount">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datCleared" HeaderText="Status" 
                                SortExpression="datCleared" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperClear" class="btn btn-xs btn-success col-md-3" runat="server"> 
                                       <%--   <i class="glyphicon glyphicon-expand"></i>--%>
                                         Clear
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="HypeRD" class="btn btn-xs btn-success col-md-3 col-md-offset-1" runat="server"> 
                                         R/D
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="HyperChange" class="btn btn-xs btn-success col-md-4 col-md-offset-1" runat="server"> 
                                       <%-- <i class="glyphicon glyphicon-expand"></i>--%>
                                         Change
                                    </asp:HyperLink>
                               </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                        SelectCommand="GetAllDuePostDatedCheques" SelectCommandType="StoredProcedure" onselected="SqlDataSource1_Selected">
                        <SelectParameters>
                            <asp:Parameter DbType="DateTime" Name="startDate" />
                            <asp:Parameter DbType="DateTime" Name="endDate" />
                            <asp:Parameter Name="branch" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
         </div>
         
         <div id="editPDC" runat="server" class="panel panel-default" >
            <div class="panel-heading" >
                <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b><span id="Span1" runat="server">
                    Post Dated Cheques</span></b></h6></div>
            </div>
            <div class="bootstrap-admin-panel-content">
               
             <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Post Dated Cheques</h5></legend>
                    <input type="hidden" runat="server" id="editskip" /> 
                     <input type="hidden" runat="server" id="AppID" /> 
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Bank</label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtBank" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Date </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtDate" class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">Cheque</label>
                        <div class="col-lg-9">
                            <input runat=server type="text"  class="form-control input-sm col-md-6" id="txtchequeno" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">Amount</label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtAmt" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10" >
                            <asp:Button ID="btnSave" 
                                class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" onclick="btnSave_Click" 
                                />
                       </div>
                    </div>
                </fieldset>
         </div>
            </div>
        </div>
     </div>
       <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
         
         function clearPDC(pid)
         {
            if(confirm("Are sure you want to clear this cheque"))
            {
                window.location.href="../pages/postdatedcheque.aspx?id="+pid+"&type=clear";
            
            }
         }
    </script>
</asp:Content>

