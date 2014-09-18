<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Collaterals.ascx.cs" Inherits="controls_Collaterals" %>

<script language="javascript" type="text/javascript">

    function HideShowSurityGroup()
    {    
        var ddl = $('#<%= ddlSurity.ClientID %>').val();
        if(ddl =="1")
        {
            $('#<%= SurityPanel.ClientID  %>').css("display","block");
        }
        else if(ddl=="2"||ddl=="0")
        {
            //alert(ddl);
             $('#<%= SurityPanel.ClientID  %>').css("display","none");            
                }
            
       }
       
     $(function(){
       
        var ddl = $('#<%= ddlSurity.ClientID %>').val();
        //alert(ddl);
        if(ddl =="1")
        {
            $('#<%= SurityPanel.ClientID  %>').css("display","block");
        }
        else if(ddl=="2"||ddl=="0")
        {
            //alert(ddl);
             $('#<%= SurityPanel.ClientID  %>').css("display","none");            
                }
     
     
    
     })

</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Collaterals</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Collaterals</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Collateral Type</label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control " ID="ddlCollateralType" runat="server"
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT datID, datDescription FROM opt_collateral_types"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Description</label>
                        <div class="col-lg-9">
                            <%-- <input runat=server type="text" class="form-control input-sm col-md-6" id="txtPercentage" autocomplete="off">--%>
                            <textarea runat="server" id="txtDescription" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Location</label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtLocation" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtValue">
                            Value</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtvalue"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="ddlSurity">
                            Third Party</label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control col-md-12" onchange="HideShowSurityGroup()"
                                ID="ddlSurity" runat="server" DataSourceID="SqlDataSource1" AppendDataBoundItems="True"
                                DataTextField="datDescription" DataValueField="datID">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesno]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div id="SurityPanel" style="display: none" runat="server">
                        <div class="form-group surityGroup">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Contact Person
                            </label>
                            <div class="col-lg-9">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtContactPerson"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group surityGroup">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Contact Person Telephone No.</label>
                            <div class="col-lg-9">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtContactTel"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group surityGroup">
                            <label class="col-lg-3 control-label" for="optionsCheckbox">
                                Physical Address</label>
                            <div class="col-lg-9">
                                <textarea runat="server" id="txtPhysicalAddress" class="form-control input-sm col-md-6"
                                    style="height: 80px"></textarea>
                                <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtPhysicalAddress" autocomplete="off">--%>
                            </div>
                        </div>
                        <div class="form-group surityGroup">
                            <label class="col-lg-3 control-label" for="ddlConfirmed">
                                Confirmed</label>
                            <div class="col-lg-9">
                                <asp:DropDownList CssClass="form-control" ID="ddlConfirmed" AppendDataBoundItems="True"
                                    runat="server" DataSourceID="SqlDataSource3" DataTextField="datDescription" DataValueField="datID">
                                    <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesno]"></asp:SqlDataSource>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                    <asp:CustomValidator ID="vCollateral" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                        <hr style="margin: 1px" />
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>
                </fieldset>
                <hr />
                <p>
                    <p>
                        <asp:Label ID="lblHeading" runat="server" Style="font-weight: 700" Text="Number of Collateral(s)"></asp:Label><span
                            runat="server" id="noCollateral" class="badge pull-right"></span>
                    </p>
                    <asp:GridView CssClass="table table-striped table-bordered" ID="gvCollateral" runat="server"
                        AutoGenerateColumns="False" DataKeyNames="datID" DataSourceID="SqlDataSource4"
                        OnRowDataBound="gvCollateral_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="CollateralType" HeaderText="Collateral Type" SortExpression="CollateralType" />
                            <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                            <asp:BoundField DataField="surety" HeaderText="Third Party" SortExpression="surety" />
                            <asp:BoundField DataField="datValue" HeaderText="Value" SortExpression="datValue" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"
                                        Text="Edit">
                                    <i class="glyphicon glyphicon-pencil pull-left"></i> Edit 
                                    </asp:HyperLink>
                                    <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"
                                        Text="Delete">
                                    <i class="glyphicon glyphicon-remove pull-left"></i>  Delete 
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                        SelectCommand="GetCollateral1" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource4_Selecting">
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
