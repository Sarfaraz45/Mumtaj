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

public partial class Setup_Usertypeforms : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    [WebMethod]
    public static string InsertRegion(string utid, string form, string UserID)
    {

        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        SqlParameter FormID = new SqlParameter("@FormID", form);
        SqlParameter UTID = new SqlParameter("@UTID", utid);
        SqlParameter CREATEBY = new SqlParameter("@CREATEBY", UserID);
        msg = AACommon.Execute("USERTYPE_FORM_INSERT", Conn, FormID, UTID, CREATEBY);


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
    public static string UpdateRegion(string DistrictID, string utid, string form, string UserID)
    {
        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter UTFID = new SqlParameter("@UTFID", DistrictID);
        SqlParameter FormID = new SqlParameter("@FormID", form);
        SqlParameter UTID = new SqlParameter("@UTID", utid);
        SqlParameter MODIFYBY = new SqlParameter("@MODIFYBY", UserID);
        msg = AACommon.Execute("USERTYPE_FORM_UPDATE", Conn, UTFID, FormID, UTID, MODIFYBY);


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
    public static string DeleteRegion(string DistrictID, string UserID)
    {
        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        //SqlParameter DISTRICT_ID_1 = new SqlParameter("@DISTRICT_ID", DistrictID);
        //DataSet ds = AACommon.ReturnDatasetBySP("TALUKA_CHECK_FOR_DELETE_DISTRICT", Conn, DISTRICT_ID_1);
        //if (ds.Tables[0].Rows.Count > 0)
        //{ retMessage = "false"; return retMessage; }
        //else
        //{
        SqlParameter UTFID = new SqlParameter("@UTFID", DistrictID);
        SqlParameter MODIFYBY = new SqlParameter("@MODIFYBY", UserID);
        msg = AACommon.Execute("USERTYPE_FORM_DELETE", Conn, UTFID, MODIFYBY);


        if (msg == "Record Saved Successfully")
        {
            retMessage = "true";
        }
        else
        {
            retMessage = "false";
        }

        return retMessage;
        //}
    }

    [WebMethod]
    public static string LoadRegion()
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet ds = AACommon.ReturnDatasetBySPWithoutParameter("USERTYPEFORM_GET_ALL", Conn);
        List<GetDistrictClass> RegionList = new List<GetDistrictClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetDistrictClass dbdc = new GetDistrictClass();

                dbdc.ID = ds.Tables[0].Rows[i]["UTFID"].ToString();
                dbdc.Form = ds.Tables[0].Rows[i]["FormTitle"].ToString();
                dbdc.UserType = ds.Tables[0].Rows[i]["UTDesc"].ToString();
                dbdc.FormID = ds.Tables[0].Rows[i]["FormID"].ToString();
                dbdc.UserTypeID = ds.Tables[0].Rows[i]["UTID"].ToString();
                RegionList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(RegionList);


    }
    [WebMethod]
    public static string LoadRegionName(string utid, string form)
    {
        string retMessage = string.Empty;
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter FormID = new SqlParameter("@FormID", form);
        SqlParameter UTID = new SqlParameter("@UTID", utid);
        DataSet ds = AACommon.ReturnDatasetBySP("FORM_TYPE_GET_BY_FORM_ID_USERTYPE_ID", Conn, FormID, UTID);
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
    public class GetDistrictClass
    {
        public string ID { get; set; }
        public string Form { get; set; }
        public string UserType { get; set; }
        public string FormID { get; set; }
        public string UserTypeID { get; set; }


    }

    [WebMethod]
    public static string LoadRegionCombo()
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
    public static string LoadForm()
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet ds = AACommon.ReturnDatasetBySPWithoutParameter("FORM_GET_ALL", Conn);
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




}