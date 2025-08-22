using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeamInvestMent : System.Web.UI.Page
{
    private string query;
    private DataTable dt = new DataTable();

    private DAL Obj = new DAL();
    private string IsoStart;
    private string IsoEnd;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    Session["DtDirect"] = null;
                    FillDetail();
                }

            }
            else
            {
                Response.Redirect("logout.aspx");
            }

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

    private void FillDetail()
    {
        try
        {
            DataTable dt = new DataTable();
            if (Session["DtDirect"] == null)
            {
                string con = "";
                string frmDate = TxtFromDate.Text;
                string toDate = TxtToDate.Text;

                if (!string.IsNullOrEmpty(frmDate))
                {
                    try
                    {
                        DateTime dtFromDate = Convert.ToDateTime(frmDate);
                    }
                    catch (Exception) { }
                }

                if (!string.IsNullOrEmpty(toDate))
                {
                    try
                    {
                        DateTime dtToDate = Convert.ToDateTime(toDate);
                    }
                    catch (Exception) { }
                }

                if (!string.IsNullOrEmpty(frmDate) && !string.IsNullOrEmpty(toDate))
                {
                    con = " And Cast(a.BillDate as Date)>='" + frmDate + "' And Cast(a.BillDate as Date)<='" + toDate + "'";
                }
                string query = "";
                if (ddltype.SelectedValue == "A")
                {
                    query = "SELECT SUM(LeftBusiness) AS [Left Business], SUM(RightBusiness) AS [Right Business] " +
                              "FROM (SELECT SUM(Repurchincome) AS LeftBusiness, 0 AS RightBusiness " +
                              "FROM " + Obj.dBName + "..Repurchincome AS a, " + Obj.dBName + "..M_memtreerelation AS b " +
                              "WHERE a.formno = b.formnodwn AND b.Legno = 1 AND a.BillType Not In ('R','V') AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "' " + con +
                              " UNION ALL " +
                              "SELECT 0 AS LeftBusiness, SUM(Repurchincome) AS RightBusiness " +
                              "FROM " + Obj.dBName + "..Repurchincome AS a, " + Obj.dBName + "..M_memtreerelation AS b " +
                              "WHERE a.formno = b.formnodwn AND b.Legno = 2 AND a.BillType Not In ('R','V') AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "'" + con + " union all " +
                              "SELECT isnull( Sum(a.PV),0.00) AS LeftBusiness, 0.00 AS RightBusiness   " +
                              "FROM  " + Obj.dBName + "..trnbv AS a where BVtype='S' and a.Formno='" + Convert.ToInt32(Session["Formno"]) + "' and (a.LegNo = 1)  " +
                              "GROUP BY a.FormNo       " +
                              " UNION ALL   " +
                              "SELECT  0.00 AS LeftBusiness, isnull(Sum(a.PV),0.00) AS RightBusiness    " +
                              "FROM " + Obj.dBName + "..trnbv as a where a.BVtype='S' and a.formno='" + Convert.ToInt32(Session["Formno"]) + "' and (a.LegNo = 2) " +
                              "GROUP BY a.FormNo " +
                              ") AS Temp";
                }
                else if (ddltype.SelectedValue == "R")
                {

                    query = "SELECT SUM(LeftBusiness) AS [Left Investment], SUM(RightBusiness) AS [Right Investment] " +
                               "FROM (SELECT SUM(Repurchincome) AS LeftBusiness, 0 AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a," + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 1 AND a.BillType='" + ddltype.SelectedValue + "' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "' " + con +
                               " UNION ALL " +
                               "SELECT 0 AS LeftBusiness, SUM(Repurchincome) AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a," + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 2 AND a.BillType='" + ddltype.SelectedValue + "' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "'" + con + " " +
                                " UNION ALL " +
                               "SELECT SUM(Repurchincome) AS LeftBusiness, 0 AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a, " + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 1 AND a.BillType='V' And Stacktype='R' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "' " + con +
                               " UNION ALL " +
                               "SELECT 0 AS LeftBusiness, SUM(Repurchincome) AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a, " + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 2 AND a.BillType='V' And Stacktype='R' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "'" + con + " " +
                               ") AS Temp";

                }
                else
                {

                    query = "SELECT SUM(LeftBusiness) AS [Left Investment], SUM(RightBusiness) AS [Right Investment] " +
                               "FROM (SELECT SUM(Repurchincome) AS LeftBusiness, 0 AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a," + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 1 AND a.BillType='" + ddltype.SelectedValue + "' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "' " + con +
                               " UNION ALL " +
                               "SELECT 0 AS LeftBusiness, SUM(Repurchincome) AS RightBusiness " +
                               "FROM " + Obj.dBName + "..Repurchincome AS a," + Obj.dBName + "..M_memtreerelation AS b " +
                               "WHERE a.formno = b.formnodwn AND b.Legno = 2 AND a.BillType='" + ddltype.SelectedValue + "' AND b.Formno = '" + Convert.ToInt32(Session["Formno"]) + "'" + con + " " +
                               ") AS Temp";
                }

                string str = IsoStart + query + IsoEnd;
                dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
                Session["DtDirect"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtDirect"];
            }

            if (dt.Rows.Count > 0)
            {
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
            }
            else
            {
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
            }
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

    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            FillDetail();
            RptDirects.PageIndex = e.NewPageIndex;
            RptDirects.DataBind();
        }
        catch (Exception) { }
    }

    protected void BtnShow_Click(object sender, EventArgs e)
    {
        try
        {
            Session["DtDirect"] = null;
            FillDetail();
        }
        catch (Exception) { }
    }

}
