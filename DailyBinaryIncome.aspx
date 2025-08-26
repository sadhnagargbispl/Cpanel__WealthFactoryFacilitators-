<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="DailyBinaryIncome.aspx.cs" Inherits="DailyBinaryIncome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            height: 15%;
            width: 358px;
        }

        .style2 {
            height: 2px;
            width: 304px;
        }

        .style3 {
            height: 2px;
            width: 358px;
        }
    </style>
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">

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
                                    <h3 class="box-title">Payout Detail</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <!-- Genex Business -->
                                                <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                                    <div>
                                                        <div class="profile-bar " style="background: #fff;">
                                                            <br>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="table-responsive">
                                                                        <div class="table mb-0" cellspacing="0" cellpadding="4" rules="all" border="1" id="ctl00_ContentPlaceHolder2_DGVReferral"
                                                                            style="width: 100%; border-collapse: collapse;">
                                                                            <asp:GridView ID="Rptdatecondition" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered"
                                                                                HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="left" AllowPaging="true"
                                                                                PageSize="20" RowStyle-HorizontalAlign="Left" OnPageIndexChanging="Rptdatecondition_PageIndexChanging">
                                                                                <Columns>
                                                                                </Columns>
                                                                            </asp:GridView>
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
        </div>
    </div>

</asp:Content>

