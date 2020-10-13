﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Usertypeforms.aspx.cs" Inherits="Setup_Usertypeforms" %>

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
            $.ajax({
                type: "POST",
                url: "UserTypeForms.aspx/LoadRegionCombo",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_ddlRegion').select.length != 0) {

                        $('#ContentPlaceHolder1_ddlRegion').empty();
                    }

                    $.each(jsdata, function (key, value) {
                        rows += "<option  value=" + value.ID + ">" + value.Name + "</option>";
                    });

                    $("#ContentPlaceHolder1_ddlRegion").append(rows);



                },
                error: function (data) {
                    alert("error found");
                }
            });
        });



        function LoadRegionCombo() {
            $.ajax({
                type: "POST",
                url: "UserTypeForms.aspx/LoadRegionCombo",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_ddlRegion').select.length != 0) {

                        $('#ContentPlaceHolder1_ddlRegion').empty();
                    }


                    $.each(jsdata, function (key, value) {
                        rows += "<option  value=" + value.ID + ">" + value.Name + "</option>";
                    });

                    $("#ContentPlaceHolder1_ddlRegion").append(rows);



                },
                error: function (data) {
                    alert("error found");
                }
            });
        };


        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "UserTypeForms.aspx/LoadForm",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_ddlForm').select.length != 0) {

                        $('#ContentPlaceHolder1_ddlForm').empty();
                    }

                    $.each(jsdata, function (key, value) {
                        rows += "<option  value=" + value.ID + ">" + value.Name + "</option>";
                    });

                    $("#ContentPlaceHolder1_ddlForm").append(rows);



                },
                error: function (data) {
                    alert("error found");
                }
            });
        });

        function LoadForm() {
            $.ajax({
                type: "POST",
                url: "UserTypeForms.aspx/LoadForm",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var rows = "";
                    if ($('#ContentPlaceHolder1_ddlForm').select.length != 0) {

                        $('#ContentPlaceHolder1_ddlForm').empty();
                    }

                    $.each(jsdata, function (key, value) {
                        rows += "<option  value=" + value.ID + ">" + value.Name + "</option>";
                    });

                    $("#ContentPlaceHolder1_ddlForm").append(rows);



                },
                error: function (data) {
                    alert("error found");
                }
            });
        };



        function EnterEvent(e) {
            if (e.keyCode == 13) {
                event.preventDefault();
                document.getElementById("btnSave").click();

            }
        }

        function setFocusToTextBox() {
            $('#ContentPlaceHolder1_ddlRegion').focus();


        }
        $(document).ready(function () {
            setFocusToTextBox();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    if ($('#tablepaging').length != 0) {

                        $('#tablepaging').remove();
                    }

                    ro = "<table id='tablepaging' class='table table-hover'  style='cursor: pointer;'><thead><th>ID</th><th>Form</th><th>User Type</th></thead><tbody>";
                    $.each(jsdata, function (key, value) {
                        //ro += "<tr><td width='10%'><button type='button' class='btn btn-info m-r-5 m-b-5' id='" + value.ID + "' title='" + value.Name + "' onclick=\"GetRegion('" + value.ID + "','" + value.Name + "');\">Edit</button></td><td width='30%'>" + value.ID + "</td><td width='60%'  class='two'>" + value.Name + "</td></tr>";
                        ro += "<tr><td width='20%'  class='one'>" + value.ID + "</td><td width='40%'  class='two'>" + value.Form + "</td><td width='40%'  class='three'>" + value.UserType + "</td><td style='display:none;'  class='four'>" + value.FormID + "</td><td style='display:none;'  class='five'>" + value.UserTypeID + "</td></tr>";

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

        });

        function LoadRegion() {
            setFocusToTextBox();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    if ($('#tablepaging').length != 0) {

                        $('#tablepaging').remove();
                    }

                    ro = "<table id='tablepaging' class='table table-hover'   style='cursor: pointer;'><thead><th>ID</th><th>Name</th></thead><tbody>";
                    $.each(jsdata, function (key, value) {
                        //ro += "<tr><td width='10%'><button type='button' class='btn btn-info m-r-5 m-b-5' id='" + value.ID + "' title='" + value.Name + "' onclick=\"GetRegion('" + value.ID + "','" + value.Name + "');\">Edit</button></td><td width='30%'>" + value.ID + "</td><td width='60%'  class='two'>" + value.Name + "</td></tr>";
                        ro += "<tr><td width='20%'  class='one'>" + value.ID + "</td><td width='40%'  class='two'>" + value.Form + "</td><td width='40%'  class='three'>" + value.UserType + "</td><td style='display:none;'  class='four'>" + value.FormID + "</td><td style='display:none;'  class='five'>" + value.UserTypeID + "</td></tr>";

                    });
                    ro = ro + "</tbody></table>";

                    $("#DivRegion").append(ro);

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

        $("#tablepaging tbody tr").live('click', function () {
            var selected = $(this).hasClass("highlight");

            /// For Getting Grid Value Start
            /// For Getting Grid Value Start

            document.getElementById("<%=hdntitle.ClientID%>").value = $(this).closest('tr').children('td.two').text();
            document.getElementById("<%=hdnid.ClientID%>").value = $(this).closest('tr').children('td.one').text();
            document.getElementById("<%=hdnregion.ClientID%>").value = $(this).closest('tr').children('td.three').text();
            document.getElementById("ContentPlaceHolder1_ddlRegion").value = $(this).closest('tr').children('td.five').text();
            document.getElementById("ContentPlaceHolder1_ddlForm").value = $(this).closest('tr').children('td.four').text();

            $("#btnSave").text("Update");
            setFocusToTextBox();

            document.getElementById("ContentPlaceHolder1_ddlRegion").style.border = "solid 1px #ccd0d4";
            document.getElementById("ContentPlaceHolder1_ddlForm").style.border = "solid 1px #ccd0d4";
            /// For Getting Grid Value End
            /// For Getting Grid Value End

            $("#tablepaging tr").removeClass("highlight");
            if (!selected)
                $(this).addClass("highlight");
            else if (selected)
                $(this).addClass("highlight");
        });

        function msgrevert() {
            $("#msgbody").text("Are you sure about this?");
            $("#confirm").show();

        }
        function msgrevert_delete() {
            $("#msgbody_delete").text("Are you sure about this?");
            $("#confirm_delete").show();

        }
        function Save() {


            $("#modal-dialog").modal();

        }

        function SaveData() {
            if ($("#btnSave").text() == "Save") {
                InsertRegion();
                $("#search").val('');
                $("#msgbody").text("Record has been inserted successfully.");
                $("#confirm").hide();


            }
            else if ($("#btnSave").text() == "Update") {
                UpdateRegion();
                $("#search").val('');
                $("#msgbody").text("Record has been updated successfully.");
                $("#confirm").hide();

            }

        }
        function DeleteData() {
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();

            if (Region == "" || Region == null) {
                document.getElementById("ContentPlaceHolder1_ddlRegion").style.border = "solid 1px red";
                return false;
            }
            var Form = $("#ContentPlaceHolder1_ddlForm").val();

            if (Form == "" || Form == null) {
                document.getElementById("ContentPlaceHolder1_ddlForm").style.border = "solid 1px red";
                return false;
            }

            $("#modal-dialog_delete").modal();
        }


        function InsertRegion() {
            var UserID = localStorage.getItem("UserID");
            var ddl = $('#ContentPlaceHolder1_ddlRegion').val();
            var form = $('#ContentPlaceHolder1_ddlForm').val();
            var dataToSend = JSON.stringify({ 'utid': ddl, 'form': form, 'UserID': UserID });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/InsertRegion",
                dataType: "json",
                data: dataToSend,
                //data: "{'RegionName':'" + $('#txtRegionName').val() + "'}",                
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
            var UserID = localStorage.getItem("UserID");
            var ddl = $('#ContentPlaceHolder1_ddlRegion').val();
            var form = $('#ContentPlaceHolder1_ddlForm').val();
            var dataToSend = JSON.stringify({ 'DistrictID': $('#ContentPlaceHolder1_hdnid').val(), 'utid': ddl, 'form': form, 'UserID': UserID });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/UpdateRegion",
                dataType: "json",
                //data: "{'RegionID':'" + $('#ctl00_ContentPlaceHolder1_hdnid').val() + "','RegionName':'" + $('#txtRegionName').val() + "'}",
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
            var UserID = localStorage.getItem("UserID");
            var dataToSend = JSON.stringify({ 'DistrictID': $('#ContentPlaceHolder1_hdnid').val(), 'UserID': UserID });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/DeleteRegion",
                dataType: "json",
                // data: "{'RegionID':'" + $('#ctl00_ContentPlaceHolder1_hdnid').val() + "'}",
                data: dataToSend,
                async: false,
                success: function (data) {
                    var obj = data.d;

                    if (obj == 'true') {
                        $("#search").val('');
                        LoadRegion();
                        Clear();
                        setFocusToTextBox();
                        $("#msgbody_delete").text("Record has been deleted successfully.");
                        $("#confirm_delete").hide();

                    }
                    else { $("#msgbody_delete").text("District ID exist in Taluka Table!"); }


                },
                error: function (result) {
                    alert(result);
                }
            });

            return results;

        }



        function Clear() {
            $('#ContentPlaceHolder1_hdnid').val('');
            $('#ctl00_ContentPlaceHolder1_hdntitle').val('');
            $('#txtPath').val('');
            $("#btnSave").text("Save");
            $("#tablepaging tr").removeClass("highlight");
            document.getElementById("ContentPlaceHolder1_ddlRegion").style.border = "solid 1px #ccd0d4";
            document.getElementById("ContentPlaceHolder1_ddlForm").style.border = "solid 1px #ccd0d4";
            LoadRegionCombo();
            LoadForm();
            setFocusToTextBox();

        }


        function Duplicate() {
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            if (Region == "" || Region == null) {
                document.getElementById("ContentPlaceHolder1_ddlRegion").style.border = "solid 1px red";
                return false;
            }

            var Form = $("#ContentPlaceHolder1_ddlForm").val();

            if (Form == "" || Form == null) {
                document.getElementById("ContentPlaceHolder1_ddlForm").style.border = "solid 1px red";
                return false;
            }
            var ddl = $('#ContentPlaceHolder1_ddlRegion').val();
            var form = $('#ContentPlaceHolder1_ddlForm').val();
            var dataToSend = JSON.stringify({ 'utid': ddl, 'form': form });
            var results = $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "UserTypeForms.aspx/LoadRegionName",
                dataType: "json",
                data: dataToSend,
                //data: "{'RegionName':'" + $('#txtRegionName').val() + "'}",                
                async: false,
                success: function (data) {
                    var obj = data.d;
                    if (obj == 'true') {

                        Save();

                    }
                    else {

                        $("#modal-dialog_duplicate").modal();

                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

            return results;


        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">




    

    <div class="modal fade" id="modal-dialog_duplicate">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
											<h4 class="modal-title">Duplicate Record</h4>
										</div>
										<div class="modal-body" id="Div2">
											Record already exist!
										</div>
										<div class="modal-footer">
											<a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal">Close</a>
											
										</div>
									</div>
								</div>
							</div> 
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
              <div class="col-md-6">
                <div class="panel widget">
                  <div class="panel-heading vd_bg-grey">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="fa fa-bar-chart-o"></i> </span> Form User Type </h3>
                  </div>
                  <div class="panel-body">
                    
                                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">User Type <span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-9 col-xs-12">

                          <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control">
                        </asp:DropDownList>

                        </div>
                      </div>
                    




                        


                    



                          <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Form <span class="required"></span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            
  <asp:DropDownList ID="ddlForm" runat="server" CssClass="form-control">
                        </asp:DropDownList>
        


                        </div>
                      </div>
                    
                      

                   







                     
                     
                      <div class="form-group form-actions">
                        <div class="col-sm-4"> </div>
                        <div class="col-sm-7">
                           <button type="button" class="btn vd_btn vd_bg-green vd_white" id="btnSave" onclick="Duplicate();">Save</button>


                          <button class="btn btn-default" type="button" onclick="Clear();">Cancel</button>
                          <button class="btn btn-danger" type="button" onclick="DeleteData();">Delete</button>










                              


                              





                        </div>
                      </div>
                                                                                 <asp:HiddenField ID="hdnid" runat="server" />
    <asp:HiddenField ID="hdntitle" runat="server" />
     <asp:HiddenField ID="hdnregion" runat="server" />

                    
                  </div>
                </div>
                <!-- Panel Widget --> 
              </div>
              <div class="col-md-6">
                <div class="panel widget">
                  <div class="panel-heading vd_bg-grey">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="fa fa-dot-circle-o"></i> </span> User Type Form List</h3>
                  </div>
                  <div class="panel-body-list  table-responsive" id="DivRegion">
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
                <!-- Panel Widget -->
               
              </div>
              <!-- col-md-12 --> 
            </div>

</asp:Content>

