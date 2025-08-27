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
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using DocumentFormat.OpenXml.Spreadsheet;

public partial class Index : System.Web.UI.Page
{
    DAL Obj = new DAL();
    DataSet Ds;
    DataSet Das;
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
                    if (Session["ShowDisclaimer"] != null && (bool)Session["ShowDisclaimer"] == true)
                    {
                        LoadDisclaimer();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "showDisclaimer();", true);
                        Session["ShowDisclaimer"] = false; // Only first time
                    }
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
    private void LoadDisclaimer()
    {
        // Get Disclaimer from DB
        string query = "Exec Sp_GetDisclaimerNoticePopup";
        Das = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr"].ConnectionString, CommandType.Text, query);
        // DB logic here (SqlConnection, SqlCommand etc.)
        // Example:
        if (Das.Tables[0].Rows.Count > 0)
        {
            lblTitle.Text = Das.Tables[0].Rows[0]["Title"].ToString(); 
            lblBody.Text = Das.Tables[0].Rows[0]["Body"].ToString();
        }
    }
    protected void btnProceed_Click(object sender, EventArgs e)
    {
        string subject = lblTitle.Text;
        string body = lblBody.Text;

        DataTable dt;
        string sql = "";
        string userEmail = "";

        string StrMsg = "";
        System.Net.Mail.MailAddress SendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
        System.Net.Mail.MailAddress SendTo = new System.Net.Mail.MailAddress(lblEmail.Text);
        System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(SendFrom, SendTo);
        //StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify; width:100%\">" +
        // "<tr>" +
        // "<td>" +
        // "<span>Dear <strong>" + lblUserNAme.Text + "</strong>,</span><br /><br />" +
        // "Thank you for logging into <strong>Wealth Factory</strong>.<br /><br />" +
        // "Please note the following important disclaimer as you proceed to explore opportunities through our platform:<br /><br />" +

        // "<b>Disclaimer</b><br />" +
        // "Wealth Factory acts solely as an introducer and is not a party to any financial, legal, or commercial transaction between you and any third-party website or business you may be redirected to. Our role is limited to facilitating access by connecting interested users with offerings from independent third-party entities.<br /><br />" +

        // "All transactions, agreements, and communications are conducted directly between you and the third-party website/business, which holds sole responsibility for their content, execution, and fulfillment.<br /><br />" +

        // "Wealth Factory:<br />" +
        // "<ul style='margin:0; padding-left:20px;'>" +
        //     "<li>Does not verify or monitor the performance or enforceability of third-party transactions</li>" +
        //     "<li>Is not liable for any disputes, delays, or losses arising from such dealings</li>" +
        //     "<li>May, where reasonably necessary, share relevant user details and assist with basic coordination at the point of introduction</li>" +
        // "</ul><br />" +

        // "By continuing, you acknowledge that your engagement with any third-party service is at your own discretion and risk, and that Wealth Factory is not liable for the outcome of any such interaction.<br /><br />" +

        // "If you have any questions, our support team is here to assist you.<br /><br />" +

        // "Warm regards,<br />" +
        // "<b>Team Wealth Factory</b>" +
        // "</td>" +
        // "</tr>" +
        // "</table>";
        StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; " +
                "line-height:23px; text-align:justify; width:100%; border:1px solid #ccc; border-radius:6px;\">" +

  // 🔹 Header Row
  "<tr>" +
    "<td style='background:#009688; color:#fff; font-size:16px; font-weight:bold; text-align:center; padding:8px; border-radius:6px 6px 0 0;'>" +
      "Important Disclaimer" +
    "</td>" +
  "</tr>" +

  // 🔹 Body Row
  "<tr>" +
    "<td style='padding:12px;'>" +
      "<span>Dear <strong>" + lblUserNAme.Text + "</strong>,</span><br /><br />" +
      "Thank you for logging into <strong>Wealth Factory</strong>.<br /><br />" +
      "Please note the following important disclaimer as you proceed to explore opportunities through our platform:<br /><br />" +

      "<b>Disclaimer</b><br />" +
      "Wealth Factory acts solely as an introducer and is not a party to any financial, legal, or commercial transaction between you and any third-party website or business you may be redirected to. Our role is limited to facilitating access by connecting interested users with offerings from independent third-party entities.<br /><br />" +

      "All transactions, agreements, and communications are conducted directly between you and the third-party website/business, which holds sole responsibility for their content, execution, and fulfillment.<br /><br />" +

      "Wealth Factory:<br />" +
      "<ul style='margin:0; padding-left:20px;'>" +
          "<li>Does not verify or monitor the performance or enforceability of third-party transactions</li>" +
          "<li>Is not liable for any disputes, delays, or losses arising from such dealings</li>" +
          "<li>May, where reasonably necessary, share relevant user details and assist with basic coordination at the point of introduction</li>" +
      "</ul><br />" +

      "By continuing, you acknowledge that your engagement with any third-party service is at your own discretion and risk, and that Wealth Factory is not liable for the outcome of any such interaction.<br /><br />" +

      "If you have any questions, our support team is here to assist you.<br /><br />" +

      "Warm regards,<br />" +
      "<b>Team Wealth Factory</b>" +
    "</td>" +
  "</tr>" +
"</table>";


        MyMessage.Subject = subject;
        MyMessage.Body = StrMsg;
        //MyMessage.Body = body;
        MyMessage.IsBodyHtml = true;

        System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(Session["MailHost"].ToString());
        smtp.Port = 587;
        smtp.EnableSsl = true;
        smtp.UseDefaultCredentials = false;
        smtp.Credentials = new System.Net.NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
        smtp.Send(MyMessage);
        //return true;
        //// Send Email
        //System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
        //mail.To.Add("user@example.com");  // Replace with login user email
        //mail.From = new System.Net.Mail.MailAddress("noreply@yourdomain.com");
        //mail.Subject = subject;
        //mail.Body = body;
        //mail.IsBodyHtml = false;

        //System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
        //smtp.Host = "smtp.yourserver.com"; // Replace with SMTP server
        //smtp.Port = 587;
        //smtp.Credentials = new System.Net.NetworkCredential("username", "password");
        //smtp.EnableSsl = true;
        //smtp.Send(mail);

        // Redirect to Home/Index page after sending mail
        Response.Redirect("Index.aspx",false);
        
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
