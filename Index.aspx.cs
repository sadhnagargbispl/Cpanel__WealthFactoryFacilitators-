using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using Microsoft.Ajax.Utilities;
using System.Net;
using System.Security.Policy;

public partial class Index : System.Web.UI.Page
{
    DAL Obj = new DAL();
    DataSet Ds;
    string IsoStart;
    string IsoEnd;
    SqlDataReader dr;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    LoadTeam();
                }
            }
            else
            {
                string key = string.Empty;
                try
                {
                    string KeyE = "6b04d38748f94490a636cf1be3d82841";
                    string IV = "f8adbf3c94b7463d";
                    byte[] KeyB = Encoding.ASCII.GetBytes(KeyE);
                    byte[] IVB = Encoding.ASCII.GetBytes(IV);

                    key = Request.Form["key"];
                    bool Islogin = false;

                    string[] Result = Decrypt(key, KeyB, IVB).Split(',');
                    int Result1 = (int)(DateTime.Now - Convert.ToDateTime(Result[2])).TotalMinutes;

                    if (Result1 > 30)
                    {
                        Response.Redirect("Logout.aspx");
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("Logout.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void LoadTeam()
    {
        try
        {
            DataSet Ds = new DataSet();
            string strquery = string.Empty;
            strquery = IsoStart;
            strquery += " Exec sp_LoadTeamNewUpdate '" + Session["FormNo"].ToString() + "' ";
            strquery += IsoEnd;
            Ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, strquery);
            Session["LoadTeam"] = Ds;
            if (Ds.Tables[0].Rows.Count > 0)
            {
                RptIncome.DataSource = Ds.Tables[0];
                RptIncome.DataBind();
            }
            if (Ds.Tables[1].Rows.Count > 0)
            {
                RptWallet.DataSource = Ds.Tables[1];
                RptWallet.DataBind();
            }
            if (Ds.Tables[2].Rows.Count > 0)
            {
                RptBusiness.DataSource = Ds.Tables[2];
                RptBusiness.DataBind();
            }
            if (Ds.Tables[3].Rows.Count > 0)
            {
                RptNews.DataSource = Ds.Tables[3];
                RptNews.DataBind();
            }
            if (Ds.Tables[4].Rows.Count > 0)
            {
                // User Info
                lblUserNAme.Text = Ds.Tables[4].Rows[0]["Name"].ToString().ToUpper();
                lblIdno.Text = Ds.Tables[4].Rows[0]["IdNo"].ToString();
                lblEmail.Text = Ds.Tables[4].Rows[0]["email"].ToString();
                lblDoj.Text = Ds.Tables[4].Rows[0]["DOJ"].ToString();
                lblActivation.Text = Ds.Tables[4].Rows[0]["ActivationDate"].ToString();
                lblPackageName.Text = Ds.Tables[4].Rows[0]["KitName"].ToString();
                lblStatus.Text = (Ds.Tables[4].Rows[0]["ActiveStatus"].ToString() == "Y") ? "Active" : "Deactive";
                Image2.ImageUrl = Ds.Tables[4].Rows[0]["ProfilePic"].ToString();
                //string mid = Ds.Tables[4].Rows[0]["MID"].ToString();
                //string encrypted = HttpUtility.UrlEncode(Crypto.Encrypt(mid + "/1"));
                lblLink.Value = "https://" + HttpContext.Current.Request.Url.Host + "/Newjoining1.aspx?ref=" + Crypto.Encrypt(Ds.Tables[4].Rows[0]["MID"] + "/1");
                //string encrypted2 = HttpUtility.UrlEncode(Crypto.Encrypt(mid + "/2"));
                lblLink1.Value = "https://" + HttpContext.Current.Request.Url.Host + "/Newjoining1.aspx?ref=" + Crypto.Encrypt(Ds.Tables[4].Rows[0]["MID"] + "/2");
                // lblLink1.Text = "https://" + HttpContext.Current.Request.Url.Host + "/Newjoining1.aspx?ref=" + Crypto.Encrypt(Ds.Tables[4].Rows[0]["MID"] + "/2");
                //aRfLink.HRef = lblLink.Text;
            }
            if (Ds.Tables[5].Rows.Count > 0)
            {
                lblRank.Text = Ds.Tables[5].Rows[0]["Reward"].ToString();
            }
            else
            {
                lblRank.Text = "Not Achieved";
            }
            if (Ds.Tables[6].Rows.Count > 0)
            {
                RptMemberStatistics.DataSource = Ds.Tables[6];
                RptMemberStatistics.DataBind();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    private void Load_Headings()
    {
        try
        {
            DataSet Ds = new DataSet();
            string strquery = Obj.Isostart + " Exec Sp_GetPopup " + Obj.IsoEnd;
            Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strquery);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        Ds.Tables[0].Rows[i]["divstart"] = Ds.Tables[0].Rows[i]["ImgPath"];
                    }
                    if (i == 1)
                    {
                        Ds.Tables[0].Rows[i]["divstart"] = Ds.Tables[0].Rows[i]["ImgPath"];
                    }
                }
            }
            Session["PopupImg"] = Ds.Tables[0];
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void Page_Unload(object sender, EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private static string Encrypt(string plainText, byte[] Key, byte[] IV)
    {
        byte[] encrypted;
        using (AesManaged aes = new AesManaged())
        {
            ICryptoTransform encryptor = aes.CreateEncryptor(Key, IV);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter sw = new StreamWriter(cs))
                    {
                        sw.Write(plainText);
                    }
                    encrypted = ms.ToArray();
                }
            }
        }
        return Convert.ToBase64String(encrypted);
    }
    private static string Decrypt(string data, byte[] Key, byte[] IV)
    {
        byte[] cipherText = Convert.FromBase64String(data);
        string plaintext = null;

        using (AesManaged aes = new AesManaged())
        {
            ICryptoTransform decryptor = aes.CreateDecryptor(Key, IV);
            using (MemoryStream ms = new MemoryStream(cipherText))
            {
                using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader reader = new StreamReader(cs))
                    {
                        plaintext = reader.ReadToEnd();
                    }
                }
            }
        }
        return plaintext;
    }
}
