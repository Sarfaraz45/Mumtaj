
LOAD_ITEMS();
LOAD_ITEMSM();

    function ValidateRow() {
        var accList = document.getElementById('ContentPlaceHolder1_hdnItems').value;
        accList = accList.replace("[", "");
        accList = accList.replace("]", "");
        accList = accList.replace(/"/g, '');

        var accArray = accList.split(',');

        var cc = 0; var ccDbCR = 0; var ccDate = 0;

      


        var elm = {};
        var elms = document.getElementById('tblItems').getElementsByTagName("input");
        for (var i = 0; i < elms.length; i++) {
            if (elms[i].id.indexOf('txtAccCode') != -1) {

                elm = elms[i];
                var iD = elm.id;
                var txtAccCodeID = iD;
                var txtAccCode = document.getElementById(txtAccCodeID).value;

                

                ////////////////////////////ACCOUNT LIST Checking
                if (accArray.indexOf(txtAccCode) == -1) {

                    document.getElementById(txtAccCodeID).style.background = 'red';
                    // txtAccCodeID.style.background = 'red';background:red
                    cc = 1;
                }
                else {
                    document.getElementById(txtAccCodeID).style.background = 'white';
                }


            }
        }

        var msg = cc + '|' + ccDbCR;//  + '|' + ccDate; //1+2+3
        return msg;

    }

    function ValidateRowM() {
        var accList = document.getElementById('ContentPlaceHolder1_hdnItemsM').value;
        accList = accList.replace("[", "");
        accList = accList.replace("]", "");
        accList = accList.replace(/"/g, '');

        var accArray = accList.split(',');

        var cc = 0; var ccDbCR = 0; var ccDate = 0;




        var elm = {};
        var elms = document.getElementById('tblItemsM').getElementsByTagName("input");
        for (var i = 0; i < elms.length; i++) {
            if (elms[i].id.indexOf('txtAccCodeM') != -1) {

                elm = elms[i];
                var iD = elm.id;
                var txtAccCodeID = iD;
                var txtAccCode = document.getElementById(txtAccCodeID).value;



                ////////////////////////////ACCOUNT LIST Checking
                if (accArray.indexOf(txtAccCode) == -1) {

                    document.getElementById(txtAccCodeID).style.background = 'red';
                    // txtAccCodeID.style.background = 'red';background:red
                    cc = 1;
                }
                else {
                    document.getElementById(txtAccCodeID).style.background = 'white';
                }


            }
        }

        var msg = cc + '|' + ccDbCR;//  + '|' + ccDate; //1+2+3
        return msg;

    }

    function addRow() {

        /////////////////////// VALIDATION START
        var cc = ValidateRow();
        if (cc == '1') {
            alert("Item Does not exist in Highlighted Rows! ");
            return false;
        }
//        else if (cc == '0|1|0') {
//            alert("Dr. Cr. Invalid in Highlighted Rows! ");
//            return false;
//        }
//        else if (cc == '1|1|0') {
//            alert("Account Does not exist & Dr. Cr. Invalid in Highlighted Rows! ");
//            return false;
//        }
//        else if (cc == '1|1|1') {
//            alert("Account Does not exist , Dr. Cr. & Date are Invalid in Highlighted Rows! ");
//            return false;
//        }
//        else if (cc == '0|0|1') {
//            alert("Date is Invalid in Highlighted Rows! ");
//            return false;
//        }
//        else if (cc == '0|1|1') {
//            alert("Dr. Cr. & Date are Invalid in Highlighted Rows! ");
//            return false;
//        }
//        else if (cc == '1|0|1') {
//            alert("Account Does not exist & Date are Invalid in Highlighted Rows! ");
//            return false;
//        }
        /////////////////////// VALIDATION END

        //SumDbCr();
        var table = document.getElementById('tblItems');

        var rowCount = table.rows.length;
        var row = table.insertRow(rowCount);
        var newID = parseFloat(rowCount);

        var cell1 = row.insertCell(0);
        var txtSr = document.createElement("input");
        txtSr.type = "text";
        txtSr.id = "txtSr" + newID;
        txtSr.value = newID;
        txtSr.className = 'form-control';
        txtSr.style.width = '100%';
        txtSr.style.border = '0px none';
        txtSr.disabled = true;
        cell1.appendChild(txtSr);

        var cell2 = row.insertCell(1);
        var txtAccCode = document.createElement("input");
        txtAccCode.type = "text";
        txtAccCode.id = "txtAccCode" + newID;
        txtAccCode.className = 'span6 typeahead form-control'; //data-source
        txtAccCode.style.width = '100%';
        txtAccCode.style.border = '0px none';
        txtAccCode.dataset.provide = "typeahead";
        txtAccCode.dataset.source = document.getElementById('ContentPlaceHolder1_hdnItems').value;
        cell2.appendChild(txtAccCode);
        document.getElementById("txtAccCode" + newID).setAttribute("autocomplete", "off");


        var cell3 = row.insertCell(2); //txtQty
        var txtWt = document.createElement("input");
        txtWt.type = "text";
        txtWt.id = "txtWt" + newID;
        txtWt.className = 'form-control';
        txtWt.style.width = '100%';
        txtWt.style.border = '0px none';
        txtWt.value = '1';
        cell3.appendChild(txtWt);
        document.getElementById("txtWt" + newID).setAttribute("autocomplete", "off");

       




        

    }
    function addRowM() {

        /////////////////////// VALIDATION START
        var cc = ValidateRowM();
        if (cc == '1') {
            alert("Item Does not exist in Highlighted Rows! ");
            return false;
        }
        
        var table = document.getElementById('tblItemsM');

        var rowCount = table.rows.length;
        var row = table.insertRow(rowCount);
        var newID = parseFloat(rowCount);

        var cell1 = row.insertCell(0);
        var txtSr = document.createElement("input");
        txtSr.type = "text";
        txtSr.id = "txtSrM" + newID;
        txtSr.value = newID;
        txtSr.className = 'form-control';
        txtSr.style.width = '100%';
        txtSr.style.border = '0px none';
        txtSr.disabled = true;
        cell1.appendChild(txtSr);

        var cell2 = row.insertCell(1);
        var txtAccCode = document.createElement("input");
        txtAccCode.type = "text";
        txtAccCode.id = "txtAccCodeM" + newID;
        txtAccCode.className = 'span6 typeahead form-control'; //data-source
        txtAccCode.style.width = '100%';
        txtAccCode.style.border = '0px none';
        txtAccCode.dataset.provide = "typeahead";
        txtAccCode.dataset.source = document.getElementById('ContentPlaceHolder1_hdnItemsM').value;
        cell2.appendChild(txtAccCode);
        document.getElementById("txtAccCodeM" + newID).setAttribute("autocomplete", "off");


        var cell3 = row.insertCell(2); //txtQty
        var txtWt = document.createElement("input");
        txtWt.type = "text";
        txtWt.id = "txtWtM" + newID;
        txtWt.className = 'form-control';
        txtWt.style.width = '100%';
        txtWt.style.border = '0px none';
        txtWt.value = '1';
        cell3.appendChild(txtWt);
        document.getElementById("txtWtM" + newID).setAttribute("autocomplete", "off");


        var cell33 = row.insertCell(3); //txtQty
        var txtWg = document.createElement("input");
        txtWg.type = "text";
        txtWg.id = "txtWgM" + newID;
        txtWg.className = 'form-control';
        txtWg.style.width = '100%';
        txtWg.style.border = '0px none';
        txtWg.value = '0';
        cell33.appendChild(txtWg);
        document.getElementById("txtWgM" + newID).setAttribute("autocomplete", "off");








    }

    function fillUNITS(a){
        var txtAccCodeID = a.id;
        var ddlUnitID = txtAccCodeID.replace('txtAccCode', 'ddlUnit');

        var txtAccCode = document.getElementById(txtAccCodeID).value;
        var splt = txtAccCode.split('^');
        var accID = splt[0];
        var itmID = accID.replace(/\s/g, '');

        var spnID = 'spnUNT' + itmID;


        var ddlUnit = document.getElementById(ddlUnitID);

        var pp = document.getElementById(spnID).innerHTML;
        //alert(pp);
        var pList = pp.split('~');
        for (var i = 0; i < pList.length; i++) {
            var pItems = pList[i].split('^');
            ddlUnit.appendChild(new Option(pItems[1], pItems[0] + '`' + pItems[2]));
        }

    }

    function LOAD_ITEMS() {

        var tblRows = "";
        var UserID = "1";
        $.ajax({
            type: 'POST',
            url: 'WH_Transfer2.aspx/LOAD_ITEMS',
            data: '{ "UserID" : "' + UserID + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                var s = msg.d.split('`');
                tblRows = s[0];
                document.getElementById('txtVoucherNo').value = s[1];
                var b = tblRows.replace(/'/g, '"');
                document.getElementById('ContentPlaceHolder1_hdnItems').value = b;
                txtAccCode = document.getElementById('txtAccCode1');
                txtAccCode.dataset.source = document.getElementById('ContentPlaceHolder1_hdnItems').value;
                document.getElementById('ContentPlaceHolder1_hdnDate').value = s[2];
                document.getElementById('datepicker-autoClose').value = s[2];
                //document.getElementById('dvUnits').innerHTML = s[3];


                //var cust = s[4];
                //var bb = cust.replace(/'/g, '"');
                //document.getElementById('ContentPlaceHolder1_hdnSupplier').value = bb;
                //txtSupplier = document.getElementById('txtSupplier');
                //txtSupplier.dataset.source = document.getElementById('ContentPlaceHolder1_hdnSupplier').value;

            }

        });
    }

    function LOAD_ITEMSM() {

        var tblRows = "";
        var UserID = "1";
        $.ajax({
            type: 'POST',
            url: 'WH_Transfer2.aspx/LOAD_ITEMSM',
            data: '{ "UserID" : "' + UserID + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                var s = msg.d.split('`');
                tblRows = s[0];
                document.getElementById('txtVoucherNo').value = s[1];
                var b = tblRows.replace(/'/g, '"');
                document.getElementById('ContentPlaceHolder1_hdnItemsM').value = b;
                txtAccCode = document.getElementById('txtAccCodeM1');
                txtAccCode.dataset.source = document.getElementById('ContentPlaceHolder1_hdnItemsM').value;
                document.getElementById('ContentPlaceHolder1_hdnDate').value = s[2];
                document.getElementById('datepicker-autoClose').value = s[2];
                

            }

        });
    }

    function tot(a) {
        var QtyID = ''; //txtQty1
        var PriceID = ''; //txtPrice1
        var totPriceID = ''; //txtTotalPrice1
        var wtID = '';
        var ddlUnitID = '';

        var thisID = a.id;
        if (thisID.indexOf('txtQty') != -1) {
            QtyID = thisID;
            PriceID = thisID.replace('txtQty', 'txtPrice');
            totPriceID = thisID.replace('txtQty', 'txtTotalPrice');
            ddlUnitID = thisID.replace('txtQty', 'ddlUnit');
            wtID = thisID.replace('txtQty', 'txtWt');
        }
        else if (thisID.indexOf('txtPrice') != -1) {
            QtyID = thisID.replace('txtPrice', 'txtQty');
            PriceID = thisID;
            totPriceID = thisID.replace('txtPrice', 'txtTotalPrice');
            ddlUnitID = thisID.replace('txtPrice', 'ddlUnit');
            wtID = thisID.replace('txtPrice', 'txtWt');
        }
        else if (thisID.indexOf('txtTotalPrice') != -1) {
            QtyID = thisID.replace('txtTotalPrice', 'txtQty');
            PriceID = thisID.replace('txtTotalPrice', 'txtPrice');
            ddlUnitID = thisID.replace('txtTotalPrice', 'ddlUnit');
            wtID = thisID.replace('txtTotalPrice', 'txtWt');
            totPriceID = thisID;
        }

        var Qty = document.getElementById(QtyID).value; //txtQty1
        var Price = document.getElementById(PriceID).value; //txtPrice1
        var totPrice = document.getElementById(totPriceID).value;

        var ddlUnit = document.getElementById(ddlUnitID).value;
        var mul = ddlUnit.split('`');
        var basMul = mul[1];

        if (Qty == "" || Qty == null) { Qty = 0; }
        if (Price == "" || Price == null) { Price = 0; }
        if (totPrice == "" || totPrice == null) { totPrice = 0; }
        document.getElementById(wtID).value = parseFloat(Qty) * parseFloat(basMul);
        document.getElementById(totPriceID).value = parseFloat(document.getElementById(wtID).value) * parseFloat(Price);

    }




    function SaveTransaction() {
        /////////////////////// DATE VALIDATION //////////////
        /////////////////////// DATE VALIDATION ////////////// 
        var txtVDate = document.getElementById('datepicker-autoClose').value;
        T_date = new Date(txtVDate);
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

        /////////////////////// VALIDATION START
        /////////////////////// VALIDATION START
       
        var cc = ValidateRow();
        if (cc == '0|1') {
            alert("Suplier does not exist! ");
            return false;
        }
        else if (cc == '1|1') {
            alert("Supplier & Item Does not exist in Highlighted Rows! ");
            return false;
        }
        else if (cc == '1|0') {
            alert("Item Does not exist in Highlighted Rows! ");
            return false;
        }


        var ccM = ValidateRowM();
        if (ccM == '0|1') {
            alert("Suplier does not exist! ");
            return false;
        }
        else if (ccM == '1|1') {
            alert("Supplier & Item Does not exist in Highlighted Rows! ");
            return false;
        }
        else if (ccM == '1|0') {
            alert("Item Does not exist in Highlighted Rows! ");
            return false;
        }

        /////////////////////// VALIDATION END

        var UserID = localStorage.getItem("UserID");
        var JOB = localStorage.getItem("JOB");
        var txtVoucherNo = document.getElementById('txtVoucherNo').value;
        var ddlTransferFrom = document.getElementById('ContentPlaceHolder1_ddlTransferFrom').value;
        var ddlTransferTo = document.getElementById('ContentPlaceHolder1_ddlTransferTo').value;

      

        var elm = {}; var tMarks = 0;
        var elms = document.getElementById('tblItems').getElementsByTagName("input");
        var str = ""; var cc = 0;
        for (var i = 0; i < elms.length; i++) {
            if (elms[i].id.indexOf('txtAccCode') != -1) {

                elm = elms[i];
                var iD = elm.id;
                var txtAccCodeID = iD;
                var txtWtID = iD.replace('txtAccCode', 'txtWt');

                var txtAccCode = document.getElementById(txtAccCodeID).value;
                var splt = txtAccCode.split('^');
                var accID = splt[0];
                var accTitle = splt[1];
                var txtAccID = accID.replace(/\s/g, '');

                
                var txtWt = document.getElementById(txtWtID).value;

                if (txtWt == "" || txtWt == null) { txtWt = 0; }

                if (txtWt != 0) {
                    if (cc == 0) {
                        str = txtAccID + "^" + txtWt + "^" + accTitle;
                    }
                    else {
                        str = str + "`" + txtAccID + "^" + txtWt + "^" + accTitle;
                    }
                }

                cc = 1;


            }
            else {

            }
        }



        var elmM = {}; var tMarkMs = 0;
        var elmsM = document.getElementById('tblItemsM').getElementsByTagName("input");
        var strM = ""; var ccM = 0;
        for (var i = 0; i < elmsM.length; i++) {
            if (elmsM[i].id.indexOf('txtAccCodeM') != -1) {

                elmM = elmsM[i];
                var iDM = elmM.id;
                var txtAccCodeIDM = iDM;
                var txtWtIDM = iDM.replace('txtAccCodeM', 'txtWtM');
                var txtWgIDM = iDM.replace('txtAccCodeM', 'txtWgM');

                var txtAccCodeM = document.getElementById(txtAccCodeIDM).value;
                var spltM = txtAccCodeM.split('^');
                var accIDM = spltM[0];
                var accTitleM = spltM[1];
                var txtAccIDM = accIDM.replace(/\s/g, '');


                var txtWtM = document.getElementById(txtWtIDM).value;
                var txtWgM = document.getElementById(txtWgIDM).value;

                if (txtWtM == "" || txtWtM == null) { txtWtM = 0; }

                if (txtWtM != 0) {
                    if (ccM == 0) {
                        strM = txtAccIDM + "^" + txtWtM + "^" + accTitleM + "^" + txtWgM;
                    }
                    else {
                        strM = strM + "`" + txtAccIDM + "^" + txtWtM + "^" + accTitleM + "^" + txtWgM;
                    }
                }

                ccM = 1;


            }
            else {

            }
        }

        
        if (cc > 0) {
            $.ajax({
                type: 'POST',
                url: 'WH_Transfer2.aspx/SaveGoods',
                //data: {},
                data: '{ "UserID" : "' + UserID + '", "str" : "' + str + '", "txtVDate" : "' + txtVDate + '", "txtVoucherNo" : "' + txtVoucherNo + '", "ddlTransferFrom" : "' + ddlTransferFrom + '", "ddlTransferTo" : "' + ddlTransferTo + '", "JOB" : "' + JOB + '", "strM" : "' + strM + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    tblRows = msg.d;
                    alert(tblRows);
                    //window.location='RequistionLIST.aspx';
                    location.reload();
                }

            });
        }

    }

    function ClearForm() {
        // LOAD_ACCOUNTS();
        // LOAD_PROJECTS();
        var tblItems = document.getElementById('tblItems');
        var rowCount = tblItems.rows.length;
        for (var i = rowCount - 2; i > 0; i--) {
            tblItems.deleteRow(i);
        }
        //        var elmtTable = document.getElementById('tblItems');
        //        var tableRows = elmtTable.getElementsByTagName('tr');
        //        var rowCount = tableRows.length;
        //       
        //        for (var x = 0; x < rowCount; x++) {
        //            if (x == 1 || x == 0) { }
        //            else {
        //                document.getElementById("tblItems").deleteRow(x);
        //            }
        //        }

    }
