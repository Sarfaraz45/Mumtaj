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

public partial class Branch_ERP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }




    [WebMethod]
    public static string InsertRegion(string Branch, string UserID)
    {

        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        string ID = AACommon.GetAlphaNumericIDSIX("ITM_BRANCH", "BRA-", "BranchID", Conn);
        SqlParameter BranchID_P = new SqlParameter("@BranchID", ID);
        SqlParameter BranchTitle_P = new SqlParameter("@BranchTitle", Branch);
        SqlParameter CREATEBY = new SqlParameter("@CreateBy", UserID);
        msg = AACommon.Execute("ITM_Branch_Insert", Conn, BranchID_P, BranchTitle_P, CREATEBY);


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
    public static string UpdateRegion(string BranchID, string BranchTitle)
    {
        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        SqlParameter BranchID_P = new SqlParameter("@BranchID", BranchID);
        SqlParameter BranchTitle_P = new SqlParameter("@BranchTitle", BranchTitle);
        msg = AACommon.Execute("ITM_Branch_Update", Conn, BranchID_P, BranchTitle_P);


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
    public static string DeleteRegion(string BranchID, string UserID)
    {

        string retMessage = string.Empty;
        string msg = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);


        SqlParameter BranchID_P = new SqlParameter("@BranchID", BranchID);
        SqlParameter DeleteBy_P = new SqlParameter("@DeleteBy", UserID);
        msg = AACommon.Execute("ITM_Branch_Delete", Conn, BranchID_P, DeleteBy_P);


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
    public static string LoadRegion()
    {
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        DataSet ds = AACommon.ReturnDatasetBySPWithoutParameter("ITM_Branch_Get", Conn);
        List<GetRegionClass> RegionList = new List<GetRegionClass>();
        RegionList.Clear();
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GetRegionClass dbdc = new GetRegionClass();

                dbdc.BranchID = ds.Tables[0].Rows[i][0].ToString();
                dbdc.BranchTitle = ds.Tables[0].Rows[i][1].ToString();
                RegionList.Insert(i, dbdc);
            }

        }


        JavaScriptSerializer jser = new JavaScriptSerializer();


        return jser.Serialize(RegionList);


    }

    public class GetRegionClass
    {
        public string UnitTypeID { get; set; }
        public string UnitTypeDesc { get; set; }


        public string PackingTypeID { get; set; }

        public string PackingTypeDesc { get; set; }

        public string BranchID { get; set; }

        public string BranchTitle { get; set; }
    }









    public static SqlParameter[] PackingTypeID_P { get; set; }

    public static object PackingTypeDesc_P { get; set; }
}