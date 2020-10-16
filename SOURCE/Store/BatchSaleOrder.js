

LoadOrders();



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

function LoadOrders() {
    // alert('mmm');
    var btchID = getParameterByName('btchID');
    var UserID = "1";
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "BatchSaleOrder.aspx/LoadOrders",
        dataType: "json",
        data: '{ "btchID" : "' + btchID + '" }',
        success: function (data) {
            var jsdata = JSON.parse(data.d);
            var ro = "";

            if ($('#tablepaging').length != 0) {

                $('#tablepaging').remove();
            }

            var aaa = 0;

            ro = "<table id='tablepaging' class='table table-striped table-hover no-head-border'   style='cursor: pointer;'><thead class='vd_bg-dark-blue vd_white'><th>ID</th><th>Date</th><th>Customer</th><th>Action</th></thead><tbody>";
            $.each(jsdata, function (key, value) {
                //ro += "<tr><td width='10%'><button type='button' class='btn btn-info m-r-5 m-b-5' id='" + value.ID + "' title='" + value.Name + "' onclick=\"GetRegion('" + value.ID + "','" + value.Name + "');\">Edit</button></td><td width='30%'>" + value.ID + "</td><td width='60%'  class='two'>" + value.Name + "</td></tr>";
                //htm = htm + "<td><a href=\"javascript:ShowPO('" + dt.Rows[i]["SOID"].ToString() + "','" + dt.Rows[i]["SODate"].ToString() + "','" + dt.Rows[i]["CustomerTitle"].ToString() + "');\"><i class='append-icon fa fa-fw fa-search-plus'></i>Issue DC</a></td>";
                ro += "<tr><td width='25%'  class='one'>" + value.PRID + "</td><td width='20%'  class='two'>" + value.PRDate + "</td><td width='35%'  class='three'>" + value.CustomerTitle + "</td><td style='display:none;'  class='four'>" + value.Email + "</td>";
                ro += "<td class='menu-action'><a href=\"javascript:LOAD_DATA_FOR_PRINT('" + value.PRID + "');\" data-original-title='view' data-toggle='tooltip' data-placement='top' class='btn menu-icon vd_bd-green vd_green'> <i class='fa fa-eye'></i> </a> <a href=\"javascript:ShowPO('" + value.PRID + "','" + value.PRDate + "','" + value.CustomerTitle + "');\" data-original-title='edit' data-toggle='tooltip' data-placement='top' class='btn menu-icon vd_bd-yellow vd_yellow'> <i class='fa fa-pencil'></i> </a> <a href=\"javascript:DELETE_ORDER('" + value.PRID + "');\" data-original-title='delete' data-toggle='tooltip' data-placement='top' class='btn menu-icon vd_bd-red vd_red'> <i class='fa fa-times'></i> </a></td></tr>";
                aaa = 1;
            });
            ro = ro + "</tbody></table>";

            $("#dvOrders").append(ro);


            //                if (aaa == 1) {
            //                    document.getElementById('dvOrderList').style.display = 'block';
            //                }
            //                else {
            //                    document.getElementById('dvOrderList').style.display = 'none';
            //                }

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



////////////////
function LOAD_DATA_FOR_PRINT(vNo) {

    var voucherID = vNo;

    $.ajax({
        type: 'POST',
        url: 'BatchSaleOrder.aspx/LOAD_DATA_FOR_PRINT',
        //data: {},
        data: '{ "voucherID" : "' + voucherID + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            //alert(msg.d);
            var s = msg.d.split('`');
            var htm = ""; var totQTY = 0;
            for (var i = 0; i < s.length; i++) {
                var pItems = s[i].split('~');
                var prid = pItems[0];
                var custID = pItems[1];
                var txtAccID = pItems[2];

                var txtAccTitle = pItems[3];
                var unitID = pItems[4];
                var Qty = pItems[5];

                var btchID = pItems[6];
                var entDt = pItems[7];
                var cust = pItems[8];
                var delDt = pItems[9];

                var k = parseFloat(i) + 1;
                // alert(i + '----' + s.length);
                if (i == 0) {
                    //htm= <table class="table table-condensed table-striped" id="tblPrint">
                    document.getElementById('spnBatchNo').innerHTML = btchID;
                    document.getElementById('spnEntryDate').innerHTML = entDt;
                    document.getElementById('spnOrderTo').innerHTML = cust;
                    document.getElementById('spnShipTo').innerHTML = cust;
                    document.getElementById('spnDelDate').innerHTML = delDt;

                    htm = htm + "<thead><tr><th class='text-center' style='width:20px;'>S.NO.</th><th>DESCRIPTION</th><th class='text-right' style='width:160px;'>QTY.</th></tr></thead>"
                    htm = htm + "<tbody><tr><td class='text-center'>" + k + "</td><td>" + txtAccTitle + "</td><td class='text-right'>" + Qty + " " + unitID + "</td></tr>";



                }
                else {
                    htm = htm + "<tr><td class='text-center'>" + k + "</td><td>" + txtAccTitle + "</td><td class='text-right'>" + Qty + " " + unitID + "</td></tr>";

                }

                document.getElementById('spnTotalItems').innerHTML = parseFloat(i) + 1;
            }

            htm = htm + " </tbody></table>";
            document.getElementById('tblPrint').innerHTML = htm;
            $('#modalOrder').modal('show');
            /////units
        }

    });



}



function ShowPO(a, b, c) {
    document.getElementById('dvPONo').innerHTML = a;
    document.getElementById('dvDate').innerHTML = b;
    document.getElementById('dvSupplier').innerHTML = c;

    var tblRows = "";
    var UserID = localStorage.getItem("UserID");
    var PONO = a;
    $.ajax({
        type: 'POST',
        url: 'BatchSaleOrder.aspx/ShowPO',
        data: '{ "UserID" : "' + UserID + '","PONO" : "' + PONO + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            var s = msg.d;
            //var str = s.split('`');
           // alert(s);
            document.getElementById('dvListStock').innerHTML = s;

        }

    });
    LoadGoods_List(a);
    $('#modalRcvdStock').modal('show');
}

function LoadGoods_List(a) {
    var tblRows = "";
    var UserID = localStorage.getItem("UserID");
    var POID = a;
    $.ajax({
        type: 'POST',
        url: 'BatchSaleOrder.aspx/LoadGoods_List',
        data: '{ "POID" : "' + POID + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            var s = msg.d;
            document.getElementById('dvGoodsLST').innerHTML = s;

        }

    });
}

function SaveGoods() {


    var UserID = localStorage.getItem("UserID");
    var txtVoucherNo = document.getElementById('dvPONo').innerHTML;
    var ddlSupplier = "";

    var dd = document.getElementById('dvDate').innerHTML;
    var ss = document.getElementById('dvSupplier').innerHTML;




    var elm = {}; var tMarks = 0;
    var elms = document.getElementById('tblPO_ItemsRequisition').getElementsByTagName("input");
    var str = ""; var cc = 0;
    for (var i = 0; i < elms.length; i++) {
        if (elms[i].id.indexOf('txtPO_QtyBal') != -1) {

            elm = elms[i];
            var iD = elm.id;
            var txtUnitPriceID = iD;
            var spnID = iD.replace('txtPO_QtyBal', 'spnPO_ALL');
            var txtQtyID = iD.replace('txtPO_QtyBal', 'txtPO_QtyBal');

            var spnHtm = document.getElementById(spnID).innerHTML;
            var splt = spnHtm.split('^');
            var txtAccID = splt[0];
            var rowID = splt[5];
            ddlSupplier = splt[6];
            var txtAccTitle = "";
            var ddlUnit = splt[1];
            var txtQty = document.getElementById(txtQtyID).value;
            var txtPrice = splt[2];
            var txtTotalPrice = splt[3];

            if (txtQty == "" || txtQty == null) { txtQty = 0; }
            if (txtPrice == "" || txtPrice == null) { txtPrice = 0; }
            if (txtTotalPrice == "" || txtTotalPrice == null) { txtTotalPrice = 0; }


            if (txtQty != 0) {
                if (cc == 0) {
                    str = txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice + "^" + rowID;
                }
                else {
                    str = str + "`" + txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice + "^" + rowID;
                }
            }

            cc = 1;


        }
        else {

        }
    }

    if (cc > 0) {
        $.ajax({
            type: 'POST',
            url: 'BatchSaleOrder.aspx/SaveGoods',
            //data: {},
            data: '{ "UserID" : "' + UserID + '", "str" : "' + str + '", "txtVoucherNo" : "' + txtVoucherNo + '", "ddlSupplier" : "' + ddlSupplier + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                tblRows = msg.d;
                alert('Delivery Challan has been Issued Successfully!');
                ShowPO(txtVoucherNo, dd, ss);
                //LoadGoods_List(txtVoucherNo);
                //window.location = 'PendingRequisitionList.aspx';
            }

        });
    }

}



/////////////////////
    