<%@ Control Language="C#" AutoEventWireup="true" CodeFile="nextofkinBeneficiary.ascx.cs" Inherits="controls_invapplications_nextofkin" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Next Of Kin</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Next Of Kin</h5>
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
                    <%--<div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Relationship</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtRelationship"
                                autocomplete="off">
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Mobile No.
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMobile"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Home Telephone No.</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtHomeTel"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Office Telephone No.</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtOfficeTel"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Email Address</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEmail"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Percentage Share</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtpercentageshare"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Address</label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtAddress" class="form-control input-sm col-md-6" style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                            <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                        </div>
                    </div>
                    <%--<asp:CustomValidator ID="vNextOfKins" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span> ERROR</h6>
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>--%>
                </fieldset>
                <hr />
                <asp:GridView CssClass="table table-stripped table-bordered" ID="gvNextOfKin" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="datID" DataSourceID="SqlDataSource1"
                    OnRowDataBound="gvNextOfKin_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="datFullName" HeaderText="Full Name" SortExpression="datFullName" />
                        <asp:BoundField DataField="datMobileNumber" HeaderText="Mobile Number" SortExpression="datMobileNumber" />
                        <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" SortExpression="datEmailAddress" />
                        <asp:BoundField DataField="datPercentageShare" HeaderText="Percentage Share" SortExpression="datPercentageShare" />
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"
                                    Text="Edit">
                                    <i class="glyphicon glyphicon-pencil pull-left"> </i>  Edit
                                </asp:HyperLink>
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-6 col-md-offset-1"
                                    Text="Delete">
                                    <i class="glyphicon glyphicon-remove pull-left"> </i>  Delete
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="getNextOfKins" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" Type="Int32" />
                        <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</div>