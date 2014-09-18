<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Enterprise.ascx.cs" Inherits="controls_Enterprise" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Entreprise </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Client Details</h5></legend>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">Title </label>
                        <div class="col-lg-10">
                            <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="Text1" autocomplete="off">--%>
                            <asp:DropDownList cssclass="chzn-single" ID="ddlTitle" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                                DataValueField="datID">
                                <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_titles]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">First Names </label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtfirstname" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">Middle Name </label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMiddlename" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">Surname </label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtSurname" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">Telephone </label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txttelephone" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="txtMobile">Mobile No.</label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMobileNo" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="txtMobile">Email</label>
                        <div class="col-lg-10">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtEmail" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" for="typeahead">Home Address </label>
                        <div class="col-lg-10">
                            <textarea runat=server id="txthomeAddress" class="form-control input-sm col-md-6"  style="width: 80%; height: 120px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10">
                            <asp:Button ID="btnSave" style="width:15%" 
                                class="btn btn-xs btn-success" runat="server" Text="Submit" 
                                onclick="btnSave_Click" />
                            
                       </div>
                    </div>
                </fieldset>
            </div>
        </div>
      </div>
</div>