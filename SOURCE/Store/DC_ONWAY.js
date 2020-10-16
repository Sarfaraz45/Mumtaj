
//LoadGoods_List()
LOAD_ACCOUNTS();
function LOAD_ACCOUNTS() {

    var tblRows = "";
    var UserID = localStorage.getItem("UserID");
    $.ajax({
        type: 'POST',
        url: 'DC_ONWAY.aspx/LOAD_ACCOUNTS',
        //data: {},
        data: '{ "UserID" : "' + UserID + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            var s = msg.d.split('`');
            var sDT = s[0];
            var eDT = s[1];
            var ar = s[2]; // s;
            // var itm = s[3];

            var cc = ar.replace(/'/g, '"');
            //txtAccCode.dataset.source = document.getElementById('ContentPlaceHolder1_hdnAccounts').value;
            document.getElementById('ContentPlaceHolder1_hdnParty').value = cc;
            txtParty = document.getElementById('txtParty');
            txtParty.dataset.source = document.getElementById('ContentPlaceHolder1_hdnParty').value;

            document.getElementById('datepicker-autoClose').value = sDT;
            document.getElementById('datepicker-autoCloseTO').value = eDT;
        }

    });
    // alert(tblRows);

}

function LoadGoods_List() {

    var cust = "0";


    if (document.getElementById('txtParty').value == null || document.getElementById('txtParty').value == "") {
        // alert("Please Select Customer! ");
        //  return false;
    }
    else {
        var txtParty = document.getElementById('txtParty').value;
        var prt = txtParty.split('^');
        var pD = prt[1];
        cust = pD.replace(/\s/g, '');

    }
    var sDt = document.getElementById('datepicker-autoClose').value;
    var eDt = document.getElementById('datepicker-autoCloseTO').value;

    var tblRows = "";
    var UserID = localStorage.getItem("UserID");
    $.ajax({
        type: 'POST',
        url: 'DC_ONWAY.aspx/LoadGoods_List',
        data: '{ "UserID" : "' + UserID + '","cust" : "' + cust + '","sDt" : "' + sDt + '","eDt" : "' + eDt + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            var s = msg.d;
            document.getElementById('dvGoodsLST').innerHTML = s;

        }

    });
}


function DeliveredDC(a, b, c,d) {
    document.getElementById('dvPONo').innerHTML = a;
    document.getElementById('dvDate').innerHTML = b;
    document.getElementById('dvSupplier').innerHTML = c;
    document.getElementById('datepicker-icon-PV').value = d;

    
    $('#modalRcvdStock').modal('show');
}




function DELIVERED() {
    var dDT = document.getElementById('datepicker-icon-PV').value;
    var dcNo = document.getElementById('dvPONo').innerHTML;
    var rcvdBY = document.getElementById('txtReceivedBy').value;
    var UserID = localStorage.getItem("UserID");
    $.ajax({
        type: 'POST',
        url: 'DC_ONWAY.aspx/DELIVERED',
        data: '{ "UserID" : "' + UserID + '","dDT" : "' + dDT + '","dcNo" : "' + dcNo + '","rcvdBY" : "' + rcvdBY + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            alert('Order has been Delivered to Customer');
            LoadGoods_List();
            $('#modalRcvdStock').modal('hide');
        }

    });
}

function ReverseDC(a, b, c) {
    document.getElementById('dvPONo_R').innerHTML = a;
    document.getElementById('dvDate_R').innerHTML = b;
    document.getElementById('dvSupplier_R').innerHTML = c;


    $('#modalRvrsDC').modal('show');
}

function REVERSE() {
    
    var dcNo = document.getElementById('dvPONo_R').innerHTML;
    var UserID = localStorage.getItem("UserID");
    $.ajax({
        type: 'POST',
        url: 'DC_ONWAY.aspx/REVERSE',
        data: '{ "UserID" : "' + UserID + '","dcNo" : "' + dcNo + '" }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            alert('DC has been Reverse Successfully');
            LoadGoods_List();
            $('#modalRvrsDC').modal('hide');
        }

    });
}