﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="personalInformation.ascx.cs"
    Inherits="controls_personalInformation" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Personal Information
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend>
                        <h5>
                            Personal Information
                        </h5>
                    </legend>
                    <input type="hidden" runat="server" id="editskip" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Title
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control input-sm" ID="ddlTitle" runat="server" DataSourceID="SqlDataSource1"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_titles]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            First Names
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm" id="txtfirstname"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Middle Name
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm" id="txtMiddlename"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Surname
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm" id="txtSurname" autocomplete="off">
                        </div>
                    </div>
                    <fieldset>
                        <legend>
                            <h5>
                                Type of Identifications</h5>
                        </legend>
                        <div class="form-group">
                            <div class="col-lg-4">
                                <asp:DropDownList CssClass="form-control input-sm" ID="ddlNo1" runat="server" DataSourceID="SqlDataSource3"
                                    DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                    <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM opt_identification_types"></asp:SqlDataSource>
                            </div>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtidNo1"
                                    autocomplete="off" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-4">
                                <asp:DropDownList CssClass="form-control input-sm" ID="ddlNo2" runat="server" DataSourceID="SqlDataSource3"
                                    DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                    <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM opt_identification_types"></asp:SqlDataSource>
                            </div>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtidNo2"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-4">
                                <asp:DropDownList CssClass="form-control input-sm" ID="ddlidNo3" runat="server" DataSourceID="SqlDataSource5"
                                    DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                    <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                    SelectCommand="SELECT datID, datDescription FROM opt_identification_types"></asp:SqlDataSource>
                            </div>
                            <div class="col-lg-8">
                                <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtidNo3"
                                    autocomplete="off">
                            </div>
                        </div>
                    </fieldset>
                    <hr />
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Date of Birth
                        </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtBirthdate" class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Gender
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control input-sm" ID="ddlGender" runat="server"
                                DataSourceID="SqlDataSource8" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True">
                                <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_genders]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Nationality
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control input-sm" ID="ddlNationality" runat="server"
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True" AutoPostBack="true">
                                <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_nationalities]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Region
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control input-sm" ID="ddlRegion" runat="server"
                                DataSourceID="SqlDataSource6" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" >
                                <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_region]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Marital Status
                        </label>
                        <div class="col-lg-9">
                            <asp:DropDownList CssClass="form-control input-sm" ID="ddlMaritalStatus" runat="server"
                                DataSourceID="SqlDataSource7" DataTextField="datDescription" DataValueField="datID"
                                AppendDataBoundItems="True">
                                <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_marital_statuses]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Spouse Name</label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtSpouse" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Number of Children
                        </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtNoChildren" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Mobile No. [SMS Default]</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMobileNo1"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Mobile No. 2</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtMobileNo2"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Home Telephone No.
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txttelephone"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Office Telephone No.
                        </label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtOfficePhone"
                                autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Fax Number</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtfaxnumber"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Email Address</label>
                        <div class="col-lg-9">
                            <input runat="server" type="text" class="form-control input-sm col-md-6" id="txtEmail"
                                autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">
                            Residential Status</label>
                        <div class="col-lg-9">
                            <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txtResStatus" autocomplete="off">--%>
                            <asp:DropDownList CssClass="form-control" ID="ddlRecStatus" runat="server" DataSourceID="SqlDataSource9"
                                DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value='0' Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_residential_statuses]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Current Residential Address
                        </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txthomeAddress" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Nearest Land Mark to Current Res. Address
                        </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtLandMark" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Previous Residential Address
                        </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtpreviousAddress" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">
                            Postal Address
                        </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtPostalAddress" class="form-control input-sm col-md-6"
                                style="height: 80px"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10">
                            <asp:Button ID="btnSave" class="btn btn-xs btn-success col-md-3" runat="server" Text="SAVE"
                                OnClick="btnSave_Click" />
                        </div>
                    </div>
                    </label>
                </fieldset>
            </div>
            <asp:CustomValidator ID="vIntialAssesment" runat="server" CssClass="col-md-10" OnServerValidate="pageValidation"
                ErrorMessage="">
                <h6>
                    Errors:</h6>
                <p id="ErrMsg" runat="server">
                </p>
            </asp:CustomValidator>
        </div>
    </div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-MM-yyyy'});
</script>

