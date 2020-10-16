using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Data.Sql;
using System.Web.Script.Serialization;
using System.IO;

public partial class Store_ISSUE_DC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    

    [WebMethod]
    public static string LoadPO(string UserID)
    {
        string htm = "";
        htm = htm + "<table id='tblPO' class='table table-striped table-hover no-head-border' >";
        htm = htm + "<thead class='vd_bg-dark-blue vd_white'><tr>";
        htm = htm + "<th>SO No.</th>";
        htm = htm + "<th>Date</th>";
        htm = htm + "<th>Customer</th>";
        htm = htm + "<th colspan='2'></th>";
        htm = htm + "</tr>";
        htm = htm + "</thead>";
        htm = htm + "<tbody>";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        DataSet ds = AACommon.ReturnDatasetBySP("SALE_SO_DC_V3", Con, null);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {

            htm = htm + "<tr >";
            htm = htm + "<td>" + dt.Rows[i]["SOID"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["SODate"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["CustomerTitle"].ToString() + "</td>";
            htm = htm + "<td><a href=\"javascript:ShowPO('" + dt.Rows[i]["SOID"].ToString() + "','" + dt.Rows[i]["SODate"].ToString() + "','" + dt.Rows[i]["CustomerTitle"].ToString() + "');\"><i class='append-icon fa fa-fw fa-search-plus'></i>Issue DC</a></td>";
            htm = htm + "<td><a href=\"javascript:DeletePO('" + dt.Rows[i]["SOID"].ToString() + "');\"><i class='append-icon fa fa-fw fa-times'></i>Delete</a></td>";
            htm = htm + "</tr>";
        }
        htm = htm + "</tbody>";
        htm = htm + "</table>";

        string aa = LoadNUMBER("DC", "SP_MASTER", "SPID", Con);
        string[] idDT = aa.Split('`');
        string rqDt = idDT[1].ToString();

        htm = htm + "^" + rqDt;
        return htm;
    }

    [WebMethod]
    public static string ShowPO(string UserID, string PONO)
    {
        string htm = "";
        htm = htm + "<table id='tblPO_ItemsRequisition' class='table table-striped table-bordered dataTable no-footer' >";
        htm = htm + "<thead><tr>";
        htm = htm + "<th style='width:5%'>S.#</th>";
        htm = htm + "<th style='width:50%'>Item</th>";
        htm = htm + "<th style='width:15%'>Qty.</th>";
        htm = htm + "<th style='width:15%'>Qty. Recvd.</th>";
        htm = htm + "<th style='width:15%'>Qty. Bal.</th>";
        htm = htm + "</tr>";
        htm = htm + "</thead>";
        htm = htm + "<tbody>";
        string htmMain = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter POID = new SqlParameter("@POID", PONO);
        DataSet ds = AACommon.ReturnDatasetBySP("SALE_SO_DETAIL_DC", Con, POID);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string id = dt.Rows[i]["ID"].ToString();
            string itmID = dt.Rows[i]["ITEMID"].ToString();
            string untID = dt.Rows[i]["UnitID"].ToString();
            string itmName = dt.Rows[i]["ITEMName"].ToString();
            string Qty = dt.Rows[i]["QtyIn"].ToString();
            string QtyPO = dt.Rows[i]["QtyOut"].ToString();
            string QtyRem = dt.Rows[i]["QtyRem"].ToString();
            string dspName = dt.Rows[i]["DisplayName"].ToString();
            string estPrice = dt.Rows[i]["UnitPrice"].ToString();
            string totPrice = dt.Rows[i]["TotalPrice"].ToString();
            string suppID = dt.Rows[i]["CustomerID"].ToString();

            string bMul = dt.Rows[i]["BaseMultiplier"].ToString();
            string totWt = dt.Rows[i]["TotWt"].ToString();

            string dsbld = "";
           
            int a = i + 1;//ITEMID SOID
            htm = htm + "<tr >";
            htm = htm + "<td>" + a + "<span id='spnPO_ALL" + a + "' style='display:none'>" + itmID + "^" + untID + "^" + estPrice + "^" + totPrice + "^" + Qty + "^" + id + "^" + suppID + "^" + bMul + "^" + totWt + "</span></td>";
            htm = htm + "<td>" + itmName + "</td>";
            htm = htm + "<td>" + Qty + " " + dspName + "<span id='spnPO_QTY" + a + "' style='display:none'>" + Qty + "</span></td>";
            htm = htm + "<td>" + QtyPO + " " + dspName + "<span id='spnPO_QTYPO" + a + "' style='display:none'>" + QtyPO + "</span></td>";

            if (QtyRem == "0") { dsbld = "disabled"; }
            htm = htm + "<td><input type='text' id='txtPO_QtyBal" + a + "' class='form-control' " + dsbld + " value='" + QtyRem + "'   style='width:100%; border:0px none;' /><span id='spnPO_QTYRem" + a + "' style='display:none'>" + QtyRem + "</span></td>";

            htm = htm + "</tr>";
        }
        htm = htm + "</tbody>";
        htm = htm + "</table>";
        return htm;
    }

    [WebMethod]
    public static string LoadNUMBER(string frmt, string tbl, string col, SqlConnection Con)
    {
        string vNO = "";
        string vDate = "";
        string mm1 = System.DateTime.Now.Month.ToString();
        string yy1 = System.DateTime.Now.Year.ToString();
        //SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet dsDATE = AACommon.ReturnDatasetBySP("Get_CurrentDate", Con, null);
        if (dsDATE.Tables[0].Rows.Count > 0)
        {
            mm1 = dsDATE.Tables[0].Rows[0]["MM"].ToString();
            yy1 = dsDATE.Tables[0].Rows[0]["YY"].ToString();
            vDate = mm1 + "/" + dsDATE.Tables[0].Rows[0]["DD"].ToString() + "/" + yy1;
        }
        dsDATE.Dispose();
        yy1 = Convert.ToString(Convert.ToInt32(yy1) - 2000);

        if (mm1.Length == 1) { mm1 = "0" + mm1; }
        if (yy1.Length == 1) { yy1 = "0" + yy1; }
        string format1 = frmt + "-" + mm1 + "-" + yy1 + "-";

        vNO = AACommon.GetAlphaNumericIDSIX(tbl, format1, col, Con);
        vNO = vNO + "`" + vDate;
        return vNO;
    }

    [WebMethod]
    public static string ValidateQTY(string itmStr, string ddlWH)
    {
        string msg = ""; string msgF = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        int cc = 0;
        string[] itmLST = itmStr.Split('`');
        for (int i = 0; i < itmLST.Length; i++)
        {
            string[] itmROW = itmLST[i].Split('^');
            //txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice

            if (itmROW.Length > 1)
            {
                string itmID = itmROW[0].ToString();
                string ddlUnit = itmROW[2].ToString();
                string txtQty = itmROW[3].ToString();
                string txtPrice = itmROW[4].ToString();
                string txtTotalPrice = itmROW[5].ToString();
                string rID = itmROW[6].ToString();
                string bMul = itmROW[7].ToString();
                Decimal totWT = Convert.ToDecimal( itmROW[8].ToString());
                string itmTitle = "";
                string qtySTK = AACommon.GetData("select Convert(varchar(12),Qty)+'`'+Convert(varchar(12),UPrice)+'`'+ITEMName as Fld from vwSTOCK_With_PRICE where ITEMID='" + itmID + "' and WHID='" + ddlWH + "'", Con, "Fld");

                Decimal qty = 0;

                if (qtySTK == "No") { qty = 0; }
                else
                {
                    string[] fld = qtySTK.Split('`');
                    qty = Convert.ToDecimal(fld[0]);
                    itmTitle = fld[2];

                    if (qty < totWT)
                    {
                        cc = 1;
                        msgF = msgF + ",  " + itmTitle;
                    }
                }
                
            }
        }

        if (cc == 1)
        { msg = "DC cannot be process due to out of stock. These are Items ("+ msgF+") with less stock."; }
        else
        { msg = "0"; }

        return msg;
    }

    [WebMethod]
    public static string LoadNUMBER_DT(string frmt, string tbl, string fld, string dtNew, SqlConnection Con)
    {
        string vNO = "";
        string[] vDT = dtNew.Split('/');
        string mm1 = vDT[0];//System.DateTime.Now.Month.ToString();
        string yy1 = vDT[2];//System.DateTime.Now.Year.ToString();
        yy1 = Convert.ToString(Convert.ToInt32(yy1) - 2000);
        if (mm1.Length == 1) { mm1 = "0" + mm1; }
        if (yy1.Length == 1) { yy1 = "0" + yy1; }
        string format1 = frmt + "-" + mm1 + "-" + yy1 + "-";
        vNO = AACommon.GetAlphaNumericIDSIX(tbl, format1, fld, Con);
        return vNO;
    }

    [WebMethod]
    public static string SaveGoods(string UserID, string str, string txtVoucherNo, string ddlSupplier, string drID, string drNm, string vehNo, string pmntDr, string entDt, string ddlWH)
    {
        string msg = "0";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);


        string ss=ValidateQTY(str, ddlWH);

        if (ss == "0")
        {

            string rqID = "";
            string rqHID = "";
            string rqDt = "";
            string rqBy = UserID;
            string rqAt = "";
            string stsID = "";// 0:Pending, 1:Approved, 2:Rejected


            ///////////////////////// ID GNERATOR /////////////////////////////
            string aa = LoadNUMBER_DT("DC", "SP_MASTER", "SPID", entDt, Con);
           // string aa = LoadNUMBER("DC", "SP_MASTER", "SPID", Con);
          //  string[] idDT = aa.Split('`');
            rqID = aa;// idDT[0].ToString();
          //  rqDt = idDT[1].ToString();

            // rqHID = LoadHistoryID(rqID);


            string prty = AACommon.GetData("select CustomerTitle from Customer where CustomerID='" + ddlSupplier + "'", Con, "CustomerTitle");

            /////////////////////////// INSERT in SP MASTER //////////////////
            SqlParameter SPID = new SqlParameter("@SPID", rqID);
            SqlParameter SPDate = new SqlParameter("@SPDate", entDt);
            SqlParameter TotalAmount = new SqlParameter("@TotalAmount", "0");
            SqlParameter DiscountAmount = new SqlParameter("@DiscountAmount", "0");
            SqlParameter TaxAmount = new SqlParameter("@TaxAmount", "0");
            SqlParameter TaxRate = new SqlParameter("@TaxRate", "0");

            SqlParameter GrandTotal = new SqlParameter("@GrandTotal", "0");
            SqlParameter AccountID = new SqlParameter("@AccountID", ddlSupplier);
            SqlParameter SP = new SqlParameter("@SP", "S");
            SqlParameter OrderNo = new SqlParameter("@OrderNo", txtVoucherNo);

            SqlParameter DrID = new SqlParameter("@DrID", drID);
            SqlParameter DrName = new SqlParameter("@DrName", drNm);
            SqlParameter VehNo = new SqlParameter("@VehNo", vehNo);
            SqlParameter PaymentDr = new SqlParameter("@PaymentDr", pmntDr);
            SqlParameter WHID = new SqlParameter("@WHID", ddlWH);
            AACommon.Execute("SP_MASTER_INSERT_V4", Con, SPID, SPDate, TotalAmount, DiscountAmount, TaxAmount, TaxRate, GrandTotal, AccountID, SP, OrderNo, DrID, DrName, VehNo, PaymentDr, WHID);

            //@DrID ,
            //   @DrName ,
            //   @VehNo ,
            //   @PaymentDr
            /////////////////////// INSERT in SP DETAIL
            string htmLIST = ""; Decimal totPrice = 0;
            string[] itmLST = str.Split('`');
            for (int i = 0; i < itmLST.Length; i++)
            {
                string[] itmROW = itmLST[i].Split('^');
                //txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice

                if (itmROW.Length > 1)
                {
                    string itmID = itmROW[0].ToString();
                    string txtAccTitle = AACommon.GetData("select ITEMName from ITM_ITEM where ITEMID='" + itmID + "'", Con, "ITEMName");
                    string ddlUnit = itmROW[2].ToString();
                    string txtQty = itmROW[3].ToString();
                    string txtPrice = itmROW[4].ToString();
                    Decimal txtTotalPrice = Convert.ToDecimal(txtQty) * Convert.ToDecimal(txtPrice);
                    string rID = itmROW[6].ToString();
                    string bMul = itmROW[7].ToString();
                    Decimal totWT = Convert.ToDecimal(itmROW[8].ToString());

                    SqlParameter SPID_1 = new SqlParameter("@SPID", rqID);
                    SqlParameter ITEMID = new SqlParameter("@ITEMID", itmID);
                    SqlParameter UnitID = new SqlParameter("@UnitID", ddlUnit);
                    SqlParameter QtyOut = new SqlParameter("@QtyOut", txtQty);
                    SqlParameter UnitPrice = new SqlParameter("@UnitPrice", txtPrice);
                    SqlParameter TotalPrice = new SqlParameter("@TotalPrice", txtTotalPrice);
                    SqlParameter rowID = new SqlParameter("@rowID", rID);
                    AACommon.Execute("SP_DETAIL_INSERT_V2_DC", Con, SPID_1, ITEMID, UnitID, QtyOut, UnitPrice, TotalPrice, rowID);

                    INS_ROW(itmID, rqID, totWT, ddlWH, entDt);

                    Decimal pric = Convert.ToDecimal(txtPrice) / Convert.ToDecimal(bMul);
                    if (i == 0) { htmLIST = txtAccTitle + "^" + pric + "^" + totWT + "^" + txtTotalPrice; }
                    else { htmLIST = htmLIST + "`" + txtAccTitle + "^" + pric + "^" + totWT + "^" + txtTotalPrice; }
                    totPrice = totPrice + Convert.ToDecimal(txtTotalPrice);
                }
            }


            EmailApp(rqID, entDt, prty, htmLIST, Convert.ToString(totPrice), "0", Convert.ToString(totPrice));

        }

        else
        {

            msg = ss;
        }

        return msg;
    }

    [WebMethod]
    public static string INS_ROW(string ItmID, string spID, Decimal wt, string whid, string SPDate)
    {
        string msg = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        string sql = "select * from vwAAA_QTY_IN where ITEMID='" + ItmID + "' and WHID='" + whid + "' and RemWT>0 order by ID";
        SqlDataAdapter da = new SqlDataAdapter(sql, Con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (wt > 0)
            {
                string Itm_ID = dt.Rows[i]["ITEMID"].ToString();
                string spDID = dt.Rows[i]["ID"].ToString();
                string shpmnet = dt.Rows[i]["ShipmentNo"].ToString();
                string UPrice = dt.Rows[i]["UPrice"].ToString();
                Decimal RemWT = Convert.ToDecimal(dt.Rows[i]["RemWT"].ToString());

                // reqWT=500  remWT=300
                Decimal avldWT = 0;

                if (wt >= RemWT)
                {
                    avldWT = RemWT;
                }
                else
                {
                    avldWT = wt;
                }

                SqlParameter BatchID = new SqlParameter("@BatchID", shpmnet);
                SqlParameter ITEMID = new SqlParameter("@ITEMID", Itm_ID);
                SqlParameter SPDetailID = new SqlParameter("@SPDetailID", spDID);
                SqlParameter SPID = new SqlParameter("@SPID", spID);
                SqlParameter Qty = new SqlParameter("@Qty", avldWT);
                SqlParameter UnitPrice = new SqlParameter("@UnitPrice", UPrice);
                SqlParameter IssueDate = new SqlParameter("@IssueDate", SPDate);
                AACommon.Execute("Batch_Costing_Detail_INSERT", Con, BatchID, ITEMID, SPDetailID, SPID, Qty, UnitPrice, IssueDate);
                //insert into Batch_Costing_Detail (wt,ItmID) values()
                wt = wt - avldWT;//500-300
            }

        }

        return msg;
    }

    [WebMethod]
    public static string LoadGoods_List(string POID)
    {
        string htm = "";
        htm = htm + "<table id='tblGoodsReceived' class='table table-striped table-hover no-head-border' >";
        htm = htm + "<thead class='vd_bg-dark-blue vd_white'><tr>";
        htm = htm + "<th>DC No.</th>";
        htm = htm + "<th>Date</th>";
        htm = htm + "<th>Total Qty.</th>";
        htm = htm + "<th colspan='1'></th>";
        htm = htm + "</tr>";
        htm = htm + "</thead>";
        htm = htm + "<tbody>";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter OrderNo = new SqlParameter("@OrderNo", POID);
        DataSet ds = AACommon.ReturnDatasetBySP("WH_RECEIVED_GOODS", Con, OrderNo);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {

            htm = htm + "<tr >";
            htm = htm + "<td>" + dt.Rows[i]["SPID"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["SPDate"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["TotQty"].ToString() + "</td>";
            //htm = htm + "<td><a href='../Reports/SALE_DC.aspx?a=" + dt.Rows[i]["SPID"].ToString() + "' target=_blank><i class='append-icon fa fa-fw fa-search-plus'></i>View</a></td>";
            htm = htm + "<td><a href='../Reports/SALE_DC.aspx?sDT=0&eDt=0&a=" + dt.Rows[i]["SPID"].ToString() + "' target=_blank><i class='append-icon fa fa-fw fa-search-plus'></i>View</a></td>";
            htm = htm + "</tr>";
        }
        htm = htm + "</tbody>";
        htm = htm + "</table>";
        return htm;
    }


    [WebMethod]
    public static string EmailApp(string tID, string tDT, string prty, string htmITMS, string tot, string tx, string grndTOT)
    {
        string htm = "";

        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter EmailType = new SqlParameter("@EmailType", "DC GEN");
        DataSet ds = AACommon.ReturnDatasetBySP("Email_List", Con, EmailType);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {

            string UserName = dt.Rows[i]["UserName"].ToString();
            string email = dt.Rows[i]["UserEmail"].ToString();

            EmailClass.SendEmail(tID, tDT, "Kashif Trading", UserName, "Delivery Challan", prty, "Item", "Unit Price", "Total Wt.", "Total Price", htmITMS, tot, tx, grndTOT, "02134590932", "info@kashiftrading.com", "www.kashiftrading.com", "Khayaban e Ittehad DHA 6 Karachi", email, "Issuance of Delivery Challan");


        }

        return htm;
    }

}