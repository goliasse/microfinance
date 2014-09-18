<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="loanaccount.aspx.cs" Inherits="pages_loanaccount" Title="Loan Accounts" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<%@ Register src="~/controls/LoanAccounts/loanaccounts.ascx" tagname="loanaccounts" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
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
              <a class="navbar-brand" href="#">Loan Accounts</a>
            &#160;
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <div class="navbar-form navbar-left pull-right col-md-8" role="search" style="width:50%">
                <div class="form-group col-lg-10">
                  <asp:TextBox ID="txtSearchTerm" OnTextChanged="txtSearchClient_TextChanged" class="col-md-6 input-sm form-control" runat="server" AutoPostBack="True"></asp:TextBox>
                  <%--<input runat="server" id="txtSearchTerm" type="text"  class="col-md-6 input-sm form-control" placeholder="Search">--%>
                </div>
                  <button type="submit" class="btn btn-sm btn-success">Submit</button>
              </div>
             
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </asp:Panel>
    
    <asp:Panel ID="contentPanel" runat="server">
        <uc1:loanaccounts ID="loanaccounts2" runat="server" />
    </asp:Panel>
  </div>
</asp:Content>

