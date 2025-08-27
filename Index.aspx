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
    /* Overlay with Flexbox Centering */
.modal {
    /*position: fixed;*/
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.6);
   
    display: none;             /* initially hidden */
    /*align-items: center;*/         /* vertical center */
    /*justify-content: center;*/     /* horizontal center */
     z-index: 9999;
}

/* Modal Box */
.modal-content {
    background: #fff;
    width: 60%;
    margin:auto;
    /*max-width: 700px;*/
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    max-height: 85vh;
    display: flex;
    flex-direction: column;
    padding: 20px;
    animation: fadeIn 0.3s ease-in-out;
}

/* Header */
.modal-header {
    background: #00a86b; /* Green header */
    color: #fff;
    padding: 12px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    font-size: 18px;
    font-weight: bold;
}

.close-btn {
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
    color: #fff;
}

.close-btn:hover {
    color: #ffcccc;
}

/* Body */
.modal-body {
    padding: 20px;
    color: #333;
    overflow-y: auto;
    flex: 1;
}

/* Footer */
.modal-footer {
    padding: 15px;
    border-top: 1px solid #ddd;
    background: #f9f9f9;
}

.btn-proceed {
    background: #00a86b;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 15px;
}

.btn-proceed:hover {
    background: #008f5a;
}

/* Animation */
/*@keyframes fadeIn {
    from {opacity:0; transform: scale(0.95);}
    to {opacity:1; transform: scale(1);}
}*/
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
   <%-- <asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
        <!-- Overlay -->
        <div id="DisclaimerModal" runat="server" class="modal" style="display:none;">
            <%--<div class="modal-overlay"></div>--%>

            <!-- Modal Box -->
            <div class="modal-content">
                <!-- Header -->
                <div class="modal-header">
                    <h3><asp:Label ID="lblTitle" runat="server" Text=""></asp:Label></h3>
                   <%-- <span class="close-btn" onclick="closeDisclaimer()">&times;</span>--%>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <p style="white-space:pre-line;">
                        <asp:Label ID="lblBody" runat="server"></asp:Label>
                    </p>
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <div class="col-sm-12 text-center">
                        <label>
                            <asp:CheckBox ID="chkterms" runat="server" onclick="DivOnOff();" TabIndex="53"></asp:CheckBox>
                            I Accept
                        </label>
                    </div>

                    <div id="DivTerms" style="display:none; text-align:center; margin-top:10px;">
                        <asp:Button ID="btnProceed" runat="server" Text="Proceed" CssClass="btn-proceed" OnClick="btnProceed_Click" />
                    </div>
                </div>
            </div>
        </div>
   <%-- </ContentTemplate>
</asp:UpdatePanel>--%>

<script type="text/javascript">
    // Show modal
    function showDisclaimer() {
        document.getElementById('<%= DisclaimerModal.ClientID %>').style.display = "block";
    }

    // Hide modal on Close
    function closeDisclaimer() {
        document.getElementById('<%= DisclaimerModal.ClientID %>').style.display = "none";
    }

    // Show/hide Proceed button when checkbox is checked
    function DivOnOff() {
        var chk = document.getElementById('<%= chkterms.ClientID %>');
        var div = document.getElementById('DivTerms');
        if (chk.checked) {
            div.style.display = "block";
        } else {
            div.style.display = "none";
        }
    }
</script>
    <div class="content-wrapper" style="min-height: 778px;">

        <script>
            (function () {
                'use strict';
                // click events
                document.body.addEventListener('click', copy, true);
                // event handler
                function copy(e) {
                    debugger;
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
                            <p style="text-align: right; padding: 4px 10px; color: #ffffff; background: #3fb1d9; border-top-left-radius: 60px;">Left Referral Link : </p>
                        </div>
                        <div class="col-md-8 col-xs-12">
                            <div class="input-group input-group-sm" style="margin-bottom: 8px;">
                                <input type="text" runat="server" class="form-control" id="lblLink" name="uid" placeholder="Distributor/Customer ID"
                                    style="background-color: rgb(255, 255, 255); font-size: 14px; color: #525252;" onclick="select()" value="#">
                                <span class="input-group-btn">
                                    <button class="btn btn-success btn-flat" type="button" data-copytarget="#ContentPlaceHolder1_lblLink">Copy</button>
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
                                <input type="text" runat="server" class="form-control" id="lblLink1" name="uidd" placeholder="Distributor/Customer ID"
                                    style="background-color: rgb(255, 255, 255); font-size: 14px; color: #525252;" onclick="select()" value="#">
                                <span class="input-group-btn">
                                    <button class="btn btn-success btn-flat" type="button" data-copytarget="#ContentPlaceHolder1_lblLink1">Copy</button>
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
                                    Reward</strong>
                                    <span class="pull-right badge bg-blue">
                                        <asp:Label ID="lblRank" runat="server" Text=""></asp:Label>
                                    </span></a></li>

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-xs-12">
                    <div class="box box-info box-solid">
                        <div class="box-header with-border">
                            <i class="ion ion-clipboard"></i>
                            <h3 class="box-title">WALLET SUMMARY </h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="display: block; padding: 10px;">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <tr>
                                        <th>WalletName </th>
                                        <th>Credit </th>
                                        <th>Debit </th>
                                        <th>Balance </th>
                                    </tr>
                                    <asp:Repeater ID="RptWallet" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%#Eval("WalletName")%></td>
                                                <td><%#Eval("Credit")%></td>
                                                <td><%#Eval("Debit")%></td>
                                                <td><%#Eval("Balance")%></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-xs-12">
                    <div class="box box-info box-solid">
                        <div class="box-header with-border">
                            <i class="ion ion-clipboard"></i>
                            <h3 class="box-title">MY TEAM DETAIL</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="display: block; padding: 10px;">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">

                                    <tr>
                                        <th style="text-align: center !important">Metrics</th>
                                        <th style="text-align: center !important"><span id="ctl00_ContentPlaceHolder1_LLeft">Left</span> </th>
                                        <th style="text-align: center !important"><span id="ctl00_ContentPlaceHolder1_LRight">Right</span> </th>
                                        <th style="text-align: center !important">Total </th>
                                    </tr>
                                    <asp:Repeater ID="RptMemberStatistics" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td style="text-align: left !important; font-weight: bold;">
                                                    <%# Eval("Name") %>
                                                </td>
                                                <td style="text-align: center !important">
                                                    <%#Eval("LeftRegistration")%>
                                                </td>
                                                <td style="text-align: center !important">
                                                    <%#Eval("RightRegistration")%>
                                                </td>
                                                <td style="text-align: center !important">
                                                    <%#Eval("TotalRegistration")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
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



