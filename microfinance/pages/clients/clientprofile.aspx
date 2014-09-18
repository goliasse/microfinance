<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="clientprofile.aspx.cs" Inherits="pages_clientprofile" Title="Client Profile" %>

<%@ Register src="~/controls/clients/coporateclient.ascx" tagname="coporateclient" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/individualclient.ascx" tagname="individualclient" tagprefix="uc2" %>
<%@ Register src="~/controls/clients/enterpriseclient.ascx" tagname="enterpriseclient" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <uc1:coporateclient ID="coporateclient1" runat="server" />
        <uc3:enterpriseclient ID="enterpriseclient1" runat="server" />
        <uc2:individualclient ID="individualclient1" runat="server" />
    </div>

</asp:Content>

