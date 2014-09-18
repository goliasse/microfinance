<%@ Page Language="C#" MasterPageFile="~/backend/MasterPage.master" AutoEventWireup="true" CodeFile="managereports.aspx.cs" Inherits="backend_Default2" Title="Assign Reports to Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <p>
        <h5>Assign Report</h5>
            <hr />
        </p>
     <div class="form-horizontal">
        <div class="form-group">
        <div class="col-md-12">
            <asp:DropDownList ID="ddlStaff" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2" 
                DataTextField="Name" DataValueField="datID" AppendDataBoundItems="True" 
                onselectedindexchanged="ddlStaff_SelectedIndexChanged">
                <asp:ListItem Value="-1">--Select--</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                SelectCommand="SELECT sys_users.datID, opt_titles.datDescription + '  ' + sys_users.datFirstnames + '  ' + sys_users.datSurname AS Name FROM sys_users INNER JOIN opt_titles ON sys_users.datID = opt_titles.datID">
            </asp:SqlDataSource>
        </div>
       <div id="mainContainer" runat="server" class="col-md-12">
       
       </div>
       <div class="form-group">
        <div class="col-md-12">
            <asp:Button ID="btnSaveRight" CssClass="btn btn-xs btn-success col-md-3" 
                runat="server" Text="ASSIGN REPORTS" onclick="btnSaveRight_Click"
               />
        </div>
    </div>
     </div>
    </div>
</asp:Content>

