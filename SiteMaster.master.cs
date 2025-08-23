using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    DAL objDal = new DAL();
    DataTable dt = new DataTable();
    SqlConnection DbConnect;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        string formattedDateTime = DateTime.Now.ToString("dd MMMM yyyy |  'Time : 'hh.mm tt");
        Session["CurrntDatetimr"] = formattedDateTime;
        try
        {
            if (Application["WebStatus"] != null)
            {
                if (Application["WebStatus"].ToString() == "N")
                {
                    Session.Abandon();
                    Response.Redirect("default.aspx", false);
                }
            }
            if (!Page.IsPostBack)
            {
                DataTable Dt = new DataTable();
                string str = "";
                if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                {
                    LblName.Text = Session["MemName"].ToString();
                    Lbldate.Text = (Session["ActiveStatus"].ToString() == "Y") ? Session["DOA"].ToString() : "";
                    string sql = objDal.Isostart + "select profilepic,* from Cmayds..M_MemberMaster where formno=" + Session["FormNo"] + objDal.IsoEnd;
                    DataTable dt1 = new DataTable();
                    dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];

                    if (dt1.Rows.Count > 0)
                    {
                        if (dt1.Rows[0]["ProfilePic"].ToString() == "")
                        {
                            Image2.ImageUrl = "./dashboard_files/user.png";
                        }
                        else
                        {
                            Image2.ImageUrl = dt1.Rows[0]["ProfilePic"].ToString();
                        }
                    }
                 
                    string lnt = Crypto.Encrypt("uid=" + Session["IDNo"] + "&pwd=" + Session["MemPassw"] + "&mobile=" + Session["MobileNo"]);

                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    private void FillStopWithdrawal()
    {
        try
        {
            string query = "";
            query = "Exec Sp_GetStopWithdrawalCheck '" + Session["FormNo"] + "' ";

            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

            if (dt.Rows.Count > 0)
            {
                Session["RStatus"] = dt.Rows[0]["RStatus"];
            }
            else
            {
                Session["RStatus"] = "N";
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }

    private string Encryptdata(string Data)
    {

        string strmsg = string.Empty;
        try
        {
            byte[] encode = new byte[Data.Length];
            encode = Encoding.UTF8.GetBytes(Data);
            strmsg = Convert.ToBase64String(encode);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return strmsg;
    }


}
