<%@ Control Language="C#" AutoEventWireup="true" CodeFile="invSummary.ascx.cs" Inherits="controls_invapplications_invSummary" %>
<div class="row">
    <div class="panel panel-default bootstrap-admin-no-table-panel">
        <div class="panel-heading">
            <div class="text-muted bootstrap-admin-box-title">
                Investment Summary
            </div>
        </div>
        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
            <div class="form-horizontal" id>
                <fieldset>
                    <legend>
                        <h6>
                            Investment Summary</h6>
                    </legend>
                    <input type="hidden" id="type" runat="server" />
                    <input type="hidden" id="editskip" runat="server" />
                    <p>
                        Client Profile Summary</p>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Client Number</label>
                        <div class="col-md-8">
                            <label id="lblClientNo" runat="server" class=" control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Full Name</label>
                        <div class="col-md-8">
                            <label id="lblClientName" runat="server" class=" control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Mobile No 1</label>
                        <div class="col-md-8">
                            <label id="lblMobile1" runat="server" class="control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Mobile No. 2</label>
                        <div class="col-md-8">
                            <label id="lblMobile2" runat="server" class=" control-label">
                            </label>
                        </div>
                    </div>
                    <br />
                    <br />
                    <p>
                        Investment Application Summary</p>
                    <hr />
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Investment Name</label>
                        <div class="col-md-8">
                            <label id="lblInvestmentName" runat="server" class=" control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Type</label>
                        <div class="col-md-8">
                            <label id="lblType" runat="server" class="control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Amount</label>
                        <div class="col-md-8">
                            <label id="lblAmount" runat="server" class=" control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Interest Rate Per Annum</label>
                        <div class="col-md-8">
                            <label id="lblRatePerAnnum" runat="server" class="control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Terms</label>
                        <div class="col-md-8">
                            <label id="lblTerms" runat=server class="control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Frequency Of Interest Payment</label>
                        <div class="col-md-8">
                            <label id="lblFreqPayment" runat="server" class="control-label">
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Mode of Investment</label>
                        <div class="col-md-8">
                            
                            <label id="lblModeOfInv" runat="server" class="control-label">
                            </label>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <label class="col-md-4 control-label">
                            Value Date</label>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtValue" CssClass="form-control input-sm my-picker" runat="server"></asp:TextBox>
                            </label>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:Button ID="btnSave" CssClass="btn btn-success btn-xs col-md-3" runat="server"
                                Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>

<script language="javascript" type="text/javascript">
         $('.my-picker').datepick({dateFormat: 'dd-mm-yyyy'});    
</script>

