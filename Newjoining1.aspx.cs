using ClosedXML.Excel;
using System;
using System.CodeDom;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Activities.Expressions;
using System.Activities;
using System.ServiceModel.Activities;


public partial class Newjoining1 : System.Web.UI.Page
{
    private double _dblAvailLeg = 0;
    private cls_DataAccess dbConnect;
    private DAL ObjDAL = new DAL();
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    public string DsnName, UserName, Passw;
    private string strQuery, strCaptcha;
    private DataTable tmpTable = new DataTable();
    private int minSpnsrNoLen, minScrtchLen;
    private double Upln, dblSpons, dblState, dblBank, dblIdNo;
    private string dblDistrict, dblTehsil, IfSC;
    private string dblPlan;
    private DateTime CurrDt;
    private string scrname;
    private string LastInsertID = "";
    private string Email = "";
    private string InVoiceNo;
    private int SupplierId;
    private string BillNo;
    private string TaxType;
    private string BillDate;
    private int SBillNo;
    private string SoldBy = "WR";
    private string FType;
    private string Password = "";
    private string membername = "";
    private string clsGeneral = "";
    private clsGeneral dbGeneral = new clsGeneral();
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private SqlConnection cnn;
    DataTable Dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        CmdSave.Attributes.Add("onclick", DisableTheButton(Page, CmdSave));
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

            cnn = new SqlConnection(constr1);

            dbConnect = new cls_DataAccess((string)Application["Connect"]);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            txtUplinerId.Text = (txtUplinerId.Text).Replace("'", "").Replace("=", "").Replace(";", "");

            string sr = "";
            string[] sbstr;
            string Key = "";
            string K = "";

            if (!Page.IsPostBack)
            {
                Session["OtpCount"] = 0;
                Session["OtpTime"] = null;
                Session["OTPP_"] = null;
                Session["Retry"] = null;

                HdnCheckTrnns.Value = GenerateRandomStringJoining(6);
                getData();

                Session["OtpCount"] = 0;
                ClrCtrl();

                RbtnLegNo.Items.Add("Left");
                RbtnLegNo.Items.Add("Right");
                RbtnLegNo.Items[0].Selected = true;

                if (!string.IsNullOrEmpty(Request.QueryString["s"]))
                {
                    K = Request["s"];
                    K = K.Replace(" ", "+");
                    sr = Crypto.Decrypt(K);

                    sbstr = sr.Split('/');
                    string UplinerFormno = sbstr[1];

                    DataTable dt = new DataTable();
                    string s = ObjDAL.Isostart + " select * from " + ObjDAL.dBName + "..M_MemberMaster where Formno='" + UplinerFormno + "'" + ObjDAL.IsoEnd;
                    dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, s).Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        txtUplinerId.Text = dt.Rows[0]["Idno"].ToString();
                    }

                    string LegNo = sbstr[3];

                    txtUplinerId.ReadOnly = true;
                    txtRefralId.Text = Session["Idno"].ToString();

                    if (LegNo == "1")
                    {
                        RbtnLegNo.SelectedIndex = 0;
                    }
                    else
                    {
                        RbtnLegNo.SelectedIndex = 1;
                    }

                    RbtnLegNo.Enabled = false;
                    Session["iLeg"] = LegNo;
                }
            refLink:

                if (Request.QueryString["ref"] != null)
                {

                    string req = Request.QueryString["ref"].Replace(" ", "+");
                    string str = Crypto.Decrypt(req);
                    string[] rfAr = str.Split('/');
                    if (rfAr.Length >= 1)
                    {
                        if (rfAr[0] != "" & rfAr[1] == "0")
                        {
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());

                            //goto refLink;
                        }
                        else if (rfAr[0] != "" & rfAr[1] == "1")
                        {
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());
                            RbtnLegNo.SelectedIndex = 0;
                            RbtnLegNo.Enabled = false;
                            goto refLink;
                        }
                        else if (rfAr[0] != "" & rfAr[1] == "2")
                        {
                            txtRefralId.Text = GetIDno(rfAr[0].ToString());
                            RbtnLegNo.SelectedIndex = 1;
                            RbtnLegNo.Enabled = false;
                            goto refLink;
                        }
                    }

                    //if (Request.QueryString["RefFormNo"].Length > 0)
                    //{
                    //    txtRefralId.Text = Get_IDNo(Convert.ToInt32(Request.QueryString["RefFormNo"]));
                    //    if (txtRefralId.Text.Trim() != "")
                    //    {
                    //        FillReferral(cnn);
                    //    }

                    //    txtRefralId.ReadOnly = true;
                    //}
                    if (txtRefralId.Text.Trim() != "")
                    {
                        FillReferral(cnn);
                    }
                    txtRefralId.ReadOnly = true;
                }

                FillPaymode(cnn);

                dbGeneral.Fill_Date_box(ddlDOBdt, ddlDOBmnth, ddlDOBYr, 1940, DateTime.Now.AddYears(-18).Year);
                dbGeneral.Fill_Date_box(DDlMDay, DDLMMonth, DDLMYear, 1940, DateTime.Now.Year);
                FillBankMaster(cnn);
                // FillStateMaster()
                FillCountryMasterNAme();
                FillCountryMasterCode();
                FindSession();
                GetConfigDtl(cnn);
                // sendSMS()
                vsblCtrl(false, true);
            }

            try
            {
                Session["Dsessid"] = 0;
            }
            catch { }

            if (Session["IsGetExtreme"].ToString() == "N")
            {
                rwSpnsr.Visible = true;
            }
            else
            {
                rwSpnsr.Visible = false;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    private string GetIDno(string Mid)
    {
        string Result = "";
        try
        {
            DataTable dt = new DataTable();

            //string strSql = ObjDAL.Isostart + "Select IDNO from " + ObjDAL.dBName + " ..M_MemberMAster Where MID = '" + Mid + "' " + ObjDAL.IsoEnd;
            string strSql = ObjDAL.Isostart + "Select IDNO from " + ObjDAL.dBName + "..M_MemberMAster Where MID = '" + Mid + "' " + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];

            if ((dt.Rows.Count > 0))
                Result = dt.Rows[0]["IDNO"].ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return Result;
    }
    private string Get_IDNo(int MyFormNo)
    {
        string IdNo = "";
        try
        {

            DataTable dt = new DataTable();

            string strSql = ObjDAL.Isostart + "select IdNo  from " + ObjDAL.dBName + "..M_MemberMaster WHERE FormNo='" + MyFormNo + "' " + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            if (dt.Rows.Count > 0)
            {
                IdNo = dt.Rows[0]["IdNo"].ToString();
            }
            //return IdNo;
        }
        catch (Exception ex)
        {

            throw new Exception(ex.Message);
        }
        return IdNo;
    }

    private string GetIDno(int Mid, ref SqlConnection cnn)
    {
        string Result = "";
        try
        {
            string strSql = ObjDAL.Isostart + "Select IDNO from " + ObjDAL.dBName + "..M_MemberMAster Where MID = '" + Mid + "' " + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            if (Dt.Rows.Count > 0)
            {
                Result = Dt.Rows[0]["IDNO"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return Result;
    }


    private string DisableTheButton(Control pge, Control btn)
    {
        try
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
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private string ClearInject(string StrObj)
    {
        try
        {
            StrObj = StrObj.Replace(";", "").Replace("'", "").Replace("=", "");
            return StrObj.Trim();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    private void FillCountryMasterNAme()
    {
        try
        {
            //strQuery = ObjDAL.Isostart + "SELECT CId,CountryNAme FROM " + ObjDAL.dBName + "..M_CountryMaster WHERE ACTIVESTATUS='Y' ORDER BY CountryNAme" + ObjDAL.IsoEnd;
            strQuery = "Exec Sp_GetCountry";
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];
            ddlCountryNAme.DataSource = Dt;
            ddlCountryNAme.DataValueField = "CId";
            ddlCountryNAme.DataTextField = "CountryNAme";
            ddlCountryNAme.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public string GenerateRandomStringJoining(int iLength)
    {
        try
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
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void FillPaymode(SqlConnection Cnn)
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + "SELECT * FROM " + ObjDAL.dBName + "..M_PayModeMaster WHERE ActiveStatus='Y' " + ObjDAL.IsoEnd;
            if (Session["DtPayMode"] == null)
            {
                Ds = SqlHelper.ExecuteDataset(Cnn, CommandType.Text, strSql);
                dt = Ds.Tables[0];
                Session["DtPayMode"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtPayMode"];
            }

            if (dt.Rows.Count > 0)
            {
                DdlPaymode.DataSource = dt;
                DdlPaymode.DataValueField = "PID";
                DdlPaymode.DataTextField = "Paymode";
                DdlPaymode.DataBind();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    private void GetConfigDtl(SqlConnection Cnn)
    {
        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + "select *  from " + ObjDAL.dBName + "..M_ConfigMaster " + ObjDAL.IsoEnd;
            if (Session["DtConfigDetail"] == null)
            {
                Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                dt = Ds.Tables[0];
                Session["DtConfigDetail"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtConfigDetail"];
            }
            if (dt.Rows.Count > 0)
            {
                Session["IsGetExtreme"] = dt.Rows[0]["IsGetExtreme"];
                Session["IsTopUp"] = dt.Rows[0]["IsTopUp"];
                Session["IsSendSMS"] = dt.Rows[0]["IsSendSMS"];
                Session["IdNoPrefix"] = dt.Rows[0]["IdNoPrefix"];
                Session["IsFreeJoin"] = dt.Rows[0]["IsFreeJoin"];
                Session["IsStartJoin"] = dt.Rows[0]["IsStartJoin"];
                Session["JoinStartFrm"] = dt.Rows[0]["JoinStartFrm"];
                Session["IsSubPlan"] = dt.Rows[0]["IsSubPlan"];
            }
            else
            {
                Session["IsGetExtreme"] = "N";
                Session["IsTopUp"] = "N";
                Session["IsSendSMS"] = "N";
                Session["IdNoPrefix"] = "";
                Session["IsFreeJoin"] = "N";
                Session["IsStartJoin"] = "N";
                Session["JoinStartFrm"] = "01-Sep-2011";
                Session["IsSubPlan"] = "N";
            }
        }
        catch
        {
            Session["CompName"] = "";
            Session["CompAdd"] = "";
            Session["CompWeb"] = "";
        }
    }

    protected void vsblCtrl(bool IsVsbl, bool IsOnlyDv)
    {
        try
        {
            if (!IsOnlyDv)
            {
                txtUplinerId.Enabled = !IsVsbl;
                txtRefralId.Enabled = !IsVsbl;
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    public string GenerateRandomString(int iLength)
    {
        try
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
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    public void SaveIntoDB()
    {
        try
        {
            string Strquery = "Insert into Trnjoining (Transid) values(" + HdnCheckTrnns.Value + ")";
            int isOk1 = 0;
            isOk1 = ObjDAL.SaveData(Strquery);
            if (isOk1 > 0)
            {
                char IsPanCard;
                string strQry = "";
                string strDOB, strDOM, strDOJ, s;
                int iLeg;
                char cGender, cMarried;
                cGender = 'M';
                cMarried = 'N';
                string HostIp = Context.Request.UserHostAddress.ToString();
                int DistrictCode, CityCode, VillageCode;
                int dblPlan;
                int InVoiceNo;
                CmdSave.Enabled = false;
                try
                {
                    if (Validt_SpnsrDtl("") == "OK")
                    {
                        iLeg = Convert.ToInt32(Session["iLeg"]);
                        if (RbtnLegNo.SelectedIndex == 0)
                        {
                            iLeg = 1;
                        }
                        else if (RbtnLegNo.SelectedIndex == 1)
                        {
                            iLeg = 2;
                        }
                        else
                        {
                            chkterms.Checked = false;
                            CmdSave.Enabled = true;
                            string scrname = "<SCRIPT language='javascript'>alert('Choose Position.');</SCRIPT>";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Choose Position.');", true);
                            RbtnLegNo.Enabled = true;
                            return;
                        }

                        TxtPasswd.Text = GenerateRandomString(6);

                        if (string.IsNullOrEmpty(txtEMailId.Text))
                        {
                            chkterms.Checked = false;
                            CmdSave.Enabled = true;
                            string scrname = "<SCRIPT language='javascript'>alert('Enter Email-Id.');</SCRIPT>";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Email-Id.');", true);
                            return;
                        }
                        if (string.IsNullOrEmpty(txtMobileNo.Text))
                        {
                            chkterms.Checked = false;
                            CmdSave.Enabled = true;
                            string scrname = "<SCRIPT language='javascript'>alert('Enter Mobile No.');</SCRIPT>";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Mobile No.');", true);
                            return;
                        }
                        //if (string.IsNullOrEmpty(txtaadharno.Text))
                        //{
                        //    chkterms.Checked = false;
                        //    CmdSave.Enabled = true;
                        //    string scrname = "<SCRIPT language='javascript'>alert('Enter Aadhar No.');</SCRIPT>";
                        //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Aadhar No.');", true);
                        //    return;
                        //}

                        if (!string.IsNullOrEmpty(txtEMailId.Text))
                        {
                            DataTable DtEmail = new DataTable();
                            DataSet DsEmail = new DataSet();
                            string strSql = ObjDAL.Isostart + " select Count(Email) as Email from " + ObjDAL.dBName + "..M_Membermaster where Email='" + txtEMailId.Text.Trim() + "' " + ObjDAL.IsoEnd;
                            DsEmail = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                            DtEmail = DsEmail.Tables[0];
                            if ((int)DtEmail.Rows[0]["Email"] >= 1)
                            {
                                CmdSave.Enabled = true;
                                chkterms.Checked = false;
                                string scrname = "<SCRIPT language='javascript'>alert('Already Registered by this Emailid.');</SCRIPT>";
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                                return;
                            }
                        }


                        if (!string.IsNullOrEmpty(txtMobileNo.Text))
                        {
                            string moblno = "";
                            string Check = "";
                            moblno = txtMobileNo.Text;
                            Check = moblno.Substring(0, 1);
                            if (Check == "0")
                            {
                                txtMobileNo.Text = "";
                                CmdSave.Enabled = true;
                                chkterms.Checked = false;
                                string scrname = "<SCRIPT language='javascript'>alert('Invalid Mobile No. .!');</SCRIPT>";
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                                return;
                            }
                        }

                        if (!string.IsNullOrEmpty(txtMobileNo.Text))
                        {
                            DataTable Dt1 = new DataTable();
                            DataSet Dsmob = new DataSet();
                            string strSql = ObjDAL.Isostart + "select Count(mobl) as mobileno from " + ObjDAL.dBName + "..M_Membermaster where Mobl='" + txtMobileNo.Text.Trim() + "' " + ObjDAL.IsoEnd;
                            Dsmob = SqlHelper.ExecuteDataset(cnn, CommandType.Text, strSql);
                            Dt1 = Dsmob.Tables[0];
                            if ((int)Dt1.Rows[0]["mobileno"] >= 1)
                            {
                                CmdSave.Enabled = true;
                                chkterms.Checked = false;
                                string scrname = "<SCRIPT language='javascript'>alert('Already Registered by this Mobile Number.');</SCRIPT>";
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                                return;
                            }
                        }

                        string q = "";
                        int i = 0;
                        DataTable Dt;

                        int BankCode = 0;
                        if (CmbBank.SelectedItem.Text.ToUpper() == "OTHERS")
                        {
                            if (!string.IsNullOrEmpty(TxtBank.Text))
                            {
                                Dt = new DataTable();
                                DataSet Ds = new DataSet();
                                q = ObjDAL.Isostart + "Select * from " + ObjDAL.dBName + "..M_BankMaster where BankName='" + TxtBank.Text.Trim() + "' and Activestatus='Y'and RowStatus='Y' " + ObjDAL.IsoEnd;
                                Ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, q);
                                Dt = Ds.Tables[0];
                                if (Dt.Rows.Count == 0)
                                {
                                    q = "insert into M_BankMaster (BankCode,BankName,AcNo,IFSCode,Remarks,ActiveStatus,LastModified,UserCode,UserId,IPAdrs,RowStatus) " +
                                        " Select Case When Max(BankCode) Is Null Then '1' Else Max(BankCode)+1 END as BankCode,'" + TxtBank.Text.ToUpper() + "','0','0', " +
                                        " '','Y','Add by " + Session["IdNo"] + " at " + DateTime.Now.ToString() + "','" + Session["MemName"] + "','" + Session["FormNo"] + "','','Y' From M_BankMaster ";

                                    dbConnect.OpenConnection();
                                    DataTable dtRead;
                                    cmd = new SqlCommand(q, dbConnect.cnnObject);
                                    i = cmd.ExecuteNonQuery();
                                    if (i > 0)
                                    {
                                        q = ObjDAL.Isostart + " select Max(BankCode)as BankCode from " + ObjDAL.dBName + " ..M_BankMaster where ActiveStatus='Y' and RowStatus='Y'" + ObjDAL.IsoEnd;
                                        dtRead = SqlHelper.ExecuteDataset(constr1, CommandType.Text, q).Tables[0];
                                        if (dtRead.Rows.Count > 0)
                                        {
                                            dblBank = (int)dtRead.Rows[0]["BankCode"];
                                        }
                                    }
                                }
                                else
                                {
                                    dblBank = (int)Dt.Rows[0]["BankCode"];
                                }
                            }
                        }
                        else
                        {
                            dblBank = Convert.ToDouble(CmbBank.SelectedValue);
                        }

                        int AreaCode = 0;
                        AreaCode = 0;

                        string RegestType = "";
                        if (RbCategory.SelectedValue == "IN")
                        {
                            RegestType = "IN";
                        }
                        else
                        {
                            RegestType = CbSubCategory.SelectedValue;
                        }
                        int PostalAreaCode = 0;
                        strDOB = ddlDOBdt.Text + "-" + ddlDOBmnth.Text + "-" + ddlDOBYr.Text;
                        strDOM = DDlMDay.Text + "-" + DDLMMonth.Text + "-" + DDLMYear.Text;
                        strDOJ = DateTime.Now.ToString("dd-MMM-yyyy");
                        dblDistrict = ClearInject(ddlDistrict.Text.ToUpper());
                        dblTehsil = ClearInject(ddlTehsil.Text.ToUpper());
                        if (dblDistrict == null)
                        {
                            dblDistrict = "";
                        }
                        dblState = 0;
                        DistrictCode = 0;
                        CityCode = 0;
                        VillageCode = 0;
                        IfSC = ClearInject(txtIfsCode.Text.ToUpper());
                        dblPlan = 0;
                        InVoiceNo = 0;

                        if ((int)Session["SessID"] == 0)
                        {
                            FindSession();
                        }

                        string Name = "";
                        string fathername = "";
                        if (RbCategory.SelectedValue == "IN")
                        {
                            Name = ClearInject(txtFrstNm.Text.ToUpper());
                            fathername = ClearInject(txtFNm.Text.ToUpper());
                        }
                        else
                        {
                            fathername = ClearInject(txtFrstNm.Text.ToUpper());
                            Name = ClearInject(TxtCompanyName.Text.ToUpper());
                        }

                        if (!string.IsNullOrEmpty(TxtAccountNo.Text) || !string.IsNullOrEmpty(txtIfsCode.Text))
                        {
                            if (string.IsNullOrEmpty(TxtAccountNo.Text))
                            {
                                chkterms.Checked = false;
                                CmdSave.Enabled = true;
                                string scrname = "<SCRIPT language='javascript'>alert('Enter Account No.');</SCRIPT>";
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter Account No.');", true);
                                return;
                            }

                            if (Convert.ToInt32(CmbBank.SelectedValue) == 0)
                            {
                                chkterms.Checked = false;
                                CmdSave.Enabled = true;
                                scrname = "<SCRIPT language='javascript'>alert('Choose Bank Name');" + "</SCRIPT>";
                                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Choose Bank Name.');", true);
                                return;
                            }

                            if (string.IsNullOrEmpty(txtIfsCode.Text))
                            {
                                chkterms.Checked = false;
                                CmdSave.Enabled = true;
                                string scrname = "<SCRIPT language='javascript'>alert('Enter IFS Code');</SCRIPT>";
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter IFS Code.');", true);
                                return;
                            }
                        }

                        DateTime Tdate = DateTime.Now;
                        strQry = "INSERT INTO m_memberMaster ( " +
                                "SessId, IdNo, CardNo, FormNo, KitId, " +
                                "UpLnFormNo, RefId, LegNo, RefLegNo, RefFormNo, " +
                                "MemFirstName, MemLastName, MemRelation, MemFName, MemDOB, MemGender, MemOccupation, " +
                                "NomineeName, Address1, Address2, Post, " +
                                "Tehsil, City, District, StateCode, CountryId, " +
                                "PinCode, PhN1, Fax, Mobl, MarrgDate, " +
                                "Passw, Doj, Relation, PanNo, " +
                                "BankID, MICRCode, BranchName, EMail, BV, " +
                                "UpGrdSessId, E_MainPassw, EPassw, ActiveStatus, billNo, RP, HostIp, " +
                                "PID, Paymode, ChDDNo, ChDDBankID, ChDDBank, ChddDate, ChDDBranch, IsPanCard, AadharNo, AadharNo2, AAdharNo3, Fld5,usercode) " +
                    "VALUES (" +
   Convert.ToInt32(Session["SessID"]) + ", 0, 0, 0, " + Convert.ToInt32(Session["Kitid"]) + ", " + Convert.ToInt32(Session["Uplnr"]) + ", " +
   "0, '" + iLeg + "', 0, " + Convert.ToInt32(Session["Refral"]) + ", '" + ClearInject(txtFrstNm.Text.ToUpper()) + "', '', " +
   "'" + CmbType.SelectedValue + "', '" + ClearInject(txtFNm.Text.ToUpper()) + "', '" + strDOB + "', '" + cGender + "', '', " +
   "'" + ClearInject(txtNominee.Text.ToUpper()) + "', '" + ClearInject(txtAddLn1.Text.ToUpper()) + "', '', '', '" + dblTehsil + "', '" + dblTehsil + "', '" +
   dblDistrict + "', " + dblState + ", "+ ddlCountryNAme.SelectedValue +", '" + txtPinCode.Text + "', '" + txtPhNo.Text + "', 'CHOOSE ACCOUNT TYPE', '" + txtMobileNo.Text + "', '" +
   strDOM + "', '" + ClearInject(TxtPasswd.Text) + "', Getdate(), '" + ClearInject(txtRelation.Text.ToUpper()) + "', '" + ClearInject(txtPanNo.Text.ToUpper()) + "', '" + dblBank + "', '" +
   ClearInject(TxtMICR.Text.ToUpper()) + "', '" + ClearInject(TxtBranchName.Text.ToUpper()) + "', '" + ClearInject(txtEMailId.Text) + "', " +
   Convert.ToInt32(Session["Bv"]) + ", 0, '" + ClearInject(TxtPasswd.Text) + "', '" + ClearInject(TxtPasswd.Text) + "', '" + Session["JoinStatus"] + "', '" + InVoiceNo + "', '" +
   Session["RP"] + "', '" + HostIp + "', " + Convert.ToInt32(DdlPaymode.SelectedValue) + ", '" + ClearInject(DdlPaymode.SelectedItem.Text.ToUpper()) + "', '" + ClearInject(TxtDDNo.Text) + "', '0', '" +
   ClearInject(TxtIssueBank.Text.ToUpper()) + "', '" + ClearInject(TxtDDDate.Text) + "', '" + ClearInject(TxtIssueBranch.Text) + "', 'N', '" + ClearInject(TxtAAdhar1.Text) + "', '" + ClearInject(TxtAadhar2.Text) + "', '" +
   ClearInject(TxtAadhar3.Text) + "', '" + Session["TransIDJoin"] + "','" + ddlMobileNAme.Text + "')";


                        int isOk = 0;
                        int retryqry = 0;
                    Savedata:
                        ;
                        isOk = SqlHelper.ExecuteNonQuery(constr, CommandType.Text, strQry);

                        LastInsertID = "0";
                        if (isOk > 0)
                        {
                            string membername = "";
                            string Email = "";
                            string mobl = "";
                            string Password = "";
                            DataTable Dtsms = new DataTable();
                            string strSql = string.Empty;

                            Dtsms = new DataTable();
                            DataSet Ds = new DataSet();

                            strSql = " SELECT TOP 1 a.IDNO,a.formno,b.IsBill,a.Passw,a.MemFirstname,";
                            strSql += "a.MemlastName,a.Email,a.mobl FROM m_MemberMaster as a,m_KitMaster as ";
                            strSql += "b where a.kitid=b.kitid And Email = '" + txtEMailId.Text.Trim() + "' Order By mid Desc ";
                            Dtsms = SqlHelper.ExecuteDataset(constr, CommandType.Text, strSql).Tables[0];
                            if ((Dtsms.Rows.Count > 0))
                            {
                                membername = Dtsms.Rows[0]["MemfirstName"] + " " + Dtsms.Rows[0]["MemLastName"];
                                Email = Dtsms.Rows[0]["Email"].ToString();
                                LastInsertID = Dtsms.Rows[0]["IDNO"].ToString();
                                Password = Dtsms.Rows[0]["Passw"].ToString();
                                mobl= Dtsms.Rows[0]["mobl"].ToString();
                                Session["Kit"] = Dtsms.Rows[0]["IsBill"].ToString();
                            }
                            else
                            {
                                LastInsertID = "10001";

                            }
                            if (Session["IsSendSMS"].ToString() == "Y")
                            {
                                //     sendSMS(cnn);
                            }
                            CmdSave.Enabled = true;
                            Session["LASTID"] = LastInsertID;
                            SendToMemberMail(LastInsertID, Email, membername, Password, mobl);
                            Session["Join"] = "YES";
                            scrname = "<SCRIPT language='javascript'>alert('Registration Successfully.Your IdNo is " + LastInsertID + "');" + "</SCRIPT>";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Try Again Later.');", true);

                            Response.Redirect("welcome.Aspx?IDNo=" + LastInsertID, false);
                        }
                        else
                        {
                            if (retryqry <= 2)
                            {
                                retryqry += 1;
                                goto Savedata;
                            }
                            CmdSave.Enabled = true;
                            chkterms.Checked = false;
                            scrname = "<SCRIPT language='javascript'>alert('Try Again Later.');" + "</SCRIPT>";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Try Again Later.');", true);
                        }
                    }
                }
                catch (Exception e)
                {
                    CmdSave.Enabled = true;
                    chkterms.Checked = false;
                    scrname = "<SCRIPT language='javascript'>alert('" + e.Message + "');" + "</SCRIPT>";
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + e.Message + "');", true);

                    return;
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Error :" + ex.Message.ToString() + "');", true);
        }
    }

    public bool SendToMemberMail(string IdNo, string Email, string MemberName, string Password, string mobl)
    {
        try
        {
            string StrMsg = "";
            System.Net.Mail.MailAddress SendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
            System.Net.Mail.MailAddress SendTo = new System.Net.Mail.MailAddress(Email);
            System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(SendFrom, SendTo);
            StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\">" +
                     "<tr>" +
                     "<td>" +
                     "Dear " + MemberName + ",<br /><br />" +
                     "Welcome to Wealth Factory - Where Opportunities Meet Growth! <br /><br />" +
                     "We're thrilled to welcome you to the Wealth Factory community! Your account has been successfully created, and you're now part of a trusted platform designed to unlock high-potential opportunities across real estate, media, finance, and beyond.<br />" +
                     "Here are your secure login details:<br />"+
                     "<strong>User ID: " + IdNo + "</strong><br />" +
                     "<strong>Registered Mobile: " + mobl + "</strong><br />" +
                     "<strong>Login Password: " + Password + "</strong><br />" +
                     "<strong>Transaction Password: " + Password + "</strong><br /><br />" +
                     "Please store these credentials securely and do not share them with anyone. <br /><br />" +
                     "Login to your dashboard and explore verified investment options. <br />If you need help, our support team is ready to assist you at every step. <br /> <br />" +
                     "Let's build something extraordinary together. <br />" +
                     "Warm wishes, <br />Team Wealth Factory" +
                     "<br />" +
                     "<br />" +
                     "</td>" +
                     "</tr>" +
                     "</table>";

            MyMessage.Subject = "Welcome to Wealth Factory - Your Account Is Now Active!";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;
            //System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com");
            SmtpClient smtp = new SmtpClient(Session["MailHost"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
            smtp.Send(MyMessage);
            return true;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            return false;
        }
    }
    private void ClrCtrl()
    {
        try
        {
            txtAddLn1.Text = "";
            txtEMailId.Text = "";
            txtFNm.Text = "";
            txtFrstNm.Text = "";
            txtMobileNo.Text = "";
            txtNominee.Text = "";
            txtPanNo.Text = "";
            txtPhNo.Text = "";
            txtPinCode.Text = "";
            txtRelation.Text = "";
            txtUplinerId.Text = "";
            lblUplnrNm.Text = "";
            ddlDistrict.Text = "";
            ddlTehsil.Text = "";
            TxtBranchName.Text = "";
            TxtAccountNo.Text = "";
            txtIfsCode.Text = "";
            txtRefralId.Text = "";
            lblRefralNm.Text = "";
            txtUplinerId.Enabled = true;
            txtRefralId.Enabled = true;

            RbtnLegNo.Enabled = true;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private void FillBankMaster(SqlConnection Cnn)
    {
        try
        {
            DataTable dt = new DataTable();

            if (Session["DtBankMaster"] == null)
            {

                string strSql = ObjDAL.Isostart + "SELECT BankCode as Bid,BANKNAME as Bank FROM " + ObjDAL.dBName + "..M_BankMaster WHERE ACTIVESTATUS='Y' and Rowstatus='Y' ORDER BY BankName" + ObjDAL.IsoEnd;
                dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
                Session["DtBankMaster"] = dt;
            }
            else
            {
                dt = (DataTable)Session["DtBankMaster"];
            }


            if (dt.Rows.Count > 0)
            {
                CmbBank.DataSource = dt;
                CmbBank.DataValueField = "Bid";
                CmbBank.DataTextField = "Bank";
                CmbBank.DataBind();
                CmbBank.SelectedIndex = 0;
            }

            TxtBank.Text = CmbBank.SelectedItem.Text;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }

    }
    public string Validt_SpnsrDtl(string chkby)
    {
        try
        {
            string Validt_SpnsrDtl = "";

            if (Session["IsGetExtreme"].ToString() == "N")
            {
                if (txtUplinerId.Text == "")
                {
                    string scrname = "<SCRIPT language='javascript'>alert('Check Placement Id');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                    txtUplinerId.Focus();

                    return Validt_SpnsrDtl;
                }
            }

            txtRefralId.Text = txtRefralId.Text.Replace("'", "").Replace("=", "").Replace(";", "");
            txtUplinerId.Text = txtUplinerId.Text.Replace("'", "").Replace("=", "").Replace(";", "");

            if (!string.IsNullOrEmpty(txtRefralId.Text))
            {
                DataTable dt = new DataTable();
                DataSet Ds = new DataSet();
                string strSql = ObjDAL.Isostart + "Select FormNo,MemFirstName + ' ' + MemLastName as MemName,ActiveStatus from " + ObjDAL.dBName + "..M_MemberMaster where Idno='" + txtRefralId.Text + "'" + ObjDAL.IsoEnd;
                Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
                dt = Dt;

                if (dt.Rows.Count == 0)
                {
                    string scrname = "<SCRIPT language='javascript'>alert('Sponsor ID Not Exist.');location.replace('Newjoining1.aspx');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                    vsblCtrl(false, true);
                    return Validt_SpnsrDtl;
                }
                //else if (dt.Rows[0]["ActiveStatus"].ToString() == "N")
                //{
                //    string scrname = "<SCRIPT language='javascript'>alert('This ID is not eligible for sponsor.');</SCRIPT>";
                //    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                //    return Validt_SpnsrDtl;
                //}
                else
                {
                    Session["Kitid"] = 1;
                    Session["Bv"] = 0;
                    Session["JoinStatus"] = "N";
                    Session["RP"] = 0;
                    Validt_SpnsrDtl = "OK";
                }

                Session["Refral"] = dt.Rows[0]["FormNo"];
                lblRefralNm.Text = dt.Rows[0]["MemName"].ToString();
            }
            else
            {
                string scrname = "<SCRIPT language='javascript'>alert('Check Sponsor ID.');location.replace('Newjoining1.aspx');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                txtRefralId.Focus();
                return Validt_SpnsrDtl;
            }

            if (Session["IsGetExtreme"].ToString() == "N")
            {
                if (!string.IsNullOrEmpty(txtUplinerId.Text))
                {
                    DataTable dt = new DataTable();
                    DataSet Ds = new DataSet();
                    string strSql = ObjDAL.Isostart + " Select FormNo,MemFirstName + ' ' + MemLastName as MemName  from " + ObjDAL.dBName + "..M_MemberMaster where Idno='" + txtUplinerId.Text + "'  " + ObjDAL.IsoEnd;
                    Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0]; ;
                    dt = Dt;

                    if (dt.Rows.Count == 0)
                    {
                        string scrname = "<SCRIPT language='javascript'>alert('Sponsor ID Not Exist');location.replace('Newjoining1.aspx');</SCRIPT>";
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                        vsblCtrl(false, true);
                        return Validt_SpnsrDtl;
                    }

                    Session["Uplnr"] = dt.Rows[0]["FormNo"];
                    Validt_SpnsrDtl = "OK";
                    lblUplnrNm.Text = dt.Rows[0]["MemName"].ToString();
                }
                else
                {
                    string scrname = "<SCRIPT language='javascript'>alert('Check Sponsor ID');location.replace('Newjoining1.aspx');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                    return Validt_SpnsrDtl;
                }
            }
            else
            {
                txtUplinerId.Text = "0";
                lblUplnrNm.Text = "";
                Session["Uplnr"] = "0";
            }

            if (Session["IsGetExtreme"].ToString() == "N")
            {
                if (Convert.ToInt32(Session["Refral"]) != Convert.ToInt32(Session["Uplnr"]))
                {
                    DataTable dt = new DataTable();
                    DataSet Ds = new DataSet();
                    string strSql = ObjDAL.Isostart + "Select * from " + ObjDAL.dBName + "..M_MemTreeRelation where FormNo=" + Session["Refral"] + " And FormNoDwn=" + Session["Uplnr"] + " " + ObjDAL.IsoEnd;
                    Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
                    dt = Dt;
                    if (dt.Rows.Count == 0)
                    {
                        string scrname = "<SCRIPT language='javascript'>alert('Place Under Does Not Exist In Sponsor Downline!!');</SCRIPT>";
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                        vsblCtrl(false, true);
                        return Validt_SpnsrDtl;
                    }
                }
            }

            if (Session["IsGetExtreme"].ToString() == "N")
            {
                if (!checkAvailLeg())
                {
                    vsblCtrl(false, true);
                    return Validt_SpnsrDtl;
                }
            }

            RbtnLegNo.Enabled = false;
            txtUplinerId.Enabled = false;
            txtRefralId.Enabled = false;
            return Validt_SpnsrDtl;
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    protected void CmdSave_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    if (!chkterms.Checked)
        //    {
        //        string scrname = "<SCRIPT language='javascript'>alert('Please select Terms and Condtions');</SCRIPT>";
        //        ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
        //        return;
        //    }
        //    else
        //    {
        //        SaveIntoDB();
        //    }
        //}
        //catch (Exception ex)
        //{
        //    throw new Exception(ex.Message);
        //}
        try
        {


            if (!chkterms.Checked)
            {
                string scrname = "<SCRIPT language='javascript'>alert('Please select Terms and Conditions');</SCRIPT>";
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
            if (string.IsNullOrEmpty(txtEMailId.Text))
            {
                chkterms.Checked = false;
                CmdSave.Enabled = true;
                string scrname = "<SCRIPT language='javascript'>alert('Enter Email-Id.');</SCRIPT>";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Email-Id.');", true);
                return;
            }
            if (string.IsNullOrEmpty(txtMobileNo.Text))
            {
                chkterms.Checked = false;
                CmdSave.Enabled = true;
                string scrname = "<SCRIPT language='javascript'>alert('Enter Mobile No.');</SCRIPT>";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Mobile No.');", true);
                return;
            }
            //if (string.IsNullOrEmpty(TxtAAdhar1.Text))
            //{
            //    chkterms.Checked = false;
            //    CmdSave.Enabled = true;
            //    string scrname = "<SCRIPT language='javascript'>alert('Enter Aadhar No.');</SCRIPT>";
            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Enter Aadhar No.');", true);
            //    return;
            //}

            if (Session["OTPP_"] == null)
            {
                Random random = new Random();
                int OTP_ = random.Next(100001, 999999);
                int OTPP_ = random.Next(200001, 999999);

                string emailId = txtEMailId.Text;
                string memberName = txtFrstNm.Text;
                string mobileNo = txtMobileNo.Text;

                Session["OtpTime"] = DateTime.Now.AddMinutes(5);
                Session["Retry"] = "1";
                Session["OTPP_"] = OTPP_;
                Session["TPP_"] = OTPP_;

                ObjDAL = new DAL();
                if (Convert.ToInt32(Session["OTPP_"]) != 0)
                {
                    Session["Retry"] = "1";
                    divOtp.Visible = true;
                }
                else
                {
                    divOtp.Visible = false;
                    return;
                }

                string query = "INSERT INTO AdminLogin(UserID, Username, Passw, MobileNo, Otp, Emailotp, emailid) " +
                               "VALUES ('0', @Username, @Passw, @MobileNo, @Otp, @EmailOtp, @EmailId)";

                using (SqlCommand cmd = new SqlCommand(query, new SqlConnection(constr)))
                {
                    cmd.Parameters.AddWithValue("@Username", txtFrstNm.Text);
                    cmd.Parameters.AddWithValue("@Passw", TxtPassword.Text);
                    cmd.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text);
                    cmd.Parameters.AddWithValue("@Otp", OTP_);
                    cmd.Parameters.AddWithValue("@EmailOtp", OTPP_);
                    cmd.Parameters.AddWithValue("@EmailId", txtEMailId.Text);

                    cmd.Connection.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    if (rowsAffected > 0)
                    {
                        string script = "<script language='javascript'>alert('OTP has been sent to your Email. Please Enter OTP');</script>";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Login Error", script, false);
                        SendToMemberMailotp(OTPP_);
                        //TxtPassword.Text = Session["OTPP_"].ToString();
                        CmdSave.Enabled = false;
                        txtRefralId.ReadOnly = true;
                        TxtPassword.ReadOnly = false;
                        RbtnLegNo.Enabled = false;
                        txtFrstNm.ReadOnly = true;
                        ddlCountryNAme.Enabled = false;
                        txtMobileNo.ReadOnly = true;
                        txtEMailId.ReadOnly = true;
                        //txtaadharno.ReadOnly = true;
                        chkterms.Enabled = false;
                        divOtp.Visible = true;
                        DivTerms.Visible = false;
                    }
                    else
                    {
                        string script = "<SCRIPT language='javascript'>alert('Try Again.');</SCRIPT>";
                        ClientScript.RegisterStartupScript(this.GetType(), "MyAlert", script);
                        return;
                    }
                }
            }
            else
            {
                Response.Redirect("Newjoining1.aspx");
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    private void FindSession()
    {
        try
        {
            Session["SessID"] = 1;
            return;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }

        try
        {
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + "Select Max(SessId) as SessId from " + ObjDAL.dBName + "..M_SessnMaster  " + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0]; ;
            dt = Dt;
            if (dt.Rows.Count > 0)
            {
                Session["SessID"] = dt.Rows[0]["SessID"];
            }
            else
            {
                errMsg.Text = "Session Not Exist. Please Enter New Session.";
                return;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    private bool checkAvailLeg()
    {
        try
        {
            int iLegNo, iformNo;
            if (RbtnLegNo.SelectedIndex == 0)
            {
                iLegNo = 1;
            }
            else if (RbtnLegNo.SelectedIndex == 1)
            {
                iLegNo = 2;
            }
            else
            {
                scrname = "<SCRIPT language='javascript'>alert('Choose Position.');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                return false;
            }

            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + " Select * from " + ObjDAL.dBName + "..M_MemberMaster where IdNo='" + txtUplinerId.Text + "' " + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];

            if (dt.Rows.Count > 0)
            {
                iformNo = Convert.ToInt32(dt.Rows[0]["FormNo"]);
            }
            else
            {
                errMsg.Text = "Check Placeunder Id.";
                scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                return false;
            }

            DataTable dt12 = new DataTable();
            DataSet Ds12 = new DataSet();
            DataTable Dt = new DataTable();
            string strSql12 = ObjDAL.Isostart + "SELECT COUNT(*) AS CNT FROM " + ObjDAL.dBName + "..M_MemberMaster WHERE UpLnFormNo= " + iformNo + " And LegNo=" + iLegNo + "  " + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql12).Tables[0]; ;
            dt12 = Dt;

            if (dt12.Rows.Count > 0)
            {
                if (Convert.ToInt32(dt12.Rows[0]["CNT"]) > 0)
                {
                    errMsg.Text = (iLegNo == 1) ? "LEFT" : "RIGHT";
                    errMsg.Text += " Position already used, please select correct Position!";
                    scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                    return false;
                }
                else
                {
                    _dblAvailLeg = iformNo;
                    return true;
                }
            }
            else
            {
                errMsg.Text = "Error In Position Selection.";
                scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Login Error", scrname, false);
                return false;
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);

        }
    }
    private void sendSMS(ref SqlConnection Cnn)
    {
        try
        {
            string mobileno = "";
            string MemberPass = "";
            string MemberTransPassw = "";
            int mobileNo;
            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + "Select IDNo,Passw,MemFirstName,EPassw,mobl,DATEADD(day, 15, Doj) as Maxdate from " + ObjDAL.dBName + "..m_MemberMaster where IDNo = '" + LastInsertID + "' And mobl= '" + txtMobileNo.Text + "' " + ObjDAL.IsoEnd;
            Ds = SqlHelper.ExecuteDataset(Cnn, CommandType.Text, strSql);
            dt = Ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                Session["SMSIDNo"] = dt.Rows[0]["IDNo"];
                Session["SMSIDPass"] = dt.Rows[0]["Passw"];
                Session["Name"] = dt.Rows[0]["MemFirstName"];
                Session["MaxDate"] = dt.Rows[0]["MaxDate"];
                Session["SMSTransPassw"] = dt.Rows[0]["EPassw"];
                mobileno = dt.Rows[0]["mobl"].ToString();
            }
            MemberPass = Session["SMSIDPass"].ToString();
            MemberTransPassw = Session["SMSTransPassw"].ToString();
            MemberPass = MemberPass.Replace("%", "%25");
            MemberPass = MemberPass.Replace("&", "%26");
            MemberPass = MemberPass.Replace("#", "%23");
            MemberPass = MemberPass.Replace("'", "%22");
            MemberPass = MemberPass.Replace(",", "%2C");
            MemberPass = MemberPass.Replace("(", "%28");
            MemberPass = MemberPass.Replace(")", "%29");
            MemberPass = MemberPass.Replace("*", "%2A");
            MemberPass = MemberPass.Replace("!", "%21");
            MemberPass = MemberPass.Replace("/", "%2F");
            MemberPass = MemberPass.Replace("@", "%40");
            MemberTransPassw = MemberTransPassw.Replace("%", "%25");
            MemberTransPassw = MemberTransPassw.Replace("&", "%26");
            MemberTransPassw = MemberTransPassw.Replace("#", "%23");
            MemberTransPassw = MemberTransPassw.Replace("'", "%22");
            MemberTransPassw = MemberTransPassw.Replace(",", "%2C");
            MemberTransPassw = MemberTransPassw.Replace("(", "%28");
            MemberTransPassw = MemberTransPassw.Replace(")", "%29");
            MemberTransPassw = MemberTransPassw.Replace("*", "%2A");
            MemberTransPassw = MemberTransPassw.Replace("!", "%21");
            MemberTransPassw = MemberTransPassw.Replace("/", "%2F");
            MemberTransPassw = MemberTransPassw.Replace("@", "%40");
            if (txtMobileNo.Text.Length >= 10 && int.TryParse(txtMobileNo.Text, out mobileNo))
            {
                WebClient client = new WebClient();
                string baseurl;
                Stream data;
                string sms = "Welcome To " + Session["CompName"] + ", Thank You For Registration.Your ID Is " + Session["SMSIDNo"] + " and Password is " + Session["SMSIDPass"] + ". Visit " + Session["CompWeb1"] + "  Best of luck.";
                try
                {
                    baseurl = "http://www.apiconnecto.com/API/SMSHttp.aspx?UserId=" + Session["SmsId"] + "&pwd=" + Session["SmsPass"] + "&Message=" + sms + "&Contacts=" + mobileno + "&SenderId=" + Session["ClientId"] + "&ServiceName=SMSOTP";
                    data = client.OpenRead(baseurl);
                    StreamReader reader = new StreamReader(data);
                    string s = reader.ReadToEnd();
                    data.Close();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
            ClrCtrl();
            dRead.Close();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void txtUplinerId_TextChanged(object sender, EventArgs e)
    {
        FillSponsor(cnn);
    }
    private void FillSponsor(SqlConnection Cnn)
    {
        try
        {
            errMsg.Text = "";
            lblErrEpin.Text = "";
            int i = 0;
            txtUplinerId.Text = txtUplinerId.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");

            DataTable dt = new DataTable();
            DataSet Ds = new DataSet();
            string strSql = ObjDAL.Isostart + " Select FormNo,MemFirstName + ' ' + MemLastName as MemName  from " + ObjDAL.dBName + "..M_MemberMaster where IDNo='" + txtUplinerId.Text + "'" + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            dt = Dt;
            if (dt.Rows.Count > 0)
            {
                lblUplnrNm.Text = dt.Rows[0]["MemName"].ToString();
                Session["Uplnr"] = dt.Rows[0]["FormNo"];
                i += 1;
            }
            else
            {
                errMsg.Text = "Invalid PlaceUnder ID!!";
                lblErrEpin.Text = "Invalid PlaceUnder ID!!";
                scrname = "<SCRIPT language='javascript'>alert('" + errMsg.Text + "');</SCRIPT>";
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            }

            if (i == 1)
            {
                checkAvailLeg();
            }
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }
    private void FillReferral(SqlConnection Cnn)
    {
        try
        {
            lblErrEpin.Text = "";
            errMsg.Text = "";
            txtRefralId.Text = txtRefralId.Text.Trim().Replace(";", "").Replace("'", "").Replace("=", "");
            DataTable dt = new DataTable();
            DataTable Dt = new DataTable();
            //string strSql = ObjDAL.Isostart + "Select A.FormNo,MemFirstName + ' ' + MemLastName as MemName,ActiveStatus  from " + ObjDAL.dBName + "..M_MemberMaster  as a Inner Join " + ObjDAL.dBName + "..KycVerify as c On a.Formno=c.formno where IDNo='" + txtRefralId.Text + "' and IsBlock='N' and (c.IsAddrssverified='Y' and c.isBankverified='Y' and c.IsPanVerified='Y') " + ObjDAL.IsoEnd;
            string strSql = ObjDAL.Isostart + "Select FormNo,MemFirstName + ' ' + MemLastName as MemName,ActiveStatus  from " + ObjDAL.dBName + "..M_MemberMaster where IDNo='" + txtRefralId.Text + "' and IsBlock='N' " + ObjDAL.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
            dt = Dt;
            if (dt.Rows.Count == 0)
            {
                scrname = "<SCRIPT language='javascript'>alert('No such record/This ID is Flashed./This Id Not Active/This Id Kyc Not Approve!!');</SCRIPT>";
                //scrname = "<SCRIPT language='javascript'>alert('This Id Kyc Not Approve!!');</SCRIPT>";
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
                txtRefralId.Text = "";
                return;
            }
            //else if (dt.Rows[0]["ActiveStatus"].ToString() == "N")
            //{
            //    scrname = "<SCRIPT language='javascript'>alert('This ID is not eligible for sponsor.');</SCRIPT>";
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Login Error", scrname, false);
            //    return;
            //}
            else
            {
                lblRefralNm.Text = dt.Rows[0]["MemName"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void CmdCancel_Click(object sender, EventArgs e)
    {
        try
        {
            ClrCtrl();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void txtRefralId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            FillReferral(cnn);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        try
        {
            if (cnn != null)
            {
                if (cnn.State == ConnectionState.Open)
                {
                    cnn.Close();
                }
            }

            dbConnect.OpenConnection();
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
        }
    }

    protected void getData()
    {

        try
        {
            DataTable dtCompany = new DataTable();
            if (Application["dtCompany"] == null)
            {

                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter();

                string strQ =
                strQ = ObjDAL.Isostart + " select * from " + ObjDAL.dBName + " ..M_CompanyMaster " + ObjDAL.IsoEnd;
                dtCompany = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQ).Tables[0];
                Application["dtCompany"] = dtCompany;
            }
            else
            {
                dtCompany = (DataTable)Application["dtCompany"];
            }
            if (dtCompany.Rows.Count > 0)
            {
                Session["CompName"] = dtCompany.Rows[0]["CompName"];
                Session["CompAdd"] = dtCompany.Rows[0]["CompAdd"];
                Session["CompWeb"] = string.IsNullOrEmpty(dtCompany.Rows[0]["WebSite"].ToString()) ? "index.asp" : dtCompany.Rows[0]["WebSite"].ToString();
                Session["Title"] = dtCompany.Rows[0]["CompTitle"];
                Session["CompMail"] = dtCompany.Rows[0]["CompMail"];
                Session["CompMobile"] = dtCompany.Rows[0]["MobileNo"];
                Session["ClientId"] = dtCompany.Rows[0]["smsSenderId"];
                Session["SmsId"] = dtCompany.Rows[0]["smsUserNm"];
                Session["SmsPass"] = dtCompany.Rows[0]["smPass"];
                Session["MailPass"] = dtCompany.Rows[0]["mailPass"];
                Session["MailHost"] = dtCompany.Rows[0]["mailHost"];
                Session["AdminWeb"] = dtCompany.Rows[0]["AdminWeb"];
                Session["CompCST"] = dtCompany.Rows[0]["CompCSTNo"];
                Session["CompState"] = dtCompany.Rows[0]["CompState"];
                Session["CompDate"] = Convert.ToDateTime(dtCompany.Rows[0]["RecTimeStamp"]).ToString("dd-MMM-yyyy");
                Session["Spons"] = "KL123456";
                Session["CompWeb1"] = dtCompany.Rows[0]["WebSite"];
                Session["CompMovieWeb"] = "";
                Session["SmsAPI"] = "";
                Session["CompShortUrl"] = dtCompany.Rows[0]["UrlShort"];
                Session["LogoUrl"] = dtCompany.Rows[0]["LogoUrl"];
            }
            else
            {
                Session["CompName"] = "";
                Session["CompAdd"] = "";
                Session["CompWeb"] = "";
                Session["Title"] = "Welcome";
            }

            DataTable dtConfig = new DataTable();
            if (Application["dtConfig"] == null)
            {

                DataSet ds = new DataSet();

                string strQ = "";

                strQ = ObjDAL.Isostart + " select * from " + ObjDAL.dBName + "..M_ConfigMaster " + ObjDAL.IsoEnd;
                dtConfig = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQ).Tables[0];
                Application["dtConfig"] = dtConfig;

            }
            else
            {
                dtConfig = (DataTable)Application["dtConfig"];
            }

            if (dtConfig.Rows.Count > 0)
            {
                Session["IsGetExtreme"] = dtConfig.Rows[0]["IsGetExtreme"];
                Session["IsTopUp"] = dtConfig.Rows[0]["IsTopUp"];
                Session["IsSendSMS"] = dtConfig.Rows[0]["IsSendSMS"];
                Session["IdNoPrefix"] = dtConfig.Rows[0]["IdNoPrefix"];
                Session["IsFreeJoin"] = dtConfig.Rows[0]["IsFreeJoin"];
                Session["IsStartJoin"] = dtConfig.Rows[0]["IsStartJoin"];
                Session["JoinStartFrm"] = dtConfig.Rows[0]["JoinStartFrm"];
                Session["IsSubPlan"] = dtConfig.Rows[0]["IsSubPlan"];
                Session["Logout"] = dtConfig.Rows[0]["LogoutPg"];
            }
            else
            {
                Session["IsGetExtreme"] = "N";
                Session["IsTopUp"] = "N";
                Session["IsSendSMS"] = "N";
                Session["IdNoPrefix"] = "";
                Session["IsFreeJoin"] = "N";
                Session["IsStartJoin"] = "N";
                Session["JoinStartFrm"] = "01-Sep-2011";
                Session["IsSubPlan"] = "N";
                Session["Logout"] = "https://HyperTrade tech.com/";
            }

            DataTable dtMsession = new DataTable();
            if (Application["dtMsession"] == null)
            {

                string strQ = "";

                strQ = ObjDAL.Isostart + " select isnull(Max(SEssid),1) as SessID from " + ObjDAL.dBName + "..D_Monthlypaydetail  " + ObjDAL.IsoEnd;
                dtMsession = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQ).Tables[0];
                Application["dtMsession"] = dtMsession;
                Application["dtMsession"] = dtMsession;
            }
            else
            {
                dtMsession = (DataTable)Application["dtMsession"];
            }

            if (dtMsession.Rows.Count > 0)
            {
                Session["MaxSessn"] = dtMsession.Rows[0]["SessID"];
            }
            else
            {
                Session["MaxSessn"] = "";
            }

            DataTable dtsession = new DataTable();
            if (Application["dtsession"] == null)
            {

                DataSet ds = new DataSet();
                string strQ = "";

                strQ = ObjDAL.Isostart + " select isnull(Max(SEssid),1) as SessID from " + ObjDAL.dBName + "..m_SessnMaster  " + ObjDAL.IsoEnd;
                dtsession = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQ).Tables[0];
                Application["dtsession"] = dtsession;
            }
            else
            {
                dtsession = (DataTable)Application["dtsession"];
            }
            if (dtsession.Rows.Count > 0)
            {
                Session["CurrentSessn"] = dtsession.Rows[0]["SessID"];
            }
            else
            {
                Session["CurrentSessn"] = "";
            }

        }
        catch (Exception ex)
        {
            Session["CompName"] = "";
            Session["CompAdd"] = "";
            Session["CompWeb"] = "";
            {
                throw new Exception(ex.Message);
            }
        }
    }
    protected void txtMobileNo_TextChanged(object sender, EventArgs e)
    {
        try
        {

            if (txtMobileNo.Text != "")
            {
                string moblno = "";
                string Check = "";
                moblno = txtMobileNo.Text;
                Check = moblno.Substring(0, 1);
                if ((Check == "0"))
                {
                    txtMobileNo.Text = "";
                    CmdSave.Enabled = true;
                    chkterms.Checked = false;
                    string scrname = "<SCRIPT language='javascript'>alert('Invalid Mobile No. .!');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
            }

            if (txtMobileNo.Text != "")
            {
                DataTable Dt1 = new DataTable();
                DataSet Dsmob = new DataSet();
                string strSql = ObjDAL.Isostart + "select Count(mobl) as mobileno from " + ObjDAL.dBName + "..M_Membermaster where Mobl='" + txtMobileNo.Text.Trim() + "' " + ObjDAL.IsoEnd;
                Dsmob = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql);
                Dt1 = Dsmob.Tables[0];
                if (Convert.ToInt32(Dt1.Rows[0]["mobileno"]) >= 1)
                {
                    txtMobileNo.Text = "";
                    CmdSave.Enabled = true;
                    chkterms.Checked = false;
                    string scrname = "<SCRIPT language='javascript'>alert('Already Registerd by this Mobile Number.');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void txtEMailId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtEMailId.Text != "")
            {
                DataTable Dt = new DataTable();
                string strSql = ObjDAL.Isostart + " select Count(Email) as Email from " + ObjDAL.dBName + "..M_Membermaster where Email='" + txtEMailId.Text.Trim() + "' " + ObjDAL.IsoEnd;
                Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strSql).Tables[0];
                if (Convert.ToInt32(Dt.Rows[0]["Email"]) >= 1)
                {
                    txtEMailId.Text = "";
                    CmdSave.Enabled = true;
                    chkterms.Checked = false;
                    string scrname = "<SCRIPT language='javascript'>alert('Already Registerd by this Emailid.');</SCRIPT>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login Error", scrname, false);
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void BtnPassword_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(Session["Retry"]) >= 3)
            {
                lblOTPMsg.Text = "Generate new otp. Otp expired.";
                lblOTPMsg.Visible = true;
                return;
            }
            else
            {
                lblOTPMsg.Visible = false;
            }

            if (Session["OTPP_"].ToString() != TxtPassword.Text.Trim())
            {
                Session["Retry"] = Convert.ToInt32(Session["Retry"]) + 1;
                lblOTPMsg.Text = "Please Enter Valid otp.";
                lblOTPMsg.Visible = true;
                return;
            }
            else
            {
                lblOTPMsg.Visible = false;
            }

            if (Convert.ToDateTime(Session["OtpTime"]) < DateTime.Now)
            {
                lblOTPMsg.Visible = true;
                scrname = "<script language='javascript'>alert('OTP Expire after 5 Minute.');location.replace('Newjoining1.aspx');</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "alert('OTP Expire after 5 Minute.');", true);
                Session["OtpTime"] = null;
                Session["OTPP_"] = null;
                Session["Retry"] = null;
                return;
            }
            else
            {
                lblOTPMsg.Visible = false;
            }

            if (!chkterms.Checked)
            {
                scrname = "<SCRIPT language='javascript'>alert('Please select Terms and Condtions');</SCRIPT>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login Error", scrname, false);
                return;
            }
            else
            {
                SaveIntoDB();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            Response.Write("Try later.");
        }
    }
    protected void btngenerate_Click(object sender, EventArgs e)
    {
        try
        {
            if (!chkterms.Checked)
            {
                scrname = "<SCRIPT language='javascript'>alert('Please select Terms and Condtions');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                return;
            }

            int OTP_ = 0;
            Random Rs = new Random();
            OTP_ = Rs.Next(100001, 999999);

            int OTPP_ = 0;
            Random Rs1 = new Random();
            OTPP_ = Rs1.Next(200001, 999999);

            string Emailid = txtEMailId.Text;
            string membername = txtFrstNm.Text;
            string mobileno = txtMobileNo.Text;
            SendToMemberMailotp(OTPP_);
            Session["OTPP_"] = OTPP_;
            Session["OtpTime"] = DateTime.Now.AddMinutes(5);
            Session["Retry"] = "1";

            if (Convert.ToInt32(Session["OTPP_"]) != 0)
            {
                Session["Retry"] = "1";
                divOtp.Visible = true;
            }
            else
            {
                divOtp.Visible = false;
                return;
            }

            ObjDAL = new DAL();
            int i = 0;
            string R = "";
            R = "INSERT AdminLogin(UserID,Username,Passw,MobileNo,Otp,Emailotp,emailid) VALUES ('0','" + txtFrstNm.Text + "','" + TxtPassword.Text + "','" + txtMobileNo.Text + "','" + OTP_ + "','" + OTPP_ + "','" + txtEMailId.Text + "')";
            i = ObjDAL.SaveData(R);
            if (i > 0)
            {
                scrname = "<script language='javascript'>alert('OTP has been send on your Email,Please Enter OTP');</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login Error", scrname, false);
                divOtp.Visible = true;
                DivTerms.Visible = false;
            }
            else
            {
                scrname = "<SCRIPT language='javascript'>alert('Try Again.');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                return;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);
        }
    }
    public bool SendToMemberMailotp(int otp)
    {
        try
        {
            SmtpClient smtpClient = new SmtpClient();
            MailMessage mail = new MailMessage();
            string StrMsg = "";
            MailAddress SendFrom = new System.Net.Mail.MailAddress(Session["CompMail"].ToString());
            MailAddress SendTo = new MailAddress(txtEMailId.Text);
            MailMessage MyMessage = new MailMessage(SendFrom, SendTo);
            mail.Subject = "Wealth Factory Account Registration!";
            StrMsg = "<table style=\"margin:0; padding:10px; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; line-height:23px; text-align:justify;width:100%\">" +
                     "<tr>" +
                     "<td>" +
                     "Dear "+txtFrstNm.Text + ",<br />" +
                     "We appreciate your interest in joining Wealth Factory <br />" +
                     "To proceed with the registration of your account, kindly verify your email address by entering the One-Time Password (OTP) provided below:<br />" +
                     "One-Time Password (OTP): <span style=\"font-weight: bold;\">" + otp + "</span> (valid for 5 minutes)." +
                     "<br />" +
                     "This code is valid for a limited time and is strictly confidential. For your security, please refrain from sharing it with anyone."+
                       "<br />" +
                     "If you did not initiate this request, no action is required. Your information remains secure and unchanged." +
                       "<br />" +
                     "If you have any questions or require assistance, please do not hesitate to contact our support team at support@wealthfactory.com" +
                            "<br />" +
                     "Regards, <br />Client Relations Team<br />Wealth Factory" +
                     "</td>" +
                     "</tr>" +
                    "</table>";

            MyMessage.Subject = "Wealth Factory Account Registration!";
            MyMessage.Body = StrMsg;
            MyMessage.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient(Session["MailHost"].ToString());
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential(Session["CompMail"].ToString(), Session["MailPass"].ToString());
            smtp.Send(MyMessage);
            return true;
        }
        catch (Exception ex)
        {
            Response.Write("Try later.");
            return false;
        }
    }

    protected void ddlCountryNAme_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillCountryMasterCode();
    }
    private void FillCountryMasterCode()
    {
        try
        {
            //DataTable dt = new DataTable();
            DataTable dt = new DataTable();
            strQuery = ObjDAL.Isostart + "SELECT StdCode FROM " + ObjDAL.dBName + "..M_CountryMaster WHERE ACTIVESTATUS='Y' AND Cid = '" + ddlCountryNAme.SelectedValue + "'" + ObjDAL.IsoEnd;
            dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, strQuery).Tables[0];
            if (dt.Rows.Count > 0)
            {
                ddlMobileNAme.Text = dt.Rows[0]["StdCode"].ToString();
            }
        }
        // ddlMobileNAme.DataSource = dt
        // ddlMobileNAme.DataValueField = "StdCode"
        // ddlMobileNAme.DataBind()

        catch (Exception ex)
        {
        }
    }


   
}
