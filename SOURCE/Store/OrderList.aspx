<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="ERP_ITM_material" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



     <script src="../jquery-1.8.2.js"></script>
    <script src="../jquery.min.js"></script>

    <script type="text/javascript">
        var counter = 0;

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
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "OrderList.aspx/LoadRegion",
                dataType: "json",
                data: "{}",
                //data: dataToSend,
                async: false,
                success: function (data) {

                    var jsdata = JSON.parse(data.d);
                    var ro = "";

                    var str = ""; var cc = 0;
                    var roTable = "";
                    //alert(ro);
                    $.each(jsdata, function (key, value) {
                        if (cc == 0) {
                            str = value.ItemName + "^" + value.Qty + "^" + value.QtyInStock + "^" + value.QtyInStockNew + "^" + value.QtyNew + "^" + value.ItemID + "^" + value.BatchID + "^";
                        }
                        else {
                            str = str + "`" + value.ItemName + "^" + value.Qty + "^" + value.QtyInStock + "^" + value.QtyInStockNew + "^" + value.QtyNew + "^" + value.ItemID + "^" + value.BatchID + "^";

                        }
                        cc = 1;

                    });

                    var splt = str.split('`');
                    var OldBatchID = 0;
                 //   ro = "<table id='tablepaging' class='table' style='cursor: pointer;' ><thead style='background: rgba(52,73,94,0.94); color: #ECF0F1;'><th>Item Name</th><th>Qty. In Stock</th><th>Required Qty.</th><th></th></thead><tbody>";
                    for (var i = 0; i < splt.length; i++) {
                        var arrString = splt[i];
                        var array = arrString.split('^');
                        
                        var ItemName = array[0];
                        var Qty = array[1];
                        var QtyInStock = array[2];                        
                        var QtyInStockNew = array[3];
                        var QtyNew = array[4];
                        var ItemID = array[5];
                        var BatchID = array[6];
                        var div = "</div><div class='panel widget light-widget panel-bd-top'><div class='panel-heading bordered'><h3 class='panel-title' id='RcpLst'> <span class='menu-icon'> <i class='icon-pie'></i> </span> Pending Order List for Batch ID : " + BatchID + " </h3><div class='vd_panel-menu'><div data-action='minimize' data-original-title='Minimize' data-toggle='tooltip' data-placement='bottom' class=' menu entypo-icon'> <i class='icon-minus3'></i> </div><div data-action='refresh'  data-original-title='Refresh' data-toggle='tooltip' data-placement='bottom' class=' menu entypo-icon smaller-font'> <i class='icon-cycle'></i> </div><div data-original-title='Config' data-toggle='tooltip' data-placement='bottom' class=' menu entypo-icon smaller-font'><div class='menu-trigger' data-action='click-trigger'> <i class='icon-cog'></i> </div><div data-action='click-target' class='vd_mega-menu-content  width-xs-2  left-xs'><div class='child-menu'><div class='content-list content-menu'><ul class='list-wrapper pd-lr-10'><li> <a href='#'> <div class='menu-icon'><i class=' fa fa-user'></i></div> <div class='menu-text'>User Menu</div> </a> </li><li> <a href='#'> <div class='menu-icon'><i class=' icon-trophy'></i></div> <div class='menu-text'>Panel Menu</div> </a> </li><li> <a href='#'> <div class='menu-icon'><i class=' fa fa-envelope'></i></div> <div class='menu-text'>Other Menu</div> </a> </li><li class='line'></li><li> <a href='#'> <div class='menu-icon'><i class=' fa fa-tasks'></i></div> <div class='menu-text'> Tasks</div> </a> </li><li> <a href='#'> <div class='menu-icon'><i class=' icon-lock'></i></div> <div class='menu-text'>Privacy</div> </a> </li></ul></div></div></div></div><div data-action='close' data-original-title='Close' data-toggle='tooltip' data-placement='bottom' class=' menu entypo-icon'> <i class='icon-cross'></i> </div></div></div><div class=' panel-body-list'><div class='col-lg-12' style='height:10px;'></div>";
                        if (OldBatchID == 0) {
                            // ro += "<tr id=" + ItemID + " ><td   width='50%' class='three'>" + ItemName + "</td><td style='text-align:left;'   class='three' width='25%' id='txtQtyInStock" + ItemID + "'>" + QtyInStock + "</td><td  style='text-align:left;'  class='three' width='25%' id='txtQty" + ItemID + "'>" + Qty + "</td><td  style='text-align:left;display:none;'   class='three' width='25%' id='txtItem" + ItemID + "'>" + ItemID + "</td></tr>"; 
                            ro += div + "<div class='col-md-12'  style='text-align:right;'><button type='button' class='btn btn-success' style='width: 20%; vertical-align:middle;font-family:sans-serif' id='" + BatchID + "' onclick='Save(this);'><b>P R O C E S S &nbsp&nbsp&nbsp&nbsp O R D E R</b></button></div><div class='col-lg-12' style='height:10px;'></div><table id='ttablepaging" + i + "' class='table' style='cursor: pointer;' >";
                            ro += "<thead style='background: rgba(52,73,94,0.94); color: #ECF0F1;'><th>Item Name</th><th>Qty. In Stock</th><th>Required Qty.</th></thead><tbody>";
                            counter = counter + 1;
                            
                        }
                        if (OldBatchID != BatchID && OldBatchID != 0) {
                            ro = ro + "</tbody></table></div></div>" + div + "<div class='col-md-12'  style='text-align:right;'><button type='button' class='btn btn-success' style='width: 20%; vertical-align:middle;font-family:sans-serif' id='" + BatchID + "' onclick='Save(this);'><b>P R O C E S S &nbsp&nbsp&nbsp&nbsp O R D E R</b></button></div><div class='col-lg-12' style='height:10px;'></div><table id='ttablepaging" + i + "' class='table' style='cursor: pointer;' ><thead style='background: rgba(52,73,94,0.94); color: #ECF0F1;'><th>Item Name</th><th>Qty. In Stock</th><th>Required Qty.</th></thead><tbody>";
                            counter = counter + 1;

                        }
                        ro += "<tr id='" + ItemID + "'><td   width='60%' class='three'  style='text-align:left;'>" + ItemName + "</td><td style='text-align:left;'   class='three' width='20%' id='txtQtyInStock" + ItemID + "'>" + QtyInStock + "</td><td  style='text-align:left;'  class='three' width='20%' id='txtQty" + ItemID + "'>" + Qty + "</td></tr>";


                        OldBatchID = BatchID;


                    }

                    //alert(ro);
                    $("#DivRegion").append(ro);

                },
                error: function (result) {
                    alert(result);
                }


            });

        };


        function tot(a) {
            //alert(a.id);
            var txtQtyIssueID = a.id;
            var txtQtyID = txtQtyIssueID.replace('txtQtyIssue', 'txtQty');
            var txtQtyInStockID = txtQtyIssueID.replace('txtQtyIssue', 'txtQtyInStock');
            //alert(txtQtyID);
            var str = document.getElementById(txtQtyID).innerHTML;
            var stock = document.getElementById(txtQtyInStockID).innerHTML;
            //alert(stock);
            //str = str.slice(0, -1);
            //stock = stock.slice(0, -1);
            var txtQty = parseFloat(str);
            var txtQtyStock = parseFloat(stock);
            //alert(txtQtyStock);
            var txtQtyIssue = parseFloat(document.getElementById(txtQtyIssueID).value);
            if (txtQty > txtQtyStock) {
                alert("Quantity not avialable in stock. Please purchase!");
                document.getElementById(txtQtyIssueID).value = "0";
            }
            if (txtQtyIssue > txtQty) {
                alert("Please reduce Quantity!");
                document.getElementById(txtQtyIssueID).value = "0";
            }
        }

        function Save(a) {
            a = a.id;           
            var UserID = localStorage.getItem("UserID");            
                $.ajax({
                    type: 'POST',
                    url: 'OrderList.aspx/SaveTransaction',
                    //data: {},
                    data: '{ "UserID" : "' + UserID + '","BatchID" : "' + a + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {                        
                        alert('Material Issued for Production');
                        document.getElementById("DivRegion").innerHTML = "";
                        LoadRegion();
                        
                    }

                });
            }

        



        function GroupWiseTable() {
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
            for (var i = 0; i < counter; i++) {
                var t = '#tablepaging' + i + ' tr:has(td)';
                var u = '#tablepaging' + i + ' .deleted';
                groupTable($(t), 0, 3);
                $(u).remove();
                
            }
//            groupTable($('#tablepaging tr:has(td)'), 0, 3);
//            $('#tablepaging .deleted').remove();
        };
        
    </script>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

                <div class="row"  id="DivRegion" >
              
                    </div>
                  
            

</asp:Content>

