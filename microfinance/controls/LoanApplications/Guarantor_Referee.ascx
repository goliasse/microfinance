<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Guarantor_Referee.ascx.cs" Inherits="controls_Guarantor_Referee" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<div class="row">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title">Guarantor</div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
        <div class="form-horizontal">
            <fieldset>
                <legend><h5>Guarantor/Referee</h5></legend>
                <input type="hidden" runat="server" id="editskip" />
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Full Name</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtfullname" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Relationship </label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtRelationship" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Number of Years Aquainted</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtYrsAcquainted" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="ddlNationality">Nationality</label>
                    <div class="col-lg-9">
                            <asp:DropDownList class="form-control" ID="ddlNationality" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True" 
                                >
                               <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_nationalities]">
                            </asp:SqlDataSource>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Date Of Birth</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtBirthdate" class="form-control input-sm col-md-6 my-picker" runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Mobile Number</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtMobile" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Home Telephone No.</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtHomeTelNo" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Office Telephone No.</label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtOfficeTelNo" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Email Address</label>
                    <div class="col-lg-9">
                       <asp:TextBox ID="txtEmail" class="form-control input-sm col-md-6" runat="server"></asp:TextBox>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Home Address</label>
                    <div class="col-lg-9">
                         <textarea runat=server id="txtHomeAddress" class="form-control input-sm col-md-6"  style="height: 80px"></textarea>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Office Address</label>
                    <div class="col-lg-9">
                         <textarea runat=server id="txtOfficeAddress" class="form-control input-sm col-md-6"  style="height: 80px"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="optionsCheckbox">Guarantor/Referee</label>
                    <div class="col-lg-9">   
                        <asp:DropDownList CssClass="form-control" ID="ddlGORR" runat="server" DataSourceID="SqlDataSource2" 
                            DataTextField="datDescription" DataValueField="datID" 
                            AppendDataBoundItems="True" >
                            <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                        </asp:DropDownList> 
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_gorr]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave" 
                            class="btn btn-xs btn-success col-md-3" runat="server" Text="ADD" 
                            onclick="btnSave_Click" />
                       <%-- <button type="reset" style="height:25;width:15%" class="btn btn-xs btn-default">Cancel</button>--%>
                        <asp:CustomValidator ID="vGuarrantor" runat="server" CssClass="col-md-10"  OnServerValidate="pageValidation" ErrorMessage="">
                         <h6>Errors:</h6>
                          <p id="ErrMsg" runat="server"></p>
                        </asp:CustomValidator>
                   </div>
                </div>
            </fieldset>
<%--            <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtBirthdate">
           </asp:CalendarExtender>--%>
            <asp:GridView CssClass="table table-stripped table-bordered" ID="gvGuarantor" runat="server" 
                AutoGenerateColumns="False" DataKeyNames="datID" 
                DataSourceID="SqlDataSource1" onrowdatabound="gvGuarantor_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="datFullName" HeaderText="Full Name" 
                        SortExpression="datFullName" />
                    <asp:BoundField DataField="datMobileNumber" HeaderText="Mobile Number" 
                        SortExpression="datMobileNumber" />
                    <asp:BoundField DataField="datEmailAddress" HeaderText="Email Address" 
                        SortExpression="datEmailAddress" />
                    <asp:BoundField DataField="gorr" HeaderText="Guarantor/Referee" 
                        SortExpression="gorr" />
                    <asp:TemplateField HeaderText="Edit">
                             <ItemTemplate>
                                 <asp:HyperLink ID="hyperEdit" runat="server" CssClass="btn btn-xs btn-success col-md-5"  Text="Edit">
                                    <i class="glyphicon glyphicon-pencil"></i> Edit 
                                </asp:HyperLink>                     
                                <asp:HyperLink ID="hyperDelete" runat="server" CssClass="btn btn-xs btn-success col-md-5 col-md-offset-1" Text="Delete">
                                    <i class="glyphicon glyphicon-remove"></i>  Delete 
                                </asp:HyperLink>
                             </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="getGuarantor" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="1" Name="clientID" SessionField="ClientID" 
                        Type="Int32" />
                    <asp:SessionParameter DefaultValue="1" Name="AppID" SessionField="AppID" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
  </div>
</div>
    <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>