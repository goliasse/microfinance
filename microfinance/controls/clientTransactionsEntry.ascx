<%@ Control Language="C#" AutoEventWireup="true" CodeFile="clientTransactionsEntry.ascx.cs" Inherits="controls_clientTransactionsEntry" %>
<div class="col-md-12">
    <div class="col-md-12 menuHeader">
        <nav class="navbar navbar-default" role="navigation">
          <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </button>
              <a class="navbar-brand" href="#">Search For Client</a>
            &#160;
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <div class="navbar-form navbar-left pull-right col-md-12" role="search" style="width:50%">
                <div class="form-group col-lg-10">
                  <asp:TextBox ID="txtSearchTerm" OnTextChanged="txtSearchClient_TextChanged" class="col-md-6 input-sm form-control" runat="server" AutoPostBack="True" 
                        ></asp:TextBox>
                  <%--<input runat="server" id="txtSearchTerm" type="text"  class="col-md-6 input-sm form-control" placeholder="Search">--%>
                </div>
                  <button type="submit" class="btn btn-sm btn-success">Search</button>
              </div>
             
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </div>
    
    <div class="col-md-12 content">
     <hr style="margin:4px"/>
     <br />
        <asp:GridView ID="gvTransactionClientList" 
            CssClass="table table-bordered table-condensed" runat="server" 
            DataSourceID="SqlDataSource1" AutoGenerateColumns="False" 
            DataKeyNames="ACC_ID,clientID" 
            onrowdatabound="gvTransactionClientList_RowDataBound">
            <Columns>
                <asp:BoundField DataField="clientname" HeaderText="Client Name" 
                    SortExpression="clientname" >
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="AccNo" HeaderText="Account No." SortExpression="AccNo" >
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="LoanAmount" HeaderText="Loan Amount" 
                    SortExpression="LoanAmount" DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Outstanding" HeaderText="Outstanding" 
                    SortExpression="Outstanding" DataFormatString="{0:#,##0.00;(#,##0.00);0}" >
                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:HyperLink CssClass="btn btn-xs btn-success col-md-4 col-md-offset-1" ID="HyperStatement" runat="server">
                            <i class="glyphicon glyphicon-chevron-right pull-left"></i>View
                        </asp:HyperLink> 
                        &nbsp;&nbsp;
                         <asp:HyperLink CssClass="btn btn-xs btn-success col-md-4 col-md-offset-1" ID="HyperEntry" runat="server">
                            <i class="glyphicon glyphicon-chevron-right pull-left"></i>Entry
                        </asp:HyperLink> 
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:sa365ConnectionString1 %>" 
            SelectCommand="SELECT c.datID AS clientID, c.datClientNumber AS CN, la.datClientFullName AS clientname, la.datID AS ACC_ID, la.datAccountNumber AS AccNo, la.datInitialAmount AS LoanAmount, la.datOutstandingAmount AS Outstanding FROM tbl_client AS c INNER JOIN tbl_loan_accounts AS la ON la.datClientID = c.datID WHERE (c.datSurname LIKE '%' + @search + '%') AND (la.datOutstandingAmount &gt;= 0) OR (la.datOutstandingAmount &gt;= 0) AND (c.datFirstName LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (c.datEmailAddress LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (c.datClientNumber LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (c.datHomeTelephoneNumber LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (c.datMobileNumber1 LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (c.datClientName LIKE '%' + @search + '%') OR (la.datOutstandingAmount &gt;= 0) AND (la.datClientFullName LIKE '%' + @search + '%')">
            <SelectParameters>
                <asp:Parameter Name="search" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
</div>