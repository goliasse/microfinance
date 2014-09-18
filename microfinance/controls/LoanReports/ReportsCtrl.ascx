<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReportsCtrl.ascx.cs" Inherits="controls_LoanReports_ReportsCtrl" %>
<div style="min-height:400px">
        <div class="col-md-4">
           <div class="panel panel-default bootstrap-admin-no-table-panel">
               <div class="panel-heading">
                    <div class="text-muted bootstrap-admin-box-title">Loan Reports</div>
               </div>
                <div class="bootstrap-admin-panel-content">
                        <asp:Button ID="btnRptAgingPortfolio" class="btn btn-xs btn-block btn-success" 
                            runat="server" Text="Aging-Portfolio" onclick="btnRptAgingPortfolio_Click" />                 
                        <asp:Button ID="btnRptClientMovement" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Client Movement" onclick="btnRptClientMovement_Click" />
                        <asp:Button ID="btnRptCreditBal" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Credit Balance" onclick="btnRptCreditBal_Click" />
                        <asp:Button ID="btnRptDisbursement" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Disbursement" onclick="btnRptDisbursement_Click" />
                        <asp:Button ID="btnRptFrozenBal" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Frozen Balance" onclick="btnRptFrozenBal_Click" />
                        <asp:Button ID="btnRptLargeExp" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Largest Exposure" onclick="btnRptLargeExp_Click" />
                        <asp:Button ID="btnRptLoanExpiry" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Loan Expiry Notice" onclick="btnRptLoanExpiry_Click" />
                        <asp:Button ID="btnRptPII" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Portfolio Interest Income" onclick="btnRptPII_Click" />
                        <asp:Button ID="btnRptPortfolioRpt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Portfolio Report" onclick="btnRptPortfolioRpt_Click" />
                        <asp:Button ID="btnRptPSO" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Portfolio Summary -Operations" onclick="btnRptPSO_Click" />
                        <asp:Button ID="btnRptPBD" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Provision for Bad Debts" onclick="btnRptPBD_Click" />
                        <asp:Button ID="btnRptPSR" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Provision Summary Report" onclick="btnRptPSR_Click" />
                        <asp:Button ID="btnRepaymentRpt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Repayment Report" onclick="btnRepaymentRpt_Click" />
                         <asp:Button ID="btnSchPayments" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Scheduled Loan Payments" 
                            onclick="btnSchPayments_Click"  />
               </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default bootstrap-admin-no-table-panel">
               <div class="panel-heading">
                    <div class="text-muted bootstrap-admin-box-title">Investments Reports</div>
               </div>
                <div class="bootstrap-admin-panel-content">
                        <asp:Button ID="btnAccountListing" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Account Listings" onclick="btnAccountListing_Click" />                 
                        <asp:Button ID="btnClientConRatio" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Client Concertration Ratio" 
                            onclick="btnClientConRatio_Click" />
                        <asp:Button ID="btnCIS" class="btn btn-xs btn-block btn-primary" runat="server" 
                            Text="Customer Investment Statement" onclick="btnCIS_Click" />
                        <asp:Button ID="btnCustomerRanking" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Customer Ranking" onclick="btnCustomerRanking_Click" />
                        <asp:Button ID="btnInvExpNotice" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Expiry Notice" onclick="btnInvExpNotice_Click" />
                        <asp:Button ID="btnFinTrans" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Financial Transaction" onclick="btnFinTrans_Click" />
                        <asp:Button ID="btnIntRedInv" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Interest Expense on Redeemed Investment" 
                            onclick="btnIntRedInv_Click" />
                        <asp:Button ID="btnInvestmentStatus" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Investment Status" onclick="btnInvestmentStatus_Click" />
                        <asp:Button ID="btnInvestment" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Investments" onclick="btnInvestment_Click" />
                        <asp:Button ID="btnMaturityPortfolio" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Maturity Portfolio" onclick="btnMaturityPortfolio_Click" />
                        <asp:Button ID="btnIntMaturity" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Monthly Interest Maturity" 
                            onclick="btnIntMaturity_Click" />
                        <asp:Button ID="btnNewInvestment" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="New Investments" onclick="btnNewInvestment_Click" />
                        <asp:Button ID="btnNewInvAnalysis" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="New Investments Analysis" 
                            onclick="btnNewInvAnalysis_Click" />
                        <asp:Button ID="btnPeriodIntEarned" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Periodic Interest Earned" 
                            onclick="btnPeriodIntEarned_Click" />
                        <asp:Button ID="btnRedemption" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Redemption" onclick="btnRedemption_Click" />
                        <asp:Button ID="btnRedemptionIss" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Redemption Issued" onclick="btnRedemptionIss_Click" />
                        <asp:Button ID="btnRepaymentCatInt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Repayment By Cat. Accrued Interest" 
                            onclick="btnRepaymentCatInt_Click" />
                        <asp:Button ID="btnRepaymentCatInvAmt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Repayment By Category Inv. Amount" 
                            onclick="btnRepaymentCatInvAmt_Click" />
                        <asp:Button ID="btnRollOver" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Roll Over" onclick="btnRollOver_Click" />
                        <asp:Button ID="btnTermsCatInt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Terms by Category Accrued Interest" 
                            onclick="btnTermsCatInt_Click" />
                        <asp:Button ID="btnTermsCatInvAmt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Terms by Repayment Inv. Amount" 
                            onclick="btnTermsCatInvAmt_Click" />
                        <asp:Button ID="btnTermsRepayInt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Terms by Repayment Accrued Interest" 
                            onclick="btnTermsRepayInt_Click" />
                        <asp:Button ID="btnTermsRepayInvAmt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Terms by Repayment Inv Amount" 
                            onclick="btnTermsRepayInvAmt_Click" />
                        <asp:Button ID="btnWeightedAveInt" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Weighted Average Monthly Interest" 
                            onclick="btnWeightedAveInt_Click" />
               </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default bootstrap-admin-no-table-panel">
               <div class="panel-heading">
                    <div class="text-muted bootstrap-admin-box-title">Financial Reports</div>
               </div>
                <div class="bootstrap-admin-panel-content">
                         <asp:Button ID="btnFinancialAging" class="btn btn-xs btn-block btn-primary" 
                            runat="server" Text="Financial Aging" onclick="btnFinancialAging_Click" />
                        <%--<asp:Button ID="Button1" class="btn btn-xs btn-block btn-success" runat="server" Text="Aging-Portfolio" />                 
                        <asp:Button ID="Button2" class="btn btn-xs btn-block btn-primary" runat="server" Text="Client Movement" />
                        <asp:Button ID="Button3" class="btn btn-xs btn-block btn-primary" runat="server" Text="Credit Balance" />
                        <asp:Button ID="Button4" class="btn btn-xs btn-block btn-primary" runat="server" Text="Disbursement" />
                        <asp:Button ID="Button5" class="btn btn-xs btn-block btn-primary" runat="server" Text="Frozen Balance" />
                        <asp:Button ID="Button6" class="btn btn-xs btn-block btn-primary" runat="server" Text="Largest Exposure" />
                        <asp:Button ID="Button7" class="btn btn-xs btn-block btn-primary" runat="server" Text="Loan Expiry Notice" />
                        <asp:Button ID="Button8" class="btn btn-xs btn-block btn-primary" runat="server" Text="Portfolio Interest Income" />
                        <asp:Button ID="Button9" class="btn btn-xs btn-block btn-primary" runat="server" Text="Portfolio Report" />
                        <asp:Button ID="Button10" class="btn btn-xs btn-block btn-primary" runat="server" Text="Portfolio Summary -Operations" />
                        <asp:Button ID="Button11" class="btn btn-xs btn-block btn-primary" runat="server" Text="Provision for Bad Debts" />
                        <asp:Button ID="Button12" class="btn btn-xs btn-block btn-primary" runat="server" Text="Provision Summary Report" />
                        <asp:Button ID="Button13" class="btn btn-xs btn-block btn-primary" runat="server" Text="Repayment Report" />--%>
               </div>
            </div>
        </div>
</div>