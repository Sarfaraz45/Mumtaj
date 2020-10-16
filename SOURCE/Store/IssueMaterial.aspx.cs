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

public partial class ERP_ITM_material : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    //public static string LoadRegion(string SID)
   public static string LoadRegion()
   {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("SELECT        dbo.Store_Issuance.StoreID, CONVERT(Nvarchar(20), dbo.Store_Issuance.OrderDate, 106) AS OrderDate, dbo.Store_Issuance.ITEMID, dbo.ITM_ITEM.ITEMName, dbo.Store_Issuance.UnitID, dbo.ITM_UNIT_TYPE.UnitTypeDesc, dbo.ITM_UNIT.DisplayName, dbo.Store_Issuance.Qty, dbo.Store_Issuance.Availed, dbo.Store_Issuance.Balance, dbo.Store_Issuance.BatchCode, dbo.Store_Issuance.IsIssue,dbo.Store_Issuance.ProductID FROM            dbo.Store_Issuance INNER JOIN dbo.ITM_ITEM ON dbo.Store_Issuance.ITEMID = dbo.ITM_ITEM.ITEMID INNER JOIN dbo.ITM_UNIT_TYPE ON dbo.ITM_ITEM.UnitTypeID = dbo.ITM_UNIT_TYPE.UnitTypeID INNER JOIN dbo.ITM_UNIT ON dbo.ITM_UNIT_TYPE.UnitTypeID = dbo.ITM_UNIT.UnitTypeID WHERE        (dbo.Store_Issuance.IsIssue = 0) order by StoreID", Conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        List<GetRegionClass> RegionList = new List<GetRegionClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetRegionClass dbdc = new GetRegionClass();

                
                dbdc.OrderDate = ds.Tables[0].Rows[i]["OrderDate"].ToString();
                dbdc.ItemName = ds.Tables[0].Rows[i]["ITEMName"].ToString();
                dbdc.Qty = ds.Tables[0].Rows[i]["Qty"].ToString() +" "+ ds.Tables[0].Rows[i]["DisplayName"].ToString();
                dbdc.Availed = ds.Tables[0].Rows[i]["Availed"].ToString() + " " + ds.Tables[0].Rows[i]["DisplayName"].ToString();
                dbdc.Balance = ds.Tables[0].Rows[i]["Balance"].ToString() + " " + ds.Tables[0].Rows[i]["DisplayName"].ToString();
                dbdc.BatchCode = ds.Tables[0].Rows[i]["BatchCode"].ToString();
                dbdc.Store = ds.Tables[0].Rows[i]["StoreID"].ToString();
                dbdc.ItemID = ds.Tables[0].Rows[i]["ITEMID"].ToString();
                dbdc.UnitID = ds.Tables[0].Rows[i]["UnitID"].ToString();
                dbdc.ProductID = ds.Tables[0].Rows[i]["ProductID"].ToString();     
                RegionList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(RegionList);


    }

    public class GetRegionClass
    {
        public string OrderDate { get; set; }
        public string ItemName { get; set; }
        public string Qty { get; set; }
        public string Availed { get; set; }
        public string Balance { get; set; }
        public string BatchCode { get; set; }
        public string Store { get; set; }
        public string ItemID { get; set; }
        public string UnitID { get; set; }
        public string ProductID { get; set; }
        
        

    }


    public class GetRegionClasss
    {
        public string UnitTypeID { get; set; }
        public string UnitTypeDesc { get; set; }



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
        //vNO = vNO + "`" + vDate;
        return vNO;
    }


    [WebMethod]
    public static string SaveTransaction(string UserID, string str)
    {
        string msg = "";

        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        string aa = LoadNUMBER("PB", "SP_MASTER", "SPID", Con);
        SqlCommand cmd = new SqlCommand("insert into SP_MASTER (SPID,SPDate,TotalAmount,DiscountAmount,TaxRate,TaxAmount,GrandTotal,AccountID,SP) values ('" + aa + "','"+DateTime.Now+"','0','0','0','0','0','0','B')", Con);
        Con.Open();
        cmd.ExecuteNonQuery();
        Con.Close();
        string[] itmLST = str.Split('`');
        for (int i = 0; i < itmLST.Length; i++)
        {
            string[] itmROW = itmLST[i].Split('^');
            //txtAccID + "^" + txtAccTitle + "^" + ddlUnit + "^" + txtQty + "^" + txtPrice + "^" + txtTotalPrice
            string itmID = itmROW[0].ToString();
            string BatchNo = itmROW[1].ToString();
            string txtQty = itmROW[2].ToString();
            string txtUnit = itmROW[3].ToString();
            string txtProduct = itmROW[4].ToString();
            string txtStore = itmROW[5].ToString();

            SqlCommand cmd1 = new SqlCommand("insert into SP_DETAIL (SPID,ITEMID,UnitID,QtyIn,QtyOut,UnitPrice,TotalPrice) values ('" + aa + "','" + itmID + "','"+txtUnit+"','0','" + txtQty + "','0','0')", Con);
            Con.Open();
            cmd1.ExecuteNonQuery();
            Con.Close();


            SqlCommand cmd2 = new SqlCommand("update Store_Issuance set Availed='"+txtQty+"',IssueDate='"+DateTime.Now+"',IsIssue='1' where BatchCode='"+BatchNo+"' and ITEMID='"+itmID+"' and UnitID='"+txtUnit+"' and ProductID='"+txtProduct+"' and StoreID='"+txtStore+"'", Con);
            Con.Open();
            cmd2.ExecuteNonQuery();
            Con.Close();

        }

        return msg;
    }





}