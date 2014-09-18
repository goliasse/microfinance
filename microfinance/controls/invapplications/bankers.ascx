<%@ Control Language="C#" AutoEventWireup="true" CodeFile="bankers.ascx.cs" Inherits="controls_invapplications_bankers" %>
 <div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Bankers Details</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Bankers Details</h5>
                    </legend>
                    <div class="form-group">
                        <input type="hidden" runat="server" id="editskip" />
                        <label class="col-lg-3 control-label" for="typeahead">
                            Bank</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtbank"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Branch
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtbranch"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Account Name</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAcName"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Account Number</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtAcNo"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="ddlActype">
                            Account Type</label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control" ID="ddlType" runat="server">
                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem>Current</asp:ListItem>
                                <asp:ListItem>Savings</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
            <hr />
            <asp:GridView ID="gvBanker" CssClass="table table-striped table-bordered" runat="server"
                DataKeyNames="datID" OnRowDataBound="gvBanker_RowDataBound" AutoGenerateColumns="False"
                DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="datBank" HeaderText="Bank Name" SortExpression="datBank" />
                    <asp:BoundField DataField="datBranch" HeaderText="Branch" SortExpression="datBranch" />
                    <asp:BoundField DataField="datAccountType" HeaderText="Account Type" SortExpression="datAccountType" />
                    <asp:BoundField DataField="datAccountName" HeaderText="Account Name" SortExpression="datAccountName" />
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
            </asp:GridView>
            &nbsp;
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                SelectCommand="GetInvBankers" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="InvAppID" SessionField="InvAppID" Type="Int32" />
                    <asp:SessionParameter Name="clientID" SessionField="ClientID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</div>