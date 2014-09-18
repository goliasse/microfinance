<%@ Control Language="C#" AutoEventWireup="true" CodeFile="applicationtrails.ascx.cs" Inherits="controls_applicationtrails" %>
<div class="row">
    <p>
         <asp:Label ID="lblHeading" runat="server" style="font-weight: 700" Text="Number of Application(s)"></asp:Label><span runat="server" id="noApplication" class="badge pull-right"></span>
    </p>
    <div>
        <asp:GridView ID="gvApplication" runat="server" CssClass="table table-striped table-condensed" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" AllowPaging="True" DataKeyNames="datID" 
            onrowdatabound="gvApplication_RowDataBound">
            <Columns>
                <asp:BoundField DataField="datClientName" HeaderText="Client Name" 
                    SortExpression="datClientName" >
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="datApplicationNumber" HeaderText="Application No." 
                    SortExpression="datApplicationNumber" >
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="loantype" HeaderText="Loan Type" 
                    SortExpression="loantype" >
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="datLoanAmount" HeaderText="Loan Amount" 
                    SortExpression="datLoanAmount" 
                    DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                       <asp:HyperLink ID="HyperTrail" CssClass="btn btn-xs btn-success col-md-8 col-md-offset-1" runat="server">
                           <i class="glyphicon glyphicon-bell">  </i>Trail
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle Font-Names="Times New Roman" Font-Size="11pt" 
                HorizontalAlign="Center" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
            
            SelectCommand="SELECT tbl_loan_application.datApplicationNumber, tbl_loan_application.datClientName, opt_loan_types.datDescription AS loantype, tbl_loan_application.datLoanAmount, tbl_loan_application.datID FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID">
        </asp:SqlDataSource>
    </div>
</div>