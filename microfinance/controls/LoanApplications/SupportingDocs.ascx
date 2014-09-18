<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SupportingDocs.ascx.cs"
    Inherits="controls_SupportingDocs" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Supporting Documents</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Supporting Documents</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Document Type</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtDocumentType"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Description
                        </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtDescription" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="optionsCheckbox">
                            Upload Document</label>
                        <div class="col-lg-9">
                            <asp:FileUpload ID="fuDocument" runat="server" />
                        </div>
                    </div>
                    <div id="docView" runat="server" class="form-group">
                        <asp:HyperLink ID="HyperDocs" runat="server"><label class="col-lg-8 control-label" for="optionsCheckbox">Click Here to view Document</label></asp:HyperLink>
                        <asp:Label ID="UploadStatusLabel" Visible="false" runat="server" Text="Label"></asp:Label>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                </fieldset>
                <hr />
                <asp:GridView CssClass="table table-stripped table-bordered" ID="gvSupportingDocs"
                    runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="DatID"
                    OnRowDataBound="gvSupportingDocs_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="datFileName" HeaderText="Document Name" SortExpression="datFileName" />
                        <asp:BoundField DataField="datDescription" HeaderText="Description" SortExpression="datDescription" />
                        <%-- <asp:BoundField DataField="datFilePath" HeaderText="Document Location" 
                        SortExpression="datFilePath" />--%>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success  col-md-5"
                                    Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i>  Edit 
                                </asp:HyperLink>
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success  col-md-6 col-md-offset-1"
                                    Text="Delete">
                                    <i class="glyphicon glyphicon-remove"></i>  Delete 
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                    SelectCommand="getSupportingDocuments" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" Type="Int32" />
                        <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</div>
