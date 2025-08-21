<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="welcome.aspx.cs" Inherits="welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <%-- <script type="text/javascript" src="assets/jquery.min.js">
    </script>

   
    <script type="text/javascript" src="assets/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="assets/jquery.validationEngine.js"></script>

    <link href="assets/validationEngine.jquery.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        function PrintDiv() {

            var divContents = document.getElementById("ctl00_ContentPlaceHolder1_dvContents").innerHTML;
            var printWindow = window.open('', '', 'height=200,width=400');
            printWindow.document.write('<html><head>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(divContents);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();

        }
    </script>--%>
     <style type="text/css" >
    .btn-info {
   width: 100% !important;
}
.btn-warning {
   width: 100% !important;
}</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--              <div class="stars"></div>
<div class="stars2"></div>
<div class="stars3"></div>  
    <div id="content" class="main-content">
        <div class="sub-header-container">
            <header class="header navbar navbar-expand-sm">
                <a href="javascript:void(0);" class="sidebarCollapse"
                    data-placement="bottom" tabindex="-1"><i class="las la-bars"></i></a>
                <ul class="navbar-nav flex-row">
                    <li>
                        <div class="page-header">
                            <nav class="breadcrumb-one" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item active" aria-current="page"><span>Welcome Letter
                                    </span></li>
                                </ol>
                            </nav>
                        </div>
                    </li>
                </ul>
            </header>
        </div>
       
        <div class="container-fluid">
            <div id="ctl00_ContentPlaceHolder2_upChPwd">

                <div id="ctl00_ContentPlaceHolder2_message">
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div id="ctl00_ContentPlaceHolder1_divgenexbusiness">
                                <div class="clearfix gen-profile-box" style="min-height: auto;">--%>
     <div class="content-wrapper">
        <div class="content-header">
           <%-- <h1>
                Welcome
            </h1>--%>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title">
                                        Welcome</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <!-- Genex Business -->
                                                <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                                    <div class="clearfix gen-profile-box" style="min-height: auto;">
                                                        <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">

                                        <br>
                                        <div class="row" style="margin-right: 350px">
                                            <div class="col-md-6">
                                            </div>
                                            <div class="col-md-5">
                                                <button type="button" class="btn btn-warning btn-flat" id="BtnHome"
                                                    runat="server" oNcLICK="BtnHome_ServerClick">
                                                    Home</button>
                                                <button type="button" class="btn btn-warning btn-flat" id="BtnPrint" runat="server"
                                                    OnClick="javascript:PrintDiv();" visible="false">
                                                    Print</button>
                                                &nbsp;
                                                  <button type="button" class="btn btn-warning btn-flat" style="width: 140px;" id="BtnNewJoin"
                                                  runat="server" OnClick="BtnNewJoin_ServerClick">
                                                   New Joining
                                                  </button>
                                            </div>
                                            <div class="clearfix">
                                            </div>
                                            <div id="dvContents" runat="server">
                                                <div class="container">

                                                    <div class="row">
                                                       
                                                        <p style="margin-bottom: 0px">
                                                            &nbsp;
                                                        </p>
                                                        <h3 class="text-danger" style="display: none;">
                                                            <strong><em>Welcome Promoters to ever shine family of connectdots !</strong>
                                                        </h3>
                                                        <h4 style="display: none;">Date : - <b>
                                                            <asp:Label ID="lblDoj" runat="server"></asp:Label></b>
                                                        </h4>
                                                        <h4 style="display: none;">Dear <b>
                                                            <asp:Label ID="LblName" runat="server"></asp:Label>
                                                            (<asp:Label ID="LblIdno" runat="server"></asp:Label>)</b>
                                                        </h4>
                                                        <p style="display: none;">
                                                            It gives us immense pleasure to welcome you as a Global Business Promoter of connectdots
                                                                            . We wish you great success in your new endeavor. You are starting a journey, where
                                                                            you will be the promoter of every application of connectdots. You engage in our
                                                                            Service and agree to be follow the rules &amp; regulations. Your Member Id as specified
                                                                            below, is to be used in all your communication with the company.
                                                        </p>
                                                        <div class="col-md-12">
                                                            <center>
                                                                <h3 style="font-size: 1.4em">Member Details!</h3>
                                                            </center>
                                                            <style>
                                                                @media screen and (min-width: 1024px) {
                                                                    .table_design {
                                                                        margin-left: 170px
                                                                    }
                                                                }
                                                            </style>
                                                            <center>
                                                                <table id="welcomeletter" runat="server" class="table_design table table-bordered" cellspacing="0">
                                                                    <center>
                                                                        <h5>Your subscription details are as follows
                                                                        </h5>
                                                                    </center>
                                                                    <tr>
                                                                        <td>
                                                                            <h5 style="font-size: 1em">Member Name
                                                                            </h5>
                                                                        </td>
                                                                        <td>
                                                                            <h5 style="font-size: 0.8em">
                                                                                <b>
                                                                                    <asp:Label ID="LblName1" runat="server"></asp:Label></b></h5>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <h5 style="font-size: 1em">Member ID
                                                                            </h5>
                                                                        </td>
                                                                        <td>
                                                                            <h5 style="font-size: 0.8em">
                                                                                <b>
                                                                                    <asp:Label ID="LblIdno1" runat="server"></asp:Label></b></h5>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td>
                                                                            <h5 style="font-size: 1em">Joining Date
                                                                            </h5>
                                                                        </td>
                                                                        <td>
                                                                            <h5 style="font-size: 0.8em">
                                                                                <b>
                                                                                    <asp:Label ID="lblDoj1" runat="server"></asp:Label></b></h5>
                                                                        </td>
                                                                    </tr>
                                                                   
                                                                    <tr>
                                                                        <td>
                                                                            <h5 style="font-size: 1em">Password
                                                                            </h5>
                                                                        </td>
                                                                        <td>
                                                                            <h5 style="font-size: 0.8em">
                                                                                <b>
                                                                                    <asp:Label ID="lblPassw" runat="server"></asp:Label></b></h5>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <h5 style="font-size: 1em">Transaction Password
                                                                            </h5>
                                                                        </td>
                                                                        <td>
                                                                            <h5 style="font-size: 0.8em">
                                                                                <b>
                                                                                    <asp:Label ID="lblTransPassw" runat="server"></asp:Label></b></h5>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </center>
                                                        </div>
                                                        <p style="display: none;">
                                                            Once again welcome to connectdots family and congratulations on taking your first
                                                                            step towards a very prosperous and promising future. We are looking forward to have
                                                                            better business prospective in your promotership.
                                                        </p>
                                                        <p style="display: none;">
                                                            <br>
                                                            Thank You!
                                                        </p>
                                                        <p class="text-success" style="display: none;">
                                                            Best Regards,
                                                                            <br />
                                                            <strong>
                                                                <%=Session["CompName"]%></strong>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr>
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
            </div>
        </div>
    </div>
<%--                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
   
    </em>--%>
   
   
</asp:Content>

