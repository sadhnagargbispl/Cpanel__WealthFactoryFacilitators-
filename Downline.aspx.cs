using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Downline : System.Web.UI.Page
{
    DataTable dt;
    SqlConnection conn = new SqlConnection();
    SqlCommand comm = new SqlCommand();
    SqlDataAdapter adp;
    DataSet ds = new DataSet();
    private clsGeneral dbGeneral = new clsGeneral();
    private cls_DataAccess dbConnect;
    string strquery;
    string frmCondition = "";
    int aCnt = 0;
    int bCnt = 0;
    DAL objDAL = new DAL();
    // ModuleFunction objModuleFun = new ModuleFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] == "OK")
            {
                if (!Page.IsPostBack)
                {
                    FillDownlineSumm();
                    FillDownline(null, true);
                    FillDownline();
                }
            }
            else
            {
                Response.Redirect("logout.aspx");
            }
        }
        catch (Exception ex)
        {

        }

    }
    private void FillDownline(string condition = "", bool isSideA = false)
    {
        try
        {
            DataTable dt = new DataTable();
            strquery = "exec sp_ShowDownLineUpdate " + Session["Formno"] + ",'" + TxtFromDate.Text + "','" + TxtToDate.Text + "'," + (isSideA ? 1 : 2) + "";
            dt = objDAL.GetData(strquery);
            if (isSideA)
            {
                Session["DirectData1"] = dt;
                RptDirects.DataSource = dt;
                RptDirects.DataBind();
                DivSideA.Style["display"] = "block";

            }
            else
            {
                Session["DirectData2"] = dt;
                Repeater3.DataSource = dt;
                Repeater3.DataBind();
                DivSideB.Style["display"] = "block";
            }
            RadioButton();
        }
        catch (Exception ex)
        {
            if (isSideA)
            {
                Response.Write(ex.Message + "SideA");
            }
            else
            {
                Response.Write(ex.Message + "SideB");
            }

            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void FillDownlineSumm()
    {
        try
        {
            // dbConnect.OpenConnection();

            strquery = "SELECT * FROM V#DownlineInfo WHERE FormNo=" + Session["Formno"];
            DataTable dt = new DataTable();
            dt = objDAL.GetData(strquery);

            // Comm = new SqlCommand(strquery, dbConnect.cnnObject);
            // Adp = new SqlDataAdapter(Comm);
            // ds = new DataSet
            // Adp.Fill(ds, "DtSummary");
            if (dt.Rows.Count > 0)
            {
                LblMemLJ.InnerText = dt.Rows[0]["RegisterLeft"].ToString();
                LblMemRJ.InnerText = dt.Rows[0]["RegisterRight"].ToString();
                LblMemLT.InnerText = dt.Rows[0]["ConfirmLeft"].ToString();
                LblMemRT.InnerText = dt.Rows[0]["ConfirmRight"].ToString();
                // LblLeftBv.InnerText = dt.Rows[0]["Leftbv"].ToString();
                //LblRightBv.InnerText = dt.Rows[0]["Rightbv"].ToString();
            }

            // Comm.Cancel();
            // ds.Dispose();
            RadioButton();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void rbleg_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButton();
    }
    private void RadioButton()
    {
        try
        {
            if (rbleg.SelectedIndex == 1)
            {
                DivSideA.Style["display"] = "block";
                DivSideB.Style["display"] = "none";
            }
            else if (rbleg.SelectedIndex == 2)
            {
                DivSideA.Style["display"] = "none";
                DivSideB.Style["display"] = "block";
            }
            else
            {
                DivSideA.Style["display"] = "block";
                DivSideB.Style["display"] = "block";
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void ExportToExcel(string strFileName, ref DataGrid dg)
    {
        var sw = new System.IO.StringWriter();
        HtmlTextWriter htw;
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/vnd.xls";
        Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
        Response.Charset = "";
        dg.EnableViewState = false;
        htw = new HtmlTextWriter(sw);
        dg.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public static void ExportToSpreadsheet(DataTable table, string name)
    {
        HttpContext context = HttpContext.Current;
        context.Response.Clear();

        foreach (DataColumn column in table.Columns)
        {
            context.Response.Write(column.ColumnName + ";");
        }
        context.Response.Write(Environment.NewLine);

        foreach (DataRow row in table.Rows)
        {
            for (int i = 0; i < table.Columns.Count; i++)
            {
                context.Response.Write(row[i].ToString().Replace(";", string.Empty) + ";");
            }
            context.Response.Write(Environment.NewLine);
        }

        context.Response.ContentType = "text/csv";
        context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".csv");
        context.Response.End();
    }
    private void ExportDownline(string condition = "", bool isSideA = false)
    {
        try
        {
            DataTable dtTemp = new DataTable();

            string strquery = " exec sp_ShowDownline " + Convert.ToInt32(Session["Formno"].ToString()) + "," + (isSideA ? 1 : 2);

            DataTable dt = new DataTable();
            dt = objDAL.GenerateTreeProc(strquery);
            DataGrid dg = new DataGrid();

            dtTemp.Columns.Add("<b>Id No</b>");
            dtTemp.Columns.Add("<b>Member Name</b>");
            dtTemp.Columns.Add("<b>Sponsor Id</b>");
            dtTemp.Columns.Add("<b>Date Of Joining</b>");
            dtTemp.Columns.Add("<b>Package</b>");
            dtTemp.Columns.Add("<b>Topup Date</b>");
            dtTemp.Columns.Add("<b>Package MRP</b>");
            dtTemp.Columns.Add("<b>PV</b>");

            for (int rCnt = 0; rCnt < dt.Rows.Count; rCnt++)
            {
                DataRow drAddItem = dtTemp.NewRow();
                for (int cCnt = 0; cCnt < 8; cCnt++)
                {
                    drAddItem[cCnt] = dt.Rows[rCnt][cCnt].ToString();
                }
                dtTemp.Rows.Add(drAddItem);
            }

            dg.DataSource = dtTemp;
            dg.DataBind();

            if (isSideA)
            {
                ExportToExcel("SideADownline.xls", ref dg);
            }
            else
            {
                ExportToExcel("SideBDownline.xls", ref dg);
            }
        }
        catch (Exception ex)
        {
            if (isSideA)
            {
                Response.Write(ex.Message + "Error In Exporting Side A");
            }
            else
            {
                Response.Write(ex.Message + "Error In Exporting Side B");
            }

            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void BtnExportB_Click(object sender, EventArgs e)
    {
        try
        {
            ExportDownline("", false);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void BtnExportA_Click(object sender, EventArgs e)
    {
        try
        {
            ExportDownline("", true);
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            objDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        FillDownline();
    }
    protected void Repeater3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        FillDownline();
    }

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        FillDownlineSumm();
        FillDownline(null, true);
        FillDownline();
    }
}