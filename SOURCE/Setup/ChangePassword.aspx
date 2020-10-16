<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Setup_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery-1.8.2.js" type="text/javascript"></script>
     <link rel="stylesheet" media="screen, print" href="../css/notifications/toastr/toastr.css">
         <script src="../js/notifications/toastr/toastr.js"></script>
<%--<script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <main id="js-page-content" role="main" class="page-content">
<script type="text/javascript">
    function CheckDataLength() {
        var field = document.getElementById("txtCPassword").value;
        if (field == "" || field == null) {
            var text = document.getElementById('txtCPassword');
            text.classList.remove('is-valid');
            text.classList.add('is-invalid');
        }
        else {

            var text = document.getElementById('txtCPassword');
            text.classList.remove('is-invalid');
            text.classList.add('is-valid');

        }
    }
    $(document).ready(function () {
        var UserID = localStorage.getItem("UserID");
       // alert(UserID);
        $.ajax({
            type: "POST",
            url: "ChangePassword.aspx/LoadPWD",
            data: '{ "UserID" : "' + UserID + '" }',
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                document.getElementById('ContentPlaceHolder1_hdnid').value=data.d;
            },
            error: function (data) {
                //alert("error found");
            }
        });
    });





    function SaveTransaction() {
        var PWD = document.getElementById('ContentPlaceHolder1_hdnid').value;
        var CPWD = document.getElementById('txtCPassword').value;
        var NPWD = document.getElementById('txtNewPassword').value;
        var RPWD = document.getElementById('txtRPassword').value;

        if (NPWD == "" || NPWD == null || RPWD == "" || RPWD == null) {
            alert('Password should not be empty');
            return false;
        }

        if (CPWD != PWD) {
            alert('Incorrect Current Password');
            return false;
        }

        if (NPWD != RPWD) {
            alert('New Password and Re-Type Password should be same');
            return false;
        }


        document.getElementById('btnApproved').value = '';
        document.getElementById('btnApproved').className = 'progress-bar progress-bar-warning';

        var UserID = localStorage.getItem("UserID");

       // alert(UserID);
        
            $.ajax({
                type: 'POST',
                url: 'ChangePassword.aspx/SaveTransaction',
                //data: {},
                data: '{ "UserID" : "' + UserID + '", "NPWD" : "' + NPWD + '" }', //advAmnt strINV tax1 tax2
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    vN = msg.d;
                    document.getElementById('ContentPlaceHolder1_hdnid').value = NPWD;
                }

            });
            setTimeout(function () { document.getElementById('btnApproved').className = 'btn vd_btn vd_bg-green'; document.getElementById('btnApproved').value = 'Assign Rights';  alert('Password has been Changed'); }, 5000);
       

    }


</script>

 <div class="subheader">
                            <h1 class="subheader-title">
                                <i class='subheader-icon fal fa-edit'></i> Change Password!
                            </h1>
                        </div>

                         <div class="panel-hdr">
                                        <h2>
                                            Change password 
                                        </h2>

                                        <div class="panel-toolbar">
                                            <button class="btn btn-panel" data-action="panel-collapse" data-toggle="tooltip" data-offset="0,10" data-original-title="Collapse"></button>
                                            <button class="btn btn-panel" data-action="panel-fullscreen" data-toggle="tooltip" data-offset="0,10" data-original-title="Fullscreen"></button>
                                            <button class="btn btn-panel" data-action="panel-close" data-toggle="tooltip" data-offset="0,10" data-original-title="Close"></button>
                                        </div>
                                    </div>
 <div class="panel widget light-widget panel-bd-top">
                       <%-- <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Change Password! <b><span id="spnPONo"></span></b></h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>--%>
                        <div class=" panel-body-list" style="padding:10px">
                     <div class="form-group">
                           <asp:HiddenField ID="hdnAccounts" runat="server" Value='["Karachi","Hyderabad","USA","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky"]' />
    <asp:HiddenField ID="hdnAmount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRemVal" runat="server" Value="0" />
    <asp:HiddenField ID="hdnNarration" runat="server" Value="0" />
     <asp:HiddenField ID="hdnDate" runat="server" Value="0" />
     <asp:HiddenField ID="hdnTotDb" runat="server" Value="0" />
     <asp:HiddenField ID="hdnTotCr" runat="server" Value="0" />
     <asp:HiddenField ID="hdnProjects" runat="server" Value="0" />
     <asp:HiddenField ID="hdnParty" runat="server" Value="0" />
     <asp:HiddenField ID="hdnDebit" runat="server" Value="0" />
                         <div class="row">
                <!-- begin col-12 -->
			    <div class="col-md-12">
			        <!-- begin panel -->
                   <div class="panel panel-inverse">
                        
                        <div class="panel-body">

                            
                                    <asp:Label ID="lblMsg" runat="server" CssClass="parsley-errors-list" Visible="False"></asp:Label>
                                    <asp:TextBox ID="txtid" runat="server" Visible="False" CssClass="form_inputfeild" placeholder="Enter Name"></asp:TextBox>                
                              
                            
                            <div class="row">
                            

                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Current Password</label>
                                    
                                    <div class="col-md-6">
                                     <input type="password" id="txtCPassword"  class="form-control is-valid" />
                                      
                                    </div>

                                    <div class="col-md-3">
                                    &nbsp;
                                    </div>
                                </div>
                            </div>

                             <div class="col-lg-12">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">New Password</label>
                                    
                                    <div class="col-md-6">
                                     <input type="password" id="txtNewPassword"  class="form-control is-valid"" />
                                       
                                    </div>

                                    <div class="col-md-3">
                                    &nbsp;
                                    </div>
                                </div>
                            </div>


                             <div class="col-lg-12">
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Re-Type Password</label>
                                    
                                    <div class="col-md-6">
                                     <input type="password" id="txtRPassword"  class="form-control is-valid" />
                                       
                                    </div>
                                     <div class="row" style="height:20px;"></div>

                                    <div class="col-md-3">
                                    <div class="form-group" style="text-align:left;">
                                    <button type="button" id="btnSave" class="btn btn-success waves-effect waves-themed" onclick="SaveData();">Save</button>
                                    <%--<button type="button" id="btnApproved" class="btn vd_btn vd_bg-green" onclick="SaveTransaction();">Submit</button>--%>
                                    </div>
                                     </div>
                                </div>
                            </div>
                        </div>
                         
                        </div>
                   </div>
                </div>

              
</div>
                      </div>


                      
                     
                     
                     
                    
                                                                                <asp:HiddenField ID="hdnid" runat="server" />

          
                  </div>
                </div>
                <!-- Panel Widget --> 

</asp:Content>

