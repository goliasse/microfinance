<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="preapproved.aspx.cs"
    Inherits="pages_preapproved" Title="Loan Pre-Approval Stage" %>

<%@ Register Src="~/controls/LoanApplications/appDetailRpt.ascx" TagName="appDetailRpt"
    TagPrefix="uc1" %>
<%@ Register Src="~/controls/LoanApplications/SupportingDocRpt.ascx" TagName="SupportingDocRpt"
    TagPrefix="uc2" %>
<%@ Register Src="~/controls/LoanApplications/comments.ascx" TagName="comments" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">

    function getCreditTeamPanel()
    {
        var ddl=$('#<%=cmbAction.ClientID %>').val();
        //alert(ddl);
        if(ddl=='Forward Application')
        {
        $('#<%=creditTeamPanel.ClientID %>').css("display","block");
        }
        else
        {
        $('#<%=creditTeamPanel.ClientID %>').css("display","none");
        }

    }
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
        $('#<%=btnRemoveAlert.ClientID%>').click(function() {
        $.blockUI();
        $.ajax({
                type: "POST",
                url: "btnRemoveAlert_Click",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(msg) {
                    $.unblockUI();
                }
            });
        });


    }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-10">
        <asp:Panel CssClass="row" ID="menuPanel" runat="server">
            <nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav mnustyle cf">
        <li>
            <asp:LinkButton ID="btnInitialAssesment" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=initialassesment">
                <span id="initassinfo" runat="server" class="badge pull-right notif"></span>
                Initial Assesment&#160;
            </asp:LinkButton>
        </li>               
        <li>
            <asp:LinkButton ID="btnPreApproval" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=preapproved">
                <span id="preapprovedinfo" runat="server" class="badge pull-right notif"></span>
                Pre Approved&#160; 
            </asp:LinkButton>
       </li>
          
        <li>
            <asp:LinkButton ID="btnAppraisals" runat="server"  PostBackUrl="~/pages/loanapplications.aspx?action=appraisals">
                <span id="Appraisalinfo" runat="server" class="badge pull-right notif"></span>
                Appraisals &#160;
            </asp:LinkButton>
       </li>
        <li>
            <asp:LinkButton ID="btnRiskAssessment" runat="server"  PostBackUrl="~/pages/loanapplications.aspx?action=risk">
                <span id="riskinfo" runat="server" class="badge pull-right notif"></span>
                Risk &#160;
            </asp:LinkButton>
       </li>
        <li>
            <asp:LinkButton ID="btnLegalAssessment" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=legal">
                <span  id="legalinfo" runat="server" class="badge pull-right notif"></span>
                Legal&#160;
            </asp:LinkButton>
       </li>
       <%-- <li>
            <asp:LinkButton ID="btnReview" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=review">
                <span  id="reviewinfo" runat="server" class="badge pull-right notif"></span>
                Review&#160;
            </asp:LinkButton>
        </li>--%>
        <li>
            <asp:LinkButton ID="btnApproval" runat="server" PostBackUrl="~/pages/loanapplications.aspx?action=approval">
                <span  id="Apprinfo" runat="server" class="badge pull-right notif"></span>
                Approvals&#160;
            </asp:LinkButton>
        </li>
        <li>
            <asp:LinkButton ID="Approvedloans" runat="server" 
                PostBackUrl="~/pages/loanapplications.aspx?action=approvedloans"><span 
                id="Approvedinfo" runat="server" class="badge pull-right notif"></span>Approved Loans&#160; </asp:LinkButton>
        </li> 
        <li>
            <asp:LinkButton ID="disbursement" runat="server" 
                PostBackUrl="~/pages/loanapplications.aspx?action=disbursement"><span 
                id="disbinfo" runat="server" class="badge pull-right notif"></span>Disbursement&#160; </asp:LinkButton>
        </li>
        
      </ul>
    </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
    </nav>
        </asp:Panel>
        <div class="col-md-12">
            <asp:Panel ID="mPanelContent" runat="server">
                <div class="row">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">
                                Pre Approvals
                            </div>
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
                                    <span class="text-warning">Loan Amount:</span> <span id="loanAmount" runat="server">
                                    </span>
                                    <br />
                                    <hr style="margin: 2px 0" />
                                    <span class="text-warning">Interest Rate:</span> <span id="lblInterestRate" runat="server">
                                    </span>
                                    <br />
                                    <hr style="margin: 2px 0" />
                                    <span class="text-warning">Duration:</span> <span id="lblDuration" runat="server">
                                    </span>
                                    <br />
                                </div>
                                <div class="col-md-4">
                                    <span class="text-warning">Outstanding Amt.:</span> <span id="lblAmtOutstanding"
                                        runat="server"></span>
                                    <br />
                                    <hr style="margin: 2px 0" />
                                    <span class="text-warning">Loan Type:</span> <span id="lblloantype" runat="server">
                                    </span>
                                    <br />
                                    <hr style="margin: 2px 0" />
                                    <span class="text-warning">Loan Date:</span> <span id="lblLoanDate" runat="server">
                                    </span>
                                    <br />
                                </div>
                            </div>
                            <div class="col-md-12" id="rootwizard">
                                <div class="navbar col-md-3">
                                    <div class="container_ col-md-12">
                                        <ul class="mli nav nav-stacked bootstrap-admin-navbar-side">
                                            <li>
                                                <asp:LinkButton ID="btnPreAppRpt" runat="server"><h6>Pre Approval Report</h6></asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton ID="btnComment" runat="server"><h6>Comment</h6></asp:LinkButton></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-content col-md-9">
                                    <div class="tab-pane_" id="tab1">
                                        <uc1:appDetailRpt ID="appDetailRpt1" runat="server" />
                                        <uc3:comments id="comments1" runat="server" />
                                    </div>
                                    <br />
                                    <ul class="pager wizard">
                                        <li class="previous first" style="display: none;"><a href="javascript:void(0);">First</a></li>
                                        <li class="previous"><a href="javascript:void(0);">Previous</a></li>
                                        <li class="next last" style="display: none;"><a href="javascript:void(0);">Last</a></li>
                                        <li class="next"><a href="javascript:void(0);">Next</a></li>
                                        <li class="next finish" style="display: none;"><a href="javascript:;">Finish</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div id="finalizeDiv" runat="server" class="center col-md-10">
                                <div class="form-group">
                                    <asp:DropDownList ID="cmbAction" onchange="getCreditTeamPanel()" runat="server">
                                        <asp:ListItem>---Select Action --</asp:ListItem>
                                        <asp:ListItem>Forward Application</asp:ListItem>
                                        <asp:ListItem>Send Back For Review</asp:ListItem>
                                        <asp:ListItem>Decline Application</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div id="creditTeamPanel" style="display: none" class="form-group" runat="server">
                                    <p>
                                        Select Credit Team to Forward Application to</p>
                                    <asp:DropDownList ID="ddlCreditTeam" runat="server" DataSourceID="SqlDataSource2"
                                        DataTextField="datDescription" DataValueField="datID" AppendDataBoundItems="True">
                                        <asp:ListItem Value="0">--Select Team --</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>"
                                        SelectCommand="SELECT [datID], [datDescription], [datTeamID], [status] FROM [sys_credit_teams] WHERE ([datTeamID] = @datTeamID)">
                                        <SelectParameters>
                                            <asp:SessionParameter DefaultValue="0" Name="datTeamID" SessionField="BranchID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="btnFinalize" CssClass="btn btn-xs btn-primary col-md-2" runat="server"
                                        Text="Finalize" OnClick="btnFinalize_Click" />
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

    </div>
</asp:Content>
