<%@ Control Language="C#" AutoEventWireup="true" CodeFile="comments.ascx.cs" Inherits="controls_comments" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Comment</div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Comment</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <div class="col-md-12">
                            <textarea runat="server" id="txtDescription" class="form-control input-sm col-md-6"
                                style="height: 250px"></textarea>
                <hr />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"
                                OnClick="btnSave_Click"/>
                        </div>
                    </div>
                </fieldset>
                <asp:CustomValidator ID="vComment" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                    ErrorMessage="">
                    <h6 class="text-center">
                        <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                    <hr style="margin: 1px" />
                    <p id="ErrMsg" runat="server">
                    </p>
                </asp:CustomValidator>
            </div>
        </div>
    </div>
</div>
