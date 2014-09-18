<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnterpriseDetails.ascx.cs" Inherits="controls_EnterpriseDetails" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Enterprise Details</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Enterprise Details</h5></legend>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Name of Enterprise</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtEntName" autocomplete="off">
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Telephone Number</label>
                    <div class="col-lg-9">
                        <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtTelephoneNo" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Fax Number</label>
                    <div class="col-lg-9">
                        <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtFaxNo" runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Physical Address</label>
                    <div class="col-lg-9">
                        <textarea runat="server" id="txtPhysicalAddress" style="height:80px" class="form-control input-sm col-md-5"></textarea>
                        <%--<asp:TextBox CssClass="form-control input-sm col-md-5" ID="TextBox1" runat="server"></asp:TextBox>--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Activity</label>
                    <div class="col-lg-9">
                        <asp:TextBox CssClass="form-control input-sm col-md-5" ID="txtActivity" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Registration Date</label>
                    <div class="col-lg-9">
                        <asp:TextBox CssClass="form-control input-sm col-md-6 my-picker" ID="txtRegDate" runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Registration Number</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtRegNo" autocomplete="off">
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Enterprise Premises Status</label>
                    <div class="col-lg-9">
                       <asp:DropDownList ID="ddlEnterprisePremStatus" runat="server" CssClass="form-control input-sm col-md-6" 
                             DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                             DataValueField="datID" AppendDataBoundItems="True">
                             <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                         </asp:DropDownList>
                         <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                             ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                             
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_residential_statuses]">
                         </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Date Of Occupancy</label>
                    <div class="col-lg-9">
                         <asp:TextBox CssClass="form-control input-sm col-md-6 my-picker" ID="txtDateOfOccupancy" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="ddlNationality">Sector</label>
                    <div class="col-lg-9">
                        <asp:DropDownList class="form-control input-sm col-md-8" ID="ddlSector" runat="server" 
                            DataSourceID="SqlDataSource2" DataTextField="datDescription" 
                            DataValueField="datID" AppendDataBoundItems="True">
                            <asp:ListItem Value='-1' Text="--Select--"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_enterprise_sectors]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"  
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                   </div>
                </div>
                <asp:CustomValidator ID="vEmploymentDetails" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                 <h6>Errors:</h6>
                  <p id="ErrMsg" runat="server"></p>
                 </asp:CustomValidator>
            </fieldset>
        </div>
    </div>
  </div>
</div>
<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
 </script>
<%--<asp:CalendarExtender TargetControlID="txtRegDate" ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy">
</asp:CalendarExtender>
<asp:CalendarExtender TargetControlID="txtDateOfOccupancy" ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy">
</asp:CalendarExtender>--%>