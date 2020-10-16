﻿using System;
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

public partial class Store_WH_Transfer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static string LoadNUMBER(string frmt)
    {
        string vNO = "";
        string vDate = "";
        string mm1 = System.DateTime.Now.Month.ToString();
        string yy1 = System.DateTime.Now.Year.ToString();
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
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

        vNO = AACommon.GetAlphaNumericIDSIX("SP_MASTER", format1, "SPID", Con);
        vNO = vNO + "`" + vDate;
        return vNO;
    }


    [WebMethod]
    public static string LoadHistoryID(string frmt)
    {
        string vNO = "";
        
        string format1 = frmt + "-" ;
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        vNO = AACommon.GetAlphaNumericIDSIX("PROC_REQUISITION_HISTORY", format1, "ReqHID", Con);
        
        return vNO;
    }

    [WebMethod]
    public static string LOAD_ITEMS(string UserID)
    {

        string acc = ""; string htmUNT = "";
        string query = "SELECT ITEMID, ITEMID+ ' ^ ' +ITEMName as ITEMName, ItemCode,UnitTypeID FROM ITM_ITEM WHERE ([IsDelete] = '0')";
        string Con = ConfigurationManager.ConnectionStrings["Con"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter(query, Con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        for (int i = 1; i <= dt.Rows.Count; i++)
        {
            string itmID = dt.Rows[i - 1]["ITEMID"].ToString();
            string UntTyp = dt.Rows[i - 1]["UnitTypeID"].ToString();
            //'["Karachi","Hyderabad","USA","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky"]'
            if (i == 1)
            { acc = acc + "['" + dt.Rows[i - 1]["ITEMName"].ToString() + "'"; }
            else if (i != 1 && i < dt.Rows.Count)
            { acc = acc + ",'" + dt.Rows[i - 1]["ITEMName"].ToString() + "'"; }
            else
            { acc = acc + ",'" + dt.Rows[i - 1]["ITEMName"].ToString() + "']"; }

            //htmUNT = htmUNT+LoadUNITS(itmID, UntTyp);
        }
        acc = acc + "`" + LoadNUMBER("WT") ;
        return acc;
    }

    [WebMethod]
    public static string LOAD_Supplier()
    {

        string acc = "";
        string query = "SELECT [SupplierID],[SupplierTitle] + '^' + [SupplierID] AS SupplierTitle FROM [Supplier] where ISDELETE='0'";
        string Con = ConfigurationManager.ConnectionStrings["Con"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter(query, Con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        for (int i = 1; i <= dt.Rows.Count; i++)
        {
            //'["Karachi","Hyderabad","USA","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky"]'
            if (i == 1)
            { acc = acc + "['" + dt.Rows[i - 1]["SupplierTitle"].ToString() + "'"; }
            else if (i != 1 && i < dt.Rows.Count)
            { acc = acc + ",'" + dt.Rows[i - 1]["SupplierTitle"].ToString() + "'"; }
            else
            { acc = acc + ",'" + dt.Rows[i - 1]["SupplierTitle"].ToString() + "']"; }

            //acc = acc + "!" + dt.Rows[i-1]["AccountTitle"].ToString();
        }

        return acc;
    }


    [WebMethod]
    public static string LoadUNITS(string itmID, string UntTyp)
    {
        string vUNT = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UnitTypeID = new SqlParameter("@UnitTypeID", UntTyp);
        DataSet ds = AACommon.ReturnDatasetBySP("ITM_UNITS_GET", Con, UnitTypeID);
        vUNT = "<span id='spnUNT" + itmID + "' style='display:none;'>";
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++ )
        {
            if (i == 0)
            {
                vUNT = vUNT + ds.Tables[0].Rows[i]["UnitID"].ToString() + "^" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + "^" + ds.Tables[0].Rows[i]["BaseMultiplier"].ToString();
            }
            else
            {
                vUNT = vUNT + "~" + ds.Tables[0].Rows[i]["UnitID"].ToString() + "^" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + "^" + ds.Tables[0].Rows[i]["BaseMultiplier"].ToString();
            }
            
        }
        ds.Dispose();
        vUNT = vUNT + "</span>";
        return vUNT;
    }

    [WebMethod]
    public static string LoadNUMBER_DT(string frmt, string dtNew)
    {
        string vNO = "";
        string vDate = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        string[] vDT = dtNew.Split('/');
        string mm1 = vDT[0];//System.DateTime.Now.Month.ToString();
        string yy1 = vDT[2];//System.DateTime.Now.Year.ToString();

        yy1 = Convert.ToString(Convert.ToInt32(yy1) - 2000);

        if (mm1.Length == 1) { mm1 = "0" + mm1; }
        if (yy1.Length == 1) { yy1 = "0" + yy1; }
        string format1 = frmt + "-" + mm1 + "-" + yy1 + "-";

        vNO = AACommon.GetAlphaNumericIDSIX("SP_MASTER", format1, "SPID", Con);
        return vNO;
    }

    [WebMethod]
    public static string SaveGoods(string UserID, string str, string txtVDate, string txtVoucherNo, string ddlTransferFrom, string ddlTransferTo, string JOB)
    {
        string msg = "";
        string msgT = "";
        string msgF = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        string rqID = "";
        string rqHID = "";
        string rqDt = "";
        string rqBy = UserID;
        string rqAt = "";
        string stsID = "";// 0:Pending, 1:Approved, 2:Rejected


        ///////////////////////// ID GNERATOR /////////////////////////////
        string aa = LoadNUMBER_DT("WT", txtVDate);
        //string[] idDT = aa.Split('`');
        string spid_FROM = aa;// idDT[0].ToString();

        // rqHID = LoadHistoryID(rqID);




        /////////////////////////// INSERT in SP MASTER //////////////////
        //from WareHouse
        SqlParameter SPID = new SqlParameter("@SPID", spid_FROM);
        SqlParameter SPDate = new SqlParameter("@SPDate", txtVDate);
        SqlParameter TotalAmount = new SqlParameter("@TotalAmount", "0");
        SqlParameter DiscountAmount = new SqlParameter("@DiscountAmount", "0");
        SqlParameter TaxAmount = new SqlParameter("@TaxAmount", "0");
        SqlParameter TaxRate = new SqlParameter("@TaxRate", "0");

        SqlParameter GrandTotal = new SqlParameter("@GrandTotal", "0");
        SqlParameter AccountID = new SqlParameter("@AccountID", "0");
        SqlParameter SP = new SqlParameter("@SP", "S");
        SqlParameter OrderNo = new SqlParameter("@OrderNo", "0");

        SqlParameter WHID = new SqlParameter("@WHID", ddlTransferFrom);
        SqlParameter ShipmentNo = new SqlParameter("@ShipmentNo", "0");
        SqlParameter JobID = new SqlParameter("@JobID", JOB);
        AACommon.Execute("SP_MASTER_INSERT_V3", Con, SPID, SPDate, TotalAmount, DiscountAmount, TaxAmount, TaxRate, GrandTotal, AccountID, SP, OrderNo, WHID, ShipmentNo,JobID);
            //////////////////////////////
        //To WareHouse
        string aa1 = LoadNUMBER_DT("WT", txtVDate);
       // string[] idDT_1 = aa1.Split('`');
        string spid_TO = aa1;// idDT_1[0].ToString();
        SqlParameter SPID_A = new SqlParameter("@SPID", spid_TO);
        SqlParameter SPDate_A = new SqlParameter("@SPDate", txtVDate);
        SqlParameter TotalAmount_A = new SqlParameter("@TotalAmount", "0");
        SqlParameter DiscountAmount_A = new SqlParameter("@DiscountAmount", "0");
        SqlParameter TaxAmount_A = new SqlParameter("@TaxAmount", "0");
        SqlParameter TaxRate_A = new SqlParameter("@TaxRate", "0");

        SqlParameter GrandTotal_A = new SqlParameter("@GrandTotal", "0");
        SqlParameter AccountID_A = new SqlParameter("@AccountID", "0");
        SqlParameter SP_A = new SqlParameter("@SP", "P");
        SqlParameter OrderNo_A = new SqlParameter("@OrderNo", "0");

        SqlParameter WHID_A = new SqlParameter("@WHID", ddlTransferTo);
        SqlParameter ShipmentNo_A = new SqlParameter("@ShipmentNo", "0");
        SqlParameter JobID2 = new SqlParameter("@JobID", JOB);
        AACommon.Execute("SP_MASTER_INSERT_V3", Con, SPID_A, SPDate_A, TotalAmount_A, DiscountAmount_A, TaxAmount_A, TaxRate_A, GrandTotal_A, AccountID_A, SP_A, OrderNo_A, WHID_A, ShipmentNo_A,JobID2);


        /////////////////////// INSERT in SP DETAIL
        int cc = 0;
        string[] itmLST = str.Split('`');
        for (int i = 0; i < itmLST.Length; i++)
        {
            string[] itmROW = itmLST[i].Split('^');
            //txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice
            if (itmROW.Length > 1)
            {
                string itmID = itmROW[0].ToString();
                Decimal txtWt = Convert.ToDecimal(itmROW[1].ToString());
                string itmTitle = itmROW[2].ToString();

                string qtySTK = AACommon.GetData("select Convert(varchar(12),Qty)+'`'+Convert(varchar(12),UPrice)+'`'+UnitID as Fld from vwSTOCK_With_PRICE where ITEMID='" + itmID + "' and WHID='" + ddlTransferFrom + "'", Con, "Fld");
                Decimal qty = 0;
                string unt = "";
                Decimal uPrice = 0;
                Decimal totPrice = 0;

                if (qtySTK == "No") { qty = 0; }
                else {
                    string[] fld = qtySTK.Split('`');
                    qty = Convert.ToDecimal(fld[0]);
                    uPrice = Convert.ToDecimal(fld[1]);
                    unt = fld[2];
                    totPrice = Convert.ToDecimal(txtWt) * uPrice;
                }

                if (qty >= txtWt)
                {

                    //SqlParameter SPID_FROM = new SqlParameter("@SPID_FROM", spid_FROM);
                    //SqlParameter SPID_TO = new SqlParameter("@SPID_TO", spid_TO);
                    //SqlParameter ITEMID = new SqlParameter("@ITEMID", itmID);
                    //SqlParameter UnitID = new SqlParameter("@UnitID", unt);
                    //SqlParameter QtyIn = new SqlParameter("@QtyIn", txtWt);
                    //SqlParameter UnitPrice = new SqlParameter("@UnitPrice", uPrice);
                    //SqlParameter TotalPrice = new SqlParameter("@TotalPrice", totPrice);
                    //AACommon.Execute("SP_DETAIL_INSERT_V2_2", Con, SPID_FROM, SPID_TO, ITEMID, UnitID, QtyIn, UnitPrice, TotalPrice);

                    INS_ROW(itmID, spid_TO,spid_FROM, txtWt, ddlTransferFrom,JOB);
                    cc = 1;
                }
                else
                {
                    msgF = msgF +",  "+ itmTitle;
                    //qty less
                }
            }
        }


        if (cc == 0)
        {
            SqlParameter SPID_FF = new SqlParameter("@SPID_FF", spid_FROM);
            SqlParameter SPID_TT = new SqlParameter("@SPID_TT", spid_TO);
            AACommon.Execute("SP_MASTER_DELETE_WH",Con, SPID_FF, SPID_TT);

        }


        if (cc == 1 && msgF == "")
        {
            msg = "All items has been transfered successfully";
        }
        else if (cc == 0 && msgF != "")
            {
                msg = "Items unable to transfer due to out of stock";
            }
        else if (cc == 1 && msgF != "")
        {
            msg = "Some Items has been moved successfully, these items ("+msgF+") unable to transfer due to out of stock";
        }
        return msg;
    }

    [WebMethod]
    public static string INS_ROW(string ItmID, string spID_To, string spID_From, Decimal wt, string whid,string JOB)
    {
        string msg = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        string sql = "select * from vwAAA_QTY_IN where ITEMID='" + ItmID + "' and WHID='" + whid + "' and RemWT>0 order by SPDate";
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
                string unitID = dt.Rows[i]["BaseUnitID"].ToString();
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


                   Decimal totPrice = Convert.ToDecimal(UPrice) * avldWT;
                   SqlParameter SPID_FROM_1 = new SqlParameter("@SPID_FROM", spID_From);
                    SqlParameter SPID_TO_1 = new SqlParameter("@SPID_TO", spID_To);
                    SqlParameter ITEMID_1 = new SqlParameter("@ITEMID", Itm_ID);
                    SqlParameter UnitID_1 = new SqlParameter("@UnitID", unitID);
                    SqlParameter QtyIn_1 = new SqlParameter("@QtyIn", avldWT);
                    SqlParameter UnitPrice_1 = new SqlParameter("@UnitPrice", UPrice);
                    SqlParameter TotalPrice_1 = new SqlParameter("@TotalPrice", totPrice);
                    SqlParameter JobID = new SqlParameter("@JobID", JOB);
                    AACommon.Execute("SP_DETAIL_INSERT_V2_2", Con, SPID_FROM_1, SPID_TO_1, ITEMID_1, UnitID_1, QtyIn_1, UnitPrice_1, TotalPrice_1,JobID);

                wt = wt - avldWT;//500-300
            }

        }

        return msg;
    }




    [WebMethod]
    public static string EmailApp()
    {
        string htm = "";

        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet ds = AACommon.ReturnDatasetBySP("Email_List_PURCHASE_REQ", Con, null);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            
            string UserName = dt.Rows[i]["UserName"].ToString();
            string email = dt.Rows[i]["email"].ToString();

            SqlParameter UName = new SqlParameter("@UName", UserName);
            SqlParameter Email = new SqlParameter("@Email", email);
            AACommon.Execute("PROC_REQUISITION_EMAIL", Con, UName, Email);


        }

        return htm;
    }

}