
LoadPO();


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

    function LoadPO() {
        var tblRows = "";
        var UserID = localStorage.getItem("UserID");
        $.ajax({
            type: 'POST',
            url: 'GOODS_RECEIVED.aspx/LoadPO',
            data: '{ "UserID" : "' + UserID + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                var s = msg.d;
                // alert(s);
                document.getElementById('dvPOList').innerHTML = s;

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
            url: 'GOODS_RECEIVED.aspx/ShowPO',
            data: '{ "UserID" : "' + UserID + '","PONO" : "' + PONO + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                var s = msg.d;
                var str = s.split('`');
                document.getElementById('dvListStock').innerHTML = str[0];
                document.getElementById('txtEntryDate').value = str[1];

            }

        });
        LoadGoods_List(a);
        $('#modalRcvdStock').modal('show');
    }


    function SaveGoods() {
        /////////////////////// DATE VALIDATION //////////////
        /////////////////////// DATE VALIDATION //////////////
        var entDT = document.getElementById('txtEntryDate').value;
        T_date = new Date(entDT);
        var chkDT = chkDATE_RANGE(T_date);
        if (chkDT == "OK") {
        }
        else {
            document.getElementById('msgDT_RANGE').innerHTML = chkDT;
            $('#modalDT_RANGE').modal('show');
            return false;
        }
        /////////////////////// DATE VALIDATION //////////////
        /////////////////////// DATE VALIDATION //////////////

        var UserID = localStorage.getItem("UserID");
        var txtVoucherNo = document.getElementById('dvPONo').innerHTML;
        var ddlSupplier = "";
         
        var dd=document.getElementById('dvDate').innerHTML;
        var ss=document.getElementById('dvSupplier').innerHTML;
        var shpmntNo = document.getElementById('txtShipmentNo').value;
        var WH = document.getElementById('ContentPlaceHolder1_ddlWH').value;



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
                url: 'GOODS_RECEIVED.aspx/SaveGoods',
                //data: {},
                data: '{ "UserID" : "' + UserID + '", "str" : "' + str + '", "txtVoucherNo" : "' + txtVoucherNo + '", "ddlSupplier" : "' + ddlSupplier + '", "shpmntNo" : "' + shpmntNo + '", "WH" : "' + WH + '", "entDT" : "' + entDT + '" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    tblRows = msg.d;
                    alert('Goods has been Received Successfully!');
                    ShowPO(txtVoucherNo, dd, ss);
                    //LoadGoods_List(txtVoucherNo);
                    //window.location = 'PendingRequisitionList.aspx';
                }

            });
        }

    }


    function LoadGoods_List(a) {
        var tblRows = "";
        var UserID = localStorage.getItem("UserID");
        var POID = a;
        $.ajax({
            type: 'POST',
            url: 'GOODS_RECEIVED.aspx/LoadGoods_List',
            data: '{ "POID" : "' + POID + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                var s = msg.d;
                document.getElementById('dvGoodsLST').innerHTML = s;

            }

        });
    }

