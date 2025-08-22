<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <%=Session["Title"]%></title>

    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="css/fonts/icomoon/style.css">
    <link rel="stylesheet" href="css/css/owl.carousel.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/css/bootstrap.min.css">
    <!-- Style -->
    <link rel="stylesheet" href="css/css/style.css">


    <script type="text/javascript" src="highslide/highslide-full.js"></script>

    <link rel="stylesheet" type="text/css" href="highslide/highslide.css" />

    <script type="text/javascript">
        hs.graphicsDir = 'highslide/graphics/';
        hs.align = 'center';
        hs.transitions = ['expand', 'crossfade'];
        hs.fadeInOut = true;
        hs.dimmingOpacity = 0.8;
        hs.outlineType = 'rounded-white';
        hs.marginTop = 60;
        hs.marginBottom = 40;
        hs.numberPosition = '';
        hs.wrapperClassName = 'custom';
        hs.width = 600;
        hs.height = 500;
        hs.number = 'Page %1 of %2';
        hs.captionOverlay.fade = 0;

        // Add the slideshow providing the controlbar and the thumbstrip

    </script>

    <!--Slider-in icons-->
    <!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

    <script language="javascript" type="text/javascript">
        function PutCursor() {
            document.loginform.Txtuid.focus();
        }
    </script>

    <script type="text/javascript">
        function disableBackButton() {
            window.history.forward();
        }
        setTimeout("disableBackButton()", 0);
    </script>

    <script type="text/javascript">

        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };

    </script>

    <script>
        document.onkeydown = function (e) {
            if (event.keyCode == 123) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'S'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'H'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'A'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'F'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'E'.charCodeAt(0)) {
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="loginform" runat="server">
        <div class="d-md-flex half" style="background-image: url(css/images/bg_2.jpg);">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-md-12">
                        <div class="form-block mx-auto" style="border-radius: 5px;">
                            <div class="text-center mb-5">
                                <h3 class="text-uppercase">
                                    <img src="images/logo.png" style="max-width: 250px;">
                                </h3>
                                <hr>
                                <h5>Login - Registration
                                </h5>
                            </div>

                            <div class="form-group first">
                                <label for="username">
                                    User ID</label>
                                <input type="text" runat="server" class="form-control" id="Txtuid" name="uid" placeholder="Distributor/Customer ID"
                                    required="">
                            </div>
                            <div class="form-group last mb-3">
                                <label for="password">
                                    Password</label>
                                <input type="password" runat="server" class="form-control" id="Txtpwd" name="pwd" placeholder="Password"
                                    required="">
                            </div>
                            <div class="d-sm-flex mb-5 align-items-center">
                                <span class="ml-auto"><a href="Forgot.aspx" onclick="return hs.htmlExpand(this, { objectType: 'iframe',width: 525,height: 280,marginTop : 0 } )" class="forgot-pass">Forgot Password</a></span>
                            </div>
                            <asp:Button ID="BtnSubmit" runat="server" Style="border-radius: 50px;" Text="Sign In" class="btn btn-block py-2 btn-primary btncls" OnClick="BtnSubmit_Click" />
                            <%--        <button type="submit" id="BtnSubmit" runat="server" class="btn btn-block py-2 btn-primary btncls">
                                    Submit
                                </button>--%>

                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <div class="line-mid">
                                        <h4 class=" ">OR</h4>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <a href="NewJoining1.aspx" style="text-decoration: none;">
                                        <input type="button" value="REGISTRATION" class="btn btn-block py-2 btn-info"></a>
                                </div>
                                <div class="col-md-6">
                                    <a href="https://cryptpayapi.com/" style="text-decoration: none;">
                                        <input type="button" value="GO TO WEBSITE" class="btn btn-block py-2 btn-success"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

<script src="css/js/jquery-3.3.1.min.js"></script>

<script src="css/js/popper.min.js"></script>

<script src="css/js/bootstrap.min.js"></script>

<script src="css/js/main.js"></script>

</html>
