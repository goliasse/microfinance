<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="applicationtracker.aspx.cs" Inherits="pages_applicationtracker" Title="Application Tracker" %>

<%@ Register src="~/controls/LoanApplications/applicationtrails.ascx" tagname="applicationtrails" tagprefix="uc1" %>
<%@ Register src="~/controls/LoanApplications/applicationtrail.ascx" tagname="applicationtrail" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="col-md-10" >
    <div class="col-md-12">
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
              <a class="navbar-brand" href="#">Search Application</a>
                
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
             <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  
                  <div class="navbar-form navbar-left pull-right" style="width:60%; margin-bottom:0px" role="search">
                    <div class="form-group col-md-10">
                        <asp:TextBox ID="txtSearchTerm" class="col-md-8 input-sm form-control" style="with:80%" runat="server" AutoPostBack="True"></asp:TextBox>
                      <%--<input runat="server" id="txtSearchTerm" type="text" class="col-md-8 input-sm form-control" placeholder="Search">--%>
                    </div>
                      <asp:Button  ID="btnSearchClient" class="btn btn-sm btn-success" runat="server" Text="Search"></asp:Button>
                  </div>
                </div><!-- /.navbar-collapse -->
             </div><!-- /.container-fluid -->
        </nav>
    </asp:Panel>
    </div>
    <div class="col-md-12">
        <asp:Panel ID="mPanelContent" runat="server">
            <uc1:applicationtrails ID="applicationtrails1" runat="server" />
            <uc2:applicationtrail ID="applicationtrail1" runat="server" />
        </asp:Panel>    
    </div>


  </div>
</asp:Content>

