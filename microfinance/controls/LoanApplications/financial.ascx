<%@ Control Language="C#" AutoEventWireup="true" CodeFile="financial.ascx.cs" Inherits="controls_financial" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<script type="text/javascript" language="javascript">
    function calcNetProfit()
    {
       var gross=$('#<%=txtGrossProfit.ClientID  %>').val();
       var admin=$('#<%=txtAdminCost.ClientID %>').val();
       
       if(!(isNaN(gross)||(isNaN(admin))))
       {
            var value = parseFloat(gross-admin).toFixed(2);
            $('#<%=txtNetProfit.ClientID %>').val(value);
       }
       else
       {
          alert("Wrong values entered");
          $('#<%=txtNetProfit.ClientID  %>').val(0)
       
        }
    }
    function calcGrossProfit()
    {
       var sales=$('#<%=txtSales.ClientID  %>').val();
       var cost=$('#<%=txtCostOfSales.ClientID %>').val();
        if(!(isNaN(sales)||(isNaN(cost))))
       {
            var value =parseFloat(sales-cost).toFixed(2);
            $('#<%=txtGrossProfit.ClientID %>').val(value);
       }
       else
       {
          alert("Wrong values entered");
          $('#<%=txtGrossProfit.ClientID  %>').val(0)
       
        } 
    }
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Financial</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Financial</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Month</label>
                        <div class="col-lg-9">
                            <asp:DropDownList class="form-control" ID="ddMonth" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                                <asp:ListItem>January</asp:ListItem>
                                <asp:ListItem>February</asp:ListItem>
                                <asp:ListItem>March</asp:ListItem>
                                <asp:ListItem>April</asp:ListItem>
                                <asp:ListItem>May</asp:ListItem>
                                <asp:ListItem>June</asp:ListItem>
                                <asp:ListItem>July</asp:ListItem>
                                <asp:ListItem>August</asp:ListItem>
                                <asp:ListItem>September</asp:ListItem>
                                <asp:ListItem>October</asp:ListItem>
                                <asp:ListItem>November</asp:ListItem>
                                <asp:ListItem>December</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Year</label>
                        <div class="col-lg-9">
                            <asp:DropDownList class="form-control" ID="ddlYear" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Sales</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtSales" onblur="calcGrossProfit()" class="form-control input-sm col-md-6"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Cost Of Sales</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtCostOfSales" onblur="calcGrossProfit()" class="form-control input-sm col-md-6"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Gross Profit</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtGrossProfit" onblur="calcNetProfit()" class="form-control input-sm col-md-6"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Admin Cost</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtAdminCost" onblur="calcNetProfit()" class="form-control input-sm col-md-6"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Net Profit</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtNetProfit" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                    <asp:CustomValidator ID="vFinancial" runat="server" CssClass="vItem col-md-12"
                        OnServerValidate="pageValidation" ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6><hr style="margin:0" />
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>
                </fieldset>
                <hr />
                <p>
                    <asp:GridView CssClass="table table-striped table-bordered" ID="gvFinancial" runat="server"
                        AutoGenerateColumns="False" DataKeyNames="datID" DataSourceID="SqlDataSource3"
                        OnRowDataBound="gvFinancial_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="datMonth" HeaderText="Month" SortExpression="datMonth" />
                            <asp:BoundField DataField="datYear" HeaderText="Year" SortExpression="datYear" />
                            <asp:BoundField DataField="datSales" HeaderText="Sales" SortExpression="datSales"
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datCostOfSales" HeaderText="Cost Of Sales" SortExpression="datCostOfSales"
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datGrossOfProfit" HeaderText="Gross Of Profit" SortExpression="datGrossOfProfit"
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datAdminCost" HeaderText="Admin Cost" SortExpression="datAdminCost"
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="datNetProfit" HeaderText="Net Profit" SortExpression="datNetProfit"
                                DataFormatString="{0:#,##0.00;(#,##0.00);0}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"
                                        Text="Edit">
                                    <i class="glyphicon glyphicon-pencil pull-left"></i>  Edit 
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-6 col-md-offset-1"
                                        Text="Delete">
                                    <i class="glyphicon glyphicon-remove pull-left"></i>  Delete 
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle BackColor="#CCFFFF" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                        SelectCommand="getFinancials" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" Type="Int32" />
                            <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
            </div>
        </div>
    </div>
</div>
