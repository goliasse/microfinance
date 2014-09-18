<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctFreezeAccount.ascx.cs" Inherits="controls_LoanAccounts_ctFreezeAccount" %>
<style type="text/css">
    .form-group{ margin-bottom:0;}

</style>
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading" >
            <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b> FREEZE  / UN-FREEZE ACCOUNT </b></h6></div>
        </div>
        <div class="bootstrap-admin-panel-content">
            <div class="form-horizontal">
                <p><h5> Loan Account Details </h5></p>
                <hr />
                <div class="form-group">
                    <label class="col-md-3">Client:</label>
                    <div class="col-md-8">
                        <span id="lblClientFullname" runat="server"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-3">Loan Amount</label>
                    <div class="col-md-8">
                        <span id="lblLoanAmount" runat="server"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-3">Loan Amt Outstanding</label>
                    <div class="col-md-8">
                        <span id="loanAmtOutstanding" runat="server"> </span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label  class="col-md-3">Interest Rate</label>
                    <div class="col-md-8">
                        <span id="lblInterestRate" runat="server"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-3">Duration</label>
                    <div class="col-md-8">
                        <span id="lblDuration" runat="server"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-3">Loan Date</label>
                    <div class="col-md-8">
                        <span id="lblLoanDate" runat="server"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-md-3">Expiry Date</label>
                    <div class="col-md-8">
                        <span id="lblExpiryDate" runat="server"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3">Category</label>
                    <div class="col-md-8">
                        <span id="lblCategory" runat="server"></span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6">
                        <asp:Button ID="btnFreezeAccount" CssClass="btn btn-xs btn-success col-lg-6" 
                            runat="server" Text="Freeze Account" onclick="btnFreezeAccount_Click" />
                    </div>
                    <div class="col-md-6">
                        <asp:Button ID="btnUnFreezeAccount" CssClass="btn btn-xs btn-success col-lg-6" 
                            runat="server" Text="Un-Freeze Account" onclick="btnUnFreezeAccount_Click" />
                    </div>
                </div>
            </div>
        </div>       
   </div>
</div>