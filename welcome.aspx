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
     <div class="content-wrapper">
  
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
                                    <div class="col-md-12" >
                                        <div class="row">
                                            <div class="col-md-12" >
                                                <!-- Genex Business -->
                                                <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                                    <div >
                                                        <div class="profile-bar " style="background: #fff;">
                              

                                        <br>
                                  <div class="row">
                                       <div class="col-md-2">
     </div> 
   <div class="col-md-8">
       
    <center>
        <h3 style="font-size: 1.4em">Member Details!</h3>
    </center>
   
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
                                         <div class="col-md-2">
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
    </div>

   
</asp:Content>

