<%@ Control Language="C#" AutoEventWireup="true" CodeFile="checklist.ascx.cs" Inherits="controls_checklist" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Check List</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend style="margin:5px 0;"><h5> Check List </h5></legend>
                <input id="editskip" runat=server type="hidden" />
                <div class="form-group">
                    <p style="margin:0" class="col-md-5 text-center">Questions</p>
                    <p style="margin:0" class="col-md-2 text-center">Answer</p>
                    <p style="margin:0" class="col-md-5 text-center">Comments</p>
                </div>
                <hr style="margin:5px 0;" />
                <div runat="server" id="appForm">
                 </div>
                 <br />
                 <br />
                
                 <asp:Button ID="btnSaveCheckList" runat="server"   CssClass="btn btn-xs btn-success col-md-3"  
                            Text="Save" onclick="btnSaveCheckList_Click"  />
            </fieldset>   
        </div>
    </div>
  </div>
</div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
        SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesnona]">
    </asp:SqlDataSource>
