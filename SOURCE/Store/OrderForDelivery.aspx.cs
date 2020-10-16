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

public partial class SALES_OrderForDelivery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string LoadOrders(string UserID)
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        
        DataSet ds = AACommon.ReturnDatasetBySP("PROD_BATCH_FOR_DELIVERY", Conn, null);
        List<GetTempOrders> ordList = new List<GetTempOrders>();
        ordList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetTempOrders dbdc = new GetTempOrders();

                dbdc.BatchID = ds.Tables[0].Rows[i]["BatchID"].ToString();
                dbdc.DeliveryDate = ds.Tables[0].Rows[i]["DeliveryDate"].ToString();
                dbdc.EntryDate = ds.Tables[0].Rows[i]["EntryDate"].ToString();
                dbdc.StatusTitle = ds.Tables[0].Rows[i]["StatusTitle"].ToString();
                dbdc.UserName = ds.Tables[0].Rows[i]["UserName"].ToString();
                dbdc.Items = ItemInfo(ds.Tables[0].Rows[i]["BatchID"].ToString());
                ordList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(ordList);


    }


    public class GetTempOrders
    {
        public string BatchID { get; set; }
        public string DeliveryDate { get; set; }
        public string EntryDate { get; set; }
        public string StatusTitle { get; set; }
        public string UserName { get; set; }
        public string Items { get; set; }

    }

    [WebMethod]
    public static string ItemInfo(string batchID)
    {
        string htm = "";

        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter BatchID = new SqlParameter("@BatchID", batchID);
        DataSet ds = AACommon.ReturnDatasetBySP("PROD_BATCH_ITEMS", Conn, BatchID);
        if (ds.Tables.Count > 0)
        {
            DataTable dt = ds.Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0) { htm = htm + " | "; }
                htm = htm + dt.Rows[i]["ITEMName"].ToString() + " : " + dt.Rows[i]["Qty"].ToString() + " " + dt.Rows[i]["DisplayName"].ToString();

            }

        }

        return htm;
    }
}