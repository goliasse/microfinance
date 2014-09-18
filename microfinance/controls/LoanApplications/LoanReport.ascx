<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoanReport.ascx.cs" Inherits="controls_LoanReport" %>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Loan Report</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Loan Report</h5></legend>
                <input type="hidden" id="editskip" runat=server />
                <div class="form-group">
                <%--div class="col-md-12"--%>
                    <div class="col-md-12">
                     <textarea runat=server id="txtDescription" class="form-control input-sm col-md-6"  style="height: 250px"></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" 
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" onclick="btnSave_Click" 
                             />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
                 <asp:CustomValidator ID="vNextOfKins" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                  <p id="ErrMsg" runat="server"></p>
                </asp:CustomValidator>
            </fieldset>
            <hr />
        </div>
    </div>
  </div>
</div>