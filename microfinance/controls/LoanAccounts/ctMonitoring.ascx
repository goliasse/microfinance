<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctMonitoring.ascx.cs"
    Inherits="controls_LoanAccounts_ctMonitoring" %>
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Account Monitoring</div>
        </div>
        <div class="bootstrap-admin-panel-content">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h6>
                            Write A Comment</h6>
                    </legend>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <textarea runat="server" id="txtComment" class="form-control input-sm" style="height: 300px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <asp:Button ID="btnSaveComments" CssClass="btn btn-xs btn-success col-md-3" runat="server"
                                Text="SAVE COMMENT" OnClick="btnSaveComments_Click" />
                        </div>
                    </div>
                    <hr style="margin: 5px;" />
                    <div class="form-group">
                        <div class="col-lg-12">
                            <asp:Button ID="btnOpenReport" CssClass="btn btn-xs btn-primary col-md-3" runat="server"
                                Text="VIEW COMMENTS" />
                        </div>
                    </div>
                    <hr style="margin: 5px;" />
                    <asp:CustomValidator ID="vAcMonitoring" runat="server" CssClass="vItem col-md-12"
                        OnServerValidate="pageValidation" ErrorMessage="">
                            <h6 class="text-center">
                                <span class=" glyphicon glyphicon-warning-sign pull-left"></span>ERROR</h6>
                            <hr style="margin: 1px" />
                            <p id="ErrMsg" runat="server">
                            </p>
                    </asp:CustomValidator>
                </fieldset>
            </div>
        </div>
    </div>
</div>
