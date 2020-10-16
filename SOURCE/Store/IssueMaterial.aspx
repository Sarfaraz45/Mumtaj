<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="IssueMaterial.aspx.cs" Inherits="ERP_ITM_material" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



     <script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            LoadRegion();
        });
        function getParameterByName(name, url) {
            if (!url) {
                url = window.location.href;
            }
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        function LoadRegion() {
            
            //            var SID = getParameterByName('SID');
            //            var dataToSend = JSON.stringify({ 'SID': SID });
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "IssueMaterial.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                //data: dataToSend,
                async: false,
                success: function (data) {

                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    if ($('#tablepaging').length != 0) {

                        $('#tablepaging').remove();
                    }
                    var str = ""; var cc = 0;
                    ro = "<table id='tablepaging' class='table' style='cursor: pointer;' ><thead style='background: rgba(52,73,94,0.94); color: #ECF0F1;'><th></th><th>Material</th><th>Qty.</th><th>Availed Qty.</th><th>Remaining Qty.</th><th>Issue Qty.</th></thead><tbody>";
                    //alert(ro);
                    $.each(jsdata, function (key, value) {
                        if (cc == 0) {
                            str = value.BatchCode + "^" + value.OrderDate + "^" + value.ItemName + "^" + value.Qty + "^" + value.Availed + "^" + value.Balance + "^" + value.Store + "^" + value.ItemID + "^" + value.UnitID + "^" + value.ProductID + "^";
                        }
                        else {
                            str = str + "`" + value.BatchCode + "^" + value.OrderDate + "^" + value.ItemName + "^" + value.Qty + "^" + value.Availed + "^" + value.Balance + "^" + value.Store + "^" + value.ItemID + "^" + value.UnitID + "^" + value.ProductID + "^";

                        }
                        cc = 1;


                        //ro += "<tr><td  class='two'>" + value.OrderDate + "</td>    <td   class='three'>" + value.ItemName + "</td><td   class='three'>" + value.Qty + "</td><td   class='three'>" + value.Availed + "</td><td   class='three'>" + value.Balance + "</td>    </tr>";

                    });
                    //ro = ro + "</tbody></table>";



                    //                    $("#DivRegion").append(ro);
                    //var ddl = document.getElementById("ContentPlaceHolder1_DropDownList").value;
                    //document.getElementById("RcpLst").innerHTML = "Recipe List for " + $('#ContentPlaceHolder1_DropDownList').find('option:selected').text();            

                    //var batchOld = "";
                    var splt = str.split('`');
                    for (var i = 0; i < splt.length; i++) {
                        var arrString = splt[i];
                        var array = arrString.split('^');

                        var BatchCode = array[0];
                        var OrderDate = array[1];
                        var ItemName = array[2];
                        var Qty = array[3];
                        var Availed = array[4];
                        var Balance = array[5];
                        var Store = array[6];
                        var ItemID = array[7];
                        var UnitID = array[8];
                        var ProductID = array[9];

                        //                        if (batchOld != BatchCode && batchOld != "") {
                        //                            var b = BatchCode;
                        //                            b.toUpperCase();
                        //                            b = b.split("").join(" ");
                        //                            ro += "<tr><td colspan='6' style='text-align:right;'><button type='button' class='btn btn-success' id='btnSave' onclick='Save();'><b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp I S S U E  &nbsp&nbsp&nbsp&nbsp M A T E R I A L &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  F O R &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp B A T C H  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp C O D E  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp " + b + "</b></button></td></tr>";
                        //                        }
                        var b1 = BatchCode;
                        var b = BatchCode;
                        b.toUpperCase();
                        b = b.split("").join(" ");

                        ro += "<tr id='" + Store + "'><td style='font-weight:bold; font-size:large; vertical-align:middle; color: gray;  font-family: cursive;' width='20%'>" + OrderDate + "," + BatchCode + "</br></br><button type='button' class='btn vd_btn vd_bg-green vd_white' style='height: 100px; width: 150px; vertical-align:middle;font-family:sans-serif' id='" + b1 + "' onclick='Save(this);'><b>ISSUE MATERIAL </b></button></td> <td   width='20%' class='three'>" + ItemName + "</td><td   class='three' width='10%' id='txtQty" + Store + "'>" + Qty + "</td><td   class='three' width='10%'>" + Availed + "</td><td   class='three' width='10%'>" + Balance + "</td> <td   class='three' width='20%'><input type='text' id='txtQtyIssue" + Store + "' class='form-control' placeholder='Issue Quantity' value='0' onkeyup='tot(this);'></td><td   class='zero' id='txtItem" + Store + "' style='display:none;'>" + ItemID + "</td><td   class='ten' id='txtUnit" + Store + "' style='display:none;'>" + UnitID + "</td><td   class='ten' id='txtProduct" + Store + "' style='display:none;'>" + ProductID + "</td><td   class='ten' id='txtStore" + Store + "' style='display:none;'>" + Store + "</td></tr>";
                        //ro += "<tr><td colspan='6' style='text-align:right;'><button type='button' class='btn btn-success' id='"+b1+"' onclick='Save();'><b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp I S S U E  &nbsp&nbsp&nbsp&nbsp M A T E R I A L &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  F O R &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp B A T C H  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp C O D E  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp " + b + "</b></button></td></tr>";
                        //var content = "<div><a href='#'>" + BatchCode + "  </a><a href='#'>" + OrderDate + "  </a><a href='#'>" + ItemName + "  </a></div>";
                        //$("#DivRegion").append(content);
                        //    batchOld = BatchCode;
                    }
                    ro = ro + "</tbody></table>";
                    //alert(ro);
                    $("#DivRegion").append(ro);

                },
                error: function (result) {
                    alert(result);
                }


            });

        };

        $(function () {
            function groupTable($rows, startIndex, total) {
                if (total === 0) {
                    return;
                }
                var i, currentIndex = startIndex, count = 1, lst = [];
                var tds = $rows.find('td:eq(' + currentIndex + ')');
                var ctrl = $(tds[0]);
                lst.push($rows[0]);
                for (i = 1; i <= tds.length; i++) {
                    if (ctrl.text() == $(tds[i]).text()) {
                        count++;
                        $(tds[i]).addClass('deleted');
                        lst.push($rows[i]);
                       // alert($rows[i].innerHTML);
                    }
                    else {
                        if (count > 1) {
                            //alert(count);
                            ctrl.attr('rowspan', count);                            
                            groupTable($(lst), startIndex + 1, total - 1)
                        }
                        count = 1;
                        lst = [];
                        ctrl = $(tds[i]);
                        lst.push($rows[i]);
                    }
                }
            }
            groupTable($('#tablepaging tr:has(td)'), 0, 3);
            $('#tablepaging .deleted').remove();
        });


        function tot(a) {
            //alert(a.id);
            var txtQtyIssueID = a.id;
            var txtQtyID = txtQtyIssueID.replace('txtQtyIssue', 'txtQty');
            //alert(txtQtyID);
            var str = document.getElementById(txtQtyID).innerHTML;
            //alert(str);
            str = str.slice(0, -1);
            var txtQty = parseFloat(str);
            //alert(txtQty);
            var txtQtyIssue = parseFloat(document.getElementById(txtQtyIssueID).value);
            if (txtQtyIssue > txtQty) {
                alert("Please reduce Quantity!");
                document.getElementById(txtQtyIssueID).value = "0";
            }
        }

        function Save(a) {
            a = a.id;
            //alert(a);


            var UserID = localStorage.getItem("UserID");
            var elm = {}; var tMarks = 0;
            var elms = document.getElementById('tablepaging').getElementsByTagName("input");
            var str = ""; var cc = 0;
            for (var i = 0; i < elms.length; i++) {
                if (elms[i].id.indexOf('txtQtyIssue') != -1) {

                    elm = elms[i];
                    var iD = elm.id;
                    var txtQtyIssueID = iD;
                    //alert(txtQtyIssueID);
                    var txtItemID = iD.replace('txtQtyIssue', 'txtItem');
                    var txtUnitID = iD.replace('txtQtyIssue', 'txtUnit');
                    var txtProductID = iD.replace('txtQtyIssue', 'txtProduct');                    
                    var txtStoreID = iD.replace('txtQtyIssue', 'txtStore');
                    //alert(txtItemID);
                    var txtQtyIssue = document.getElementById(txtQtyIssueID).value;
                    //alert(txtQtyIssue);
                    var txtItem = document.getElementById(txtItemID).innerHTML;
                    var txtUnit = document.getElementById(txtUnitID).innerHTML;
                    var txtProduct = document.getElementById(txtProductID).innerHTML;
                    //alert(txtProduct);
                    var txtStore = document.getElementById(txtStoreID).innerHTML;
                    //alert(txtItem);
                    if (txtQtyIssue == "" || txtQtyIssue == null) { txtQtyIssue = 0; }


                    if (txtQtyIssue != 0) {
                        if (cc == 0) {
                            str = txtItem + "^" + a + "^" + txtQtyIssue + "^" + txtUnit + "^" + txtProduct + "^" + txtStore;
                            //alert(str);
                        }
                        else {
                            str = str + "`" + txtItem + "^" + a + "^" + txtQtyIssue + "^" + txtUnit + "^" + txtProduct + "^" + txtStore;
                            //alert(str);
                        }
                    }

                    cc = 1;


                }
                else {

                }
            }

            if (cc > 0) {
                //alert("a");
                $.ajax({
                    type: 'POST',
                    url: 'IssueMaterial.aspx/SaveTransaction',
                    //data: {},
                    data: '{ "UserID" : "' + UserID + '", "str" : "' + str + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {
                        tblRows = msg.d;
                        alert('Material Issued for Production');
                        LoadRegion();
                        //window.location = 'NC_RecipeList.aspx';
                    }

                });
            }

        }

        
    </script>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
              <div class="col-md-12">
                <div class="panel widget">
                  <div class="panel-heading vd_bg-grey">
                    <h3 class="panel-title"> <span class="menu-icon"> <i class="fa fa-bar-chart-o"></i> </span> Batch Wise Pending Material List </h3>
                  </div>
                  <div class="panel-body">
                    <form class="form-horizontal" action="#" role="form" runat="server">

                         <div class="form-group">
                          <div class="x_content"id="DivRegion" >

                    <table class="table" id="tablepaging">
                      <thead>
                        <tr>
                             <td></td>
                             
                             <td>Order Date</td>
                            <td>Material</td>
                            <td>Quantity</td>
                            
                          
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <th></th>
                <th></th>
                <th></th>
                            <th></th>
                  
                        </tr>
                     
                        
                      </tbody>
                    </table>

                  </div>
                      </div>

                      
                    </form>
                  </div>
                </div>
                <!-- Panel Widget --> 
              </div>
           
              <!-- col-md-12 --> 
            </div>
                 
              
              
                 








</asp:Content>

