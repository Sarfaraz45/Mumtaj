﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="ITM_Itemold.aspx.cs" Inherits="ERP_ITM_Item" %>

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
        $(document).ready(function () {
            LoadRegion();
        });

        


        function LoadRegion() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ITM_Item.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    if ($('#tablepaging').length != 0) {

                        $('#tablepaging').remove();
                    }

                    ro = "<table id='tablepaging' class='table table-striped table-hover no-head-border' style='cursor: pointer;' ><thead class='vd_bg-dark-blue vd_white'><th>ID</th><th>Item Name</th><th>Item Code</th></thead><tbody>";
                    $.each(jsdata, function (key, value) {
                        ro += "<tr><td   class='one'>" + value.ITEMID + "</td>   <td   class='two'>" + value.ITEMName + "</td>    <td   class='three'>" + value.ItemCode + "</td>    <td  style='display:none;' class='four'>" + value.BarCode + "</td>  <td  style='display:none;'  class='five'>" + value.Discription + "</td> <td   style='display:none;' class='six'>" + value.UnitTypeID + "</td><td   style='display:none;' class='seven'>" + value.DistPercentage + "</td> <td   style='display:none;' class='eight'>" + value.TradePrice + "</td> <td   style='display:none;' class='nine'>" + value.RetailPrice + "</td><td   style='display:none;' class='ten'>" + value.PackingTypeID + "</td>  </tr>";

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




        //Use for Dropdown

        $(document).ready(function () {
            // alert("sadasd");
            $.ajax({
                type: "POST",
                url: "ITM_Item.aspx/LoadRegionCombo1",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_DropDownList').select.length != 0) {

                        $('#ContentPlaceHolder1_DropDownList').empty();
                    }

                    $.each(jsdata, function (key, value) {
                        //alert(value.QualificationID);
                        rows += "<option  value=" + value.UnitTypeID + ">" + value.UnitTypeDesc + "</option>";
                    });

                    $("#ContentPlaceHolder1_DropDownList").append(rows);




                },
                error: function (data) {
                    alert("error found");
                }
            });
        });


        //Another DropDown

        $(document).ready(function () {
            // alert("sadasd");
            $.ajax({
                type: "POST",
                url: "ITM_Item.aspx/LoadRegionCombo2",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_ddlPacking').select.length != 0) {

                        $('#ContentPlaceHolder1_ddlPacking').empty();
                    }

                    $.each(jsdata, function (key, value) {
                        //alert(value.QualificationID);
                        rows += "<option  value=" + value.PackingTypeID + ">" + value.PackingTypeDesc + "</option>";
                    });

                    $("#ContentPlaceHolder1_ddlPacking").append(rows);




                },
                error: function (data) {
                    alert("error found");
                }
            });
        });





        function Save() {


            var field = document.getElementById("txtitemname").value;
            var field = document.getElementById("txtItemCode").value;



            if (field == "" || field == null) {
                document.getElementById("txtitemname").style.border = "solid 1px red";
                document.getElementById("txtItemCode").style.border = "solid 1px red";



                return false;
            }



            $("#modal-dialog").modal();

        }




        function msgrevert() {
            $("#msgbody").text("Are you sure about this?");
            $("#confirm").show();

        }










        function EnterEvent(e) {
            if (e.keyCode == 13) {
                event.preventDefault();
                document.getElementById("btnSave").click();
                $('#btnSave').click();
            }
        }







        function DeleteData() {

            $("#modal-dialog_delete").modal();
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

            document.getElementById("txtitemname").style.border = "solid 1px white";
            document.getElementById("txtItemCode").style.border = "solid 1px white";
            document.getElementById("txtbarcode").style.border = "solid 1px white";
            document.getElementById("txtDiscription").style.border = "solid 1px white";
            document.getElementById("txtdistPer").style.border = "solid 1px white";
            document.getElementById("txtTradePrice").style.border = "solid 1px white";
            document.getElementById("txtRetailPrice").style.border = "solid 1px white";
           



        }



        function InsertRegion() {
            //alert("asd");
            var ddl = document.getElementById("ContentPlaceHolder1_DropDownList").value;
            var ddlPacking = document.getElementById("ContentPlaceHolder1_ddlPacking").value;

            var UserID = localStorage.getItem("UserID");
            var dataToSend = JSON.stringify({ 'ITEMName': $('#txtitemname').val(), 'ItemCode': $('#txtItemCode').val(), 'BarCode': $('#txtbarcode').val(), 'Discription': $('#txtDiscription').val(), 'UserID': UserID, 'UnitTypeID': ddl, 'DistPerc': $('#txtdistPer').val(), 'TradePrice': $('#txtTradePrice').val(), 'RetailPrice': $('#txtRetailPrice').val(), 'PackingTypeID': ddlPacking });
            // alert(dataToSend);
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ITM_Item.aspx/InsertRegion",
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
            var ddl = document.getElementById("ContentPlaceHolder1_DropDownList").value;
            var ddlPacking = document.getElementById("ContentPlaceHolder1_ddlPacking").value;

            var dataToSend = JSON.stringify({ 'ITEMID': $('#ContentPlaceHolder1_hdnid').val(), 'ITEMName': $('#txtitemname').val(), 'ItemCode': $('#txtItemCode').val(), 'BarCode': $('#txtbarcode').val(), 'Discription': $('#txtDiscription').val(), 'UnitTypeID': ddl, 'DistPerc': $('#txtdistPer').val(), 'TradePrice': $('#txtTradePrice').val(), 'RetailPrice': $('#txtRetailPrice').val(), 'PackingTypeID': ddlPacking });
            //alert(dataToSend);
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ITM_Item.aspx/UpdateRegion",
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
            var dataToSend = JSON.stringify({ 'ITEMID': $('#ContentPlaceHolder1_hdnid').val(), 'UserID': UserID });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ITM_Item.aspx/DeleteRegion",
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












        function Clear() {
            $('#ctl00_ContentPlaceHolder1_hdnid').val('');
            $('#txtitemname').val('');
            $('#txtItemCode').val('');
            $('#txtbarcode').val('');
            $('#txtDiscription').val('');
            $('#txtdistPer').val('');
            $('#txtTradePrice').val('');
            $('#txtRetailPrice').val('');

            $("#btnSave").text("Save");
        }



        $("#tablepaging tbody tr").live('click', function () {
            document.getElementById("<%=hdnid.ClientID%>").value = $(this).closest('tr').children('td.one').text();
            document.getElementById("txtitemname").value = $(this).closest('tr').children('td.two').text();
            document.getElementById("txtItemCode").value = $(this).closest('tr').children('td.three').text();
            document.getElementById("txtbarcode").value = $(this).closest('tr').children('td.four').text();
            document.getElementById("txtDiscription").value = $(this).closest('tr').children('td.five').text();
            document.getElementById("txtdistPer").value = $(this).closest('tr').children('td.seven').text();
            document.getElementById("txtTradePrice").value = $(this).closest('tr').children('td.eight').text();
            document.getElementById("txtRetailPrice").value = $(this).closest('tr').children('td.nine').text();

            document.getElementById("ContentPlaceHolder1_DropDownList").value = $(this).closest('tr').children('td.six').text();
            document.getElementById("ContentPlaceHolder1_ddlPacking").value = $(this).closest('tr').children('td.ten').text();


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
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="icon-pie"></i> </span> Item </h3>
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
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Item Name <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtitemname" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Item Name">
                        </div>
                      </div>

                      
                         <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Item Code <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtItemCode" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Item Code">
                        </div>
                      </div>





                         <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Bar Code <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtbarcode" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Bar Code">
                        </div>
                      </div>


                         <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Discription <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtDiscription" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Discription">
                        </div>
                      </div>


                          <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Select Unit Type <span class="required"></span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                             <asp:DropDownList ID="DropDownList" runat="server"  CssClass="form-control"></asp:DropDownList>    
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Distributor Percentage <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtdistPer" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Distributor Percent">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Trade Price <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtTradePrice" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Trade Price">
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Retail Price <span class="required">*</span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="txtRetailPrice" required="required" class="form-control col-md-7 col-xs-12" placeholder="Enter Retail Price">
                        </div>
                      </div>
                    
                     <div class="form-group">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Packing <span class="required"></span>
                        </label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                             <asp:DropDownList ID="ddlPacking" runat="server" CssClass="form-control"></asp:DropDownList>    
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

