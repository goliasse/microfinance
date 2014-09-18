<%@ Control Language="C#" AutoEventWireup="true" CodeFile="newuser.ascx.cs" Inherits="backend_controls_newuser" %>
<div class="col-md-12">
<div class="panel panel-default bootstrap-admin-no-table-panel">
    <div class="panel-heading">
        <div class="text-muted bootstrap-admin-box-title"> Users </div>
    </div>
    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
       <div class="col-md-10">
        <div class="form-horizontal">
            <input type="hidden" runat="server" id="editskip" />
            <fieldset>
                <legend><h5> Users </h5></legend>
                
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Title</label>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="ddlTitle" CssClass="form-control col-md-6" 
                        runat="server" DataSourceID="SqlDataSource1" 
                            DataTextField="datDescription" DataValueField="datID" 
                        AppendDataBoundItems="True">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                            SelectCommand="SELECT [datID], [datDescription] FROM [opt_titles]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">First Name</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtfirstname" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Surname</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtsurname" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Date of Birth</label>
                    <div class="col-lg-9">
                        <asp:TextBox   ID="txtBirthdate" CssClass="form-control input-xs my-picker" runat="server"></asp:TextBox>
                    </div>
                </div>  
                 <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Email Address</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtEmail" autocomplete="off">
                    </div>
                </div> 
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Mobile Number</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtMobileNo" autocomplete="off">
                    </div>
                </div>  
                  <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Position</label>
                    <div class="col-lg-9">
                        <input runat=server type="text" class="form-control input-sm col-md-6" id="txtPosition" autocomplete="off">
                    </div>
                </div>  
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Designation </label>
                    <div class="col-lg-9">
                        
                        <asp:DropDownList cssclass="form-control" ID="ddlDesignation" runat="server"  
                            DataSourceID="SqlDataSource3" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [opt_levels]">
                       </asp:SqlDataSource>
                    </div>
                </div>       
                <div class="form-group">
                    <label class="col-lg-3 control-label" for="typeahead">Branch </label>
                    <div class="col-lg-9">
                        <%--<asp:ComboBox CssClass="chzn-single" ID="ComboBox1" runat="server">
                        </asp:ComboBox>--%>
                        <%--<input runat=server type="text" class="form-control input-sm col-md-6" id="txttelno" autocomplete="off">--%>
                        <asp:DropDownList cssclass="form-control" ID="ddlTeam" runat="server"  DataSourceID="SqlDataSource2" DataTextField="datDescription" 
                                DataValueField="datID" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                                SelectCommand="SELECT [datID], [datDescription] FROM [tbl_teams]">
                       </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                   <div class="col-lg-10" >
                        <asp:Button ID="btnSave"  
                            class="btn btn-xs btn-success col-md-2" runat="server" Text="ADD USER" onclick="btnSave_Click" 
                             />
                   </div>
                </div>
            </fieldset>
           </div>
        </div>
    </div>
  </div>
  <script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});
    </script>
 <%-- <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txtBirthdate" Format="dd/MM/yyyy" runat="server">
  </asp:CalendarExtender>--%>
</div>

