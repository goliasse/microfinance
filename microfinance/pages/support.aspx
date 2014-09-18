<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="support.aspx.cs" Inherits="pages_support" Title="Support for system users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
       <p>
        <h5></h5>
        <hr />
       </p>     
        <div class="panel panel-default bootstrap-admin-no-table-panel">
            <div class="panel-heading">
                <div class="text-muted bootstrap-admin-box-title">Error Report</div>
            </div>
            <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                <div class="form-horizontal">
                    <fieldset>
                        <legend><h5>Error Report</h5></legend>
                        <input type="hidden" runat=server  id="editskip" />
                        <div class="form-group">
                        <%--div class="col-md-12"--%>
                            <div class="col-md-12">
                             <textarea runat=server id="txtDescription" class="form-control input-sm col-md-6"  style="height: 250px"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group">
                           <div class="col-lg-10" >
                                <asp:Button ID="btnSave"  class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"/>
                               <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                           </div>
                        </div>
                    </fieldset>
                    <hr />
                </div>
            </div>
          </div>
    </div>
</asp:Content>

