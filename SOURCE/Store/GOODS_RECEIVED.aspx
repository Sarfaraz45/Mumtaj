<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="GOODS_RECEIVED.aspx.cs" Inherits="Store_GOODS_RECEIVED" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="row"  id="dvOrderList">
                <!-- begin col-12 -->
			    <div class="col-md-12" >
			        <!-- begin panel -->
                   <div class="panel widget light-widget panel-bd-top">
                        <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Goods Received! </h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>
                        <div class=" panel-body-list" style="padding:10px">

                             

                             <div class="row">
                              <div id="dvPOList" class="col-lg-12">
                             
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
                          <h4 class="modal-title" id="H1">Received Stock</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                           <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">PO No.</label>
                                    
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
                                    <label class="col-md-12 control-label">Supplier</label>
                                    
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
                            
                            
                             <div class="row"><div class="col-lg-12" >
                             <div class="col-lg-3">
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Entry Date</label>
                                    
                                    <div class="col-md-12 input-group" >
                                       <input type="text" placeholder="Date" id="txtEntryDate" />
                                        <span class="input-group-addon" id="spnTrigerEntryDate" data-datepicker="#txtEntryDate"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>

                             <div class="col-lg-3" >
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Warehouse</label>
                                    
                                    <div class="col-md-12">
                                <asp:DropDownList ID="ddlWH" CssClass="form-control" runat="server" DataSourceID="SqlDataSource1" 
                                            DataTextField="WHTitle" DataValueField="WHID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:Con %>" 
                                            SelectCommand="SELECT '0' as [WHID],'Select Warehouse' as [WHTitle] FROM [WAREHOUSE] union SELECT [WHID], [WHTitle] FROM [WAREHOUSE]">
                                           
                                        </asp:SqlDataSource>


                                    </div>
                                </div>
                            </div>


                             <div class="col-lg-3" >
                                <div class="form-group">
                                    <label class="col-md-12 control-label">Shipment No</label>
                                    
                                    <div class="col-md-12">
                                <input id="txtShipmentNo" class="width-100"/>


                                    </div>
                                </div>
                            </div>
                             
                            <%-- <input type="button" id="btnClear" class="btn btn-danger btn-sm" value="Clear Form" onclick="ClearForm();" />--%>
                             <div class="col-lg-3">
                             <div class="col-lg-12">&nbsp;</div>
                              <div class="col-lg-12">
                             <input type="button" id="Button1" class="btn btn-success btn-block" value="Received Stock" onclick="SaveGoods();" />
                             </div>
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




 <script src="../js/jquery-1.9.1.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>

    <script src="GOODS_RECEIVED.js" type="text/javascript"></script>
    <script type="text/javascript" src='../AAUI/plugins/jquery-ui/jquery-ui.custom.min.js'></script>
   
    <script type="text/javascript">


        $("#txtEntryDate").datepicker({ dateFormat: 'm/dd/yy' });
        $('[data-datepicker]').click(function (e) {
            var data = $(this).data('datepicker');
            $(data).focus();
        });
    </script>
</asp:Content>

