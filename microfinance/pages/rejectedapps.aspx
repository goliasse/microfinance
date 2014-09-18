<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="rejectedapps.aspx.cs" Inherits="pages_rejectedapps" Title="Rejected Applications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <div class="col-md-12">
            <p><h4><b>Rejected Applications </b></h4><hr /></p>
        </div>
        <div class="col-md-12">
            <asp:GridView ID="gvRejectedApps" class="table table-bordered" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1" onrowdatabound="gvRejectedApps_RowDataBound" 
                DataKeyNames="datID">
                <Columns>
                    <asp:BoundField DataField="datClientName" HeaderText="Client" 
                        SortExpression="datClientName" />
                    <asp:BoundField DataField="datApplicationNumber" 
                        HeaderText="Application No" SortExpression="datApplicationNumber" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datLoanType" HeaderText="Loan Type" 
                        ReadOnly="True" SortExpression="datLoanType" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datLoanAmount" HeaderText="Loan Amount" 
                       DataFormatString="{0:#,##0.00;(#,##0.00);0}" SortExpression="datLoanAmount" >
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datDuration" HeaderText="Duration" 
                        SortExpression="datDuration" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="datInterestRate" HeaderText="Int. Rate" 
                        SortExpression="datInterestRate" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperReinstate" CssClass="btn btn-success btn-xs col-md-5" runat="server">Reinstate</asp:HyperLink>
                            <asp:HyperLink ID="HyperDelete"  CssClass="btn btn-success btn-xs col-md-5 col-md-offset-1" runat="server"><i class="glyphicon glyphicon-remove-circle"></i>  
                            Delete </asp:HyperLink>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
                
                SelectCommand="SELECT datID,datClientName, datApplicationNumber, dbo.getOptLoanType(datLoanType) AS datLoanType, datLoanAmount, datDuration, datInterestRate FROM tbl_loan_application WHERE (datApplicationStatus = @ID)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="17" Name="ID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

