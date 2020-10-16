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
        SqlDataAdapter da = new SqlDataAdapter("select * from VW_Order_Wise_Item_List", Conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        List<GetRegionClass> RegionList = new List<GetRegionClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetRegionClass dbdc = new GetRegionClass();

                dbdc.ItemName = ds.Tables[0].Rows[i]["ITEMName"].ToString();
                dbdc.Qty = ds.Tables[0].Rows[i]["RequiredQty"].ToString();
                dbdc.QtyInStock = ds.Tables[0].Rows[i]["QtyAvailable"].ToString();               
                dbdc.QtyInStockNew = Convert.ToDouble(ds.Tables[0].Rows[i]["QtyAvailable"].ToString());
                dbdc.QtyNew = Convert.ToDouble(ds.Tables[0].Rows[i]["RequiredQty"].ToString());
                dbdc.ItemID = ds.Tables[0].Rows[i]["ITEMID"].ToString();
                dbdc.BatchID = ds.Tables[0].Rows[i]["BatchID"].ToString();
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
        public string AvailedNew { get; set; }
        public string BalanceNew { get; set; }
        public string TotalQty { get; set; }
        public string ProductType { get; set; }
        public string QtyInStock { get; set; }
        public string DeliveryDate { get; set; }
        public string Status { get; set; }
        public double QtyInStockNew { get; set; }
        public double QtyNew { get; set; }
        public string BatchID { get; set; }
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
    public static string SaveTransaction(string UserID, string BatchID)
    {
        string msg = "";

        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        SqlDataAdapter da = new SqlDataAdapter("SELECT        SUM(dbo.PROD_DETAIL.Qty) AS Qty, dbo.ITM_ITEM.ITEMID, dbo.ITM_ITEM.ITEMName, dbo.PROD_MASTER.BatchID FROM            dbo.ITM_ITEM INNER JOIN                          dbo.PROD_DETAIL ON dbo.ITM_ITEM.ITEMID = dbo.PROD_DETAIL.ITEMID INNER JOIN                          dbo.ITM_UNIT ON dbo.PROD_DETAIL.UnitID = dbo.ITM_UNIT.UnitID INNER JOIN                          dbo.PROD_MASTER ON dbo.PROD_DETAIL.PRID = dbo.PROD_MASTER.PRID WHERE        (dbo.PROD_MASTER.Status = 0) and BatchID='" + BatchID + "' GROUP BY dbo.ITM_ITEM.ITEMID, dbo.ITM_ITEM.ITEMName, dbo.PROD_MASTER.Status, dbo.PROD_MASTER.BatchID", Con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            string aa = LoadNUMBER("PB", "SP_MASTER", "SPID", Con);
            SqlCommand cmd3 = new SqlCommand("insert into SP_MASTER (SPID,SPDate,TotalAmount,DiscountAmount,TaxRate,TaxAmount,GrandTotal,AccountID,SP) values ('" + aa + "','" + DateTime.Now + "','0','0','0','0','0','0','B')", Con);
            Con.Open();
            cmd3.ExecuteNonQuery();
            Con.Close();
            for (int i = 0; i < dt.Rows.Count; i++)
            {               
                string ID = AACommon.GetAlphaNumericIDSIX("Store_Master","STM-","StoreMasterID",Con);
                SqlCommand cmd = new SqlCommand("insert into Store_Master (StoreMasterID,BatchID,Date,ItemID,Qty,Balance) values ('" + ID + "','" + dt.Rows[i]["BatchID"].ToString() + "','" + DateTime.Now + "','" + dt.Rows[i]["ITEMID"].ToString() + "','" + dt.Rows[i]["Qty"].ToString() + "','" + dt.Rows[i]["Qty"].ToString() + "')", Con);
                Con.Open();
                cmd.ExecuteNonQuery();
                Con.Close();
                SqlDataAdapter da1 = new SqlDataAdapter("SELECT        dbo.ItemRecipeMaster.ItemRecipeID, dbo.ItemRecipeDetail.ItemRecipeDetailID, dbo.ItemRecipeMaster.ITEMID, dbo.ITM_ITEM.ITEMName, dbo.ItemRecipeDetail.MaterialID, dbo.ItemRecipeDetail.Qty,                          dbo.ItemRecipeDetail.Unit FROM            dbo.ItemRecipeMaster INNER JOIN                          dbo.ITM_ITEM ON dbo.ItemRecipeMaster.ITEMID = dbo.ITM_ITEM.ITEMID INNER JOIN                          dbo.ItemRecipeDetail ON dbo.ItemRecipeMaster.ItemRecipeID = dbo.ItemRecipeDetail.ItemRecipeID where dbo.ItemRecipeMaster.ITEMID='"+dt.Rows[i]["ITEMID"].ToString()+"'", Con);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                if (dt1.Rows.Count > 0)
                {
                    for (int j = 0; j < dt1.Rows.Count; j++)
                    {
                        double totalqty = Convert.ToDouble(dt.Rows[i]["Qty"].ToString()) * Convert.ToDouble(dt1.Rows[j]["Qty"].ToString());
                        SqlCommand cmd1 = new SqlCommand("insert into Store_Material (StoreMasterID,MaterialID,UnitID,Qty,Balance,IsIssue,IssueBy,IssueDate,CreateBy) values ('" + ID + "','" + dt1.Rows[j]["MaterialID"].ToString() + "','" + dt1.Rows[j]["Unit"].ToString() + "','" + totalqty + "','" + totalqty + "','1','" + UserID + "','" + DateTime.Now + "','" + UserID + "')", Con);
                        Con.Open();
                        cmd1.ExecuteNonQuery();
                        Con.Close();
                        SqlCommand cmd4 = new SqlCommand("insert into SP_DETAIL (SPID,ITEMID,UnitID,QtyIn,QtyOut,UnitPrice,TotalPrice) values ('" + aa + "','" + dt1.Rows[j]["MaterialID"].ToString() + "','" + dt1.Rows[j]["Unit"].ToString() + "','0','" + totalqty + "','0','0')", Con);
                        Con.Open();
                        cmd4.ExecuteNonQuery();
                        Con.Close();
                    }
                }

                
            }

            SqlCommand cmd2 = new SqlCommand("update PROD_MASTER set Status=1 where BatchID='" + BatchID + "'", Con);
            Con.Open();
            cmd2.ExecuteNonQuery();
            Con.Close();

        }

        msg = "True";
        return msg;
    }





}