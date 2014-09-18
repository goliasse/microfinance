<%@ Page Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="pages_changepassword" Title="Change User Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-md-10">
        <div class="panel panel-default">
            <div class="panel-heading" >
            <div class="text-muted bootstrap-admin-box-title"><h6 style="margin:3px"><b> CHANGE 
                PASSWORD </b></h6></div>
        </div>
            <div class="bootstrap-admin-panel-content">
            
          <div class="form-horizontal">
            <div class="form-group">
                <label class="col-lg-2"> User&#39;s Name </label>
                <div class="col-lg-8">
                    <h6><span runat="server" id="lblName" class="col-md-8"></span></h6>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2"> Email </label>
                <div class="col-lg-8">
                    <h6><span runat="server" id="lblEmail" class=" col-md-8"></span></h6>
                </div>
            </div>
             <div class="form-group">
                <label class="col-lg-2"> Mobile Number </label>
                <div class="col-lg-8">
                   <h6><span runat="server" id="lblCellNumber" class=" col-md-8"></span></h6>
                </div>
            </div>
            <hr/>
            <fieldset>
                <div class="form-group">
                    <label class="col-lg-2"> Old Password </label>
                    <div class="col-lg-8">
                        <asp:TextBox ID="txtOldPassword" CssClass="form-control input-sm col-md-5" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-2"> New Password </label>
                    <div class="col-lg-8">
                       <asp:TextBox ID="txtNewPassword" CssClass="form-control input-sm col-md-5" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-2"> Confirm Password </label>
                    <div class="col-lg-8">
                       <asp:TextBox ID="txtConfirmPassword" CssClass="form-control input-sm col-md-5" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                </div>
                <hr />
                 <div class="form-group">
                    <div class="col-md-12">
                        <asp:Button ID="btnChangePassword" CssClass="btn btn-xs btn-success col-md-3" 
                            runat="server" Text="Change Password" onclick="btnChangePassword_Click" />
                    </div>
                </div>
            </fieldset>
          </div>
       </div>
        </div>
    
    
    
    
    
    </div>
</asp:Content>

