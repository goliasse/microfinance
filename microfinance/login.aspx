<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SA 365</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap -->
        <link rel="stylesheet" media="screen" href="asset/css/bootstrap.min.css">
        <link rel="stylesheet" media="screen" href="asset/css/bootstrap-theme.min.css">
        <link rel="stylesheet" media="screen" href="asset/css/xtraStyle.css">

        <!-- Bootstrap Admin Theme -->
        <link rel="stylesheet" media="screen" href="asset/css/bootstrap-admin-theme.css">

        <!-- Custom styles -->
        <style type="text/css">
            .alert{
                margin: 0 auto 20px;
            }
        </style>

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
           <script type="text/javascript" src="js/html5shiv.js"></script>
           <script type="text/javascript" src="js/respond.min.js"></script>
        <![endif]-->
</head>
<body id="LoginBody"  class="bootstrap-admin-without-padding">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
    <div class="container" style="margin-top:30px">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
              <div class="panel-heading"><h3 class="panel-title"><strong>Sign in </strong></h3></div>
              <div class="panel-body">
               <div role="form">
              <div class="form-group">
                <label for="exampleInputEmail1">Username or Email</label>
                <input type="text" runat="server" id="txtUsername" name="email" class="form-control" style="border-radius:0px"  placeholder="Enter email" autocomplete="off">
              </div>
              <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password" runat="server" name="password" id="txtPassword" class="form-control" style="border-radius:0px" placeholder="Password">
              </div>
            <%--  <a href="/sessions/forgot_password">(forgot password)</a><br />--%><br />
              <%--<button type="submit" class="btn btn-sm btn-default">Sign in</button>--%>
              <asp:Button class="btn btn-xs btn-default col-md-3" 
                        ID="btnLogin" runat="server" Text="Log In" onclick="btnLogin_Click" />
            </div>
              </div>
            </div>
            </div>
       </div>

               <%-- <asp:Button ID="btnHidden" runat="server"  Text="Button" />
                <cc1:ModalPopupExtender
                    ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                    Drag="True" DropShadow="True" DynamicServicePath="" Enabled="True" PopupControlID="Panel1"
                    TargetControlID="btnHidden" >
                </cc1:ModalPopupExtender>
                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnContinue" CssClass="modalPopup" Style="display: none" Width="300px">
                    <P class="myMenu">Login Successful !</P><br />
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td style="width: 17%" valign="top">
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/asset/Images/ICO-Alarm-Tick.ico-128x128.png" TabIndex="4" /></td>
                            <td style="width: 70%" valign="top">
                                <strong>
                    Select Role<br />
                                </strong>
                    <br />
                    <asp:RadioButtonList ID="rblUserRoles" runat="server" TabIndex="2">
                    </asp:RadioButtonList></td>
                        </tr>
                    </table>
                    <hr />
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td align="right" colspan="2" style="height: 24px">
                    <asp:Button ID="btnClose" runat="server" Text="Cancel" EnableTheming="False" OnClick="btnClose_Click" TabIndex="1" />&nbsp;
                                &nbsp;<asp:Button ID="btnContinue" runat="server" Text="Continue" EnableTheming="False" OnClick="btnContinue_Click" /></td>
                        </tr>
                    </table>
                    
                    </asp:Panel>--%>

            
        
    </form>
    <script type="text/javascript" src="asset/js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="asset/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            $(function() {
                // Setting focus
                $('input[name="email"]').focus();

                // Setting width of the alert box
                var alert = $('.alert');
                var formWidth = $('.bootstrap-admin-login-form').innerWidth();
                var alertPadding = parseInt($('.alert').css('padding'));

                if(isNaN(alertPadding)){
                    alertPadding = parseInt($(alert).css('padding-left'));
                }

                $('.alert').width(formWidth - 2 * alertPadding);
            });
        </script>
</body>
</html>
