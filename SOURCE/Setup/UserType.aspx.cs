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

public partial class Setup_UserType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    [WebMethod]
    public static string InsertRegion(string RegionName, string UserID)
    {

        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UTDesc = new SqlParameter("@UTDesc", RegionName);
        SqlParameter CREATEBY = new SqlParameter("@CREATEBY", UserID);
        msg = AACommon.Execute("USERTYPE_INSERT", Conn, UTDesc, CREATEBY);


        if (msg == "Record Saved Successfully")
        {
            retMessage = "true";
        }
        else
        {
            retMessage = "false";
        }

        return retMessage;
    }

    [WebMethod]
    public static string UpdateRegion(string RegionID, string RegionName, string UserID)
    {
        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UTID = new SqlParameter("@UTID", RegionID);
        SqlParameter UTDesc = new SqlParameter("@UTDesc", RegionName);
        SqlParameter MODIFYBY = new SqlParameter("@MODIFYBY", UserID);
        msg = AACommon.Execute("USERTYPE_UPDATE", Conn, UTID, UTDesc, MODIFYBY);


        if (msg == "Record Saved Successfully")
        {
            retMessage = "true";
        }
        else
        {
            retMessage = "false";
        }

        return retMessage;
    }


    [WebMethod]
    public static string DeleteRegion(string RegionID, string UserID)
    {

        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UTID_1 = new SqlParameter("@UTID", RegionID);
        DataSet ds = AACommon.ReturnDatasetBySP("USER_CHECK_FOR_DELETE_USERTYPE", Conn, UTID_1);
        if (ds.Tables[0].Rows.Count > 0)
        { retMessage = "false"; return retMessage; }
        else
        {
            SqlParameter UTID = new SqlParameter("@UTID", RegionID);
            SqlParameter MODIFYBY = new SqlParameter("@MODIFYBY", UserID);
            msg = AACommon.Execute("USERTYPE_DELETE", Conn, UTID, MODIFYBY);


            if (msg == "Record Saved Successfully")
            {
                retMessage = "true";
            }
            else
            {
                retMessage = "false";
            }
        }
        return retMessage;

    }

    [WebMethod]
    public static string LoadRegion()
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet ds = AACommon.ReturnDatasetBySPWithoutParameter("USERTYPE_GET_ALL", Conn);
        List<GetRegionClass> RegionList = new List<GetRegionClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetRegionClass dbdc = new GetRegionClass();

                dbdc.ID = ds.Tables[0].Rows[i][0].ToString();
                dbdc.Name = ds.Tables[0].Rows[i][1].ToString();
                RegionList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(RegionList);


    }
    
    [WebMethod]
    public static string LoadRegionName(string RegionName)
    {
        string retMessage = string.Empty;
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UTDesc = new SqlParameter("@UTDesc", RegionName);
        DataSet ds = AACommon.ReturnDatasetBySP("USERTYPE_GET_BY_NAME", Conn, UTDesc);
        List<GetRegionClass> RegionList = new List<GetRegionClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            retMessage = "false";

        }
        else
        {
            retMessage = "true";
        }



        return retMessage;
    }

    public class GetRegionClass
    {
        public string ID { get; set; }
        public string Name { get; set; }

    }






}