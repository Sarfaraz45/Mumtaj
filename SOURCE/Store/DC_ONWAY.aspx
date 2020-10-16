<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="DC_ONWAY.aspx.cs" Inherits="Store_DC_ONWAY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:HiddenField ID="hdnParty" runat="server" Value="0" />
<div class="row"  id="dvOrderList">
                <!-- begin col-12 -->
			    <div class="col-md-12" >
			        <!-- begin panel -->
                   <div class="panel widget light-widget panel-bd-top">
                        <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> On Way Delivery Challan! </h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>
                        <div class=" panel-body-list" style="padding:20px">

                              <div class="row">                            

                             <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Customer</label>
                                    
                                    <div class="col-md-12">
                                        <input type="text" id="txtParty" class="span6 typeahead width-100" data-provide="typeahead" data-items="20"  />
                                    </div>

                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Date From</label>
                                    
                                    <div class="col-md-12">
                                     <div class="input-group">
                                       <input type="text"  id="datepicker-autoClose" placeholder="Date From" />
                                       <span class="input-group-addon" id="Span1" data-datepicker="#datepicker-autoClose"><i class="fa fa-calendar"></i></span>
                                       </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Date To</label>
                                    
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <input type="text"  id="datepicker-autoCloseTO" placeholder="Date From" />
                                        <span class="input-group-addon" id="datepicker-icon-trigger-PVTO" data-datepicker="#datepicker-autoCloseTO"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-2" style="text-align:center">
                            <div class="col-md-12">
                            &nbsp;
                            </div>
                            <div class="col-md-12">
                            
                            <a class="btn  btn-block btn-success" href="javascript:LoadGoods_List();"><span class="menu-icon"><i class="fa fa-fw fa-search"></i></span> Get DC's</a>
                            
                            </div>
                            </div>                          

                        </div>

                             <div class="row">
                              <div class="table-responsive" id="dvGoodsLST" >
                                
                            </div>
                             </div>

                             <div class="row">
                             <div class="col-lg-8">&nbsp;</div>
                             </div>

                        </div>
                   
                   </div>
               </div>
              
</div>



<!-- Modal Purchase Order -->
                  <div class="modal fade" id="modalRcvdStock" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" style="width:900px">
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H1">Delivered</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                           <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">DC No.</label>
                                    
                                    <div class="col-md-12" id="dvPONo">
                                        
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Date</label>
                                    
                                    <div class="col-md-12" id="dvDate">
                                      
                                    </div>
                                </div>
                            </div>

                            


                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Customer</label>
                                    
                                    <div class="col-md-12" id="dvSupplier">
                               


                                    </div>
                                </div>
                            </div>

                           

                            
                        </div>


                            <div class="row">
                                <div class="col-lg-5" >
                                   <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Date <span class="required"></span>
                        </label>
                        <div class="col-sm-9 controls">
                         <div class="input-group">
                                        <input type="text" placeholder="Date" id="datepicker-icon-PV" />
                                        <span class="input-group-addon" id="datepicker-icon-trigger-PV" data-datepicker="#datepicker-icon-PV"><i class="fa fa-calendar"></i></span>
                                    </div>
                        </div>
                      </div> 
                            </div>
                            <div class="col-lg-7" >
                            <div class="form-group">
                                <label class="col-md-4 control-label" style="text-align:right">Received By</label>
                                <div class="col-md-8"><input type="text" id="txtReceivedBy"  style="width:100%;"/></div>
                            </div>

                                    <%--<input type="button" value="" class="fa-plus-square" onclick="addRow();SumDbCr();"/>--%>
                                </div>
                            </div>
                            
                            
                             <div class="row"><div class="col-lg-12" style="text-align:right">
                             <div class="col-lg-9">
                             &nbsp;
                             </div>
                             
                            <%-- <input type="button" id="btnClear" class="btn btn-danger btn-sm" value="Clear Form" onclick="ClearForm();" />--%>
                             <div class="col-lg-3">
                             <input type="button" id="Button1" class="btn btn-success btn-block" value="Delivered" onclick="DELIVERED();" />
                             </div>
                             </div></div>

                             
                          
                        </div>
                        <div class="modal-footer background-login">
                          <!--<button type="button" class="btn vd_btn vd_bg-grey" data-dismiss="modal">No</button>
                          <button type="button" class="btn vd_btn vd_bg-green" onclick="ProcessOrder();">Yes</button>-->
                        </div>
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 
              <!-- Modal Quotation -->





<!-- Modal REVERSE Order -->
                  <div class="modal fade" id="modalRvrsDC" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" style="width:900px">
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H2">Reverse Delivery Challan</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                           <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">DC No.</label>
                                    
                                    <div class="col-md-12" id="dvPONo_R">
                                        
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Date</label>
                                    
                                    <div class="col-md-12" id="dvDate_R">
                                      
                                    </div>
                                </div>
                            </div>

                            


                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Customer</label>
                                    
                                    <div class="col-md-12" id="dvSupplier_R">
                               


                                    </div>
                                </div>
                            </div>

                           

                            
                        </div>


                            
                             <div class="row"><label class="col-md-12 control-label">Are you sure you want to reverse the Delivery Challan?</label></div>

                             
                          
                        </div>
                        <div class="modal-footer background-login">
                          <button type="button" class="btn vd_btn vd_bg-grey" data-dismiss="modal">No</button>
                          <button type="button" class="btn vd_btn vd_bg-green" onclick="REVERSE();">Yes</button>
                        </div>
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 
              <!-- Modal REVERSE -->

 <script src="../js/jquery-1.9.1.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src='../AAUI/plugins/jquery-ui/jquery-ui.custom.min.js'></script>
    <script src="DC_ONWAY.js" type="text/javascript"></script>

    <script type="text/javascript">
       
        $("#datepicker-icon-PV").datepicker({ dateFormat: 'm/dd/yy' });
        $('[data-datepicker]').click(function (e) {
            var data = $(this).data('datepicker');
            $(data).focus();
        });
    </script>

    <script type="text/javascript">



        $("#datepicker-autoClose").datepicker({ dateFormat: 'm/dd/yy' });
        $('[data-datepicker]').click(function (e) {
            var data = $(this).data('datepicker');
            $(data).focus();
        });

        $("#datepicker-autoCloseTO").datepicker({ dateFormat: 'm/dd/yy' });
        $('[data-datepicker]').click(function (e) {
            var data = $(this).data('datepicker');
            $(data).focus();
        });
    </script>
</asp:Content>

