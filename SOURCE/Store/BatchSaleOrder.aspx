<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="BatchSaleOrder.aspx.cs" Inherits="SALES_BatchSaleOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <asp:HiddenField ID="hdnItems" runat="server" Value='["Karachi","Hyderabad","USA","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky"]' />
    <asp:HiddenField ID="hdnPRID" runat="server" Value="0" />
     <asp:HiddenField ID="hdnPRDate" runat="server" Value="0" />
    <asp:HiddenField ID="hdnAmount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRemVal" runat="server" Value="0" />
    <asp:HiddenField ID="hdnNarration" runat="server" Value="0" />
     <asp:HiddenField ID="hdnDate" runat="server" Value="0" />
     <asp:HiddenField ID="hdnTotDb" runat="server" Value="0" />
     <asp:HiddenField ID="hdnTotCr" runat="server" Value="0" />
     <asp:HiddenField ID="hdnUnits" runat="server" Value="kg^1~gm^2~ton^3~m^4~cm^5~mm^6" />
     <asp:HiddenField ID="hdnQtyTotal" runat="server" Value="0" />
     <asp:HiddenField ID="hdnQtyTotalPaste" runat="server" Value="0" />
     <div id="dvUnits" style="display:none"></div>
 <!-- #modal-message -->
<!-- #modal-message -->
<!-- #modal-message -->
<!-- #STYLE 1 -->
<div class="modal fade" id="modal-dialog">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
											<h4 class="modal-title">Modal Dialog</h4>
										</div>
										<div class="modal-body">
											Modal body content here...
										</div>
										<div class="modal-footer">
											<a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
											<a href="javascript:;" class="btn btn-sm btn-success">Action</a>
										</div>
									</div>
								</div>
							</div>


<!-- #STYLE 2 -->
<div class="modal modal-message fade" id="modal-message">
	<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
											<h4 class="modal-title">Modal Message Header</h4>
										</div>
										<div class="modal-body">
											<p>Text in a modal</p>
											<p>Do you want to turn on location services so GPS can use your location ?</p>
										</div>
										<div class="modal-footer">
											<a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
											<a href="javascript:;" class="btn btn-sm btn-primary">Save Changes</a>
										</div>
									</div>
								</div>
</div>
<!-- #modal-message -->
<!-- #modal-message -->
<!-- #modal-message -->








 <div class="row"  id="dvOrderList">
                <!-- begin col-12 -->
			    <div class="col-md-12" >
			        <!-- begin panel -->
                   <div class="panel widget light-widget panel-bd-top">
                        <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Orders in the Batch! </h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>
                        <div class=" panel-body-list" style="padding:10px">

                             <div class="row">
                             <div class="col-lg-8">&nbsp;</div>
                             <div class="col-sm-4" style="text-align:right;">
                             <a class="btn vd_btn vd_bg-green finish" href="javascript:void(0);" data-toggle="modal" data-target="#modalProcess" style="display: inline-block;">
                             <span class="menu-icon"><i class="fa fa-fw fa-check"></i></span> Finish Order</a>

                             </div></div>


                             <div class="row">
                              <div id="dvOrders" class="col-lg-12">
                             <table class="table" id="tablepaging">
                       <thead>
                        <tr>
                             <td></td>
                             <td>ID</td>
                             <td>Date</td>
                            <td>Customer</td>
                            <td>Action</td>
                           
                          
                        </tr>
                      </thead>
                      <tbody>
                       
                       <tr>
                          <th></th>
                          <th></th>
              
                           
                
                        </tr>
                     
                       
                      </tbody>
                    </table>
                             </div>
                             </div>

                             <div class="row">
                             <div class="col-lg-8">&nbsp;</div>
                             </div>

                        </div>
                   
                   </div>
               </div>
              
</div>

 <!-- Modal Message -->
                  <div class="modal fade" id="modalSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" >
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H3">Alert!</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                            <div class="form-group">
                              <label class="col-sm-12 control-label" id="lblAlertMsg">Order has been added in Batch!</label>
                            </div>
                          
                        </div>
                        
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 


 <!-- Modal Message -->
                  <div class="modal fade" id="modalProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" >
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="myModalLabel">Warning!</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                            <div class="form-group">
                              <label class="col-sm-12 control-label">Are You sure, You want to process this Batch?</label>
                            </div>
                          
                        </div>
                        <div class="modal-footer background-login">
                          <button type="button" class="btn vd_btn vd_bg-grey" data-dismiss="modal">No</button>
                          <button type="button" class="btn vd_btn vd_bg-green" onclick="ProcessOrder();">Yes</button>
                        </div>
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 



 <!-- Modal Message -->
                  <div class="modal fade" id="modalDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" >
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H2">Warning!</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                            <div class="form-group">
                              <label class="col-sm-12 control-label" id="lblDelete">Are You sure, You want to Delete this Order?</label>
                            </div>
                          
                        </div>
                        <div class="modal-footer background-login" id="dvDeleteFooter">
                          <button type="button" class="btn vd_btn vd_bg-grey" data-dismiss="modal">No</button>
                          <button type="button" class="btn vd_btn vd_bg-green" onclick="DELETE_ORDER_FINAL();">Yes</button>
                        </div>
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 


 <!-- Modal View -->
                  <div class="modal fade" id="modalOrder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" style="width:900px">
                      <div class="modal-content">
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H1">Order Detail!</h4>
                        </div>
                        <div class="modal-body"> 
                        	
                            <div class="vd_content-section clearfix">
                            <div class="row">
                            <div class="col-lg-8">&nbsp;</div>
                             <div class="col-sm-4">
                
                  <button class="btn vd_btn vd_bg-grey" type="button"><i class="fa fa-print append-icon"></i>Print</button>
                
                  <button class="btn vd_btn vd_bg-green " type="button"><i class="fa fa-download append-icon"></i>Save as PDF</button>
                
              </div>
                            </div>

            <div class="row">
              <div class="col-sm-12">
                <div class="panel widget light-widget">
                  <div class="panel-body" style="padding:40px;">
                    <div class="pull-right text-right">
                      <h3 class="font-semibold mgbt-xs-20">Order Detail</h3>
                      <table class="table table-bordered">
                        <tr>
                          <th>Batch No.</th>
                          <th>Entry Date</th>
                        </tr>
                        <tr>
                          <td><span id="spnBatchNo"></span></td>
                          <td><span id="spnEntryDate"></span></td>
                        </tr>
                      </table>
                    </div>
                    <div class="mgbt-xs-20"><img alt="logo" id="imgPrintLogo" src="img/logo.png" /></div>
                    <address>
                    <span id="spnCompAddress"></span><br>
                    <abbr title="Phone">P:</abbr> <span id="spnCompTel">(123) 456-7890</span><br />
                    <br />
                    <span id="spnCompEmail">info@venmond.com</span>
                    </address>
                    <hr/>
                    <br/>
                    <div class="pd-25">
                      <div class="row">
                        <div class="col-xs-3">
                          <address>
                          <strong>Order For:</strong><br>
                          <span id="spnOrderTo">John Doe<br>
                          Incorporesano Ltd.<br>
                          (123) 456-7890
                          </span>
                          </address>
                        </div>
                        <div class="col-xs-4">
                          <address>
                          <strong>Ship To:</strong><br>
                          <span id="spnShipTo">
                          John Doe<br>
                          795 Folsom Ave, Suite 600<br/>
                          San Francisco, CA 94107<br>
                          </span>
                          </address>
                        </div>
                        <div class="col-xs-2">
                          <address>
                          <strong>Delivery Date:</strong><br>
                          <span id="spnDelDate">24 July 2013</span>
                          </address>
                        </div>
                        <div class="col-xs-3">
                          <div class="text-right">
                          <strong>Total Items:</strong><br>
                          <span class="mgtp-5 vd_green font-md" id="spnTotalItems">$2499.99</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <table class="table table-condensed table-striped" id="tblPrint">
                      <thead>
                        <tr>
                          <th class="text-center" style="width:20px;">S.NO.</th>
                          <th>DESCRIPTION</th>
                          <th class="text-right" style="width:160px;">QTY.</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td class="text-center">1</td>
                          <td>Samsung Galaxy Note 3 III N900 32gb Black Factory Unlocked Android Cell Phone</td>
                          <td class="text-right">1 KG</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <!-- panel-body --> 
                  
                </div>
                <!-- Panel Widget --> 
              </div>
              <!-- col-sm-9-->             
            </div>
            <!-- row --> 
           </div>
          </div>
                          
                        </div>
                       
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                
                  <!-- /.modal --> 




<!-- Modal Delivery Challan  -->
                  <div class="modal fade" id="modalRcvdStock" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" style="width:900px">
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="H4">Issue Delivery Challan</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                           <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">SO No.</label>
                                    
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
                                <div class="col-lg-12 table-responsive" id="dvListStock">
                                   

                                    <%--<input type="button" value="" class="fa-plus-square" onclick="addRow();SumDbCr();"/>--%>
                                </div>
                            </div>
                            
                            
                             <div class="row"><div class="col-lg-12" style="text-align:right">
                             <div class="col-lg-9">
                             &nbsp;
                             </div>
                             
                            <%-- <input type="button" id="btnClear" class="btn btn-danger btn-sm" value="Clear Form" onclick="ClearForm();" />--%>
                             <div class="col-lg-3">
                             <input type="button" id="Button1" class="btn btn-success btn-block" value="Issue Delivery Challan" onclick="SaveGoods();" />
                             </div>
                             </div></div>

                             <div class="table-responsive" id="dvGoodsLST" >
                                
                            </div>
                          
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





<%--<script type="text/javascript" src="json2.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jstorage.js"></script>

--%>

      <%-- <script type="text/javascript" src="prototype.js"></script>
        <script type="text/javascript" src="jstorage.min.js"></script>--%>
        <script src="../js/jquery-1.9.1.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
    <script src="BatchSaleOrder.js" type="text/javascript"></script>
</asp:Content>

