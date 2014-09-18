<%@ Control Language="C#" AutoEventWireup="true" CodeFile="directors.ascx.cs" Inherits="controls_invapplications_directors" %>
<script type="text/javascript" language="javascript">
    
    function getAge(dateString) {
        var today = new Date();
        var birthDate = new Date(dateString[2], dateString[1] - 1, dateString[0]);;
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        return age;
    }
   function setAge(){
         var age = getAge($('#<%=txtbirthdate.ClientID %>').val().split("-"));
        $('#<%=txtAge.ClientID %>').val(age);
   }
    
</script>

<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Share Holder/Director</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Share Holder/Director</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Full Name</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtfullname"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Date Of Birth</label>
                        <div class="col-lg-6">
                            <asp:TextBox CssClass="form-control input-sm my-picker" ID="txtbirthdate" runat="server"></asp:TextBox>
                        </div>
                        </asp:TextBox><input type="button" value="Calculate Age" onclick="setAge()" class="btn btn-success btn-xs col-md-2" />
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Age</label>
                        <div class="col-lg-6">
                            <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtAge" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Nationality</label>
                        <div class="col-lg-9">
                            <asp:DropDownList class="form-control input-sm col-md-6" ID="ddlNationality" runat="server"
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_nationalities]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Country Of Residence</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtcountryres"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Educational Background</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEducationalBackground"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Date Of Appointment</label>
                        <div class="col-lg-9">
                            <asp:TextBox CssClass="form-control input-sm col-md-6 my-picker" ID="txtDateOfAppointment"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Share Holder/Director</label>
                        <div class="col-lg-9">
                            <asp:DropDownList ID="ddlShord" runat="server" CssClass="form-control input-sm col-md-6"
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_shord]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div runat="server" id="percentage" class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Percentage</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtpercentage"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                            <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                        </div>
                    </div>
                    <%--<asp:CustomValidator ID="vOwnership" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <span class=" glyphicon glyphicon-warning-sign pull-left"></i>
                            <h6 class="text-center">
                                <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                            <hr style="margin: 1px" />
                            <p id="ErrMsg" runat="server">
                            </p>
                    </asp:CustomValidator>--%>
                </fieldset>
                <hr />
                <asp:GridView CssClass="table table-bordered" ID="gvOwnership" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="datID" DataSourceID="SqlDataSource1" OnRowDataBound="gvOwnership_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="datFullName" HeaderText="Name" SortExpression="datFullName" />
                        <asp:BoundField DataField="datAppointment" HeaderText="Date Of Appointment" SortExpression="datAppointment" />
                        <asp:BoundField DataField="datDescription" HeaderText="Type Of Ownership" SortExpression="datDescription" />
                        <asp:BoundField DataField="datPercentage" HeaderText="Percentage" SortExpression="datPercentage" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"
                                    Text="Edit">
                                <i class="glyphicon glyphicon-pencil pull-right"></i> Edit 
                                </asp:HyperLink>
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-6 col-md-offset-1"
                                    Text="Delete">
                                <i class="glyphicon glyphicon-remove pull-right"></i> Delete
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="getOwners" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" Type="Int32" />
                        <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'd-m-yyyy'});
</script>