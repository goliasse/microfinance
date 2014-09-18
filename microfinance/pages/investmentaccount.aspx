<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="investmentaccount.aspx.cs" Inherits="pages_investmentaccount" Title="Investment Accounts" %>

<%@ Register src="../controls/invaccounts/invclientlist1.ascx" tagname="invclientlist1" tagprefix="uc1" %>

<%@ Register src="../controls/invaccounts/invclientlist2.ascx" tagname="invclientlist2" tagprefix="uc2" %>
<%@ Register src="../controls/invaccounts/invclientlist3.ascx" tagname="invclientlist3" tagprefix="uc3" %>

<%@ Register src="../controls/invaccounts/invclientlist4.ascx" tagname="invclientlist4" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf1">
                 
                    <li>
                        <asp:LinkButton ID="btnIntMaturity" runat="server"  PostBackUrl="~/pages/investmentaccount.aspx?action=intmaturity">
                            <span id="intmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Interest Maturity&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnInvMaturity" runat="server" PostBackUrl="~/pages/investmentaccount.aspx?action=invmaturity">
                            <span  id="invmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Investment Maturity&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnMatured" runat="server" PostBackUrl="~/pages/investmentaccount.aspx?action=matured">
                            <span  id="maturedinfo" runat="server" class="badge pull-right notif"></span>
                            Matured&#160;
                        </asp:LinkButton>
                    </li> 
                    <li>
                        <asp:LinkButton ID="btnInvDisbursement" runat="server" PostBackUrl="~/pages/investmentaccount.aspx?action=disbursed">
                            <span  id="invdisbInfo" runat="server" class="badge pull-right notif"></span>
                            Disbursement&#160;
                        </asp:LinkButton>
                    </li>
                  </ul>
                </div><!-- /.navbar-collapse -->
              </div><!-- /.container-fluid -->
            </nav>
        </asp:Panel>
        
        <asp:Panel CssClass="row" ID="contentPanel" runat="server" >
            <div style="min-height: 400px;">
                <uc4:invclientlist4 ID="invclientlist41" runat="server" />
                <uc2:invclientlist2 ID="invclientlist21" runat="server" />
                <uc3:invclientlist3 ID="invclientlist31" runat="server" />
                <uc1:invclientlist1 ID="invclientlist11" runat="server" />
                
            </div>           
        </asp:Panel>
    </div>

</asp:Content>

