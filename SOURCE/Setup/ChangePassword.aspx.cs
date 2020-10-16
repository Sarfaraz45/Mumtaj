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

public partial class Setup_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static string LoadPWD(string UserID)
    {
        string pwd = "";
        SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);
        pwd = AACommon.GetData("select Password from USERS where UserID='" + UserID + "'", Conn, "Password");
        pwd = Encryption.Decrypt(pwd);
        return pwd;
    }

    [WebMethod]
    public static string SaveTransaction(string UserID, string NPWD)
    {

        string vNo = "";
        SqlConnection Con = new SqlConnection(ConfigurationManager.ConnectionStrings["Con"].ConnectionString);

        NPWD = Encryption.Encrypt(NPWD);

        SqlParameter UserID_1 = new SqlParameter("@UserID", UserID);
        SqlParameter PWD = new SqlParameter("@PWD", NPWD);
        AACommon.Execute("PWD_UPDATE", Con, UserID_1, PWD);



        return vNo;
    }
}