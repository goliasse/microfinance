<%@ Control Language="C#" AutoEventWireup="true" CodeFile="spouse.ascx.cs" Inherits="controls_spouse" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Spouse Details
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Spouse Details</h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Full Name
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtFullName"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Telephone Number
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="telno"
                                autocomplete="off" />
                        </div>
                    </div>
                    <fieldset>
                        <legend>
                            <h5>
                                Type of Identifications</h5>
                        </legend>
                        <div class="form-group">
                            <div class="col-lg-3">
                                <asp:DropDownList CssClass="form-control input-sm" ID="ddlNo1" runat="server" DataSourceID="SqlDataSource3"
                                    DataTextField="datDescription" DataValueField="datID" AutoPostBack="False" AppendDataBoundItems="True">
                                    <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM opt_identification_types"></asp:SqlDataSource>
                            </div>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtidNo"
                                    autocomplete="off" />
                            </div>
                        </div>
                    </fieldset>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Name Of Dependents
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNameOfDependents"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Date Married
                        </label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="txtDateMarried" class="form-control input-sm col-md-6 my-picker"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <hr style="margin: 0" />
                        <h5>
                            Employment Details
                        </h5>
                        <hr style="margin-top: 0" />
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Name Of Employer
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtNameOfEmployer"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Telephone Number
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtTelNo"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Employer&#39;s Address
                        </label>
                        <div class="col-lg-8">
                            <textarea runat="server" id="txtPhysicalAddress" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Industry Type
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtIndustry"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Employee Number
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEmpNo"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Position
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtPosition"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Monthly Income
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMonthly"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Contact Person
                        </label>
                        <div class="col-lg-8">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtContactPersion"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                   <asp:CustomValidator ID="vOwnership" runat="server" CssClass="vItem col-md-12" OnServerValidate="pageValidation"
                        ErrorMessage="">
                        <span class=" glyphicon glyphicon-warning-sign pull-left"></i>
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

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
</script>

<%--<asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtDateMarried">
</asp:CalendarExtender>
--%>