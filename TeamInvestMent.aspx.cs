using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Spreadsheet;
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

public partial class TeamInvestMent : System.Web.UI.Page
{
    string strquery;
    DataTable dt;
    clsGeneral objGen = new clsGeneral();
    private DAL objDAL = new DAL();
    SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            if (!Page.IsPostBack)
            {

                Filldate();
                FillLevel();
                LevelDetail();
                FillLevel_Ra();

            }
        }
        else
        {
            Response.Redirect("Logout.aspx");
        }
    }
    protected void FillLevel()
    {
        try
        {
            string query = "Select distinct * from (Select 0 As MLevel,'-- ALL --' As LevelName Union ALL " +
                           " select MLevel,'Level :' + convert(varchar, MLevel) as LevelName from R_MemTreeRelation with(nolock) " +
                           "where FormNo='" + Session["FormNo"] + "') as Temp order by MLevel";

            using (SqlCommand command = new SqlCommand(query, Conn))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);


            }
        }
        catch (Exception ex)
        {
        }
    }
    private void Filldate()
    {
        try
        {
            DAL objDAL;
            DataTable dtData = new DataTable();
            objDAL = new DAL();
            string query = "Select Replace(Convert(Varchar,Getdate(),106),' ','-') as CurrentDate";
            dtData = objDAL.GetData(query);
            if (dtData.Rows.Count > 0)
            {
                // TxtFromDate.Text = dtData.Rows[0]["CurrentDate"].ToString();
                // TxtToDate.Text = dtData.Rows[0]["CurrentDate"].ToString();
            }
        }
        catch (Exception ex)
        {
            // Handle exception (logging can be added here)
        }
    }
    protected void LevelDetail()
    {
        string str = "";
        string condition = "";

        try
        {

            string scrname = "";
            string FrmDate = TxtFromDate.Text;
            string ToDate = TxtToDate.Text;

            if (!string.IsNullOrEmpty(FrmDate))
            {
                try
                {
                    DateTime Dt = Convert.ToDateTime(FrmDate);
                }
                catch (Exception ex)
                {
                    scrname = "<SCRIPT language='javascript'>alert('Check Start Date.. ');" + "</SCRIPT>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", scrname);
                    return;
                }
            }

            if (!string.IsNullOrEmpty(ToDate))
            {
                try
                {
                    DateTime Dt = Convert.ToDateTime(ToDate);
                }
                catch (Exception ex)
                {
                    scrname = "<SCRIPT language='javascript'>alert('Check End Date.. ');" + "</SCRIPT>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", scrname);
                    return;
                }
            }

            if (!string.IsNullOrEmpty(FrmDate) && !string.IsNullOrEmpty(ToDate))
            {
                condition += " And Cast(Convert(Varchar,b.rectimestamp,106) as Date) >= '" + FrmDate + "' And Cast(Convert(Varchar,b.rectimestamp,106) as Date) <= '" + ToDate + "'";

                // condition += " And b.BillDate >= '" + FrmDate + "' And b.BillDate <= '" + ToDate + "'";
            }

            str = "select Replace(Convert(Varchar, b.rectimestamp,106),' ','-')+' '+CONVERT(varchar(15),CAST(b.rectimestamp AS TIME),22) as [Bill Date], a.Idno, (a.MemFirstName + ' ' + a.MemLastName) As [Member Name], " +
                  "Case when d.LegNo = 1 then 'Left' else 'Right' end as [Group Name], " +
                  "b.RepurchIncome as [Business] " +
                  "from M_MemberMaster as a with(nolock) inner Join M_MemTreeRelation as d with(nolock) on a.Formno = d.FormnoDwn " +
                  "Inner Join RepurchIncome as b with(nolock) on a.Formno = b.Formno " +
                  "where d.Formno = '" + Session["Formno"] + "' " +
                  condition + " and a.Formno = b.Formno  " +
                  "Order by b.rectimestamp desc";
            //AND B.MBV <> 0 and b.BillType <> 'R'
            DataTable dt = new DataTable();
            DAL obj = new DAL();
            dt = objDAL.GetData(str);
            Session["DirectData1"] = dt;
            GrdDirects.DataSource = dt;
           // LblttlRcd.Text = dt.Rows.Count.ToString();
            LblttlRcd1.Text = dt.Rows.Count.ToString();
            GrdDirects.CurrentPageIndex = 0;
            GrdDirects.PageSize = Convert.ToInt32(ddlPazeSize.SelectedValue);
            GrdDirects.DataBind();

            divR.Visible = false;
            //divT.Visible = true;
            lblleftbv.Visible = true;
            lblbv.Visible = true;
            DataRow aDr1 = dt.NewRow();

            try
            {
               // Lblleft.Text = dt.Compute("Sum(Business)", "").ToString();
                //Lblright.Text = "0";
                lblleftbv.Text = dt.Compute("Sum(Business)", "").ToString();
                lblleftbv.Text = "0";
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }
            try
            {
                //Lblright.Text = dt.Compute("Sum(Business)", "").ToString();
                //Lblleft.Text = "0";
                lblbv.Text = dt.Compute("Sum(Business)", "").ToString();
                lblbv.Text = "0";
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }
            DataTable dt1 = dt.Copy();
            DataView dv = new DataView(dt1);
            dv.RowFilter = "[Group Name] = 'Left'";
            dt1 = dv.ToTable();

            try
            {
                if (dt1.Rows.Count > 0)
                {
                    DataRow aDr2 = dt1.NewRow();
                   // Lblleft.Text = dt1.Compute("Sum(Business)", "").ToString();
                    lblleftbv.Text = "Left Business :" + dt1.Compute("Sum(Business)", "").ToString();
                }
                else
                {
                    //Lblleft.Text = "0.00";
                    lblleftbv.Text = "Left Business : 0.00";
                }
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }
            dt1 = dt.Copy();
            DataView dv1 = new DataView(dt1);
            dv1.RowFilter = "[Group Name] = 'Right'";
            dt1 = dv1.ToTable();

            try
            {
                if (dt1.Rows.Count > 0)
                {
                    DataRow aDr3 = dt1.NewRow();
                    //Lblright.Text = dt1.Compute("Sum(Business)", "").ToString();
                    lblbv.Text = "Right Business:" + dt1.Compute("Sum(Business)", "").ToString();
                }
                else
                {
                    //Lblright.Text = "0.00";
                    lblbv.Text = "Right Business: 0.00";
                }
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }

            divR.Visible = false;
            //divT.Visible = true;

            //DataRow aDr1 = dt.NewRow();
            aDr1 = dt.NewRow();
            try
            {

                try
                {
                    //Lblleft.Text = dt.Compute("Sum(Business)", "").ToString();
                }
                catch (Exception ex) { }

               // Lblright.Text = "0";
            }
            catch (Exception ex) { }

            try
            {

                if (dt.Rows.Count > 0)
                {
                    try
                    {
                       // Lblright.Text = dt.Compute("Sum(Business)", "").ToString();
                    }
                    catch (Exception ex) { }
                }
                //Lblleft.Text = "0";
            }
            catch (Exception ex) { }


            //DataTable dt1 = dt.Copy();
            dt1 = dt.Copy();

            //DataView dv = new DataView(dt1);
            dv = new DataView(dt1);
            dv.RowFilter = "[Group Name] = 'Left'";
            dt1 = dv.ToTable();
            if (dt1.Rows.Count > 0)
            {
                DataRow aDr2 = dt1.NewRow();
                try
                {
                    //Lblleft.Text = dt1.Compute("Sum(Business)", "").ToString();
                }
                catch (Exception ex) { }
            }
            else
            {
                //Lblleft.Text = "0.00";
                //LblLeftRoyalty.Text = "0.00";
            }

            dt1 = dt.Copy();
            //DataView dv1 = new DataView(dt1);
            dv1 = new DataView(dt1);
            dv1.RowFilter = "[Group Name] = 'Right'";
            dt1 = dv1.ToTable();
            if (dt1.Rows.Count > 0)
            {
                DataRow aDr3 = dt1.NewRow();
                try
                {
                    //Lblright.Text = dt1.Compute("Sum(Business)", "").ToString();
                }
                catch (Exception ex) { }
            }
            else
            {
                //Lblright.Text = "0.00";
            }

            divR.Visible = true;
            //divT.Visible = false;
            if (dt.Rows.Count > 0)
            {
                try
                {
                    lblTotalBV.Text = dt.Compute("Sum([Business])", "").ToString();
                }
                catch (Exception ex) { }
            }
            else
            {
                lblTotalBV.Text = "0";
                //totalrp.Text = "0";
            }

            try
            {
                //Lblleft.Text = dt.Compute("Sum(Business)", "").ToString();
                //Lblright.Text = "0";
            }
            catch (Exception ex) { }

            if (dt.Rows.Count > 0)
            {
                try
                {
                   // Lblright.Text = dt.Compute("Sum(Business)", "").ToString();
                }
                catch (Exception ex) { }
            }
            //Lblleft.Text = "0";
           // leftrp.Text = "0";
            //DataTable dt1 = dt.Copy();
            dt1 = dt.Copy();
            //DataView dv = new DataView(dt1);
            dv = new DataView(dt1);
            dv.RowFilter = "[Group Name] = 'Left'";
            dt1 = dv.ToTable();
            if (dt1.Rows.Count > 0)
            {
                DataRow aDr2 = dt1.NewRow();
                try
                {
                   // Lblleft.Text = dt1.Compute("Sum([Business])", "").ToString();
                }
                catch (Exception ex) { }
            }
            else
            {
                //Lblleft.Text = "0.00";
               // LblLeftRoyalty.Text = "0.00";
               // leftrp.Text = "0.00";
            }

            dt1 = dt.Copy();
            //DataView dv1 = new DataView(dt1);
            dv1 = new DataView(dt1);
            dv1.RowFilter = "[Group Name] = 'Right'";
            dt1 = dv1.ToTable();
            if (dt1.Rows.Count > 0)
            {
                DataRow aDr3 = dt1.NewRow();
                try
                {
                   // Lblright.Text = dt1.Compute("Sum([Business])", "").ToString();
                }
                catch (Exception ex) { }
            }
            else
            {
                //Lblright.Text = "0.00";

            }

            //divRoyalty.Visible = false;



        }
        catch (Exception)
        {
            // Handle exception if needed
        }


    }
    protected void GrdDirects_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        try
        {
            GrdDirects.CurrentPageIndex = 0;
            GrdDirects.CurrentPageIndex = e.NewPageIndex;
            GrdDirects.DataSource = Session["DirectData1"];
            GrdDirects.PageSize = Convert.ToInt32(ddlPazeSize.SelectedValue);
            GrdDirects.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void DdlLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LevelDetail();
        }
        catch (Exception ex)
        {
        }
    }
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LevelDetail();
        }
        catch (Exception ex)
        {
        }
    }
    protected void BtnExportToExcel_Click(object sender, EventArgs e)
    {

    }
    private void ExportToExcel(string strFileName, ref DataGrid dg)
    {
        try
        {
            StringWriter sw = new StringWriter();
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
        catch (Exception ex)
        {

        }
    }
    protected void RbtProduct_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //if (RbtProduct.SelectedValue == "R")
            //{

            //    LblLevel.Text = "Group Wise";
            //    DdlLevel.Visible = false;
            //    RbtLegNo.Visible = true;

            //}
            //else
            //{
            //    LblLevel.Text = "Group Wise";
            //    DdlLevel.Visible = false;
            //    RbtLegNo.Visible = true;
            //}
        }
        catch (Exception ex)
        {

        }
    }
    protected void FillLevel_Ra()
    {
        try
        {
            //if (RbtProduct.SelectedValue == "R")
            //{
            //    LblLevel.Text = "Group Wise";
            //    DdlLevel.Visible = false;
            //    RbtLegNo.Visible = true;
            //}
            //else
            //{
            //    LblLevel.Text = "Group Wise";
            //    DdlLevel.Visible = false;
            //    RbtLegNo.Visible = true;
            //}
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlPazeSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GrdDirects.DataSource = Session["DirectData1"];
            GrdDirects.PageSize = Convert.ToInt32(ddlPazeSize.SelectedValue);
            GrdDirects.DataBind();
        }
        catch (Exception)
        {
            // Handle exception if needed
        }
    }


}
