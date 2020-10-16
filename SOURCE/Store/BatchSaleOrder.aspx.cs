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



public partial class SALES_BatchSaleOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string LoadOrders(string btchID)
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter BatchID = new SqlParameter("@BatchID", btchID);
        DataSet ds = AACommon.ReturnDatasetBySP("PR0D_ORDER_LIST", Conn, BatchID);
        List<GetTempOrders> ordList = new List<GetTempOrders>();
        ordList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetTempOrders dbdc = new GetTempOrders();

                dbdc.BatchID = ds.Tables[0].Rows[i]["BatchID"].ToString();
                dbdc.PRID = ds.Tables[0].Rows[i]["PRID"].ToString();
                dbdc.PRDate = ds.Tables[0].Rows[i]["PRDate"].ToString();
                dbdc.CustomerID = ds.Tables[0].Rows[i]["CustomerID"].ToString();
                dbdc.CustomerTitle = ds.Tables[0].Rows[i]["CustomerTitle"].ToString();
                ordList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(ordList);


    }


    public class GetTempOrders
    {
        public string BatchID { get; set; }
        public string PRID { get; set; }
        public string PRDate { get; set; }
        public string CustomerID { get; set; }
        public string CustomerTitle { get; set; }

    }


    [WebMethod]
    public static string LOAD_DATA_FOR_PRINT(string voucherID)
    {
        string summary = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        try
        {
            SqlParameter PRID = new SqlParameter("@PRID", voucherID);
            DataSet ds = AACommon.ReturnDatasetBySP("PROD_ORDER_DETAIL", con, PRID);
            DataTable dt = new DataTable();
            if (ds.Tables.Count > 0)
            { dt = ds.Tables[0]; }

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0) { summary = summary + "`"; }
                string prid = dt.Rows[i]["PRID"].ToString();
                string custID = dt.Rows[i]["AccountID"].ToString();

                string txtAccID = dt.Rows[i]["ITEMID"].ToString();
                string txtAccTitle = dt.Rows[i]["ITEMName"].ToString();
                string unitID = dt.Rows[i]["DisplayName"].ToString();
                string Qty = dt.Rows[i]["Qty"].ToString();

                string btchID = dt.Rows[i]["BatchID"].ToString();
                string entDt = dt.Rows[i]["EntryDate"].ToString();
                string cust = dt.Rows[i]["CustomerTitle"].ToString();
                string delDt = dt.Rows[i]["DeliveryDate"].ToString();


                summary = summary + prid + "~" + custID + "~" + txtAccID + "~" + txtAccTitle + "~" + unitID + "~" + Qty + "~" + btchID + "~" + entDt + "~" + cust + "~" + delDt;

            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return summary;
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
            htm = htm + "<td><a href='../Reports/SALE_DC.aspx?a=" + dt.Rows[i]["SPID"].ToString() + "' target=_blank><i class='append-icon fa fa-fw fa-search-plus'></i>View</a></td>";

            htm = htm + "</tr>";
        }
        htm = htm + "</tbody>";
        htm = htm + "</table>";
        return htm;
    }


    [WebMethod]
    public static string DELETE_ORDER_FINAL(string voucherID)
    {
        string summary = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        try
        {
            SqlParameter PRID = new SqlParameter("@PRID", voucherID);
            AACommon.Execute("PROD_ORDER_TEMP_DELETE", con, PRID);

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return summary;
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
            string dsbld = "";

            int a = i + 1;//ITEMID SOID
            htm = htm + "<tr >";
            htm = htm + "<td>" + a + "<span id='spnPO_ALL" + a + "' style='display:none'>" + itmID + "^" + untID + "^" + estPrice + "^" + totPrice + "^" + Qty + "^" + id + "^" + suppID + "</span></td>";
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
    public static string SaveGoods(string UserID, string str, string txtVoucherNo, string ddlSupplier)
    {
        string msg = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        string rqID = "";
        string rqHID = "";
        string rqDt = "";
        string rqBy = UserID;
        string rqAt = "";
        string stsID = "";// 0:Pending, 1:Approved, 2:Rejected


        ///////////////////////// ID GNERATOR /////////////////////////////
        string aa = LoadNUMBER("DC", "SP_MASTER", "SPID", Con);
        string[] idDT = aa.Split('`');
        rqID = idDT[0].ToString();
        rqDt = idDT[1].ToString();

        // rqHID = LoadHistoryID(rqID);




        /////////////////////////// INSERT in SP MASTER //////////////////
        SqlParameter SPID = new SqlParameter("@SPID", rqID);
        SqlParameter SPDate = new SqlParameter("@SPDate", rqDt);
        SqlParameter TotalAmount = new SqlParameter("@TotalAmount", "0");
        SqlParameter DiscountAmount = new SqlParameter("@DiscountAmount", "0");
        SqlParameter TaxAmount = new SqlParameter("@TaxAmount", "0");
        SqlParameter TaxRate = new SqlParameter("@TaxRate", "0");

        SqlParameter GrandTotal = new SqlParameter("@GrandTotal", "0");
        SqlParameter AccountID = new SqlParameter("@AccountID", ddlSupplier);
        SqlParameter SP = new SqlParameter("@SP", "S");
        SqlParameter OrderNo = new SqlParameter("@OrderNo", txtVoucherNo);
        AACommon.Execute("SP_MASTER_INSERT_V2", Con, SPID, SPDate, TotalAmount, DiscountAmount, TaxAmount, TaxRate, GrandTotal, AccountID, SP, OrderNo);


        /////////////////////// INSERT in SP DETAIL

        string[] itmLST = str.Split('`');
        for (int i = 0; i < itmLST.Length; i++)
        {
            string[] itmROW = itmLST[i].Split('^');
            //txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice
            string itmID = itmROW[0].ToString();
            string ddlUnit = itmROW[2].ToString();
            string txtQty = itmROW[3].ToString();
            string txtPrice = itmROW[4].ToString();
            string txtTotalPrice = itmROW[5].ToString();
            string rID = itmROW[6].ToString();

            SqlParameter SPID_1 = new SqlParameter("@SPID", rqID);
            SqlParameter ITEMID = new SqlParameter("@ITEMID", itmID);
            SqlParameter UnitID = new SqlParameter("@UnitID", ddlUnit);
            SqlParameter QtyOut = new SqlParameter("@QtyOut", txtQty);
            SqlParameter UnitPrice = new SqlParameter("@UnitPrice", txtPrice);
            SqlParameter TotalPrice = new SqlParameter("@TotalPrice", txtTotalPrice);
            SqlParameter rowID = new SqlParameter("@rowID", rID);
            AACommon.Execute("SP_DETAIL_INSERT_V2_DC", Con, SPID_1, ITEMID, UnitID, QtyOut, UnitPrice, TotalPrice, rowID);

        }



        return msg;
    }


}