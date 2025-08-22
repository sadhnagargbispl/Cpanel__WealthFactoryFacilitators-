using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using ClosedXML.Excel;
using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reply : System.Web.UI.Page
{
    DataTable Dt = new DataTable();
    string scrname;
    DAL objDAL = new DAL();
    ModuleFunction objModuleFun;
    string CIdQS;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            objDAL = new DAL();
            if (string.IsNullOrEmpty(Request.QueryString["CId"]) == false)
            {
                CIdQS = Request.QueryString["CId"];

                if (!IsPostBack)
                {
                    if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                    {
                        if (string.IsNullOrEmpty(Request.QueryString["CId"]) == false)
                        {
                            BindData();
                        }
                    }
                    else
                    {
                        scrname = "<SCRIPT language='javascript'> window.top.location.reload();" + "</SCRIPT>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Close", scrname, false);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    public string GenerateRandomString(int iLength)
    {
        Random rdm = new Random();
        char[] allowChrs = "123456789".ToCharArray();
        string sResult = "";

        for (int i = 0; i < iLength; i++)
        {
            sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
        }

        return sResult;
    }

    private void BindData()
    {
        try
        {
            CIdQS = Request.QueryString["CId"];
            string sql = "Select M.IDNo,M.MemName,ISNULL(Replace(CONVERT(varchar,M.RecTimeStamp,106),' ','-'),'') as CDate,";
            sql += "M.CType,M.Complaint ,ISNULL(S.Solution,'') as Solution,ISNULL(Replace(CONVERT(varchar,S.RecTimeStamp,106),' ','-'),'') as SDate FROM";
            sql += "(Select b.MemFirstName +' '+ b.MemLastName as MemName,a.*";
            sql += " FROM " + objDAL.dBName + "..M_ComplaintMaster as a," + objDAL.dBName + "..M_MemberMaster as b";
            sql += " WHERE a.IDNo=b.IDNo AND a.CID='" + CIdQS + "') as M LEFT JOIN " + objDAL.dBName + "..M_SolutionMaster as S";
            sql += " ON M.CID=S.CID";
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            if (Dt.Rows.Count > 0)
            {
                LblCType.Text = Dt.Rows[0]["CType"].ToString();
                TxtComplaint.Text = Dt.Rows[0]["Complaint"].ToString();
                TxtPreReply.Text = "";
                for (int i = 0; i < Dt.Rows.Count; i++)
                {
                    if (TxtPreReply.Text != "")
                    {
                        TxtPreReply.Text = TxtPreReply.Text + Environment.NewLine + "-----------------------------------------" + Environment.NewLine;
                    }
                    if (Dt.Rows[i]["Solution"].ToString().Trim() != "")
                    {
                        TxtPreReply.Text = TxtPreReply.Text + Dt.Rows[i]["SDate"].ToString() + ": " + Environment.NewLine + Dt.Rows[i]["Solution"].ToString();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private string DisableTheButton(Control pge, Control btn)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
        sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
        sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
        sb.Append("this.value = 'Please wait...';");
        sb.Append("this.disabled = true;");
        sb.Append(pge.Page.GetPostBackEventReference(btn));
        sb.Append(";");
        return sb.ToString();
    }


    private void ClearAll()
    {
        try
        {
            LblCType.Text = "";
            TxtComplaint.Text = "";
            TxtPreReply.Text = "";

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}
