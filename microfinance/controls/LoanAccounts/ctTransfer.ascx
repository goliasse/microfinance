<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctTransfer.ascx.cs" Inherits="controls_LoanAccounts_ctTransfer" %>
<style type="text/css">
    .form-group{ margin-bottom:0;}

</style>
<div class="row">
     <div class="panel panel-default">
        <div class="panel-heading" >
            <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b> ACCOUNT TRANSFERS </b></h6></div>
        </div>
        <div class="bootstrap-admin-panel-content">
            
          <div class="form-horizontal">
            <div class="form-group">
                <label class="col-lg-3"> Branch </label>
                <div class="col-lg-8">
                    <span runat="server" id="lblBranch" class="col-md-8"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-3"> Credit Team </label>
                <div class="col-lg-8">
                    <span runat="server" id="lblCreditTeam" class=" col-md-8"></span>
                </div>
            </div>
            <hr/>
           
            <fieldset>
                <div class="form-group">
                    <label class="col-lg-3"> New Branch </label>
                    <div class="col-lg-8">
                        <asp:DropDownList ID="ddlNewBranch"  CssClass="form-control input-sm" 
                            runat="server" AppendDataBoundItems="True" AutoPostBack="True" 
                            DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                            DataValueField="datID">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [tbl_teams]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3"> New Credit Team </label>
                    <div class="col-lg-8">
                        <asp:DropDownList ID="ddlNewCT" CssClass="form-control input-sm" 
                            runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2" 
                            DataTextField="datDescription" DataValueField="datID">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlNewBranch" Name="datTeamID" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <hr />
                 <div class="form-group">
                    <div class="col-md-12">
                        <asp:Button ID="btnAccountTransfer" CssClass="btn btn-xs btn-success col-md-3" 
                            runat="server" Text="Transfer Account" onclick="btnAccountTransfer_Click" />
                    </div>
                </div>
            </fieldset>
          </div>
       </div>
     </div>
</div>