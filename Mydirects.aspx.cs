using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Drawing;

public partial class Mydirects : System.Web.UI.Page
{
    DataSet ds;
    DataTable dt;
    SqlConnection conn = new SqlConnection();
    SqlCommand comm = new SqlCommand();
    SqlDataAdapter adp;
    DAL obj = new DAL();
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string isoStart;
    string isoEnd;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    if (!string.IsNullOrEmpty(Request["typeforreportshow"]))
                    {
                        Session["DirDel"] = null;
                        Session["DirDelCount"] = null;
                        FillLevel();
                        DdlLevel.SelectedValue = "0";
                        DDlSearchby.SelectedValue = "Y";
                        LevelDetail(1);
                        FillData();
                    }
                    else if (!string.IsNullOrEmpty(Request["type"]))
                    {
                        Session["DirDel"] = null;
                        Session["DirDelCount"] = null;
                        FillLevel();
                        DdlLevel.SelectedValue = "1";
                        DDlSearchby.SelectedValue = "Y";
                        LevelDetail(1);
                        FillData();
                    }
                    else
                    {
                        Session["DirDel"] = null;
                        Session["DirDelCount"] = null;
                        FillLevel();
                        DdlLevel.SelectedValue = "0";
                        LevelDetail(1);
                        FillData();
                    }
                }

            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void FillLevel()
    {
        // conn = new SqlConnection(Application["Connect"]);
        // conn.Open();
        try
        {
            SqlParameter[] prms = new SqlParameter[2];
            prms[0] = new SqlParameter("@FormNo", Session["FormNo"]);
            prms[1] = new SqlParameter("@type", "N");

            ds = SqlHelper.ExecuteDataset(constr1, "sp_GetLevel", prms);
            DdlLevel.DataSource = ds.Tables[0];
            DdlLevel.DataTextField = "LevelName";
            DdlLevel.DataValueField = "MLevel";
            DdlLevel.DataBind();
            // conn.Close();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void PageSize_Changed(object sender, EventArgs e)
    {
        try
        {
            LevelDetail(1);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    public void LevelDetail(int pageIndex)
    {
        try
        {
            DataTable dt = new DataTable();
            DataTable dt1 = new DataTable();

            if (Session["DirDel"] == null)
            {
                string legno = "";
                string level = "";
                string rank = "";
                if (rbtnsearch.SelectedValue == "L")
                {
                    legno = "0"; // Changed to string for consistency
                    level = DdlLevel.SelectedValue;
                    rank = "0"; // Changed to string for consistency
                }
                else
                {
                    legno = rbtnsearch.SelectedValue;
                    level = "1"; // Changed to string for consistency
                    rank = "0"; // Changed to string for consistency
                }

                // GrdDirects.DataSource = null;
                // GrdDirects.DataBind();

                SqlParameter[] prms = new SqlParameter[7];
                prms[0] = new SqlParameter("@MLevel", level);
                prms[1] = new SqlParameter("@Legno", legno);
                prms[2] = new SqlParameter("@ActiveStatus", DDlSearchby.SelectedValue);
                prms[3] = new SqlParameter("@FormNo", Session["FormNo"]);
                // prms[4] = new SqlParameter("@Rank", rank);
                prms[4] = new SqlParameter("@PageIndex", pageIndex);
                prms[5] = new SqlParameter("@PageSize", 100000);
                prms[6] = new SqlParameter("@RecordCount", SqlDbType.Int) { Direction = ParameterDirection.Output };

                ds = SqlHelper.ExecuteDataset(constr1, "sp_GetLevelDetailCpanel_", prms);
                dt = ds.Tables[0];
                Session["DirDel"] = dt;

                dt1 = ds.Tables[1];
                Session["DirDelCount"] = dt1;
            }
            else
            {
                dt = (DataTable)Session["DirDel"];
                dt1 = (DataTable)Session["DirDelCount"];
            }

            // GrdDirects.DataSource = ds.Tables[0];
            // GrdDirects.DataBind();

            if (dt1.Rows.Count > 0)
            {
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
                int recordCount = dt.Rows.Count;
                lbltotal.Text = recordCount.ToString();
            }
            else
            {
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
                int recordCount = 0;
                lbltotal.Text = recordCount.ToString();
            }

            // PopulatePager(recordCount, pageIndex);

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + " SideB");
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void FillData()
    {
        try
        {
            // string qry = " Select * from V#ReferalDownlineinfo where Formno=" + Session["FormNo"] + " ";
            // DataTable dt1 = new DataTable();
            // dt = Obj.GetData(qry);

            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            string strSql = isoStart + " Select * from V#ReferalDownlineinfo where Formno=" + Session["FormNo"] + " " + isoEnd;
            ds = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql);
            dt = ds.Tables[0];
            // dt = ObjDAL.GetData(strSql);
            if (dt.Rows.Count > 0)
            {
                tdDirectleft.InnerText = dt.Rows[0]["RegisterLeft"].ToString();
                tdDirectright.InnerText = dt.Rows[0]["RegisterRight"].ToString();
                TotalDirect.InnerText = (Convert.ToDecimal(dt.Rows[0]["RegisterLeft"]) + Convert.ToDecimal(dt.Rows[0]["RegisterRight"])).ToString();
                tddirectActive.InnerText = dt.Rows[0]["ConfirmLeft"].ToString();
                tdindirectActive.InnerText = dt.Rows[0]["ConfirmRight"].ToString();
                TotalActive.InnerText = (Convert.ToDecimal(dt.Rows[0]["ConfirmLeft"]) + Convert.ToDecimal(dt.Rows[0]["ConfirmRight"])).ToString();
                Directunit.InnerText = Convert.ToDecimal(dt.Rows[0]["LeftBv"]).ToString();
                indirectunit.InnerText = Convert.ToDecimal(dt.Rows[0]["RightBv"]).ToString();
                totalunit.InnerText = (Convert.ToDecimal(dt.Rows[0]["LeftBv"]) + Convert.ToDecimal(dt.Rows[0]["RightBv"])).ToString();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Session["DirDel"] = null;
            Session["DirDelCount"] = null;
            LevelDetail(1);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

    }
    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            RptDirects.PageIndex = e.NewPageIndex;
            LevelDetail(1);
        }
        catch (Exception ex)
        {
            // Optionally log the exception or handle it
        }

    }
    protected void rbtnsearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rbtnsearch.SelectedValue == "L")
            {
                lbllevel.Visible = true;
            }
            else
            {
                lbllevel.Visible = false;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }

}