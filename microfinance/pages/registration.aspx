<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="registration.aspx.cs" Inherits="registration" Title="Client Registration" %>
<%@ Register src="~/controls/CompanyClient.ascx" tagname="CompanyClient" tagprefix="uc1" %>
<%@ Register src="~/controls/Enterprise.ascx" tagname="Enterprise" tagprefix="uc2" %>

<%@ Register src="~/controls/IndividualClient.ascx" tagname="IndividualClient" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-9">
        <div class="row">
        <div class ="form-inline col-md-12">
            <div class="form-group col-md-4">
                <div class="col-md-12">
                <asp:RadioButton ID="rdbInvidual" CssClass="radio" Text="  Individual" GroupName="clientType" 
                    runat="server" oncheckedchanged="rdbInvidual_CheckedChanged"  AutoPostBack=true/> 
                </div>
                <%--<div>
                    <label class="col-md-8">Individual</label>
                </div>--%>
           </div>
           <div class="form-group col-md-4">
             <div class="col-md-12">
                <asp:RadioButton ID="rdbEntreprise" CssClass="radio Text=" Enterprise" GroupName="clientType" 
                    runat="server" oncheckedchanged="rdbEntreprise_CheckedChanged" AutoPostBack=true /> 
                </div>
             </div>
           <div class="form-group col-md-4">
            <div class="col-md-12">
            <asp:RadioButton ID="rdbCompany" CssClass="radio Text="  Company" GroupName="clientType" 
                runat="server" oncheckedchanged="rdbCompany_CheckedChanged"  AutoPostBack=true/> 
            </div>
         </div>
        </div>  
        <asp:Panel ID="LoadTypeControl" CssClass="col-md-12" runat="server" >
            <uc1:CompanyClient ID="CompanyClient1" runat="server" />
            <uc2:Enterprise ID="Enterprise1" runat="server" />
            <uc3:IndividualClient ID="IndividualClient10" runat="server" />
        </asp:Panel>
    </div>
    </div>
</asp:Content>

