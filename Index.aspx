<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <style>
        .tblpadding {
            padding-top: 5px !important;
            padding-bottom: 0px !important;
        }

        .tblpadding1 {
            padding-top: 5px !important;
            padding-bottom: 0px !important;
            text-align: right;
        }
    </style>

    <script type="text/javascript">
        function copyText() {

            var range, selection, worked;
            var element = document.getElementById("ContentPlaceHolder1_lblLink");
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(element);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }

            try {
                document.execCommand('copy');
                alert('link copied');
            }
            catch (err) {
                alert('unable to copy link');
            }
            return false;
        }

    </script>

    <script type="text/javascript">
        function copyText1() {
            debugger;
            var range, selection, worked;
            var element = document.getElementById("ContentPlaceHolder1_lblLink1");
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(element);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }

            try {
                document.execCommand('copy');
                alert('link copied');
            }
            catch (err) {
                alert('unable to copy link');
            }
            return false;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="min-height: 778px;">

        <script>
            (function () {
                'use strict';
                // click events
                document.body.addEventListener('click', copy, true);
                // event handler
                function copy(e) {
                    // find target element
                    var
                        t = e.target,
                        c = t.dataset.copytarget,
                        inp = (c ? document.querySelector(c) : null);
                    // is element selectable?
                    if (inp && inp.select) {
                        // select text
                        inp.select();
                        try {
                            // copy text
                            document.execCommand('copy');
                            inp.blur();
                            alert('Copied...!!');
                        }
                        catch (err) {
                            alert('please press Ctrl/Cmd+C to copy');
                        }
                    }
                }

            })();

        </script>

        <script src="./dashboard_files/jquery-1.7.1.js"></script>

        <script>

            function upgradefun() {
                $.ajax({
                    type: "get",
                    url: "upgrade_id.php",
                    data: 'amtid=' + amtid,
                    success: function (response) {
                        if (response.trim() == "ok") {
                            window.location.href = "dashboard.php?success=1";
                        } else {
                            document.getElementById('errorDivs').innerHTML = response;
                        }
                    }
                });
            }

        </script>

        <!-- Content Header (Page header) -->
        <section class="content-header head-new" style="min-height: 64px; background: #ffffff; box-shadow: 0px 0px 6px #9c9c9c; padding: 14px 20px 0;">
            <div class="row">
                <div class="col-md-2 col-xs-6">
                    <h4 style="font-size: 20px; font-weight: 600; margin: 4px 0 15px;">DASHBOARD</h4>
                </div>
                <div class="col-md-5 col-xs-12">
                    <div class="row">
                        <div class="col-md-4 col-xs-12">
                            <p style="text-align: right; padding: 4px 10px; color: #ffffff; background: #3fb1d9; border-top-left-radius: 60px;">&nbsp;&nbsp;&nbsp;&nbsp;Left Referral Link : </p>
                        </div>
                        <div class="col-md-8 col-xs-12">
                            <div class="input-group input-group-sm" style="margin-bottom: 8px;">
                                <asp:Label ID="lblLink" runat="server" Text="" onClick="select()" Style="background-color: rgb(255, 255, 255); font-size: 14px; color: #525252;"></asp:Label>
                                <span class="input-group-btn">

                                    <asp:Button ID="btncopy" class="btn btn-success btn-flat" runat="server" Text="Copy" OnClientClick="return copyText();" Style="width: auto" />

                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-5 col-xs-12">
                    <div class="row">
                        <div class="col-md-4 col-xs-12">
                            <p style="text-align: right; padding: 4px 10px; color: #ffffff; background: #3fb1d9; border-top-left-radius: 60px;">Right Referral Link : </p>
                        </div>
                        <div class="col-md-8 col-xs-12">
                            <div class="input-group input-group-sm" style="margin-bottom: 8px;">
                                <asp:Label ID="lblLink1" runat="server" Text="" onClick="select()" Style="background-color: rgb(255, 255, 255); font-size: 14px; color: #525252;"></asp:Label>
                                <%--<input class="form-control" type="text" id="website1" value="https://cpanel.life4ever.co.in/NewJoiningfree.aspx?ref=muC64RboUtAQpE2ujeYMvg==&side=Left" onClick="select()" style="background-color: rgb(255, 255, 255);font-size: 14px;color: #525252;">--%>
                                <span class="input-group-btn">
                                    <asp:Button ID="Button1" class="btn btn-success btn-flat" OnClientClick="return copyText1();"
                                        runat="server" Text="Copy" Style="width: auto" />
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-md-4 col-xs-12">
                    <div class="box box-widget widget-user-2" style="border: 1px solid #cacaca;">
                        <!-- Add the bg color to the header using any of the bg-* classes -->
                        <div class="widget-user-header bg-blue" style="padding: 12px; background: linear-gradient(to right, #1f6fab, #33a62b);">
                            <div class="widget-user-image">
                                <asp:Image ID="Image2" runat="server" Style="height: 65px; max-width: 70px;" class="imageUser img-circle" />
                                <%--   <img src="./dashboard_files/user2.png" style="height: 65px; max-width: 70px;" class="imageUser img-circle"> --%>
                            </div>
                            <h5 class="widget-user-username" style="font-size: 16px; font-weight: bold; margin-bottom: 12px;">ACCOUNT </h5>
                            <!-- <h5 class="widget-user-desc" style="font-size: 12px;">View your account details here</h5>  -->
                        </div>
                        <div class="widget-user-image" style="position: absolute; top: 27px; left: 30%; margin-left: 70px;"></div>
                        <div class="box-footer no-padding">
                            <ul class="nav nav-stacked">
                                <li><a href=""><strong><i class="fa fa-arrow-circle-o-right margin-r-5"></i>Status</strong> <span class="pull-right badge bg-blue"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i>&nbsp;
                                    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                                </span></a></li>
                                <li><a href="#"><strong><i class="fa fa-user margin-r-5"></i>Name</strong> <span class="pull-right badge bg-blue">
                                    <asp:Label ID="lblUserNAme" runat="server" Text=""></asp:Label>
                                </span></a></li>
                                <li><a href="#"><strong><i class="fa fa-user margin-r-5"></i>Username</strong> <span class="pull-right badge bg-blue">
                                    <asp:Label ID="lblIdno" runat="server" Text=""></asp:Label></span></a> </li>
                                <li style="display: none"><a href="#"><strong><i class="fa fa-map-marker margin-r-5"></i>Email Id</strong> <span class="pull-right badge bg-blue"><span>
                                    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></span> </span></a></li>
                                <li><a href="#"><strong><i class="fa fa-calendar margin-r-5"></i>Registration Date</strong> <span class="pull-right badge bg-blue">
                                    <asp:Label ID="lblDoj" runat="server" Text=""></asp:Label>
                                </span></a></li>
                                <li><a href="#"><strong>
                                    <i class="fa fa-calendar margin-r-5"></i>Date Of Activation</strong>
                                    <span class="pull-right badge bg-blue">
                                        <asp:Label ID="lblActivation" runat="server" Text=""></asp:Label>
                                    </span></a></li>
                                <li><a href="#"><strong>
                                    <i class="fa fa-map-marker margin-r-5"></i>
                                    My Pack</strong>
                                    <span class="pull-right badge bg-blue">
                                        <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                    </span></a></li>

                                <li><a href="#"><strong>
                                    <i class="fa fa-map-marker margin-r-5"></i>
                                    Rank</strong>
                                    <span class="pull-right badge bg-blue">
                                        <asp:Label ID="lblRank" runat="server" Text=""></asp:Label>
                                    </span></a></li>

                            </ul>
                        </div>
                    </div>

                </div>

                <asp:Repeater ID="RptWallet" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 col-sm-6 col-xs-12">
                            <%#Eval("HtmlSnippet")%>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Repeater ID="RptIncome" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 col-sm-6 col-xs-12">
                            <%#Eval("HtmlSnippet")%>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                 <asp:Repeater ID="RptBusiness" runat="server">
     <ItemTemplate>
         <div class="col-md-4 col-sm-6 col-xs-12">
             <%#Eval("HtmlSnippet")%>
         </div>
     </ItemTemplate>
 </asp:Repeater>
            </div>
            <div class="row">
                <div class="box box-info box-solid">
                    <div class="box-header with-border">
                        <i class="ion ion-clipboard"></i>
                        <h3 class="box-title">LATEST INFORMATION</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="box-comment" style="cursor: pointer;">
                            <marquee loop="true" behavior="scroll" direction="up" scrolldelay="60" scrollamount="2" style="margin-top: 0px; height: 250px;" onmouseover="this.stop();" onmouseout="this.start();">

                                <asp:Repeater runat="server" ID="RptNews">
                                    <ItemTemplate>

                                        <div class="comment-text" style="color: black;">
                                            <span class="username" style="color: #c3602b;">
                                                <h4><i class="fa fa-user"></i><%#Eval("NewsDate")%> </h4>
                                            </span>

                                            <p><%#Eval("NewsDetail")%></p>
                                        </div>
                                        <hr />
                                    </ItemTemplate>
                                </asp:Repeater>

                            </marquee>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            function myFunction() {
                var copyText = document.getElementById("referral-link");
                copyText.select();
                document.execCommand("copy");

                var tooltip = document.getElementById("refcopy");
                tooltip.innerHTML = "Copied: " + copyText.value;
            }

            function outFunc() {
                var tooltip = document.getElementById("refcopy");
                tooltip.innerHTML = "Copy to clipboard";
            }
        </script>

    </div>
    <!-- /.content-wrapper -->
    <!-- Bootstrap -->

    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>

    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>

    <!-- Bootstrap -->
    <div id="MyPopup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="color: Red; font-size: 20px; font-weight: 600;"></h4>
                </div>
                <div class="modal-body" style="font-size: 16px; font-weight: 600;">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function ShowPopup(title, body) {
            $("#MyPopup .modal-title").html(title);
            $("#MyPopup .modal-body").html(body);
            $("#MyPopup").modal("show");
        }
    </script>

    <!-- Styles -->
    <style>
        #chartdiv {
            width: 100%;
            height: 500px;
        }
    </style>
</asp:Content>



