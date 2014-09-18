<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="initInterview.aspx.cs"
    Inherits="pages_invapplication_initInterview" Title="Investment Interview" %>

<%@ Register Src="../../controls/invapplications/bankers.ascx" TagName="bankers"
    TagPrefix="uc1" %>
<%@ Register Src="../../controls/invapplications/constituentInvestors.ascx" TagName="constituentInvestors"
    TagPrefix="uc2" %>
<%@ Register Src="../../controls/invapplications/contactperson.ascx" TagName="contactperson"
    TagPrefix="uc3" %>
<%@ Register Src="../../controls/invapplications/investmentdetails.ascx" TagName="investmentdetails"
    TagPrefix="uc4" %>
<%@ Register Src="../../controls/invapplications/nextofkin.ascx" TagName="nextofkin"
    TagPrefix="uc5" %>
<%@ Register Src="../../controls/invapplications/personalInformation.ascx" TagName="personalInformation"
    TagPrefix="uc6" %>
<%@ Register Src="../../controls/invapplications/supportingdocs.ascx" TagName="supportingdocs"
    TagPrefix="uc7" %>
<%@ Register Src="../../controls/invapplications/beneficiaries.ascx" TagName="beneficiaries"
    TagPrefix="uc8" %>
<%@ Register Src="../../controls/invapplications/InitiatorsInfo.ascx" TagName="InitiatorsInfo"
    TagPrefix="uc9" %>
<%@ Register Src="../../controls/invapplications/advise.ascx" TagName="advise" TagPrefix="uc10" %>
<%@ Register Src="../../controls/invapplications/coporateInfo.ascx" TagName="coporateInfo"
    TagPrefix="uc11" %>
<%@ Register Src="../../controls/invapplications/directors.ascx" TagName="directors"
    TagPrefix="uc12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
    function alertMessage()
    { 
        $.blockUI({ message: $('#<%=popup101.ClientID %>'), css: { width: '300px'} });
    }
    function closeAlert()
    {
        $.unblockUI();
    }
    function removeAlert()
    {
        PageMethods.removertalert();
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="datStage" value="Intial Interview" />
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid">

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav mnustyle cf1">
                    <li>
                        <asp:LinkButton ID="btnInitInterview" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=initInterview"> <span id="initInvinfo" runat="server" class="badge pull-right notif"></span>Investment Interview&#160; </asp:LinkButton>
                    </li>               
                    <li>
                        <asp:LinkButton ID="btnReceipts" runat="server" PostBackUrl="~/pages/invapplications.aspx?action=receipt"> <span id="receiptinfo" runat="server" class="badge pull-right notif"></span>Receipts&#160; </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnCertification" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=certification"> <span id="certinfo" runat="server" class="badge pull-right notif"></span>Certification&#160; </asp:LinkButton>
                   </li>
                    <li>
                        <asp:LinkButton ID="btnInvApproved" runat="server"  PostBackUrl="~/pages/invapplications.aspx?action=approved"> <span id="InvApproved" runat="server" class="badge pull-right notif"></span>Approved&#160; </asp:LinkButton>
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
                    </li>--%> 
                  </ul>
                </div><!-- /.navbar-collapse -->
              </div><!-- /.container-fluid -->
            </nav>
        </asp:Panel>
        <asp:Panel ID="mPanelContent" runat="server">
            <div class="row">
                <div class="panel panel-default bootstrap-admin-no-table-panel">
                    <div class="panel-heading">
                        <div class="text-muted bootstrap-admin-box-title">
                            Initial Interview</div>
                    </div>
                    <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                        <div class="col-md-12 alert alert-info" style="padding: 8px">
                            <a class="close" data-dismiss="alert" href="#">×</a> <span>Application Information</span>
                            <hr style="margin: 2px 0; color: White" />
                            <div class="col-md-4">
                                <span class="text-warning">Client Name:</span> <span id="lblapplicantName" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Client No:</span> <span id="lblClientNo" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Application No:</span> <span id="lblAppNo" runat="server">
                                </span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Amount:</span> <span id="lblInvestmentAmount"
                                    runat="server"></span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Accrued Interest:</span> <span id="lblAccInterest" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Terms:</span> <span id="lblTerm" runat="server"></span>
                                <br />
                            </div>
                            <div class="col-md-4">
                                <span class="text-warning">Investment Name:</span> <span id="lblInvestmentName" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Investment Type:</span> <span id="lblInvtype" runat="server">
                                </span>
                                <br />
                                <hr style="margin: 2px 0" />
                                <span class="text-warning">Date:</span> <span id="lblValueDate" runat="server"></span>
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
                                            <asp:LinkButton runat="server" ID="btnIntestmentDetails"><h6>Investment Details</h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnPersonalInfo" runat="server"><h6>Personal Information  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnJointInfo" runat="server"><h6>Joint Investors Information  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnCoporateInfo" runat="server"><h6>Coporate Information  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnInitiatorsInfo" runat="server"><h6>Initiators Personal Information  </h6></asp:LinkButton></li>
                                        <li>
                                            <asp:LinkButton ID="btnDirectors" runat="server"><h6>Directors/Shareholders</h6></asp:LinkButton></li>
                                        <li>
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
                                            <asp:LinkButton ID="btnAdvise" runat="server"><h6>Advise </h6></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-9 tab-content" style="min-height: 450px">
                                <div class="tab-pane_">
                                    <uc1:bankers id="bankers1" runat="server" />
                                    <uc2:constituentInvestors ID="constituentInvestors1" runat="server" />
                                    <uc3:contactperson ID="contactperson1" runat="server" />
                                    <uc4:investmentdetails ID="investmentdetails1" runat="server" />
                                    <uc7:supportingdocs ID="supportingdocs1" runat="server" />
                                    <uc9:InitiatorsInfo ID="InitiatorsInfo1" runat="server" />
                                    <uc6:personalInformation ID="personalInformation1" runat="server" />
                                    <uc5:nextofkin ID="nextofkin1" runat="server" />
                                    <uc8:beneficiaries ID="beneficiaries1" runat="server" />
                                    <uc10:advise ID="advise1" runat="server" />
                                    <uc11:coporateInfo ID="coporateInfo1" runat="server" />
                                    <uc12:directors ID="directors1" runat="server" />
                                </div>
                                <ul class="pager wizard">
                                    <li class="previous first" style="display: none;">
                                        <asp:LinkButton ID="btnFirst" runat="server">First</asp:LinkButton></li>
                                    <li class="previous">
                                        <asp:LinkButton ID="btnPrevious" runat="server" OnClick="btnPrevious_Click">Previous</asp:LinkButton></li>
                                    <li class="next last" style="display: none;">
                                        <asp:LinkButton ID="btnLast" runat="server">Last</asp:LinkButton></li>
                                    <li class="next">
                                        <asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click">Next</asp:LinkButton></li>
                                    <li class="next finish" style="display: none;">
                                        <asp:LinkButton ID="btnFinish" runat="server">Finish</asp:LinkButton></li>
                                </ul>
                            </div>
                        </div>
                        <br style="clear: both" />
                        <div class="center col-md-10">
                            <div class="center form-group">
                                <asp:Button ID="btnFinalize" runat="server" CssClass="btn btn-xs btn-primary col-md-2"
                                    Text="Submit" OnClick="btnFinalize_Click" />
                            </div>
                        </div>
                        <br />
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
