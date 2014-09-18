<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="invapplications.aspx.cs"
    Inherits="pages_invapplications" Title="Investment Applications" %>
<%@ Register src="~/controls/invapplications/invclientlist.ascx" tagname="clientlist" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf1">
                    <li>
                        <asp:LinkButton ID="btnInitInterview" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=initInterview">
                            <span id="initInvinfo" runat="server" class="badge pull-right notif"></span>
                            Investment Interview&#160;
                        </asp:LinkButton>
                    </li>               
                    <li>
                        <asp:LinkButton ID="btnReceipts" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=receipt">
                            <span id="receiptinfo" runat="server" class="badge pull-right notif"></span>
                            Receipts&#160; 
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnCertification" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=certification">
                            <span id="certinfo" runat="server" class="badge pull-right notif"></span>
                            Certification&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnInvApproved" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=approved">
                            <span id="InvApproved" runat="server" class="badge pull-right notif"></span>
                            Approved&#160;
                        </asp:LinkButton>
                   </li>
                   <%-- <li>
                        <asp:LinkButton ID="btnIntMaturity" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=intMaturity">
                            <span id="intmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Interest Maturity&#160;
                        </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnInvMaturity" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=invmaturity">
                            <span  id="invmaturityinfo" runat="server" class="badge pull-right notif"></span>
                            Investment Maturity&#160;
                        </asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnMatured" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=matured">
                            <span  id="maturedinfo" runat="server" class="badge pull-right notif"></span>
                            Matured&#160;
                        </asp:LinkButton>
                    </li> --%>
                  </ul>
                </div><!-- /.navbar-collapse -->
              </div><!-- /.container-fluid -->
            </nav>
        </asp:Panel>
        
        <asp:Panel CssClass="row" ID="contentPanel" runat="server" >
            <div style="min-height: 400px;">
                <uc1:clientlist ID="clientlist1" runat="server" />
            </div>           
        </asp:Panel>
    </div>
</asp:Content>
