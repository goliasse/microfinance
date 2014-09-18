<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CompanyClient.ascx.cs" Inherits="controls_CompanyClient" %>
 <div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Company /SME </div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Client Details</h5></legend>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Company Name </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtcompanyname" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Telephone No. </label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txttelno" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Physical Address </label>
                    <div class="col-lg-9">
                        <textarea runat=server id="txtphysicalAddress" class="form-control input-sm col-md-6"  style="width: 80%; height: 120px"></textarea>
                        <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtaddress" autocomplete="off" />--%>
                    </div>
                </div>
                <hr /> 
                <div class="form-group">
                    <div class="col-lg-9">
                    <h4>Initiators</h4>
                    </div>
                </div>
                <hr />
                <div class="form-group">
                    <label class="col-lg-2 control-label" for="optionsCheckbox">Full Name</label>
                    <div class="col-lg-10">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtInFullname" autocomplete="off">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-lg-2 control-label" for="txtMobile">Mobile No.</label>
                    <div class="col-lg-10">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMobileno" autocomplete="off" />
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-2 control-label" for="txtMobile">Email</label>
                    <div class="col-lg-10">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtEmail" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10">
                        <asp:Button ID="btnSave" style="height:25px;width:15%" 
                            class="btn btn-xs btn-success" runat="server" Text="Submit" 
                            onclick="btnSave_Click" />
                        <button type="reset" style="height:17px; width:15%" 
                            class="btn btn-xs btn-default">Cancel</button>
                   </div>
                </div>
                <asp:CustomValidator ID="vCompanyClient" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                  <p id="ErrMsg" runat="server"></p>
               </asp:CustomValidator>
            </fieldset>
        </div>
    </div>
  </div>
</div>