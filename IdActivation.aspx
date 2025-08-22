<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="IdActivation.aspx.cs" Inherits="IdActivation" %>

<asp:Content ContentPlaceHolderID="head" runat="server" ID="content2">

    <script type="text/javascript" src="assets/jquery.min.js">
    </script>
    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>
    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>
    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .feedbackform {
            width: auto;
            height: auto;
            position: absolute;
            top: 100px;
            left: 40%;
            z-index: 9999;
            display: block;
            padding: 15px;
            background: #fff;
            border-radius: 5px;
            border: 1px solid;
        }

            .feedbackform img {
                max-width: 150px;
                display: block;
            }

        .feedbackpop {
            background: url(images/blackbg2.png) repeat;
            position: fixed;
            width: 100%;
            height: 100%;
            display: block;
            z-index: 9999;
        }

        #closeicon a {
            background: url(images/close2.png) no-repeat;
            width: 55px;
            height: 55px;
            display: block;
            margin: -22px -30px 0 0;
            float: right;
            position: absolute;
            right: 0px;
        }

            #closeicon a:hover {
                background: url(images/close2_hover.png) no-repeat;
            }

        #feedbackwrap {
            width: 1000px;
            margin: 0 auto;
            position: relative;
        }

        @media ( max-width: 1000px ) {
            #feedbackwrap {
                width: 100%;
            }

            .feedbackform {
                left: 2%;
                right: 2%;
            }
        }
    </style>
    <script type="text/javascript">

        function checkWAmt() {

            var WAvlBal = '<%= Session["ServiceWallet"] %>';

            var Amt = document.getElementById("<%= txtAmount.ClientID %>").value;

            if (parseFloat(Amt) > parseFloat(WAvlBal)) {
                alert('Transfer amount could not be greater than available balance.');
                document.getElementById("<%= txtAmount.ClientID %>").value = '0';
                return false;
            }

            else {
                return true;
            }

        }

    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <div class="content-header">
            <h1>Id Activation
            </h1>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Id Activation</h3>
                        </div>
                        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                            <div class="clearfix gen-profile-box">
                                <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">
                                        <br>
                                        <div class="centered">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <h4>Available Balance:<span class="red" id="AvailableBal" style="color: Red" runat="server"></span>
                                                    </h4>
                                                </div>
                                                <div class="form-group" id="DiMemberId" runat="server">
                                                    <label for="inputdefault">
                                                        Member Id</label>
                                                    <asp:TextBox ID="txtMemberId" runat="server" class="form-control validate[required]"
                                                        AutoPostBack="true" OnTextChanged="txtMemberId_TextChanged"></asp:TextBox>
                                                    <asp:Label ID="lblFormno" runat="server" Visible="false"></asp:Label>
                                                </div>
                                                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                    <ContentTemplate>
                                                        <div class="form-group" id="DivMemberName" runat="server">
                                                            <label for="inputdefault">
                                                                Member Name</label>
                                                            <asp:Label ID="LblMobile" runat="server" Visible="false"></asp:Label>
                                                            <asp:TextBox ID="TxtMemberName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                                        </div>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="txtMemberId" EventName="TextChanged" />

                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                <div class="form-group" style="display: none;">
                                                    <label for="inputdefault">
                                                        Payment Type</label>
                                                    <asp:DropDownList ID="DDLPaymode" runat="server" class="form-control" AutoPostBack="true">
                                                        <asp:ListItem Text="Wallet" Value="1"></asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <div class="form-group" id="DivCurrency" runat="server" visible="false">
                                                            <label for="inputdefault">
                                                                Currency <span class="red">*</span></label>
                                                            <asp:DropDownList ID="ddlcurrency" runat="server" CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="form-group" id="Div1" runat="server">
                                                            <label for="inputdefault">
                                                                Package</label>
                                                            <asp:DropDownList ID="CmbKit" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="CmbKit_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>

                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="DDLPaymode" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <div class="form-group">
                                                            <label for="inputdefault">
                                                                Amount <span class="red">*</span></label>
                                                            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control validate[required]"
                                                                onchange="checkWAmt();" onkeypress="return isNumberKey(event);" Enabled="false"></asp:TextBox><asp:Label
                                                                    ID="LblAmount" runat="server" Visible="false"></asp:Label>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAmount"
                                                                ErrorMessage="Enter numbers Only." ValidationExpression="((\d+)((\.\d{1,2})?))$" />
                                                            <asp:HiddenField ID="hdnMacadrs" runat="server" />
                                                            <asp:HiddenField ID="HdnTopupSeq" runat="server" />
                                                            <asp:HiddenField ID="HdnMemberMacAdrs" runat="server" />
                                                            <asp:HiddenField ID="HdnMemberTopupseq" runat="server" />
                                                            <asp:HiddenField ID="MemberStatus" runat="server" />
                                                            <asp:HiddenField ID="hdnFormno" runat="server" />
                                                            <asp:HiddenField ID="hdnemail" runat="server" />
                                                        </div>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="CmbKit" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                <div class="form-group ">
                                                      <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                    <label for="inputdefault">
                                                        Transaction Password</label>
                                                    <asp:TextBox ID="TxtTransPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <asp:Button ID="cmdSave1" runat="server" Text="Submit" class="btn btn-primary" ValidationGroup="Validation" OnClick="cmdSave1_Click" />
                                                </div>
                                                <div class="form-group ">
                                                    <asp:Label ID="LblError" runat="server" Visible="false"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
