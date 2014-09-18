<%@ Control Language="C#" AutoEventWireup="true" CodeFile="accessrights.ascx.cs" Inherits="backend_controls_accessrights" %>
<style type="text/css">
    .form-group{ margin-bottom:0;}
</style>

<div class="col-md-12">
    <input type="hidden" id="userID" runat="server" />
 <p>
    <h5><b>  Access Rights   </b><small>   Assign rights to the users of the system </small></h5>
    <hr />
 </p>
 <div class="form-horizontal">
    <div id="mainContainer" runat="server">
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <asp:Button ID="btnSaveRight" CssClass="btn btn-xs btn-success col-md-3" 
                runat="server" Text="SAVE RIGHTS" onclick="btnSaveRight_Click" 
               />
        </div>
    </div>
  </div>






</div>