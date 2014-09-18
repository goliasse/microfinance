<%@ Page Language="C#" MasterPageFile="~/backend/MasterPage.master" AutoEventWireup="true" CodeFile="users.aspx.cs" Inherits="backend_users" Title="Users" %>

<%@ Register src="../controls/newuser.ascx" tagname="newuser" tagprefix="uc1" %>

<%@ Register src="../controls/users.ascx" tagname="users" tagprefix="uc2" %>

<%@ Register src="../controls/accessrights.ascx" tagname="accessrights" tagprefix="uc3" %>

<%@ Register src="../controls/userroles.ascx" tagname="userroles" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10" >
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    </button>
                  <a class="navbar-brand" href="../pages/users.aspx">Users</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <div class="navbar-form navbar-left pull-right col-md-8" role="search" style="width:50%">
                    <div class="form-group col-lg-10">
                      <asp:TextBox ID="txtSearchTerm"  class="col-md-6 input-sm form-control search-query" runat="server" AutoPostBack="True"></asp:TextBox>
                      <%--<input runat="server" id="txtSearchTerm" type="text"  class="col-md-6 input-sm form-control" placeholder="Search">--%>
                    </div>
                      <button type="submit" class="btn btn-sm btn-success">Submit</button>
                 </div>
                <!-- /.navbar-collapse -->
              </div><!-- /.container-fluid -->
            </nav>
        </asp:Panel>    
        <asp:Panel CssClass="row" ID="contentPanel" runat="server">
            <uc2:users ID="users1" runat="server" />          
            <uc4:userroles ID="userroles1" runat="server" />
            <uc1:newuser ID="newuser1" runat="server" />                      
            <uc3:accessrights ID="accessrights1" runat="server" />
                      
        </asp:Panel>
    </div>
</asp:Content>

