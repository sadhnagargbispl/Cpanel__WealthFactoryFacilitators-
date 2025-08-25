using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class Reward : System.Web.UI.Page
{
    SqlConnection Conn;
    SqlCommand Comm;
    DataSet Ds = new DataSet();
    SqlDataAdapter Ad;
    DAL obj = new DAL();
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && (string)Session["Status"] == "OK")
            {
               // AchievePair();
                AchieveReward();
                NextReward();
                PendingReward();
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
    private void PendingReward()
    {
        try
        {
            string str = "select * from M_RewardFinal where formno='" + Session["Formno"] + "'";
            DataTable Dt = new DataTable();
            Dt = obj.GetData(str);
            string sql;

            if (Dt.Rows.Count > 0)
            {
                sql = "select Reward,Amount,Cast(RDays as int) as RDays, " +
                      "0 as RemainingDays, " +
                      "Notimelimit,newpair from M_rewardmaster as a " +
                      "Left Join M_membermaster as c On c.Formno='" + Session["FormNo"] + "' where " +
                      "RewardId Not In(Select Distinct(Rewardid)+1 " +
                      "from M_RewardFinal where Formno='" + Session["FormNo"] + "' Group by Formno,Rewardid ) and RewardId>1";

                Dt = new DataTable();
                Dt = obj.GetData(sql);

                if (Dt.Rows.Count > 0)
                {
                    for (int i = 0; i < Dt.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            Dt.Rows[i]["RemainingDays"] = Convert.ToInt32(Session["RemainDays"]) + Convert.ToInt32(Dt.Rows[i]["RDays"]);
                        }
                        else
                        {
                            Dt.Rows[i]["RemainingDays"] = Convert.ToInt32(Dt.Rows[i - 1]["RemainingDays"]) + Convert.ToInt32(Dt.Rows[i]["RDays"]);
                        }
                    }

                    Session["RemainDays"] = "0";
                    GrdPending.DataSource = Dt;
                    GrdPending.DataBind();
                }
                else
                {
                    sql = "select * from M_Rewardmaster where Rewardid>1";
                    Dt = new DataTable();
                    Dt = obj.GetData(sql);
                    GrdPending.DataSource = Dt;
                    GrdPending.DataBind();
                }
            }
            else
            {
                string sql1 = "select Rank,Reward,Amount,Cast(RDays as int) as RDays,Cast(CummRdays as Int) as Cummrdays, " +
                              "0 as RemainingDays, Case when DateDiff(Day,c.UpgradeDate,Getdate())>Cast(CummRDays as int) then " +
                              "0 else Cast(CummRDays as int)-DateDiff(Day,c.UpgradeDate,Getdate()) end as RemainDays, " +
                              "Notimelimit,Pair as newpair,c.ActiveStatus from M_rewardmaster as a " +
                              "Left Join M_membermaster as c On c.Formno='" + Session["FormNo"] + "' where " +
                              "RewardId Not In(Select Distinct(Rewardid)+1 " +
                              "from M_RewardFinal where Formno='" + Session["FormNo"] + "' Group by Formno,Rewardid ) and RewardId>1";

                Dt = new DataTable();
                Dt = obj.GetData(sql1);
                int k = 0;

                if (Dt.Rows.Count > 0)
                {
                    for (int i = 0; i < Dt.Rows.Count; i++)
                    {
                        if (Dt.Rows[0]["ActiveStatus"].ToString() == "N")
                        {
                            Dt.Rows[i]["RemainingDays"] = Convert.ToInt32(Dt.Rows[i]["CummRdays"]);
                        }
                        else if (i == 0 && Convert.ToInt32(Dt.Rows[i]["RemainDays"]) == 0)
                        {
                            Dt.Rows[i]["RemainingDays"] = 0;
                        }
                        else if (Convert.ToInt32(Dt.Rows[i]["RemainDays"]) > 0 && k == 0)
                        {
                            Dt.Rows[i]["RemainingDays"] = Convert.ToInt32(Session["RemainDays"]) + Convert.ToInt32(Dt.Rows[i]["RemainDays"]);
                            k++;
                        }
                        else
                        {
                            Dt.Rows[i]["RemainingDays"] = Convert.ToInt32(Dt.Rows[i - 1]["RemainingDays"]) + Convert.ToInt32(Dt.Rows[i]["RDays"]);
                        }
                    }

                    Session["RemainDays"] = "0";
                    GrdPending.DataSource = Dt;
                    GrdPending.DataBind();
                }
                else
                {
                    sql = "select * from M_Rewardmaster where Rewardid>1";
                    Dt = new DataTable();
                    Dt = obj.GetData(sql);
                    GrdPending.DataSource = Dt;
                    GrdPending.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    private void NextReward()
    {
        try
        {
            string s = "Exec Sp_NextReward '" + Session["Formno"] + "'";
            DataTable Dt = new DataTable();
            Dt = obj.GetData(s);

            if (Dt.Rows.Count > 0)
            {
                Session["RemainDays"] = Dt.Rows[0]["Remaining Days"];
                GrdNext.DataSource = Dt;
                GrdNext.DataBind();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    //private void AchievePair()
    //{
    //    try
    //    {
    //        string str = "select * from V#RpInfo where FormNo='" + Session["FormNo"] + "'";
    //        DataTable Dt = new DataTable();
    //        Dt = obj.GetData(str);
    //        GrdRewardPair.DataSource = Dt;
    //        GrdRewardPair.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        string path = HttpContext.Current.Request.Url.AbsoluteUri;
    //        string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
    //        obj.WriteToFile(text + ex.Message);
    //        Response.Write("Try later.");
    //        Response.Write(ex.Message);
    //        Response.End();
    //    }
    //}
    private void AchieveReward()
    {
        try
        {
            string str = "Exec Sp_AchievedReward '" + Session["formno"] + "'";
            DataTable dt = obj.GetData(str);
            GrdRewards.DataSource = dt;
            GrdRewards.DataBind();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
            Response.Write(ex.Message);
            Response.End();
        }
    }
    protected void Reedembtn(object sender, EventArgs e)
    {
        GridViewRow GridvwRow;
        string R = "";
        GridvwRow = (GridViewRow)((Control)sender).Parent.Parent;

        Label lblRewards = (Label)GridvwRow.FindControl("lblreward");

        string dl = "Update M_RewardFinal set IsRedeem='Y',Redeemdate=Getdate() " +
                    "where FormNo='" + Session["FormNo"] + "' and Rewardid='" + Convert.ToInt32(lblRewards.Text) + "'";

        int updateeffect = 0;
        string scrname = "";

        updateeffect = obj.SaveData(dl);

        if (updateeffect != 0)
        {
            scrname = "<SCRIPT language='javascript'>alert('Redeem Successfully!');</SCRIPT>";
        }
        else
        {
            scrname = "<SCRIPT language='javascript'>alert('Redeem Unsuccessful!');</SCRIPT>";
        }

        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Reward", scrname, false);
        AchieveReward();
    }

}
