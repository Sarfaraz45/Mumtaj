<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="Customer.aspx.cs" Inherits="ERP_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../jquery-1.8.2.js" type="text/javascript"></script>
         <link rel="stylesheet" media="screen, print" href="../css/notifications/toastr/toastr.css">

         <script src="../js/notifications/toastr/toastr.js"></script>
   <title>MUMTAJ SERVICES | Customer</title>

  <%--   <script src="../js/vendors.bundle.js" type="text/javascript"></script>
        <script src="../js/app.bundle.js" type="text/javascript"></script>
   <link rel="stylesheet" media="screen, print" href="../css/datagrid/datatables/datatables.bundle.css">
   <script src="../js/datagrid/datatables/datatables.bundle.js"></script>--%>
   
  

</asp:Content>
<%--dd--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <main id="js-page-content" role="main" class="page-content">
                        
                        <div class="subheader">
                            <h1 style="font-weight:900;" class="subheader-title">
                                Dealers List
                            </h1>
                        </div>
                     
                          <label  id="lblID" style="display:none;"></label>
        <asp:HiddenField ID="hdnid" runat="server" />
                         <div class="row">
                            <div class="col-xl-6">
                                <div id="panel-1" class="panel">
                                    <div class="panel-hdr">



                                                               <div class="search " >
                            <form class="app-forms hidden-xs-down" role="search" action="page_search.html" autocomplete="off">
                           <%-- <div class="col-md-7">
                                <input type="text" id="search-field" placeholder="Search here" class="form-control" tabindex="1">
                                    </div>--%>
                                  <%-- <a href="#" onclick="return false;" class="btn-danger btn-search-close js-waves-off d-none" data-action="toggle" data-class="mobile-search-on">--%>
                                       <%-- <button type="submit"><i class="fal fa-search"></i></button>
                                   --%>


                                   <%-- </a>--%>
                                    <input style="border:1px solid black; border-radius:5px; margin: 0px; width:90%; padding:10px" type="text" placeholder="Search.." name="search"/>
      <button style="padding: 6px 10px;
  
  margin: 0px;
  background:white;
  font-size: 25px;
  border: none;
  cursor: pointer;
  float:right;
  border:1px solid black;
  border-radius: 5px;" type="submit"><i class="fal fa-search"></i></button>
                            </form>
                  </div>
                        

                        <%--Search Working--%>


                                       
                                                                       <%--        <div class="search">
                            <form class="app-forms hidden-xs-down" role="search" action="page_search.html" autocomplete="off">
                                <input type="text" id="search-field" placeholder="Search here" class="form-control" tabindex="1">
                                <a href="#" onclick="return false;" class="btn-danger btn-search-close js-waves-off d-none" data-action="toggle" data-class="mobile-search-on">
                                    <button class="form-control fa fa-search" aria-hidden="true"></button>
                                    <i class="fal fa-times"></i>
                                </a>
                            </form>


                                     <%--   <div class="panel-toolbar">
                                            <button class="btn btn-panel" data-action="panel-collapse" data-toggle="tooltip" data-offset="0,10" data-original-title="Collapse"></button>
                                            <button class="btn btn-panel" data-action="panel-fullscreen" data-toggle="tooltip" data-offset="0,10" data-original-title="Fullscreen"></button>
                                            <button class="btn btn-panel" data-action="panel-close" data-toggle="tooltip" data-offset="0,10" data-original-title="Close"></button>
                                        </div>--%>
                             <%--       </div>--%>
                                    
                           
                                   
                           
                        </div>
                         
                                  <%--  <div class="panel-container show">

                                        <div class="panel-content">      
                                      
                                            <form>
                                     
                                               
                                            
                                            </form>
                                                                         
                                            
                                        </div>
                                    </div>--%>
                                </div>
                            </div>

                            
                          
                          </div>
                        

                          <div class="row" >
                            <div class="col-xl-12" style='border:2px solid #F3F4F6; border-radius:10px;'>
                                <div id="Div1" class="panel">
                                    <%--<div class="panel-hdr">--%>
                                     <%--
                                    </div>   <h2>
                                           Customer List
                                        </h2>

                                        <div class="panel-toolbar">
                                            <button class="btn btn-panel" data-action="panel-collapse" data-toggle="tooltip" data-offset="0,10" data-original-title="Collapse"></button>
                                            <button class="btn btn-panel" data-action="panel-fullscreen" data-toggle="tooltip" data-offset="0,10" data-original-title="Fullscreen"></button>
                                            <button class="btn btn-panel" data-action="panel-close" data-toggle="tooltip" data-offset="0,10" data-original-title="Close"></button>
                                        </div>--%>

                                    <div class="panel-container show" >
                                        <div class="panel-content" style='border:2px solid #F3F4F6; border-radius:10px;'>                                          
                                            <form >
                                                
                                                <div class="form-group" id="DivRegion">
                                                    
                                                </div>
                                                                                                <div class="row" style="height:20px;"></div>

                                                                    
                                                 <div class="form-group" style="text-align:right;">
                                             <button  style="width:10%;" type="button" id="btnSave" class="btn btn-success waves-effect waves-themed" onclick="SaveData();">Save</button>
                                             
                                             
                                             <button style="width:10%;" type="button" class="btn btn-warning waves-effect waves-themed" onclick="DeleteRegion();">Delete</button>
                                             <button  style="width:10%;"type="button" id="btnClear" class="btn btn-secondary waves-effect waves-themed" onclick="Clear();">Cancel</button>
                                             </div>
                                                </form></div></div>
                                    </div>
                                    </div></div>
                    </main>
    <script src="Customer.js" type="text/javascript"></script> 
        <%--   <script src="../js/vendors.bundle.js" type="text/javascript"></script>
        <script src="../js/app.bundle.js" type="text/javascript"></script>--%>
</asp:Content>


