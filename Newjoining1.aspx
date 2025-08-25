<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Newjoining1.aspx.cs" Inherits="Newjoining1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <script type="text/javascript" src="assets/jquery.min.js">
    </script>

    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function DivOnOff() {


            if (document.getElementById("<%= chkterms.ClientID %>").checked == true) {


                document.getElementById("DivTerms").style.display = "block";



            }
            else {
                document.getElementById("DivTerms").style.display = "none";
            }
        }

        function FnBankChange(val) {

            if (val == "97") {

                document.getElementById("divBank").style.display = "block";

            }
            else {
                document.getElementById("divBank").style.display = "none";
            }

        }
        function FnVillageChange(val) {

            if (val == "381264") {

                document.getElementById("divVillage").style.display = "block";

            }
            else {
                document.getElementById("divVillage").style.display = "none";
            }

        }
        function FnPostVillageChange(val) {
            var ddlVillage = document.getElementById("<%=DDlPostVillage.ClientID %>");
            var selectedText = ddlVillage.options[ddlVillage.selectedIndex].innerHTML;
            var selectedValue = ddlVillage.value;
            document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;
            if (val == "381264") {

                document.getElementById("divPostVillage").style.display = "block";

            }
            else {
                document.getElementById("divPostVillage").style.display = "none";
            }

        }

        function GetSelectedItem() {

            var rb = document.getElementById("<%=RbtMarried.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "Y") {
                        document.getElementById("divMarriageDate").style.display = "block";
                    }
                    else {
                        document.getElementById("divMarriageDate").style.display = "none";
                    }
                }
            }
        }
        function GetRegistrationAs() {

            var rb = document.getElementById("<%=RbCategory.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "IN") {
                        document.getElementById("RegType").style.display = "none";
                        document.getElementById("CompName").style.display = "none";
                        document.getElementById("CompRegistrationNo").style.display = "none";
                        document.getElementById("Div1").style.display = "block";
                        document.getElementById("divFName").style.display = "block";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Birth";
                        var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
                        var radio = rb.getElementsByTagName("input");
                        radio[0].checked = true;
                    }
                    else {
                        document.getElementById("RegType").style.display = "block";
                        document.getElementById("CompName").style.display = "block";
                        document.getElementById("CompRegistrationNo").style.display = "block";
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "block";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Properitor ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                        var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
                        var radio = rb.getElementsByTagName("input");
                        radio[0].checked = true;
                    }
                }
            }
        }

        function GetRegistrationType() {

            var rb = document.getElementById("<%=CbSubCategory.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked == true) {
                    if (radio[i].value == "SP") {
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Properitor ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                    else if (radio[i].value == "PF") {
                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "block";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Partner ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                    else {

                        document.getElementById("Div1").style.display = "none";
                        document.getElementById("divFName").style.display = "none";
                        document.getElementById("TrPrtnrCap").style.display = "none";
                        document.getElementById("<%=LblName.ClientID %>").textContent = "Owner ";
                        document.getElementById("<%=LblRegistDate.ClientID %>").textContent = "Date Of Company Registration";
                    }
                }
            }
        }
        function GetSameAsPostal() {

            if (document.getElementById("<%= ChkSame.ClientID %>").checked == true) {
                document.getElementById("<%= TxtPostalAddress.ClientID %>").value = document.getElementById("<%= txtAddLn1.ClientID %>").value;
                document.getElementById("<%= TxtPostPincode.ClientID %>").value = document.getElementById("<%= txtPinCode.ClientID %>").value;
                document.getElementById("<%= TxtpostState.ClientID %>").value = document.getElementById("<%= txtStateName.ClientID %>").value;
                document.getElementById("<%= HPostStateCode.ClientID %>").value = document.getElementById("<%= StateCode.ClientID %>").value;
                document.getElementById("<%= TxtPostDistrict.ClientID %>").value = document.getElementById("<%= ddlDistrict.ClientID %>").value;
                document.getElementById("<%= HPostDistrict.ClientID %>").value = document.getElementById("<%= HDistrictCode.ClientID %>").value;
                document.getElementById("<%= TxtPostCity.ClientID %>").value = document.getElementById("<%= ddlTehsil.ClientID %>").value;
                document.getElementById("<%= HPostCity.ClientID %>").value = document.getElementById("<%= HCityCode.ClientID %>").value;
                var x = document.getElementById("<%= DDlVillage.ClientID %>").options.length;
                var ddl = document.getElementById("<%= DDlVillage.ClientID %>");
                for (var i = 0; i < x; i++) {
                    document.getElementById("<%= DDlPostVillage.ClientID %>").options[i] = new Option(ddl.options[i].text, ddl.options[i].value);
                }
                var ddlVillage = document.getElementById("<%=DDlVillage.ClientID %>");
                var selectedValue = ddlVillage.value;

                document.getElementById("<%= DDlPostVillage.ClientID %>").value = selectedValue;
                if (selectedValue == "381264") {

                    document.getElementById("<%= DDlPostVillage.ClientID %>").value = selectedValue;
                    document.getElementById("divPostVillage").style.display = "block";

                    document.getElementById("<%= TxtPostVillage.ClientID %>").value = document.getElementById("<%= TxtVillage.ClientID %>").value;
                    document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;
                }
                else {
                    document.getElementById("divPostVillage").style.display = "none";
                    document.getElementById("<%= TxtPostVillage.ClientID %>").textcontent = "";
                }
                document.getElementById("<%= HPostVillage.ClientID %>").value = selectedValue;

            }
            else {
                document.getElementById("<%= TxtPostalAddress.ClientID %>").value = "";
                document.getElementById("<%= TxtPostPincode.ClientID %>").value = "";
                document.getElementById("<%= TxtpostState.ClientID %>").value = "";
                document.getElementById("<%= HPostStateCode.ClientID %>").value = "";
                document.getElementById("<%= TxtPostDistrict.ClientID %>").value = "";
                document.getElementById("<%= HPostDistrict.ClientID %>").value = "";
                document.getElementById("<%= TxtPostCity.ClientID %>").value = "";
                document.getElementById("<%= HPostCity.ClientID %>").value = "";
                document.getElementById("<%= HPostVillage.ClientID %>").value = "";
                document.getElementById("divPostVillage").style.display = "none";
                document.getElementById("<%= TxtPostVillage.ClientID %>").textcontent = "";
                var rmOption = document.getElementById("<%= DDlPostVillage.ClientID %>");
                var x = document.getElementById("<%= DDlPostVillage.ClientID %>").options.length;



                for (var i = 0; i < x; i++) {

                    rmOption.remove(0);
                }

            }
        }
      
        
    </script>

    <script type="text/javascript">
        var jq = $.noConflict();
        function pageLoad(sender, args) {
            jq(document).ready(function() {

                jq("#aspnetForm").validationEngine('attach', { promptPosition: "topRight" });
            });

            jq("#<%=CmdSave.ClientID %>").click(function () {


                var valid = jq("#aspnetForm").validationEngine('validate');
                var vars = jq("#aspnetForm").serialize();
                if (valid == true) {
                    return true;

                } else {
                    return false;
                }
            });




        }

    </script>



<style>
	
	.main-content {
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: black;
}

.stars, .stars2, .stars3 {
    position: absolute;
    width: 100%;
    height: 100%;
    background-repeat: repeat;
    background-size: cover;
    pointer-events: none;
    z-index: 9999999 !important;
}

.stars {
    background-image: url('https://www.transparenttextures.com/patterns/stardust.png');
    animation: moveStars 50s linear infinite;
}

.stars2 {
    background-image: url('https://www.transparenttextures.com/patterns/stardust.png');
    animation: moveStars 100s linear infinite;
}

.stars3 {
    background-image: url('https://www.transparenttextures.com/patterns/stardust.png');
    animation: moveStars 150s linear infinite;
}

@keyframes moveStars {
    from { transform: translateY(0); }
    to { transform: translateY(-1000px); }
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
            DisplayAfter="0">
            <ProgressTemplate>
                <div class="modal1">
                    <div class="center1">
                        <img alt="" src="images/loader.gif" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>--%>
    <div class="content-wrapper">
        <section class="content-header">
     <%-- <h1>  New Joining </h1>--%>
    </section>
        <section class="content">
          <div class="row">
        <div class="col-md-12">
        
    
        <div class="row">
            <div class="col-md-12">
             <div class="box box-primary">
             <div class="box-header with-border">
              <h3 class="box-title">New Joining</h3>
            </div>
   
        <div class="row">
        <div class="col-md-12">
            <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
              
                <div class="clearfix gen-profile-box" style="min-height: auto;">
                    <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">
                <br>
                <div class="centered">
                    <div class="clr">
                        <asp:Label ID="errMsg" runat="server" CssClass="error"></asp:Label>
                    </div>
                    <div class="col-md-6" class="form-horizontal">
                        <h4 style="font-size: medium; font-weight: 700; padding-top: 10px;">
                            Sponsor Detail</h4>
                        <div class="form-group ">
                            <label>
                                Sponsor ID<span class="red">*</span></label>
                            <asp:TextBox ID="txtRefralId" CssClass="form-control validate[required,custom[onlyLetterNumber]]"
                                TabIndex="1" runat="server" AutoPostBack="True" ValidationGroup="eInformation" OnTextChanged="txtRefralId_TextChanged"
                                autocomplete="off" ></asp:TextBox>
                            <asp:Label ID="lblRefralNm" runat="server" ForeColor="Red" ></asp:Label>
                            <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                        </div>
                        <%--  <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                <ContentTemplate>--%>
                        <div class="form-group greybt" id="rwSpnsr" runat="server" visible="false" >
                            <label class="control-label col-sm-2">
                                Upliner ID<span class="red">*</span></label>
                            <asp:TextBox ID="txtUplinerId" class="form-control" TabIndex="2" runat="server" AutoPostBack="True"
                                ValidationGroup="eSponsor" autocomplete="off"></asp:TextBox>
                            <asp:Label ID="lblUplnrNm" runat="server" ForeColor="#D11F7B"></asp:Label>
                        </div>
                        <div class="form-group greybt" runat="server" id="DivLeg1">
                            <label>
                                Select Group<span class="red">*</span></label>
                            <%--<div class="col-sm-10">--%>
                                <asp:RadioButtonList ID="RbtnLegNo" runat="server" TabIndex="3" RepeatDirection="Horizontal"
                                    Style="width: 150px" />
                           <%-- </div>--%>
                        </div>
                        <h4 style="font-size: medium; font-weight: 700; padding-top: 10px;">
                            Personal Detail</h4>
                        <div id="dvreg" runat="server" visible="false">
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    Registration As</label>
                                <asp:RadioButtonList ID="RbCategory" runat="server" RepeatDirection="Horizontal"
                                    TabIndex="4" onchange="return GetRegistrationAs()">
                                    <asp:ListItem Text="Individual" Value="IN" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Company" Value="C"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="form-group" id="RegType" style="display: none">
                                <label class="control-label col-sm-2">
                                    <asp:Label ID="LblRegType" Text="Registration Type" runat="server"></asp:Label></label>
                                <asp:RadioButtonList ID="CbSubCategory" runat="server" TabIndex="5" RepeatDirection="Horizontal"
                                    onchange="return GetRegistrationType()">
                                    <asp:ListItem Text="ProprietorShip" Value="SP" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Partnership Firm" Value="PF"></asp:ListItem>
                                    <asp:ListItem Text="Private Limited Company" Value="PL"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label>
                                <asp:Label ID="LblName" runat="server"></asp:Label>Name<span class="red">*</span></label>
                            <asp:TextBox ID="txtFrstNm" class="form-control" runat="server" TabIndex="6" ValidationGroup="eInformation"
                                autocomplete="off" CssClass="form-control validate[required,custom[onlyLetterNumberChar]]"></asp:TextBox>
                        </div>
                        <div class="form-group" id="TrPrtnrCap" style="display: none">
                            <label class="control-label col-sm-2">
                                <asp:Label ID="LblPartnerName" runat="server" Text="Partner Name Seperated By Comma(,)"></asp:Label></label></div>
                        <div class="form-group greybt" id="divFName" runat="server" visible="false">
                            <label class="control-label col-sm-2">
                                Father/HUSBAND's Name</label>
                            <div class="row">
                                <div class="col-sm-3">
                                    <asp:DropDownList CssClass="form-control" ID="CmbType" runat="server" TabIndex="7">
                                        <asp:ListItem Value="S/O" Text="S/O"></asp:ListItem>
                                        <asp:ListItem Value="D/O" Text="D/O"></asp:ListItem>
                                        <asp:ListItem Value="W/O" Text="W/O"></asp:ListItem>
                                        <asp:ListItem Value="H/O" Text="H/O"></asp:ListItem>
                                        <asp:ListItem Value="C/O" Text="C/O"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-9" style="padding-left: 0px;">
                                    <asp:TextBox ID="txtFNm" runat="server" TabIndex="8" class="form-control" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div id="Div1" class="form-group greybt" visible="false" runat="server">
                            <label class="control-label col-sm-2">
                                <asp:Label ID="LblRegistDate" runat="server" Text="Date Of Birth"></asp:Label></label>
                            <div class="row">
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="ddlDOBdt" runat="server" CssClass="form-control" TabIndex="9"
                                        autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="ddlDOBmnth" runat="server" CssClass="form-control" TabIndex="10"
                                        autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="ddlDOBYr" runat="server" Style="padding-right: 30px;" CssClass="form-control"
                                        TabIndex="11" autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="Div2" visible="false" runat="server">
                            <label class="control-label col-sm-2">
                                <span class="red">*</span>
                            </label>
                            <asp:RadioButtonList ID="RbtMarried" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" TabIndex="12" onchange="return GetSelectedItem()" autocomplete="off">
                                <asp:ListItem Text="Married" Value="Y"></asp:ListItem>
                                <asp:ListItem Text="UnMarried" Value="N"></asp:ListItem>
                            </asp:RadioButtonList>
                            <span class="red"></span>
                        </div>
                        <div class="form-group greybt" id="divMarriageDate" visible="false" style="display: none;">
                            <label class="control-label col-sm-2">
                                Marriage Date</label>
                            <div class="row">
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="DDlMDay" runat="server" CssClass="form-control" TabIndex="13">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="DDLMMonth" runat="server" CssClass="form-control" TabIndex="14">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-4  p0 pl10">
                                    <asp:DropDownList ID="DDLMYear" runat="server" Style="padding-right: 30px;" CssClass="form-control"
                                        TabIndex="15">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="CompName" style="display: none">
                            <label class="control-label col-sm-2">
                                Company Name
                            </label>
                            <asp:TextBox ID="TxtCompanyName" runat="server" CssClass="form-control" TabIndex="16"></asp:TextBox>
                        </div>
                        <div class="form-group" id="CompRegistrationNo" style="display: none">
                            <label class="control-label col-sm-2">
                                Company Registration No
                            </label>
                            <asp:TextBox ID="TxtRegistrationNo" runat="server" CssClass="form-control" TabIndex="17"></asp:TextBox>
                        </div>
                        <div id="dvpin" runat="server" visible="false">
                            <h4>
                                Contact Detail</h4>
                            <%--  <h5>
Permanent Address</h5>--%>
                            <div id="Div3" class="form-group " visible="false" runat="server">
                                <label class="control-label col-sm-2">
                                    Address</label>
                                <asp:TextBox ID="txtAddLn1" CssClass="form-control" TabIndex="18" runat="server"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <%--      <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>--%>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    Pin code<span class="red">*</span></label>
                                <asp:TextBox ID="txtPinCode" CssClass="form-control" onkeypress="return isNumberKey(event);"
                                    TabIndex="19" runat="server" MaxLength="6" autocomplete="off" AutoPostBack="true"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    State</label><asp:TextBox ID="txtStateName" runat="server" CssClass="form-control"
                                        TabIndex="16" autocomplete="off" Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="StateCode" runat="server" />
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    District</label>
                                <asp:TextBox ID="ddlDistrict" CssClass="form-control" TabIndex="17" runat="server"
                                    autocomplete="off" Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="HDistrictCode" runat="server" />
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    City</label>
                                <asp:TextBox ID="ddlTehsil" CssClass="form-control" TabIndex="18" runat="server"
                                    ValidationGroup="eInformation" autocomplete="off" Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="HCityCode" runat="server" />
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    Area</label>
                                <asp:DropDownList ID="DDlVillage" CssClass="form-control" TabIndex="19" runat="server"
                                    ValidationGroup="eInformation" autocomplete="off" onchange="FnVillageChange(this.value);">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group" id="divVillage" style="display: none">
                                <label class="control-label col-sm-2">
                                    Area Name</label>
                                <asp:TextBox ID="TxtVillage" CssClass="form-control" TabIndex="20" runat="server"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <div id="Dvfld" runat="server" visible="false">
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Same As Above<span class="red">*</span></label>
                                    <asp:CheckBox ID="ChkSame" runat="server" onclick="return GetSameAsPostal()" TabIndex="21" /></div>
                                <h5>
                                    Postal Address</h5>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        Address</label>
                                    <asp:TextBox ID="TxtPostalAddress" CssClass="form-control" TabIndex="22" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                                
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        Pin code<span class="red">*</span></label>
                                    <asp:TextBox ID="TxtPostPincode" CssClass="form-control" onkeypress="return isNumberKey(event);"
                                        TabIndex="23" runat="server" MaxLength="6" autocomplete="off" AutoPostBack="true"></asp:TextBox>
                                </div>
                               
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        State</label><asp:TextBox ID="TxtpostState" runat="server" CssClass="form-control"
                                            TabIndex="24" autocomplete="off" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField ID="HPostStateCode" runat="server" />
                                </div>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        District</label>
                                    <asp:TextBox ID="TxtPostDistrict" CssClass="form-control" TabIndex="25" runat="server"
                                        autocomplete="off" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField ID="HPostDistrict" runat="server" />
                                </div>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        City</label>
                                    <asp:TextBox ID="TxtPostCity" CssClass="form-control" TabIndex="26" runat="server"
                                        ValidationGroup="eInformation" autocomplete="off" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField ID="HPostCity" runat="server" />
                                </div>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        Area</label>
                                    <asp:DropDownList ID="DDlPostVillage" CssClass="form-control" TabIndex="27" runat="server"
                                        ValidationGroup="eInformation" autocomplete="off" onchange="FnPostVillageChange(this.value);">
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="HPostVillage" runat="server" />
                                </div>
                                <div class="form-group" id="divPostVillage" style="display: none">
                                    <label class="control-label col-sm-2">
                                        Area Name</label>
                                    <asp:TextBox ID="TxtPostVillage" CssClass="form-control" TabIndex="28" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                              
                            </div>
                        </div>
                        <div class="form-group">
                            <label>
                                Country Name<span class="red">*</span>
                            </label>
                            <asp:DropDownList ID="ddlCountryNAme" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCountryNAme_SelectedIndexChanged">
                            </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountryName" ErrorMessage="Please select a country." InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
          
                        </div>
                        <%--<div class="form-group ">
                            <label>
                                Mobile No.<span class="red">*</span></label>
                            <asp:TextBox ID="txtMobileNo" onkeypress="return isNumberKey(event);" CssClass="form-control validate[required,custom[mobile]]"
                                TabIndex="29" runat="server" MaxLength="10" ValidationGroup="eInformation" autocomplete="off"></asp:TextBox>
                        </div>--%>
                        <div class="row">
                            <div class="col-sm-3" style="padding-Top: 23px;">
                              <asp:TextBox ID="ddlMobileNAme"  CssClass="form-control "
                            runat="server"  ValidationGroup="eInformation" autocomplete="off" Enabled="false"></asp:TextBox>

                            </div>
                            <div class="col-sm-9" >
                            <label>
                            Mobile No.<span class="red">*</span></label>
                      <asp:TextBox ID="txtMobileNo" onkeypress="return isNumberKey(event);" CssClass="form-control validate[required,custom[mobile]]"
                            runat="server" MaxLength="10" ValidationGroup="eInformation" autocomplete="off"  ></asp:TextBox>
                            
                            </div>
             
                        </div>
                        <div id="Div4" class="form-group" visible="false" runat="server">
                            <label class="control-label col-sm-2">
                                Phone No.</label>
                            <asp:TextBox ID="txtPhNo" onkeypress="return isNumberKey(event);" CssClass="form-control"
                                TabIndex="30" runat="server" MaxLength="10" autocomplete="off"></asp:TextBox>
                        </div>
                        <div id="Div5" class="form-group greybt" runat="server">
                            <label>
                                E-Mail ID<span class="red">*</span></label>
                            <asp:TextBox ID="txtEMailId" CssClass="form-control validate[custom[email]]" TabIndex="31"
                                runat="server" autocomplete="off"></asp:TextBox>
                        </div>
                        <div id="Div9" class="form-group greybt" runat="server" visible="false" >
                            <label>
                                Aadhar No<span class="red">*</span></label>
                            <asp:TextBox ID="txtaadharno" CssClass="form-control" TabIndex="32"
                                runat="server" MaxLength="12" onkeypress="return isNumberKey(event);" autocomplete="off"></asp:TextBox>
                        </div>
                        <div id="Div6" class="form-group" runat="server" visible="false">
                            <label class="control-label col-sm-2">
                                PAN No Available<span class="red">*</span></label>
                            <div class="col-sm-10">
                                <asp:RadioButtonList ID="RbtPan" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                    RepeatLayout="Table" TabIndex="41">
                                    <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                </asp:RadioButtonList>
                                <span class="red">
                                    <asp:Label ID="LblPanNoAvail" runat="server" Text="Payout will deduct 20%, If you not enter PAN NO."></asp:Label></span>
                            </div>
                        </div>
                        <div class="form-group greybt" runat="server" visible="false">
                            <label class="control-label col-sm-2">
                                PAN No.<span class="red">*</span>
                            </label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtPanNo" RepeatDirection="Horizontal" CssClass="form-control validate[custom[panno]]"
                                    TabIndex="42" runat="server" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                        <div id="dvname" runat="server" visible="false">
                            <h4>
                                Nominee Detail</h4>
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    Nominee Name
                                </label>
                                <asp:TextBox ID="txtNominee" CssClass="form-control" TabIndex="32" runat="server"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="form-group greybt">
                                <label class="control-label col-sm-2">
                                    Relation</label>
                                <asp:TextBox ID="txtRelation" CssClass="form-control" TabIndex="33" runat="server"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                            <div id="divBankDetail" runat="server">
                                <h4>
                                    Bank Detail</h4>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Account No.</label>
                                    <asp:TextBox ID="TxtAccountNo" onkeypress="return isNumberKey(event);" CssClass="form-control"
                                        TabIndex="34" runat="server" MaxLength="16" autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group ">
                                    <label class="control-label col-sm-2">
                                        Account Type</label>
                                    <asp:DropDownList ID="DDLAccountType" runat="server" CssClass="form-control" TabIndex="21">
                                        <asp:ListItem Text="CHOOSE ACCOUNT TYPE" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="SAVING ACCOUNT" Value="SAVING ACCOUNT"></asp:ListItem>
                                        <asp:ListItem Text="CURRENT ACCOUNT" Value="CURRENT ACCOUNT"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Bank</label>
                                    <asp:DropDownList ID="CmbBank" runat="server" CssClass="form-control" TabIndex="36"
                                        onchange="FnBankChange(this.value);" autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group" id="divBank" style="display: none">
                                    <label class="control-label col-sm-2">
                                        Bank Name</label>
                                    <asp:TextBox ID="TxtBank" CssClass="form-control" TabIndex="37" runat="server" autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Branch Name</label>
                                    <asp:TextBox ID="TxtBranchName" CssClass="form-control" TabIndex="38" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        IFSC Code
                                    </label>
                                    <asp:TextBox ID="txtIfsCode" runat="server" CssClass="form-control" TabIndex="39"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group" visible="false">
                                    <asp:TextBox ID="TxtMICR" CssClass="form-control" Visible="false" TabIndex="40" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div id="Div7" class="form-group greybt" runat="server" visible="false">
                                <label class="control-label col-sm-2">
                                    AADHAR No.
                                </label>
                                <div class="row">
                                    <div class="col-sm-3  p0 pl10">
                                        <asp:TextBox ID="TxtAAdhar1" CssClass="form-control" TabIndex="43" runat="server"
                                            onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-1  p0 pl10" style="text-align: center">
                                        -
                                    </div>
                                    <div class="col-sm-3  p0 pl10">
                                        <asp:TextBox ID="TxtAadhar2" CssClass="form-control" TabIndex="44" runat="server"
                                            onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-1  p0 pl10" style="text-align: center">
                                        -
                                    </div>
                                    <div class="col-sm-3  p0 pl10">
                                        <asp:TextBox ID="TxtAadhar3" CssClass="form-control" TabIndex="45" runat="server"
                                            onkeypress="return isNumberKey(event);" MaxLength="4" autocomplete="off"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="divpay" runat="server" visible="false">
                                <h4>
                                    Payment Deposit Detail</h4>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Select Paymode</label>
                                    <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="form-control"
                                        TabIndex="46" autocomplete="off">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        <asp:Label ID="LblDDNo" runat="server" Text="Draft/CHEQUE No. *"></asp:Label></label>
                                    <asp:TextBox ID="TxtDDNo" CssClass="form-control" TabIndex="47" runat="server" MaxLength="15"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        <asp:Label ID="LblDDDate" runat="server" Text="Draft/CHEQUE Date *"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="TxtDDDate" runat="server" TabIndex="48" CssClass="form-control"
                                        autocomplete="off"></asp:TextBox>
                                   <%-- <AjaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtDDDate"
                                        Format="dd-MMM-yyyy">
                                    </AjaxToolkit:CalendarExtender>--%>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Issued Bank Name
                                    </label>
                                    <asp:TextBox ID="TxtIssueBank" CssClass="form-control" TabIndex="49" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                                <div class="form-group greybt">
                                    <label class="control-label col-sm-2">
                                        Issued Bank Branch</label>
                                    <asp:TextBox ID="TxtIssueBranch" CssClass="form-control" TabIndex="50" runat="server"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div id="divlogin" runat="server" visible="false">
                            <h4>
                                Login Information</h4>
                            <div class="form-group ">
                                <label class="control-label col-sm-2">
                                    Password<span class="red">*</span></label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="TxtPasswd" class="validate[required,minSize[5],maxSize[10]] form-control"
                                        TabIndex="51" runat="server" TextMode="Password" ValidationGroup="eInformation"
                                        autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div id="Div8" class="form-group" visible="false" runat="server">
                                <label class="control-label col-sm-2">
                                    Transaction Password<span class="red">*</span></label>
                                <asp:TextBox ID="TxtTransactionPassword" class="validate[required,minSize[5],maxSize[10]] form-control"
                                    TabIndex="52" runat="server" TextMode="Password" ValidationGroup="eInformation"
                                    autocomplete="off"></asp:TextBox>
                            </div>
                        </div>
                     
                        <asp:Label ID="lblErrEpin" runat="server" CssClass="error"></asp:Label>
                        <div class="col-sm-12">
                             <label >
                                <center>
                                    <asp:CheckBox ID="chkterms" runat="server" onclick="DivOnOff();" TabIndex="53" />
                                    I Agree With<a href="#" data-toggle="modal" data-target="#myModalTerm" >
                                        Terms And Condition</a>.
                                </center>
                        </div>
                        <div id="DivTerms" runat="server" visible="true" >
                            <%--<asp:Button ID="CmdSave" runat="server" Text="Send Otp" CssClass="btn btn-block py-2 btn-info"
                                TabIndex="54"  OnClick="CmdSave_Click"/>--%>
                            <asp:Button ID="CmdSave" runat="server" Text="Submit" CssClass="btn btn-success btn-flat"
                                TabIndex="54"  OnClick="CmdSave_Click"/>
                            &nbsp;<asp:Button ID="CmdCancel" runat="server" Text="Cancel" CssClass="btn btn-block py-2 btn-success"
                                ValidationGroup="eCancel" TabIndex="55" Visible="false" Onclikc="CmdCancel_Click"/>
                        </div>
                        <br />
                        <div id="divOtp" runat="server" visible="false">
                            <br />
                            <div class="col-lg-12 col-md-12">
                                <div class="form-group">
                                    <label>
                                        <b>Enter OTP Sent on your E-mail Id.</b> <span class="red">*</span></label>
                                    <br />
                                    <asp:TextBox ID="TxtPassword" autocomplete="off" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Label ID="lblOTPMsg" runat="server"></asp:Label>
                                    <asp:RequiredFieldValidator ID="rbtnbsa" runat="server" ControlToValidate="TxtPassword"
                                        SetFocusOnError="true" Text="*" ValidationGroup="Submitbtn"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <asp:Button ID="BtnPassword" runat="server" ValidationGroup="Submitbtn" Text="Submit"
                                    class="btn btn-warning btn-sm p-2" Width="150px" OnClick="BtnPassword_Click"/>
                                <asp:Button ID="btngenerate" runat="server" Text="Re-Generate OTP" class="btn btn-warning btn-sm p-2"
                                    Width="150px"  OnClick ="btngenerate_Click" />
                            </div>
                        </div>
                      </label>
                    </div>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="eSponsor" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="eInformation" />
                    &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                        ErrorMessage="Special characters are not allowed" ControlToValidate="txtUplinerId"
                        ValidationExpression="^[a-zA-Z0-9 _]*$" Display="None" ValidationGroup="eSponsor" />&nbsp;
                    <asp:RequiredFieldValidator runat="server" ID="RFV123" ValidationGroup="eSponsor"
                        ControlToValidate="RbtnLegNo" ErrorMessage="Choose Position" Display="None" />
                    &nbsp; &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server"
                        ErrorMessage="Special characters are not allowed" ControlToValidate="txtFrstNm"
                        ValidationExpression="^[a-zA-Z0-9 _,]*$" SetFocusOnError="true" Display="None"
                        ValidationGroup="eInformation" />
                    &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                        ErrorMessage="Special characters are not allowed" ControlToValidate="txtFNm"
                        ValidationExpression="^[a-zA-Z0-9 _]*$" SetFocusOnError="true" Display="None"
                        ValidationGroup="eInformation" />&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="None" ControlToValidate="txtPinCode"
                        runat="server" ErrorMessage="PinCode Required" SetFocusOnError="true" ValidationGroup="eInformation"></asp:RequiredFieldValidator>&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="None" ControlToValidate="TxtPostPincode"
                        runat="server" ErrorMessage="PinCode Required" SetFocusOnError="true" ValidationGroup="eInformation"></asp:RequiredFieldValidator>&nbsp;
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" Display="None"
                        ControlToValidate="TxtMobileNo" ErrorMessage="Minimum 12 Digits" ValidationExpression="^[0-9]{12,12}$"
                        SetFocusOnError="true" ValidationGroup="eInformation"></asp:RegularExpressionValidator>--%>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server"
                        Display="None" ControlToValidate="txtPhNo" ErrorMessage="Minimum 10 Digits with STD Code"
                        ValidationExpression="^[0-9]{10,10}$" SetFocusOnError="true" ValidationGroup="eInformation">
                    </asp:RegularExpressionValidator>&nbsp;
                    <asp:RegularExpressionValidator ID="EmailExpressionValidator" runat="server" ControlToValidate="txtEMailId"
                        ErrorMessage="Enter Valid Email ID!" Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        SetFocusOnError="true" ValidationGroup="eInformation"></asp:RegularExpressionValidator>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please check PAN Format"
                        Display="None" SetFocusOnError="true" ControlToValidate="txtPanNo" ValidationExpression="[A-Za-z]{5}\d{4}[A-Za-z]{1}"
                        ValidationGroup="eInformation"></asp:RegularExpressionValidator>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Display="None"
                        ErrorMessage="Special characters are not allowed" ControlToValidate="txtNominee"
                        SetFocusOnError="true" ValidationExpression="^[a-zA-Z0-9 _]*$" ValidationGroup="eInformation" />&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator17" runat="server"
                        Display="None" ErrorMessage="Special characters are not allowed" ControlToValidate="txtRelation"
                        SetFocusOnError="true" ValidationExpression="^[a-zA-Z0-9 _]*$" ValidationGroup="eInformation" />&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server"
                        ErrorMessage="Special characters not allowed" ControlToValidate="TxtBranchName"
                        ValidationExpression="^[a-zA-Z0-9 _]*$" Display="None" SetFocusOnError="true"
                        ValidationGroup="eInformation" />&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Special characters not allowed"
                        ControlToValidate="txtIfsCode" ValidationExpression="^[a-zA-Z0-9 _]*$" Display="None"
                        SetFocusOnError="true" ValidationGroup="eInformation" />&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" Display="None" ControlToValidate="TxtPasswd"
                        runat="server" ErrorMessage="Password Required" SetFocusOnError="true" ValidationGroup="eInformation"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="None" ControlToValidate="TxtTransactionPassword"
                        runat="server" ErrorMessage="Transaction Password Required" SetFocusOnError="true"
                        ValidationGroup="eInformation"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="Enter Valid IFSC Code"
                        Display="None" ControlToValidate="TxtIfsCode" ValidationGroup="eInformation"
                        ValidationExpression="[A-Za-z]{4}[0][a-zA-Z0-9]{6}$" SetFocusOnError="true"></asp:RegularExpressionValidator>&nbsp;
                </div>
            </div>
                    </div>
                </div>
                <div class="row">
                </div>
            </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </section>
        </div>
        <div id="myModalTerm" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">
                            Terms And Conditions</h4>
                    </div>
                    <div class="modal-body">
                        
                        <p>
                           These Terms and Conditions ("Terms") govern your use of the website www.wealthfactory.life ("Website") owned and operated by Wealth Factory ("We," "Us," or "Our"), and shall apply to all users, whether individuals or entities, including potential investors, clients, browsers, affiliates, and third-party businesses accessing or interacting with the Website or services offered directly or indirectly through it.
                        </p>
                        <h5>
                           1. DEFINITIONS
                        </h5>
                        <p>
                           1.1 "User" refers to any natural or legal person who accesses, views, interacts with, or uses the Website, including clients, investors, and third-party business representatives.</p>
                        <p>
                           1.2"Third-Party Businesses" refer to independent entities or partners listed, referred, or linked to from the Website that may offer financial, investment, advisory, real estate, or other commercial opportunities.</p>
                        <p>
                           1.3"Services" refers to information dissemination, lead facilitation, marketing, or redirection services, etc. offered through the Website by Wealth Factory.</p>
                        <h5>
    2. ELIGIBILITY AND LEGAL COMPETENCE
 </h5>
 <p>
    2.1 By accessing the Website, or using any portion of the Website or associated Services, the User expressly represents and warrants the following:
<br />
a. That the User is at least 18 years of age, or the age of legal majority in their jurisdiction, whichever is higher;
<br />
b. That the User is of sound mind, not disqualified or declared incompetent under applicable laws, including the Indian Contract Act, 1872;
<br />
c. That the User has full legal capacity and authority to enter into binding contracts in their own name, or on behalf of an entity they represent;
<br />
d. That the User is not barred by any court, regulatory body, or statute from accessing financial or commercial services.
</p>
 <p>
     2.2 If the User is under the age of 18, or is otherwise incompetent to contract, the User must not access or use this Website or agree to these Terms.
 </p>
 <p>
    2.3 The User acknowledges that Wealth Factory reserves the right, at its sole discretion, to require proof of age, identity, or competence at any time. Failure to provide satisfactory evidence may result in restricted access, suspension, or termination of the User's account or usage rights without any liability to Wealth Factory.
 </p>
                                <h5>
    3. NATURE OF SERVICES
 </h5>
 <p>
   3.1 Wealth Factory acts solely as an information platform and marketing interface to introduce users to potential business opportunities offered by third parties.
</p>
 <p>
    3.2 Wealth Factory does not offer personalized investment, legal, financial, or tax advisory services unless separately stated and offered through a registered and licensed entity.
 </p>
 <p>
   3.3 Information provided on the Website is intended for general informational purposes only and should not be construed as a solicitation, recommendation, or endorsement of any investment or commercial opportunity.
 </p>
 <p>
   3.4 Wealth Factory assumes no responsibility for monitoring, verifying, or enforcing any transactions or commercial activities conducted by Users outside the Website with third parties.
 </p>
  <h5>
    4. INTELLECTUAL PROPERTY
 </h5>
 <p>
  4.1 The Website and its Content, including but not limited to text, graphics, software, layout, logos, domain names, and proprietary strategies, are the exclusive intellectual property of Wealth Factory and are protected by Indian and international copyright, trademark, and other intellectual property laws.
</p>
 <p>
    4.2 Users may not copy, store, modify, distribute, republish, reproduce, or create derivative works from any material on the Website without prior written permission from Wealth Factory.
 </p>
 <p>
   4.3 The User agrees not to engage in any activity that infringes upon the intellectual property rights of Wealth Factory, including reverse engineering, decompiling, or otherwise tampering with the Website's structure or functionality.
 </p>
 <p>
   4.4 Third-party trademarks or copyrighted materials displayed on the Website remain the property of their respective owners. Nothing on the Website grants the User any right to use such third-party intellectual property.
 </p>
                          <h5>
    5. THIRD-PARTY REDIRECTIONS
 </h5>
 <p>
  5.1 The Website may include links to third-party websites or businesses. By clicking these links, users acknowledge and agree that Wealth Factory acts solely as an introducer, and any subsequent transactions or engagements are between the user and the third party.
</p>
 <p>
    5.2 Wealth Factory does not bear responsibility for the content, legality, or fulfillment of any third-party offerings. All issues, disputes, or claims arising from such engagements are solely between the user and the third-party business.
 </p>
                                                  <h5>
    6. RISK DISCLOSURE
 </h5>
 <p>
  6.1 By accessing or engaging with any product, service, opportunity, or third-party platform facilitated or introduced through Wealth Factory, the user expressly acknowledges and accepts that all such interactions are inherently subject to commercial, financial, legal, and market risks, including but not limited to partial or total loss of capital.
</p>
 <p>
    6.2 Wealth Factory does not offer, promote, or endorse any fixed-return or risk-free investment opportunities. Users must assume that all investment strategies carry the potential for both gains and losses, and that no assurance or warranty of profitability or suitability is offered by Wealth Factory or its affiliates.
 </p>
<p>
   6.3 All decisions relating to investment, tax planning, or legal strategy must be independently made by the user in consultation with qualified professionals. Neither Wealth Factory nor its group companies, affiliates, distributors, partners, nor any of their representatives provide legal, tax, or investment advice, nor do they assist in determining the fair value of any security or investment. Users are solely responsible for appointing their own legal, tax, and financial advisors prior to acting upon any opportunity.
</p>
<p>
  6.4 Users are further advised that past performance of any investment, product, or recommendation, whether discussed in general terms or reflected in any material or Research Report, should not be construed as a guarantee or indicator of future outcomes. No Research Report, article, or commentary made available by Wealth Factory should be relied upon as a recommendation to buy, sell, or hold any security or financial instrument.
</p>
                        <p>
 6.5 Wealth Factory, its affiliates, and representatives expressly disclaim any liability for losses, damages, or adverse consequences, including, but not limited to, financial loss, regulatory consequences, dissatisfaction, or disputes, arising from any engagement, transaction, or reliance upon information accessed through or in connection with Wealth Factory's platform.
</p>
                        <p>
 6.6 Users understand and agree that they proceed solely at their own discretion, risk, and liability.
</p>
                                                                          <h5>
    7. NO FIDUCIARY OR ADVISORY RELATIONSHIP
 </h5>
 <p>
 Nothing on the Website, nor any interaction with Wealth Factory or its representatives, shall be interpreted to establish a fiduciary, advisory, principal-agent, or partnership relationship. Users acknowledge that all engagements are undertaken independently and at their own discretion, without reliance on any advisory duty, recommendation, or implied obligation from Wealth Factory.
</p>
                                                                          <h5>
    8. LIMITATION OF LIABILITY
 </h5>
 <p>
 8.1 To the maximum extent permitted by applicable law, Wealth Factory, including its affiliates, officers, representatives, and employees, shall not be liable for any loss, damage, cost, or liability arising out of or in connection with:
<br />
a. Any errors, omissions, delays, or inaccuracies in Website content, whether technical, editorial, or user-generated;
<br />
b. Access disruptions, system downtime, server failures, bugs, malware, or other technological malfunctions;
<br />
c. User decisions or actions taken based on any content, communication, or connection facilitated through the Website;
<br />
d. Any business, investment, reputational, or opportunity loss stemming from use, misuse, or inability to use the Website or Services.
</p>
<p>
 8.2 In no event shall Wealth Factory be liable for any indirect, incidental, special, exemplary, or consequential damages, including loss of profits, revenue, or data, even if foreseeable or previously advised of the possibility.
</p>

                                                                                                  <h5>
    9. INDEMNITY
 </h5>
 <p>
 9.1 The User agrees to fully indemnify, defend, and hold harmless Wealth Factory, including its affiliates, officers, directors, employees, and authorized agents, from and against any and all claims, demands, proceedings, losses, liabilities, damages, penalties, costs, and expenses, arising out of or in connection with:
<br />
a. Any breach of these Terms or applicable laws or regulations by the User;
<br />
b. Any unauthorized, unlawful, negligent, or improper use of the Website or its content by the User;
<br />
c. Any reliance placed by the User on third-party offerings, links, introductions, or representations facilitated through the Website;
<br />
d. Any misrepresentation, act, or omission by the User during interactions with third-party websites, businesses, or platforms introduced via the Website.
</p>
<p>
 9.2 This indemnity obligation shall survive the termination or expiration of these Terms and the User's use of the Website.
</p>
<h5>
    10. TERMINATION AND MODIFICATION
 </h5>
 <p>
 10.1 Wealth Factory reserves the unconditional right, at its sole discretion, to:
<br />
a. Modify, update, suspend, or discontinue any part of the Website or its features, services, or content, in whole or in part, at any time and without prior notice;
<br />
b. Amend or revise these Terms periodically. The User's continued access or use of the Website following such updates shall constitute deemed acceptance of the modified Terms;
<br />
c. Suspend, restrict, or permanently terminate the User's access to the Website, without notice or liability, in the event of suspected fraud, violation of applicable laws, breach of these Terms, Code of Conduct, or for any conduct deemed harmful to the Website, its Users, or third-party partners.
</p>
<p>
 10.2 The User acknowledges that Wealth Factory shall not be liable for any loss, damage, or inconvenience caused by such modification, suspension, or termination of access.
</p>
                        <p>
 10.3 Upon termination, all rights granted to the User under the Website shall cease immediately, and the User shall promptly discontinue all use of the Website.
</p>
                        <h5>
    11. GOVERNING LAW AND JURISDICTION
 </h5>
 <p>
 These Terms shall be governed by and construed in accordance with the laws of India.
</p>
                        <p>
                            Any dispute arising under or in connection with these Terms shall be subject to the exclusive jurisdiction of the Courts at Gurugram, Haryana, India.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="myModalPolicy" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            &times;</button>
                        <h4 class="modal-title">
                            Privacy-Policy</h4>
                    </div>
                    <div class="modal-body">
                        <h4>
                            Policies and Procedures
                        </h4>
                        <p>
                            It is the responsibility of each Promoter to read, understand, adhere to, and ensure
                            that he or she is aware of and operating under the most current version of these
                            Policies. When enrolling a new Promoter, it is the responsibility of the enrolling
                            Promoter to provide the most current version of these Policies, the Cmayds technology
                            Terms and Conditions and the Business Plan to the applicant prior to his or her
                            execution of the Promoter Agreement.
                        </p>
                        <p>
                            Cmayds Technology reserves the right to change these Policies and Procedures,
                            Terms and Conditions, Compensation Plan and Marketing Policy at any time.</p>
                        <h4>
                            1. Ethics
                        </h4>
                        <p>
                            The COMPANY conducts business in an ethical and credible manner and requires its
                            promoters to deal ethically with their customers, with each other and with the COMPANY.
                            The COMPANY permits no unethical or illegal activity and will intercede when such
                            behavior may exist, and the COMPANY reserves the right to use its best judgment
                            in deciding whether certain Promoter activities are unethical. Furthermore, the
                            COMPANY may use its own discretion in determining the appropriate course of action.
                            If the COMPANY determines that unethical activities may exist, then it reserves
                            the right to suspend or terminate that promoter status, including but not limited
                            to all commissions and payments of any kind. Under no circumstances is an Promoter
                            who is terminated for unethical or illegal activity entitled to a refund of their
                            renewal fee, nor are they entitled to sell or transfer their position.</p>
                        <p>
                            <strong>Examples of unethical behaviour include but are not limited to the following:</strong>
                        </p>
                        <p>
                            A. Making any false or misleading remarks, statements, innuendos or rumours that
                            may disparage the COMPANY, its products or services, its Business plan, its employees,
                            its founders or another COMPANY Promoter</p>
                        <p>
                            B. Making any claim regarding the COMPANY’s products that are not found on the COMPANY’s
                            current websites or official, current marketing material</p>
                        <p>
                            C. Directly or indirectly disclosing any information to a third party other than
                            an official COMPANY authorized employee for the purpose of assisting you with a
                            specific issue.</p>
                        <p>
                            D. Providing, selling or revealing any customer lists and/or their contact information
                            that appears in your downline report to a third party. This includes the customer
                            lists and/or their contact information that belongs to the COMPANY or appears in
                            any other Promoter activity report or downline report.</p>
                        <p>
                            E. Directly or indirectly disclosing the password or other access code to third
                            parties</p>
                        <p>
                            F. Any unauthorized use of the COMPANY’s name, logos, photos, videos, trademarks
                            or copyrighted material in any way</p>
                        <p>
                            G. Violation of any state or federal laws or regulations</p>
                        <p>
                            H. Competing with the COMPANY’s products or services directly or indirectly through
                            association with another business or through your own personal efforts</p>
                        <p>
                            I. Aggressive or abusive language, behavior or treatment or any inappropriate behavior
                            toward any COMPANY employee, founder or another COMPANY Promoter.</p>
                        <h4>
                            2. Marketing Advertising Policy
                        </h4>
                        <p>
                            Cmayds Technology offers a Unique different Business plan that is provided by
                            the company to help you build your business. These materials such as brochures and
                            business PPT's are available through the website and given to you by company. There
                            are those Promoters who prefer to use their own materials or create materials for
                            certain special meetings. In the meetings this is the case, we have outlined our
                            policy and procedures for personalized marketing materials. Cmayds Technology
                            requires that all personalized marketing material be approved, by the COMPANY before
                            a Promoter can DISTRIBUTE such material.</p>
                        <h4>
                            Privacy Policy</h4>
                        <h5>
                            Personal Information
                        </h5>
                        <p>
                            The COMPANY maintains a strong commitment to protecting the privacy of our customers
                            and Promoters and their personal information. “Personal Information” means any information
                            about an identifiable individual, other than business contact information. We protect
                            that information. Unauthorized disclosure or access of personal information, including
                            but not limited to account information or personal identification number, is a violation
                            of the COMPANY’s Privacy Policy and is strictly prohibited.</p>
                        <p>
                            The Promoter acknowledges that during this Agreement, he or she will be provided
                            or will be exposed to or will have access to personal information and that such
                            personal information is confidential. The Promoter agrees that such Personal Information
                            will be collected, used and disclosed only for the purposes for which it was collected
                            and only in relation to the provision of the COMPANY’s services or products.</p>
                        <p>
                            The Promoter agrees to co-operate with the COMPANY in any regulatory investigation
                            or in any internal investigation regarding any alleged privacy breach or complaint.</p>
                        <h4>
                            Conclusion
                        </h4>
                        <p>
                            The rules and regulations outlined in this document are intended to protect the
                            opportunity for all involved.
                        </p>
                        <p>
                            Please follow the Terms and Conditions as well as the Policies and Procedures as
                            set forth here to ensure that you are in compliance. Please note that any infraction
                            of these rules and regulations may result in suspension or immediate deactivation/termination
                            of your status as an Cmayds Technology Promoter</p>
                        <p>
                            It is the goal of the COMPANY to introduce our applications, products and vision
                            to as many members/clients as possible with the purpose in mind of offering them
                            a Business opportunity for earning. Coupled with this is our desire to help others
                            achieve financial reward for being involved with us as a Promoters. The COMPANY
                            desires to develop a long term, stable relationship of mutual respect, trust and
                            integrity with our Promoters. By assisting them in achieving their goals and dreams,
                            the COMPANY’s goal of establishing a long-lasting team will be realized.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

