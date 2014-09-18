<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="pages_profile" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-md-10">
   <div class="row">
    <input type="button" name="HideShowProfile" id="HideShowProfile" value="Edit Profile" class="btn btn-success btn-xs" />
    </div>
    <br />
   <div class="myProfile col-md-8">
        <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Users Profile </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Corporate Information</h5></legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead"> Name </label>
                        <div class="col-lg-9">
                            <span></span>
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Commencement Date </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="TextBox1" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Year In Business </label>
                        <div class="col-lg-9"> 
                           <input runat=server type="text" class="form-control input-sm col-md-6" id="Text2" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Industry Type </label>
                        <div class="col-lg-9">
                           <asp:DropDownList cssclass="form-control input-sm" ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                                DataValueField="datID" AutoPostBack=true ></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_industry]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Sector </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control input-sm" ID="DropDownList2" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" 
                                DataValueField="datID"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_sector] WHERE ([datIndustryID] = @datIndustryID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlIndustryType" Name="datIndustryID" 
                                        PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Physical Address </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="Textarea1" class="form-control input-sm col-md-5" style="height:80px"></textarea>
                            <%--<input runat=server type="text" class="form-control input-sm col-md-5" id="txtInterestrate" autocomplete="off">--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone No. 1 </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="Text3" autocomplete="off">
                        </div>
                    </div><div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone No. 2 </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="Text4" autocomplete="off">
                        </div>
                    </div><div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Fax </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="Text5" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Nature Of Business </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="Text6" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Premises Status </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control" ID="DropDownList3" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                                DataValueField="datID">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_premises_statuses]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">Registered </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control" ID="DropDownList4" runat="server" 
                                DataSourceID="SqlDataSource6" DataTextField="datDescription" onchange="HideShowRegistered()"
                                DataValueField="datID">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesno]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div runat=server id="Div1" style="display:none">
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">Registration Date </label>
                            <div class="col-lg-9">
                                    <asp:TextBox ID="TextBox2" class="form-control datepicker input-sm col-md-5" runat="server"></asp:TextBox>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">Registration Number </label>
                            <div class="col-lg-9">
                                    <asp:TextBox ID="TextBox3" class="form-control datepicker input-sm col-md-5" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">VAT Number </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="Text7" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">TIN </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="Text8" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Website </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="Text9" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10">
                            <asp:Button ID="Button1" style="height:25px;width:15%" class="btn btn-xs btn-success" runat="server" Text="SAVE" />
                       </div>
                    </div>
                </fieldset>
            </div>
        </div>
      </div>
   </div>
   <div class="Edit col-md-8">
        <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">Edit Users Profile </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal">
                <fieldset>
                    <legend><h5>Corporate Information</h5></legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Company Name </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-6" id="txtCompanyName" autocomplete="off">
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Commencement Date </label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtCommencementDate" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Year In Business </label>
                        <div class="col-lg-9"> 
                           <input runat=server type="text" class="form-control input-sm col-md-6" id="txtYearsInBusiness" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Industry Type </label>
                        <div class="col-lg-9">
                           <asp:DropDownList cssclass="form-control input-sm" ID="ddlIndustryType" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="datDescription" 
                                DataValueField="datID" AutoPostBack=true ></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_industry]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Sector </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control input-sm" ID="ddlSector" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="datDescription" 
                                DataValueField="datID"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_sector] WHERE ([datIndustryID] = @datIndustryID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlIndustryType" Name="datIndustryID" 
                                        PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Physical Address </label>
                        <div class="col-lg-9">
                            <textarea runat="server" id="txtPhysicalAddress" class="form-control input-sm col-md-5" style="height:80px"></textarea>
                            <%--<input runat=server type="text" class="form-control input-sm col-md-5" id="txtInterestrate" autocomplete="off">--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone No. 1 </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtTel1" autocomplete="off">
                        </div>
                    </div><div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Telephone No. 2 </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtTel2" autocomplete="off">
                        </div>
                    </div><div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Fax </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtFax" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Nature Of Business </label>
                        <div class="col-lg-9">
                            <input runat=server type="text" class="form-control input-sm col-md-5" id="txtNatureofbusiness" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Premises Status </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control" ID="ddlPremisesStatus" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                                DataValueField="datID">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_premises_statuses]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="txtMobile">Registered </label>
                        <div class="col-lg-9">
                            <asp:DropDownList cssclass="form-control" ID="ddlRegistered" runat="server" 
                                DataSourceID="SqlDataSource6" DataTextField="datDescription" onchange="HideShowRegistered()"
                                DataValueField="datID">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_yesno]">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div runat=server id="RegisteredPanel" style="display:none">
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">Registration Date </label>
                            <div class="col-lg-9">
                                    <asp:TextBox ID="txtRegistrationDate" class="form-control datepicker input-sm col-md-5" runat="server"></asp:TextBox>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-lg-3 control-label" for="typeahead">Registration Number </label>
                            <div class="col-lg-9">
                                    <asp:TextBox ID="txtRegistrationNumber" class="form-control datepicker input-sm col-md-5" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">VAT Number </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="txtVATNo" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">TIN </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="txtTIN" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" for="typeahead">Website </label>
                        <div class="col-lg-9">
                             <input runat=server type="text" class="form-control input-sm col-md-5" id="txtwebsite" autocomplete="off" />
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="col-lg-10">
                            <asp:Button ID="btnSave" style="height:25px;width:15%" class="btn btn-xs btn-success" runat="server" Text="SAVE" />
                       </div>
                    </div>
                </fieldset>
            </div>
        </div>
      </div>
   </div>
 </div>
</asp:Content>

