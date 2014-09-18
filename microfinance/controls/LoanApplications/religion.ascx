<%@ Control Language="C#" AutoEventWireup="true" CodeFile="religion.ascx.cs" Inherits="controls_religion" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Religion Details </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Religion Details</h5></legend>
                    <input type="hidden" runat="server" id="editskip" /> 
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Religion </label>
                        <div class="col-lg-8">
                            <asp:DropDownList ID="ddlReligion" CssClass="form-control" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt-religion]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Place Of Worship </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtPlaceOfWorship" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Name Of Leader </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtNameOfLeader" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone Number </label>
                        <div class="col-lg-8">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtTel" autocomplete="off" />
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Physical Address </label>
                        <div class="col-lg-8">
                             <textarea runat=server id="txtPhysicalAddress" class="form-control input-sm col-md-6"  style=" height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" onclick="btnSave_Click" />
                       </div>
                    </div>
                     <asp:CustomValidator ID="vNextOfKins" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                     <h6>Errors:</h6>
                      <p id="ErrMsg" runat="server"></p>
                    </asp:CustomValidator>
                    
                </fieldset>
            </div>
        </div>
      </div>
</div>
