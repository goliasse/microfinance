<%@ Page Language="C#" MasterPageFile="~/backend/MasterPage.master" AutoEventWireup="true" CodeFile="companyprofile.aspx.cs" Inherits="backend_pages_companyprofile" Title="Company Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <div class="col-md-12">
            <p><h6><b> Company Profile Information  </b></h6><hr style="margin:0px" /></p>
        </div>
        <div class="col-md-12">
            <div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Company Profile Information</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5></h5></legend>
                <div class="">
                    <asp:Image ID="picLogo" class="img-thumbnail" runat="server" />
                </div>
                <hr />
                <input type="hidden" runat="server" id="editskip" /> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Company</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtCompany" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Postal Address</label>
                    <div class="col-lg-9">
                        <textarea id="txtpostalAddress" runat="server" class="form-control input-sm col-md-6" ></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Telephone No.</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtTelNo" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Email</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEmail" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Website Url</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtWebsite" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Physical Address</label>
                    <div class="col-lg-9">
                        <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtlocation" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Logo</label>
                    <div class="col-lg-9">
                        <asp:FileUpload ID="fuLogo" runat="server"></asp:FileUpload>
                        <%--<input runat="server" type="text" class="form-control input-sm col-md-6" id="Text5" autocomplete="off">--%>
                    </div>
                </div>
                
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" 
                            Text="SAVE" onclick="btnSave_Click" />
                       
                   </div>
                </div>
            </fieldset>
            <hr />
        </div>
    </div>
  </div>
        
        
        </div>
    </div>
</asp:Content>

