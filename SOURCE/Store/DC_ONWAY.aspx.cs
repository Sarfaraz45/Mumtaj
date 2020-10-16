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

public partial class Store_DC_ONWAY : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string SET_DATE()
    {
        string summary = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        // System.Windows.Forms.MessageBox.Show(summary);
        try
        {
            DataTable dt = AACommon.LoadControl("DATE_FILTER", con, null);


            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0) { summary = summary + "`"; }

                summary = summary + dt.Rows[i]["WeekStart"].ToString() + "`" + dt.Rows[i]["WeekEnd"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);

            //return null;
        }
        //}

        return summary;
    }

    [WebMethod]
    public static string LOAD_ACCOUNTS(string UserID)
    {
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

      

        string acc = "";
        string query = "SELECT [CustomerID],[CustomerTitle] + '^' + [CustomerID] AS CustomerTitle FROM [Customer]";

        SqlDataAdapter da = new SqlDataAdapter(query, Con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        for (int i = 1; i <= dt.Rows.Count; i++)
        {
            //'["Karachi","Hyderabad","USA","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky"]'
            if (i == 1)
            { acc = acc + "['" + dt.Rows[i - 1]["CustomerTitle"].ToString() + "'"; }
            else if (i != 1 && i < dt.Rows.Count)
            { acc = acc + ",'" + dt.Rows[i - 1]["CustomerTitle"].ToString() + "'"; }
            else
            { acc = acc + ",'" + dt.Rows[i - 1]["CustomerTitle"].ToString() + "']"; }

            //acc = acc + "!" + dt.Rows[i-1]["AccountTitle"].ToString();
        }

        acc = SET_DATE() + "`" + acc + "`";
        return acc;
    }


    [WebMethod]
    public static string GetDate()
    {
        
        string vDate = "";
        string mm1 = System.DateTime.Now.Month.ToString();
        string yy1 = System.DateTime.Now.Year.ToString();
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConACC"].ConnectionString);
        DataSet dsDATE = AACommon.ReturnDatasetBySP("Get_CurrentDate", Con, null);
        if (dsDATE.Tables[0].Rows.Count > 0)
        {
            mm1 = dsDATE.Tables[0].Rows[0]["MM"].ToString();
            yy1 = dsDATE.Tables[0].Rows[0]["YY"].ToString();
            vDate = mm1 + "/" + dsDATE.Tables[0].Rows[0]["DD"].ToString() + "/" + yy1;
        }
        dsDATE.Dispose();

        return vDate;
    }

    [WebMethod]
    public static string LoadGoods_List(string UserID, string cust, string sDt, string eDt)
    {
        string htm = "";
        htm = htm + "<table id='tblGoodsReceived' class='table table-striped table-hover no-head-border' >";
        htm = htm + "<thead class='vd_bg-dark-blue vd_white'><tr>";
        htm = htm + "<th>DC No.</th>";
        htm = htm + "<th>Date</th>";
        htm = htm + "<th>Customer</th>";
        htm = htm + "<th>Total Qty.</th>";
        htm = htm + "<th colspan='3'></th>";
        htm = htm + "</tr>";
        htm = htm + "</thead>";
        htm = htm + "<tbody>";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        SqlParameter DtFrom = new SqlParameter("@DtFrom", sDt);
        SqlParameter DtTo = new SqlParameter("@DtTo", eDt);
        SqlParameter CustomerID = new SqlParameter("@CustomerID", cust);
        DataSet ds = AACommon.ReturnDatasetBySP("SALE_ONWAY_DC_V2", Con, DtFrom, DtTo, CustomerID);
        DataTable dt = new DataTable();
        if (ds.Tables.Count > 0)
        {
            dt = ds.Tables[0];
        }

        string currDate = GetDate();
        for (int i = 0; i < dt.Rows.Count; i++)
        {

            htm = htm + "<tr >";
            htm = htm + "<td>" + dt.Rows[i]["SPID"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["SPDate"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["CustomerTitle"].ToString() + "</td>";
            htm = htm + "<td>" + dt.Rows[i]["TotQty"].ToString() + "</td>";
            htm = htm + "<td><a href='../Reports/SALE_DC.aspx?sDT=0&eDt=0&a=" + dt.Rows[i]["SPID"].ToString() + "' target=_blank><i class='append-icon fa fa-fw fa-search-plus'></i>View</a></td>";
            htm = htm + "<td><a href=\"javascript:DeliveredDC('" + dt.Rows[i]["SPID"].ToString() + "','" + dt.Rows[i]["SPDate"].ToString() + "','" + dt.Rows[i]["CustomerTitle"].ToString() + "','" + currDate + "');\"><i class='append-icon fa fa-fw fa-check'></i>Delivered</a></td>";
            if (dt.Rows[i]["IsInvoice"].ToString() == "0")
            {
                htm = htm + "<td><a href=\"javascript:ReverseDC('" + dt.Rows[i]["SPID"].ToString() + "','" + dt.Rows[i]["SPDate"].ToString() + "','" + dt.Rows[i]["CustomerTitle"].ToString() + "');\"><i class='append-icon fa fa-fw fa-mail-reply-all'></i>Reverse</a></td>";
            }
            else
            {
                htm = htm + "<td></td>";
            }
                htm = htm + "</tr>";
        }
        htm = htm + "</tbody>";
        htm = htm + "</table>";
        return htm;
    }

    [WebMethod]
    public static string DELIVERED(string UserID, string dDT, string dcNo, string rcvdBY)
    {
        string msg = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        /////////////////////////// INSERT in SP MASTER //////////////////
        SqlParameter SPID = new SqlParameter("@SPID", dcNo);
        SqlParameter DeliveredDate = new SqlParameter("@DeliveredDate", dDT);
        SqlParameter ReceivedBy = new SqlParameter("@ReceivedBy", rcvdBY);
        AACommon.Execute("SALE_DC_DELIVERED", Con, SPID, DeliveredDate, ReceivedBy);


        return msg;
    }

    [WebMethod]
    public static string REVERSE(string UserID, string dcNo)
    {
        string msg = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        SqlParameter SPID = new SqlParameter("@SPID", dcNo);
        DataSet ds = AACommon.ReturnDatasetBySP("DC_ITEMS_GET", Con, SPID);
        DataTable dt = new DataTable();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            string id = ds.Tables[0].Rows[i]["ID"].ToString();
            string itmID = ds.Tables[0].Rows[i]["ITEMID"].ToString();
            string untID = ds.Tables[0].Rows[i]["UnitID"].ToString();
            string qty = ds.Tables[0].Rows[i]["QtyOut"].ToString();
            string rwID = ds.Tables[0].Rows[i]["SODID"].ToString();

            SqlParameter ID = new SqlParameter("@ID", id);
            SqlParameter QtyOut = new SqlParameter("@QtyOut", qty);
            SqlParameter rowID = new SqlParameter("@rowID", rwID);
            AACommon.Execute("DC_DETAIL_REVERSE", Con, ID, QtyOut, rowID);


           
        }
        ds.Dispose();

        /////////////////////////// DELETE from TABLES //////////////////
        SqlParameter SPID_1 = new SqlParameter("@SPID", dcNo);
        AACommon.Execute("DC_REVERSE", Con, SPID_1);


        return msg;
    }
}