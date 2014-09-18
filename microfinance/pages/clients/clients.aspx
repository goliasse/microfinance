<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="clients.aspx.cs" Inherits="pages_clients" Title="Clients " %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>--%>
<%@ Register src="~/controls/clients/clients.ascx" tagname="clients" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/clientPortfolios.ascx" tagname="clientPortfolios" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    function loadPage(pid,cid)
    { 
        var appid =null;
        var accid =null
        //alert(pid);
        if(cid=='loanApp'){$('#type').html("Loan Application Details"); appid=pid};
        if(cid=='loanAcc'){$('#type').html("Loan Account Details"); accid=pid};
        //$("#ucHolder").load("controls/clients/clientPortfolios.ascx");
        PageMethods.mywebMethod(cid,appid,accid);
        $.blockUI({ message: $('#<%=ItemDetails.ClientID %>'), css: { width: '60%', margin:'45px auto',left:'20%',top:'55px' } });
    }
</script>
<style type="text/css">
.modalBackground
{
background-color: Gray;
filter: alpha(opacity=70);
opacity: 0.7;
}
.modalPopup
{
background-color: White;
height: 250px;
width:500px;
text-align:left;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-9">
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
              <a class="navbar-brand" href="#">Clients</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <div class="navbar-form navbar-left pull-right " role="search" style="width:80%">
                    <div class="col-md-5">
                        <asp:TextBox ID="txtSearchTerm" class="input-sm form-control" OnTextChanged="btnSearchClient_TextChanged"  style="width:120%" runat="server" AutoPostBack="True"></asp:TextBox>
                      <%--<input runat="server" id="txtSearchTerm" type="text" class="col-md-8 input-sm form-control" placeholder="Search">--%>
                     </div> 
                     <div class="col-md-3">
                        <asp:Button OnClick="searchClient" ID="btnSearchClient" class="btn btn-sm btn-success pull-right" runat="server" Text="Search"></asp:Button>
                     </div>   
                     <div class=" col-md-4 pull-right"><asp:LinkButton PostBackUrl="~/pages/registration.aspx" ID="mblReg" runat="server" class="btn btn-sm btn-success pull-right"><i class="glyphicon glyphicon-plus-sign pull-right"></i> New Client &nbsp;&nbsp; </asp:LinkButton></div>                       
              </div>
              
              
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </asp:Panel>
    
    <asp:Panel CssClass="row" ID="contentPanel" runat="server">
        <uc1:clients ID="clients1" runat="server" />
    </asp:Panel>
    <div runat="server" id="ItemDetails" class="col-md-12" style="display:none;">
       <p><h5><small id="type"></small></h5></p>
       <hr style="margin:1px;" /> 
       <div id="ucHolder" runat="server" class="col-md-12" style="min-height:200px">
       <uc1:clientPortfolios ID="clientPortfolios1" runat="server" />
       <hr style="margin:3px" />
       </div>
       
       <br/>
       <br style="clear:both"/>
       <div class="col-md-12" >
             <input type="button" class="btn btn-success btn-xs col-md-3 col-md-offset-4" value="Close" onclick="closeDialog()" />
       </div>
       <br />
       <br />
    </div>
    </div>
</asp:Content>

