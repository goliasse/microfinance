<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LegalReport.ascx.cs" Inherits="controls_Legal" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Legal Report</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Legal Report</h5></legend>
                <input type="hidden" runat=server  id="editskip" />
                <div class="form-group">
                <%--div class="col-md-12"--%>
                    <div class="col-md-12">
                     <textarea runat=server id="txtDescription" class="form-control input-sm col-md-6"  style="height: 250px"></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"  class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" onclick="btnSave_Click" 
                             />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
            </fieldset>
            <hr />
        </div>
    </div>
  </div>
</div>