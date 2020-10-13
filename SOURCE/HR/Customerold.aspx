﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="Customerold.aspx.cs" Inherits="ERP_Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


     <script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>

    <style type="text/css">
        .highlight{
            background:#cfd1d3;
        }
        .nonhighlight {
            background:white;
        }
        .pg-normal { 
cursor: pointer; 
background: #fff; 
padding: 8px 15px 8px 15px; 
margin: 20px 0;
border-radius: 4px;
display: inline-block;
box-sizing: border-box;
margin-bottom: 0!important;
margin-top: 0!important;
border-color: #e2e7eb;
border: 1px solid #ddd;
font-size: 12px;
font-family: 'Open Sans',"Helvetica Neue",Helvetica,Arial,sans-serif;
color: #707478;
        
}

.pg-selected { 
color: #fff; 
background: #000000; 
padding: 8px 15px 8px 15px; 
border-radius: 4px;
display: inline-block;
box-sizing: border-box;
margin-bottom: 0!important;
margin-top: 0!important;
border-color: #e2e7eb;
border: 1px solid #ddd;
font-size: 12px;
font-family: 'Open Sans',"Helvetica Neue",Helvetica,Arial,sans-serif;
    
}
.pg-normal:hover { 
color: #242a30;
background: #e2e7eb;
border-color: #d8dde1;
}
      



    </style>


      <script type="text/javascript">

          function Pager(tableName, itemsPerPage) {

              this.tableName = tableName;

              this.itemsPerPage = itemsPerPage;

              this.currentPage = 1;

              this.pages = 0;

              this.inited = false;

              this.showRecords = function (from, to) {

                  var rows = document.getElementById(tableName).rows;

                  // i starts from 1 to skip table header row

                  for (var i = 1; i < rows.length; i++) {

                      if (i < from || i > to)

                          rows[i].style.display = 'none';

                      else

                          rows[i].style.display = '';

                  }

              }

              this.showPage = function (pageNumber) {
                  if (!this.inited) {

                      alert("not inited");

                      return;

                  }

                  var oldPageAnchor = document.getElementById('pg' + this.currentPage);

                  oldPageAnchor.className = 'pg-normal';

                  this.currentPage = pageNumber;

                  var newPageAnchor = document.getElementById('pg' + this.currentPage);

                  newPageAnchor.className = 'pg-selected';

                  var from = (pageNumber - 1) * itemsPerPage + 1;

                  var to = from + itemsPerPage - 1;

                  this.showRecords(from, to);

              }

              this.prev = function () {

                  if (this.currentPage > 1)

                      this.showPage(this.currentPage - 1);


              }

              this.next = function () {
                  var rows = document.getElementById(tableName).rows;
                  var records = (rows.length - 1);
                  this.pages = Math.ceil(records / itemsPerPage);


                  if (this.currentPage < this.pages) {

                      this.showPage(this.currentPage + 1);

                  }

              }


              this.init = function () {

                  var rows = document.getElementById(tableName).rows;

                  var records = (rows.length - 1);

                  this.pages = Math.ceil(records / itemsPerPage);

                  this.inited = true;

              }


              this.showPageNav = function (pagerName, positionId) {

                  if (!this.inited) {

                      alert("not inited");

                      return;

                  }

                  var element = document.getElementById(positionId);

                  var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> ←&nbsp Previous </span> ';

                  for (var page = 1; page <= this.pages; page++)

                      pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

                  pagerHtml += '<span onclick="' + pagerName + '.next();" class="pg-normal"> Next &nbsp→ </span>';

                  element.innerHTML = pagerHtml;

              }

          }

</script>


    <script type="text/javascript">

        LoadRegion();

        function LoadRegion() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Customer.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    if ($('#tablepaging').length != 0) {

                        $('#tablepaging').remove();
                    }

                    ro = "<table id='tablepaging' class='table table-striped table-hover no-head-border' style='cursor: pointer;' ><thead class='vd_bg-dark-blue vd_white'><th>ID</th> <th>Customer</th> <th>Phone</th>  </thead><tbody>";
                    $.each(jsdata, function (key, value) {
                        ro += "<tr><td   class='one'>" + value.CustomerID + "</td><td   class='two'>" + value.CustomerTitle + "</td><td  style='display:none;' class='three'>" + value.CustomerCode + "</td><td  class='four'>" + value.Phone + "</td><td  style='display:none;' class='five'>" + value.Fax + "</td><td  style='display:none;' class='six'>" + value.Email + "</td><td  style='display:none;'  class='seven'>" + value.AddressLine1 + "</td><td   style='display:none;' class='eight'>" + value.AddressLine2 + "</td><td    style='display:none;' class='nine'>" + value.NTN + "</td><td  style='display:none;' class='ten'>" + value.GST + "</td><td  class='eleven' style='display:none;'>" + value.SRB + "</td><td  style='display:none;' class='tweleve'>" + value.InvoiceDays + "</td><td  class='thirteen' style='display:none;'>" + value.AgingDays + "</td><td  class='fourteen' style='display:none;'>" + value.OpBal + "</td><td  class='CellNo' style='display:none;'>" + value.CellNo + "</td><td  class='Phone2' style='display:none;'>" + value.Phone2 + "</td><td  class='CNIC' style='display:none;'>" + value.CNIC + "</td><td  class='BookingDay' style='display:none;'>" + value.BookingDay + "</td><td  class='DeliveryDay' style='display:none;'>" + value.DeliveryDay + "</td><td  class='CustomerTypeID' style='display:none;'>" + value.CustomerTypeID + "</td></tr>";

                    });
                    ro = ro + "</tbody></table>";

                    $("#DivRegion").append(ro);
                    var pager = new Pager('tablepaging', 8);
                    pager.init();
                    pager.showPageNav('pager', 'pageNavPosition');
                    pager.showPage(1);


                },
                error: function (result) {
                    alert(result);
                }


            });

        };







        function Save() {


            var field = document.getElementById("txtSupplierTitle").value;
            var field = document.getElementById("txtPhone").value;
            var field = document.getElementById("txtEmail").value;
            var field = document.getElementById("txtAddressLine1").value;


            if (field == "" || field == null) {
                document.getElementById("txtSupplierTitle").style.border = "solid 1px red";
                document.getElementById("txtPhone").style.border = "solid 1px red";
                document.getElementById("txtEmail").style.border = "solid 1px red";
                document.getElementById("txtAddressLine1").style.border = "solid 1px red";


                return false;
            }




            $("#modal-dialog").modal();

        }




        function msgrevert() {
            $("#msgbody").text("Are you sure about this?");
            $("#confirm").show();

        }




        function DeleteData() {

            $("#modal-dialog_delete").modal();
        }








        function EnterEvent(e) {
            if (e.keyCode == 13) {
                event.preventDefault();
                document.getElementById("btnSave").click();
                $('#btnSave').click();
            }
        }


        function SaveData() {


            if ($("#btnSave").text() == "Save") {

                InsertRegion();
                $("#msgbody").text("Record has been inserted successfully.");
                $("#confirm").hide();

            }
            else if ($("#btnSave").text() == "Update") {

                $("#search").val('');
                $("#msgbody").text("Record has been updated successfully.");
                $("#confirm").hide();

                UpdateRegion();

            }

            document.getElementById("txtSupplierTitle").style.border = "solid 1px white";
            document.getElementById("txtSupplierCode").style.border = "solid 1px white";
            document.getElementById("txtPhone").style.border = "solid 1px white";
            document.getElementById("txtFax").style.border = "solid 1px white";
            document.getElementById("txtEmail").style.border = "solid 1px white";
            document.getElementById("txtAddressLine1").style.border = "solid 1px white";
            document.getElementById("txtAddressLine2").style.border = "solid 1px white";
            document.getElementById("txtNTN").style.border = "solid 1px white";
            document.getElementById("txtGST").style.border = "solid 1px white";
            document.getElementById("txtSRB").style.border = "solid 1px white";






        }



        function InsertRegion() {
            //alert("asd");
            var UserID = localStorage.getItem("UserID");
            var txtCellNo = document.getElementById('txtCellNo').value;
            var txtPhone2 = document.getElementById('txtPhone2').value;
            var txtCNIC = document.getElementById('txtCNIC').value;
            var ddlBookingDay = document.getElementById('ddlBookingDay').value;
            var ddlDeliveryDay = document.getElementById('ddlDeliveryDay').value;
            var ddlCustomerTypeID = document.getElementById('ContentPlaceHolder1_ddlCustomerType').value;

            var dataToSend = JSON.stringify({ 'CustomerTitle': $('#txtSupplierTitle').val(), 'CustomerCode': $('#txtSupplierCode').val(), 'Phone': $('#txtPhone').val(), 'Fax': $('#txtFax').val(), 'Email': $('#txtEmail').val(), 'AddressLine1': $('#txtAddressLine1').val(), 'AddressLine2': $('#txtAddressLine2').val(), 'NTN': $('#txtNTN').val(), 'GST': $('#txtGST').val(), 'SRB': $('#txtSRB').val(), 'UserID': UserID, 'InvDays': $('#ddlInvoiceDuration').val(), 'AgDays': $('#txtAgingDays').val(), 'opBal': $('#txtOpBal').val(), 'txtCellNo': txtCellNo, 'txtPhone2': txtPhone2, 'txtCNIC': txtCNIC, 'ddlBookingDay': ddlBookingDay, 'ddlDeliveryDay': ddlDeliveryDay, 'ddlCustomerTypeID': ddlCustomerTypeID });
            //alert(dataToSend);
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Customer.aspx/InsertRegion",
                dataType: "json",
                data: dataToSend,
                //data: "{'RegionName':'" + $('#txtunittype').val() + "'}",                
                async: false,
                success: function (data) {
                    var obj = data.d;
                    if (obj == 'true') {
                        LoadRegion();
                        Clear();


                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

            return results;

        }












        function UpdateRegion() {
            // alert("abc");
            //var UserID = localStorage.getItem("UserID");
            //alert($('#ContentPlaceHolder1_hdnid').val());LgrID
            var txtCellNo = document.getElementById('txtCellNo').value;
            var txtPhone2 = document.getElementById('txtPhone2').value;
            var txtCNIC = document.getElementById('txtCNIC').value;
            var ddlBookingDay = document.getElementById('ddlBookingDay').value;
            var ddlDeliveryDay = document.getElementById('ddlDeliveryDay').value;
            var ddlCustomerTypeID = document.getElementById('ContentPlaceHolder1_ddlCustomerType').value;
            var dataToSend = JSON.stringify({ 'CustomerID': $('#ContentPlaceHolder1_hdnid').val(), 'CustomerTitle': $('#txtSupplierTitle').val(), 'CustomerCode': $('#txtSupplierCode').val(), 'Phone': $('#txtPhone').val(), 'Fax': $('#txtFax').val(), 'Email': $('#txtEmail').val(), 'AddressLine1': $('#txtAddressLine1').val(), 'AddressLine2': $('#txtAddressLine2').val(), 'NTN': $('#txtNTN').val(), 'GST': $('#txtGST').val(), 'SRB': $('#txtSRB').val(), 'InvDays': $('#ddlInvoiceDuration').val(), 'AgDays': $('#txtAgingDays').val(), 'opBal': $('#txtOpBal').val(), 'txtCellNo': txtCellNo, 'txtPhone2': txtPhone2, 'txtCNIC': txtCNIC, 'ddlBookingDay': ddlBookingDay, 'ddlDeliveryDay': ddlDeliveryDay, 'ddlCustomerTypeID': ddlCustomerTypeID });
            //alert(dataToSend);
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Customer.aspx/UpdateRegion",
                dataType: "json",
                data: dataToSend,
                async: false,
                success: function (data) {
                    var obj = data.d;
                    if (obj == 'true') {
                        LoadRegion();
                        Clear();

                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

            return results;

        }

        function DeleteRegion() {
            //  alert($('#ContentPlaceHolder1_hdnid').val());
            var UserID = localStorage.getItem("UserID");
            var dataToSend = JSON.stringify({ 'CustomerID': $('#ContentPlaceHolder1_hdnid').val(), 'UserID': UserID });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Customer.aspx/DeleteRegion",
                dataType: "json",
                data: dataToSend,
                async: false,
                success: function (data) {
                    var obj = data.d;

                    if (obj == 'true') {

                        LoadRegion();
                        Clear();
                        $("#msgbody_delete").text("Record has been deleted successfully.");
                        $("#confirm_delete").hide();



                    }


                },
                error: function (result) {
                    alert(result);
                }
            });

            return results;

        }


        function msgrevert_delete() {
            $("#msgbody_delete").text("Are you sure about this?");
            $("#confirm_delete").show();

        }







        function Clear() {
            $('#ctl00_ContentPlaceHolder1_hdnid').val('');
            $('#txtSupplierTitle').val('');
            $('#txtSupplierCode').val('');
            $('#txtPhone').val('');
            $('#txtFax').val('');
            $('#txtEmail').val('');
            $('#txtAddressLine1').val('');
            $('#txtAddressLine2').val('');
            $('#txtNTN').val('');
            $('#txtGST').val('');
            $('#txtSRB').val('');
            $('#txtOpBal').val('');
            $('#txtAgingDays').val('');
            $('#ddlInvoiceDuration').val('1');
            $("#btnSave").text("Save");


           document.getElementById('txtCellNo').value="";
           document.getElementById('txtPhone2').value = "";
           document.getElementById('txtCNIC').value = "";
        }



        $("#tablepaging tbody tr").live('click', function () {
            document.getElementById("<%=hdnid.ClientID%>").value = $(this).closest('tr').children('td.one').text();
            document.getElementById("txtSupplierTitle").value = $(this).closest('tr').children('td.two').text();
            document.getElementById("txtSupplierCode").value = $(this).closest('tr').children('td.three').text();
            document.getElementById("txtPhone").value = $(this).closest('tr').children('td.four').text();
            document.getElementById("txtFax").value = $(this).closest('tr').children('td.five').text();
            document.getElementById("txtEmail").value = $(this).closest('tr').children('td.six').text();
            document.getElementById("txtAddressLine1").value = $(this).closest('tr').children('td.seven').text();
            document.getElementById("txtAddressLine2").value = $(this).closest('tr').children('td.eight').text();
            document.getElementById("txtNTN").value = $(this).closest('tr').children('td.nine').text();
            document.getElementById("txtGST").value = $(this).closest('tr').children('td.ten').text();
            document.getElementById("txtSRB").value = $(this).closest('tr').children('td.eleven').text();

            document.getElementById("txtAgingDays").value = $(this).closest('tr').children('td.thirteen').text();
            document.getElementById("ddlInvoiceDuration").value = $(this).closest('tr').children('td.tweleve').text();
            document.getElementById("txtOpBal").value = $(this).closest('tr').children('td.fourteen').text();

            document.getElementById("txtCellNo").value = $(this).closest('tr').children('td.CellNo').text();
            document.getElementById("txtPhone2").value = $(this).closest('tr').children('td.Phone2').text();
            document.getElementById("txtCNIC").value = $(this).closest('tr').children('td.CNIC').text();
            document.getElementById("ddlBookingDay").value = $(this).closest('tr').children('td.BookingDay').text();
            document.getElementById("ddlDeliveryDay").value = $(this).closest('tr').children('td.DeliveryDay').text();
            document.getElementById("ContentPlaceHolder1_ddlCustomerType").value = $(this).closest('tr').children('td.CustomerTypeID').text();
            //txtCellNo, string txtPhone2, string txtCNIC, string ddlBookingDay, string ddlDeliveryDay, string ddlCustomerTypeID
            //CellNo, Phone2, CNIC, BookingDay, DeliveryDay, CustomerTypeID
            $("#btnSave").text("Update");


        });









    </script>


</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    

    <div class="modal fade" id="modal-dialog">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
											<h4 class="modal-title">Confirmation Required</h4>
										</div>
										<div class="modal-body" id="msgbody">
											Are you sure about this?
										</div>
										<div class="modal-footer">
											<a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal" onclick="msgrevert();">Close</a>
											<a href="javascript:;" class="btn btn-sm btn-success" onclick="SaveData();" id="confirm">Confirm</a>
										</div>
									</div>
								</div>
							</div>

    <div class="modal fade" id="modal-dialog_delete">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
											<h4 class="modal-title">Confirmation Required</h4>
										</div>
										<div class="modal-body" id="msgbody_delete">
											Are you sure about this?
										</div>
										<div class="modal-footer">
											<a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal" onclick="msgrevert_delete();">Close</a>
											<a href="javascript:;" class="btn btn-sm btn-danger" onclick="DeleteRegion();" id="confirm_delete">Confirm</a>
										</div>
									</div>
								</div>
							</div>



<div class="row">
                <!-- begin col-12 -->
			    <div class="col-md-12">
			        <!-- begin panel -->
                       <div class="panel widget light-widget panel-bd-top">
                        <div class="panel-heading bordered">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Customer </h3>
                    <div class="vd_panel-menu">
  <div data-action="minimize" data-original-title="Minimize" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-minus3"></i> </div>
  <div data-action="refresh"  data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon smaller-font"> <i class="icon-cycle"></i> </div>
  
  <div data-action="close" data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class=" menu entypo-icon"> <i class="icon-cross"></i> </div>
</div>
<!-- vd_panel-menu --> 
                  </div>
                        <div class=" panel-body-list" style="padding:10px">

    <div class="row">
              <div class="col-md-6">

                    
                         

                      
                         
                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12"> Customer Title <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtSupplierTitle" required="required" class="form-control" placeholder="Enter Customer Title">  
                            
                        </div>
                      </div>



                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Customer Code <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtSupplierCode" required="required" class="form-control" placeholder="Enter Customer Code">  
                            
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Cell No <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtCellNo" required="required" class="form-control" placeholder="Enter Cell">  
                            
                        </div>
                      </div>

                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Phone <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtPhone" required="required" class="form-control" placeholder="Enter Phone">  
                            
                        </div>
                      </div>

                       <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Phone 2 <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtPhone2" required="required" class="form-control" placeholder="Enter Phone 2">  
                            
                        </div>
                      </div>



                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Fax <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtFax" required="required" class="form-control" placeholder="Enter Fax">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12"> Email <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtEmail" required="required" class="form-control" placeholder="Enter Email">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12"> Address Line 1 <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtAddressLine1" required="required" class="form-control" placeholder="Enter Address Line 1">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12"> Address Line 2 <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtAddressLine2" required="required" class="form-control" placeholder="Enter Address Line 2">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">NTN <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtNTN" required="required" class="form-control" placeholder="Enter NTN">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">GST<span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtGST" required="required" class="form-control" placeholder="Enter GST">  
                            
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">SRB <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtSRB" required="required" class="form-control" placeholder="Enter SRB">  
                            
                        </div>
                      </div>

                       <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Aging Days <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtAgingDays" required="required" value="1" class="form-control" placeholder="Enter Aging Days">  
                            
                        </div>
                      </div>

                      <div class="form-group" style="display:none">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Invoice Duration <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          
                          <select id="ddlInvoiceDuration" class="form-control">
                              <option selected value="1">Daily</option>
                              <option value="7">Weekly</option>
                              <option value="15">Fortnigh</option>
                              <option value="30">Monthly</option>
                          </select>
                            
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Opening Balance <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtOpBal" required="required" value="0" class="form-control" 
                          placeholder="Enter Opening Balance">  
                            
                        </div>
                      </div>
                    

                     <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">CNIC <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text" id="txtCNIC" required="required" class="form-control" placeholder="Enter CNIC">  
                            
                        </div>
                      </div>


                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Booking Day <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <select id="ddlBookingDay">
                          <option value="0">SELECT DAY</option>
                          <option value="MONDAY">MONDAY</option>
                          <option value="TUESDAY">TUESDAY</option>
                          <option value="WEDNESDAY">WEDNESDAY</option>
                          <option value="THURSDAY">THURSDAY</option>
                          <option value="FRIDAY">FRIDAY</option>
                          <option value="SATURDAY">SATURDAY</option>
                          <option value="SUNDAY">SUNDAY</option>
                          
                          </select> 
                            
                        </div>
                      </div>


                      
                      <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Delivery Day <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <select id="ddlDeliveryDay">
                          <option value="0">SELECT DAY</option>
                          <option value="MONDAY">MONDAY</option>
                          <option value="TUESDAY">TUESDAY</option>
                          <option value="WEDNESDAY">WEDNESDAY</option>
                          <option value="THURSDAY">THURSDAY</option>
                          <option value="FRIDAY">FRIDAY</option>
                          <option value="SATURDAY">SATURDAY</option>
                          <option value="SUNDAY">SUNDAY</option>
                          
                          </select> 
                            
                        </div>
                      </div>


                       <div class="form-group">
                        <label class="control-label col-md-4 col-sm-4 col-xs-12">Delivery Day <span class="required"></span>
                        </label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                           <asp:DropDownList ID="ddlCustomerType" CssClass="width-100" runat="server" DataSourceID="SqlDataSource1" 
                                            DataTextField="CustomerTypeDesc" DataValueField="CustomerTypeID">
                                </asp:DropDownList>


                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:Con %>" 
                                            SelectCommand="SELECT '0' as [CustomerTypeID],'CUSTOMER TYPE' as [CustomerTypeDesc] FROM [ITM_Customer_Type] union SELECT [CustomerTypeID], [CustomerTypeDesc] FROM [ITM_Customer_Type] WHERE ([ISDELETE] = @ISDELETE)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="ISDELETE" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                            
                        </div>
                      </div>


                      



                         
                    
                     
                     
                     
                      <div class="form-group form-actions">
                        <div class="col-sm-4"> </div>
                        <div class="col-sm-7">
                           <button type="button" class="btn vd_btn vd_bg-green vd_white" id="btnSave" onclick="Save();">Save</button>


                          <button class="btn btn-default" type="button" onclick="Clear();">Cancel</button>
                          <button class="btn btn-danger" type="button" onclick="DeleteData();">Delete</button>




                        </div>
                      </div>
                                                                                <asp:HiddenField ID="hdnid" runat="server" />

              </div>
              <div class="col-md-6">
               
                  <div class="table-responsive" id="DivRegion">
                    <table class="table" id="tablepaging">
                       <thead>
                        <tr>
                             <td></td>
                             <td>ID</td>
                             <td>Item Name</td>
                            <td>Item Code</td>
                           
                          
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
              <!-- col-md-12 --> 
            </div>

            </div>
            </div>
            </div>
            </div>

               

      <script type="text/javascript">
          var pager = new Pager('tablepaging', 8);
          pager.init();
          pager.showPageNav('pager', 'pageNavPosition');
          pager.showPage(1);
</script>

<script type="text/javascript">
    $("#search").keyup(function () {
        //split the current value of searchInput
        var data = this.value.split(" ");
        //create a jquery object of the rows
        var jo = $("#tablepaging").find("tr");
        if (this.value == "") {
            jo.show();
            var pager = new Pager('tablepaging', 8);
            pager.init();
            pager.showPageNav('pager', 'pageNavPosition');
            pager.showPage(1);
            $("#pageNavPosition").show();
            return;

        }
        //hide all the rows
        jo.hide();

        //Recusively filter the jquery object to get results.
        jo.filter(function (i, v) {
            var $t = $(this);
            for (var d = 0; d < data.length; ++d) {
                //if ($t.text().toLowerCase().indexOf(data[d]) > -1) {
                if ($t.text().toLowerCase().indexOf(data[d]) > -1) {
                    //if ($t.is(":contains('" + data[d] + "')")) {                    
                    $("#pageNavPosition").hide();
                    return true;

                }
                else if ($t.text().toUpperCase().indexOf(data[d]) > -1) {
                    //if ($t.is(":contains('" + data[d] + "')")) {                    
                    $("#pageNavPosition").hide();
                    return true;

                }
            }

            return false;
        })


        //show the rows that match.
.show();
    }).focus(function () {
        this.value = "";
        $(this).css({
            "color": "black"
        });
        $(this).unbind('focus');
    }).css({
        "color": "#C0C0C0"
    });

</script>





</asp:Content>

