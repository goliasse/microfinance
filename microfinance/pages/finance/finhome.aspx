<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="finhome.aspx.cs" Inherits="pages_finance_finhome" Title="Financial Transactions"%>
<%@ Register Src="~/controls/Finance/FinReceipt.ascx" TagName="Receipt"  TagPrefix="uc1" %>
<%@ Register Src="~/controls/Finance/FinPayment.ascx" TagName="Payment"  TagPrefix="uc1" %>
<%@ Register Src="~/controls/Finance/FinJournal.ascx" TagName="Journal"  TagPrefix="uc1" %>
<%@ Register src="~/controls/Finance/invclientlist.ascx" tagname="clientlist" tagprefix="uc1" %>
<%@ Register src="~/controls/Finance/clientlist.ascx" tagname="clientlist1" tagprefix="uc1" %>
    
    
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf1">
                    <li>
                        <asp:LinkButton ID="btnFinPendingRec" runat="server"  PostBackUrl="~/pages/finance/finhome.aspx?panel=PendingReceipt"><span id="pendingRecInfo" runat="server" class="badge pull-right notif"></span>Pending Receipts</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnFinPendingDis" runat="server"  PostBackUrl="~/pages/finance/finhome.aspx?panel=PendingDisbursement"><span id="pendingDisInfo" runat="server" class="badge pull-right notif"></span>Pending Disbursement</asp:LinkButton>
                    </li>
                   <!-- <li>
                        <asp:LinkButton ID="btnFinReceipt" runat="server" PostBackUrl="~/pages/finance/finhome.aspx?panel=Receipt">Receipt</asp:LinkButton>
                    </li>               
                    <li>
                        <asp:LinkButton ID="btnFinPayment" runat="server" PostBackUrl="~/pages/finance/finhome.aspx?panel=Payment">Payment</asp:LinkButton>
                   </li> -->
                    <li>
                        <asp:LinkButton ID="btnFinJournal" runat="server"  PostBackUrl="~/pages/finance/finhome.aspx?panel=Journal">Journal</asp:LinkButton>
                   </li>
                   <%--
                   <li>
                        <asp:LinkButton ID="btnFinPending" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=intMaturity"> <span id="finpendinginfo" runat="server" class="badge pull-right notif"></span>Pending &#160; </asp:LinkButton>
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
                <uc1:Receipt  ID="ReceiptPanel" runat="server" />
                <uc1:Payment ID="PaymentPanel" runat ="server" />
                <uc1:Journal ID="JournalPanel" runat ="server" />
                <uc1:clientlist ID="receiptpendinglist" runat="server" />
                <uc1:clientlist1 ID="disbursementpendinglist" runat="server" />
            </div>           
        </asp:Panel>
    </div>
</asp:Content>
