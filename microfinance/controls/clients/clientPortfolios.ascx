<%@ Control Language="C#" AutoEventWireup="true" CodeFile="clientPortfolios.ascx.cs" Inherits="controls_clients_clientPortfolios" %>
<style type="text/css">
    .form-group{margin-bottom:0;}
</style>
<div class="col-md-12">
    <div id="ItemLoanDataHolder">
        <h6><small>Client Profile</small></h6><hr style="margin:3px;" />
        <div class="form-horizontal">
        
            <div class="form-group">
                <label class="col-md-3 text-right">Client Number</label>
                <div class="col-md-8">
                    <label id="clientNo" class="pull-left" runat="server"></label>   
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 text-right">Client Name</label>
                <div class="col-md-8">
                    <label id="clientname" class="pull-left" runat="server"></label>   
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 text-right">Mobile</label>
                <div class="col-md-8">
                    <label id="clMobile" class="pull-left" runat="server"></label>   
                </div>
            </div>
        </div> 
        <div id="itemLoanApp" class="col-md-12" runat="server" >
        <p>
            <h5><small>Loan Application </small></h5>
            <hr style="margin:2px"/>
        </p>
            <div class="form-horizontal">
                 <div class="col-md-7">
                        <div class="form-group">
                            <label class="col-md-5 text-right">Loan Amount</label>
                            <div class="col-md-7">
                                <label id="lnAmt" class="pull-left"  runat="server"></label>   
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 text-right">Loan Type</label>
                            <div class="col-md-7">
                                <label id="lnType" class="pull-left"  runat="server"></label>   
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 text-right">Application Date</label>
                            <div class="col-md-7">
                                <label id="lnAppDate" class="pull-left" runat="server"></label>   
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 text-right">Duration</label>
                            <div class="col-md-7">
                                <label id="lnDuration" class="pull-left" runat="server"></label>   
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 text-right">Current Location/Stage</label>
                            <div class="col-md-7">
                                <label id="lnAppStatus" class="pull-left" runat="server"></label>   
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-5 text-right">Branch Opened At</label>
                            <div class="col-md-7">
                                <label id="lnAppBranch" class="pull-left" runat="server"></label>   
                            </div>
                        </div>
                </div>
                 <div class="col-md-5 btn-group-vertical">
                         <div class="col-md-12"><a id="btnEditApp" runat="server" class="btn-group btn-group-sm btn-success col-md-12"><i class="glyphicon glyphicon-pencil"></i>  Edit </a></div>
                         <div class="col-md-12"><a id="btnViewAppTracker" runat="server"  class="btn-group btn-group-sm btn-success col-md-12">View Application Tracker</a></div>
                         <div class="col-md-12"><a id="A3" runat="server" class="btn-group btn-group-sm btn-success col-md-12">  </a></div>
                  </div>
            </div>   
        </div>
        <div class="clearfixes"></div>
        <div id="ItemLoanAccount" class="col-md-12" runat="server">
        <p>
            <h5><small>Loan Account  </small></h5>
            <hr style="margin:2px"/>
        </p>
            <div class="form-horizontal">
                <div class="col-md-7">
                <div class="form-group">
                    <label class="col-md-5 text-right">Outstanding Amount</label>
                    <div class="col-md-7">
                        <label id="lnOutstanding" class="pull-left"  runat="server"></label>   
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-5 text-right">Start Date</label>
                    <div class="col-md-7">
                        <label id="lnStartDate" class="pull-left" runat="server"></label>   
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-5 text-right">End Date</label>
                    <div class="col-md-7">
                        <label id="lnEndDate" class="pull-left"  runat="server"></label>   
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-5 text-right">Branch Opened At</label>
                    <div class="col-md-7">
                        <label id="lnAccBranch" class="pull-left" runat="server"></label>   
                    </div>
                </div>
              </div>
                <div class="col-md-5 btn-group-vertical">
                   <div class="col-md-12"><a id="btnViewAppReport" runat="server" class="btn-group btn-group-sm btn-success col-md-12">Application Report </a></div>
                   <div class="col-md-12"> <a id="btnTransactions" runat="server"  class="btn-group btn-group-sm btn-success col-md-12 ">Transactions </a></div>
                   <div class="col-md-12"> <a id="btnViewStatement" runat="server"  class="btn-group btn-group-sm btn-success col-md-12">View Statement </a></div>
                   <div class="col-md-12"> <a id="btnMonitorAccount" runat="server"  class="btn-group btn-group-sm btn-success col-md-12">Monitor Account </a></div>
                </div>
            </div>
        </div>
        <br />
        <br />
    </div>
