<%@ Page Title="Client Area" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="clienthome.aspx.cs" Inherits="pages_clients_clienthome" %>

<%@ Register src="~/controls/clients/coporateclient.ascx" tagname="coporateclient" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/individualclient.ascx" tagname="individualclient" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/enterpriseclient.ascx" tagname="enterpriseclient" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/loanaccounts.ascx" tagname="loanaccounts" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/invaccounts.ascx" tagname="invaccounts" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/pendingloans.ascx" tagname="pendingloans" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/pendinginvestments.ascx" tagname="pendinginvestments" tagprefix="uc1" %>
<%@ Register src="~/controls/clients/LoanStatusLog.ascx" tagname="statuslog" tagprefix="uc1" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<input type="hidden" id="datStage" value="Intial Interview" />
    <div class="col-md-10">
        <asp:Panel ID="mPanelContent" runat="server">
            <div class="row">
                <div class="panel panel-default bootstrap-admin-no-table-panel">
                    <div class="panel-heading">
                        <div class="text-muted bootstrap-admin-box-title">
                            Client Area</div>
                    </div>
                    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                        <div class="col-md-12 alert alert-info" style="padding: 8px">
                            <a class="close" data-dismiss="alert" href="#">×</a> <span>Client Information</span>
                            <hr style="margin: 2px 0; color: White" />
                            <div class="col-md-4">
                                <span class="text-warning">Client Name:</span> <span id="lblClientName" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Client No:</span> <span id="lblClientNo" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Client Type:</span> <span id="lblClientType" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Email:</span> <span id="lblEmail"
                                    runat="server"></span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Telephone:</span> <span id="lblTelephone" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Mobile:</span> <span id="lblMobile" runat="server"></span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Postal Addr.:</span> <span id="lblPostalAddress" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Residential Addr.:</span> <span id="lblResAddress" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Nationality:</span> <span id="lblNationality" runat="server"></span>
                                <br />
                            </div>
                        </div>
                        <div class="col-md-12" id="rootwizard" style="padding-left: 0">
                            <div class="navbar col-md-3" 
                                style="padding-left: 0; padding-right: 0; top: 0px; left: 0px;">
                                <div class="container col-md-12" 
                                    style="padding-left: 0; padding-right: 0; top: 0px; left: 0px;">
                                    <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                        <li>
                                            <asp:LinkButton runat="server" ID="btnIntestmentDetails"><h6>Client Summary</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnPersonalInfo" runat="server" 
                                                onclick="btnPersonalInfo_Click"><h6>Edit Profile</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnJointInfo" runat="server" onclick="btnJointInfo_Click"><h6>Investment Accounts</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnCoporateInfo" runat="server" 
                                                onclick="btnCoporateInfo_Click"><h6>Loan Accounts</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnInitiatorsInfo" runat="server" 
                                                onclick="btnInitiatorsInfo_Click"><h6>Pending Investments</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnDirectors" runat="server" onclick="btnDirectors_Click"><h6>Pending Loans</h6></asp:LinkButton></li>
                                        <!--<li>
                                            <asp:LinkButton ID="btnBeneficiaries" runat="server"><h6>Beneficiaries</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnnok" runat="server"><h6>Next Of Kin</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton runat="server" ID="btnConPerson"><h6>Contact Person</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnbankers" runat="server"><h6>Bankers</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnsupportingdocs" runat="server"><h6>Supporting Documents </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnAdvise" runat="server"><h6>Advise </h6></asp:LinkButton></li>-->
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9 tab-content" style="min-height: 450px">
                                <div class="tab-pane_">
                                    <uc1:coporateclient ID="coporateclientprofile" runat="server" />
                                    <uc1:enterpriseclient ID="enterpriseclientprofile" runat="server" />
                                    <uc1:individualclient ID="individualclientprofile" runat="server" />
                                    <uc1:loanaccounts ID="loanaccounts" runat ="server" />
                                    <uc1:invaccounts ID="invaccounts" runat ="server" />
                                    <uc1:pendingloans ID="pendingloans" runat = "server" />
                                    <uc1:pendinginvestments ID="pendinginvestments" runat ="server" />
                                    <uc1:statuslog ID="statuslog" runat ="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="modal-dialog" style="width: 298px">
            <div class="modal-content" style="display: none" runat="server" id="popup101">
                <div class="modal-header">
                    <%--<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>--%>
                    <h5 class="modal-title" id="myModalAlertLabel">
                        Alert On Account</h5>
                </div>
                <div class="modal-body">
                    <p runat="server" id="pAlertmsg">
                    </p>
                </div>
                <div class="modal-footer" style="height: 20px">
                    <button class="btn btn-xs btn-primary" id="btnRemoveAlert" runat="server" onclick="removeAlert()"
                        type="button">
                        Remove Alert</button>
                    <button class="btn btn-xs btn-default" onclick="closeAlert()" type="button">
                        Close</button>
                </div>
                <br />
                <br />
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
        $('#rootwizard').bootstrapWizard({});
        });
    </script>
</asp:Content>

