<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Auditors.ascx.cs" Inherits="controls_Auditors" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Auditors</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Auditors</h5></legend>
                <div class="form-group">
                <input type="hidden" runat="server" id="editskip" /> 
                    <label class="col-lg-3 control-label" for="typeahead">Name</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtName" autocomplete="off" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Address</label>
                    <div class="col-lg-9">
                        <textarea runat="server" class="form-control input-sm col-md-6" style="height:80px" id="txtAddress"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Auditors/Solicitors</label>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="ddlAuditors_solicitors" CssClass="form-control" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                            DataValueField="datID" AppendDataBoundItems="True">
                            <asp:ListItem Value="-1" Text="--Select--" ></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_aors]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"  
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" onclick="btnSave_Click" 
                            />
                   </div>
                </div>
                <asp:CustomValidator ID="vOwnership" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <h6 class="text-center">
                            <span class=" glyphicon glyphicon-warning-sign pull-left"></span> ERROR</h6>
                        <hr style="margin: 1px" />
                        <p id="ErrMsg" runat="server">
                        </p>
                    </asp:CustomValidator>
            </fieldset>
            <hr  />
           <p> 
            <asp:GridView CssClass="table table-bordered table-striped" ID="gvAuditors" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                   DataSourceID="SqlDataSource3" onrowdatabound="gvAuditors_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datAuditorName" HeaderText="Auditor Name" 
                        SortExpression="datAuditorName" />
                    <asp:BoundField DataField="datAddress" HeaderText="Address" 
                        SortExpression="datAddress" />
                    <asp:BoundField DataField="datDescription" HeaderText="Description" 
                        SortExpression="datDescription" />
                    <asp:TemplateField HeaderText="Edit">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1"  Text="Edit">
                                    <i class="glyphicon glyphicon-pencil pull-left"> </i>  Edit
                                </asp:HyperLink>                     
                                <asp:HyperLink ID="hyperDelete" runat="server"  CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1" Text="Delete">
                                    <i class="glyphicon glyphicon-remove pull-left"></i>  Delete 
                                </asp:HyperLink>
                             </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="GetAuditors" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                        Type="Int32" />
                    <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            </p>
        </div>
    </div>
  </div>
</div>