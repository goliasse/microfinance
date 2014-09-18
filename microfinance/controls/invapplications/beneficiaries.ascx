<%@ Control Language="C#" AutoEventWireup="true" CodeFile="beneficiaries.ascx.cs"
    Inherits="controls_invapplications_beneficiaries" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Beneficiaries
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h6>
                            Beneficiaries</h6>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Title</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlTitle" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="true">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_titles]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            First Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtfirstname" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Middle Name</label>
                        <div class="col-md-9">
                            <input type="text" id="txtmiddlename" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Surname</label>
                        <div class="col-md-9">
                            <input type="text" id="txtsurname" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Birthdate</label>
                        <div class="col-md-9">
                            <input type="text" id="txtBirthdate" runat="server" class="input-sm form-control my-picker" />
                        </div>
                    </div>
                    <fieldset>
                        <legend>
                            <h5>
                                Type of Identification</h5>
                        </legend>
                        <div class="form-group">
                            <div class="col-lg-4">
                                <asp:DropDownList CssClass="form-control" ID="ddlNo1" runat="server" DataSourceID="SqlDataSource3"
                                    DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                    <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM opt_identification_types"></asp:SqlDataSource>
                            </div>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtidNo1"
                                    autocomplete="off" />
                            </div>
                        </div>
                    </fieldset>
                    <hr style="margin: 1px;" />
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Occupation</label>
                        <div class="col-md-9">
                            <input type="text" id="txtOccupation" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Percentage Share</label>
                        <div class="col-md-9">
                            <input type="text" id="txtpercentageshare" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Mobile Number</label>
                        <div class="col-md-9">
                            <input type="text" id="txtMobile" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Email Address</label>
                        <div class="col-md-9">
                            <input type="text" id="txtEmail" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Home Telephone Number</label>
                        <div class="col-md-9">
                            <input type="text" id="txtHomeTel" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Office Telephone Number</label>
                        <div class="col-md-9">
                            <input type="text" id="txtOffTel" runat="server" class="input-sm form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Postal Address</label>
                        <div class="col-md-9">
                            <textarea id="txtPostalAddress" class="form-control input-sm" runat="server" cols="20"
                                rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">
                            Residential Address</label>
                        <div class="col-md-9">
                            <textarea id="txtResAddress" class="form-control input-sm" runat="server" cols="20"
                                rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-9">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="Save"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
            <hr />
            <p>
                <asp:GridView ID="gvBeneficiaries" CssClass="table table-bordered" runat="server" AutoGenerateColumns="False" DataKeyNames="datID"
                    DataSourceID="SqlDataSource1" 
                    onrowdatabound="gvBeneficiaries_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Name"></asp:TemplateField>
                        <asp:BoundField DataField="datMobileNumber" HeaderText="Mobile No." SortExpression="datMobileNumber" />
                        <asp:BoundField DataField="datEmailAddress" HeaderText="Email" SortExpression="datEmailAddress" />
                        <asp:BoundField DataField="datPercentageShare" HeaderText="Percentage Share" SortExpression="datPercentageShare" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"
                                    Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i>  Edit
                                </asp:HyperLink>
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"
                                    Text="Delete">
                                    <i class="glyphicon glyphicon-remove"></i> Delete 
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="GetBeneficiaries" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                        <asp:SessionParameter Name="ClientID" SessionField="ClientID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </p>
        </div>
    </div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
</script>

