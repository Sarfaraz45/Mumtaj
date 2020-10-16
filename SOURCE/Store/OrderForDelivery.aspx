<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="OrderForDelivery.aspx.cs" Inherits="SALES_OrderForDelivery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="hdnBatchID" Value="0" runat="server" />

 <div class="row" style=" display:none;" id="dvOrderList">
                <!-- begin col-12 -->
			    <div class="col-md-12" >
			        <!-- begin panel -->
                   <div class="panel widget light-widget panel-bd-top">
                        <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Orders for Delivery! </h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>
                        <div class=" panel-body-list" style="padding:10px">

                          


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

                             <div class="row" >
                             <div class="col-lg-8">&nbsp;</div>
                             </div>

                        </div>
                   
                   </div>
               </div>
              
</div>


 <!-- Modal Message -->
                  <div class="modal fade" id="modalProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                      <div class="modal-content" >
                        <div class="modal-header vd_bg-blue vd_white">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                          <h4 class="modal-title" id="myModalLabel">Report Format!</h4>
                        </div>
                        <div class="modal-body" > 
                        	
                            <div class="form-group">
                              <label class="col-sm-12 control-label">Please, select report format from below option!</label>
                            </div>
                            <div class="form-group">
                              <button type="button" class="btn vd_btn vd_bg-grey" onclick="ShowReport('1');">Batch Summary</button>
                          <button type="button" class="btn vd_btn vd_bg-green" onclick="ShowReport('2');">Batch with Orders Detail</button>
                            </div>
                          
                        </div>
                        <div class="modal-footer background-login">
                          
                        </div>
                      </div>
                      <!-- /.modal-content --> 
                    </div>
                    <!-- /.modal-dialog --> 
                  </div>
                  <!-- /.modal --> 


 <script src="../js/jquery-1.9.1.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
        <script type="text/javascript">
            LoadOrders();

            function LoadOrders() {
                // alert('mmm');
                var UserID = "1";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "OrderForDelivery.aspx/LoadOrders",
                    dataType: "json",
                    data: '{ "UserID" : "' + UserID + '" }',
                    success: function (data) {
                        var jsdata = JSON.parse(data.d);
                        var ro = "";

                        if ($('#tablepaging').length != 0) {

                            $('#tablepaging').remove();
                        }

                        var aaa = 0;

                        ro = "<table id='tablepaging' class='table table-striped table-hover no-head-border'   style='cursor: pointer;'><thead class='vd_bg-dark-blue vd_white'><th>Batch ID</th><th>Delivery Date</th><th>Status</th><th>Entry Date</th><th>Entry By</th><th>Action</th></thead><tbody>";
                        $.each(jsdata, function (key, value) {
                            //ro += "<tr><td width='10%'><button type='button' class='btn btn-info m-r-5 m-b-5' id='" + value.ID + "' title='" + value.Name + "' onclick=\"GetRegion('" + value.ID + "','" + value.Name + "');\">Edit</button></td><td width='30%'>" + value.ID + "</td><td width='60%'  class='two'>" + value.Name + "</td></tr>";
                            ro += "<tr><td width='20%'  >" + value.BatchID + "</td><td width='18%'  >" + value.DeliveryDate + "</td><td width='15%'  >" + value.StatusTitle + "</td><td width='18%' >" + value.EntryDate + "</td><td width='15%'  >" + value.UserName + "</td>";
                            ro += "<td class='menu-action'><a href=\"BatchSaleOrder.aspx?btchID=" + value.BatchID + "\" data-original-title='Order' data-toggle='tooltip' data-placement='top' class='btn menu-icon vd_bd-green vd_green'> <i class='fa fa-shopping-cart'></i> </a> </td></tr>";
                            ro += "<tr ><td >&nbsp;</td><td colspan='5' style='border-bottom:1px solid #000'>" + value.Items + "</td></tr>";
                            aaa = 1;
                        });
                        ro = ro + "</tbody></table>";

                        $("#dvOrders").append(ro);


                        if (aaa == 1) {
                            document.getElementById('dvOrderList').style.display = 'block';
                        }
                        else {
                            document.getElementById('dvOrderList').style.display = 'none';
                        }

                        var pager = new Pager('tablepaging', 8);
                        pager.init();
                        pager.showPageNav('pager', 'pageNavPosition');
                        pager.showPage(1);
                        $("#pageNavPosition").show();



                    },
                    error: function (result) {
                        alert(result);
                    }


                });

            };

            function LOAD_DATA_FOR_PRINT(btchID) {

                document.getElementById('ContentPlaceHolder1_hdnBatchID').value = btchID;
                $("#modalProcess").modal('show');
                // $('#modalSuccess').modal('show');
                // alert(btchID);
            }

            function ShowReport(a) {
                var btchID = document.getElementById('ContentPlaceHolder1_hdnBatchID').value;
                window.location.assign("../Reports/PROD_BatchRPT.aspx?a=" + a + "&BtchID=" + btchID);
            }
        </script>
</asp:Content>

