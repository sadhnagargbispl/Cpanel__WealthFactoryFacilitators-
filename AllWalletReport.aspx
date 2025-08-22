<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AllWalletReport.aspx.cs" Inherits="AllWalletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                    <h3 class="box-title">Wallet Detail</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <!-- Genex Business -->
                                                <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                                                    <div>
                                                        <div class="profile-bar " style="background: #fff;">
                                                            <div class="form-horizontal">
                                                                <div class="col-md-12">
                                                                    <div class="table-responsive">
                                                                        <div class="form-group ">
                                                                            <table class="rounded_colhead" width="430">
                                                                                <tr>
                                                                                    <td>
                                                                                        <b>Wallet Type :</b>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlVoucherType" runat="server" CssClass="form-control ">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary " OnClick="btnSearch_Click" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        <div class="form-group ">
                                                                            <table id="ctl00_cphData_tbUserDetails" class="rounded_colhead" cellspacing="0" cellpadding="0"
                                                                                width="430" border="0">
                                                                                <tr>

                                                                                    <td style="height: 25px; width: 50px; font-size: 12px; font-family: Verdana"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 7px" class="textB" valign="middle" align="right" rowspan="9"></td>
                                                                                    <td class="PanelHeaderBackground" valign="middle" align="right" colspan="3" height="1"></td>
                                                                                    <td height="1"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="height: 6px" valign="middle" align="right" colspan="3"></td>
                                                                                    <td style="height: 6px"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 108px; height: 25px" class="textBP" valign="middle" align="right">Deposit
                                                                                    </td>
                                                                                    <td style="width: 8px; height: 25px" class="colon" valign="middle" align="center">:
                                                                                    </td>
                                                                                    <td id="MCredit" runat="server" style="height: 25px; width: 300px;" class="textBP" valign="middle"
                                                                                        align="left">0.00
                                                                                    </td>
                                                                                    <td style="height: 25px">&nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="PanelHeaderBackground" valign="middle" align="right" colspan="3" height="1"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 108px; height: 25px" class="textBP" valign="middle" align="right">Used
                                                                                    </td>
                                                                                    <td style="width: 8px; height: 25px" class="colon" valign="middle" align="center">:
                                                                                    </td>
                                                                                    <td id="MDebit" runat="server" style="height: 25px; width: 300px;" class="textBP" valign="middle"
                                                                                        align="left">0.00
                                                                                    </td>
                                                                                    <td style="height: 25px"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="PanelHeaderBackground" valign="middle" align="right" colspan="3" height="1"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 108px; height: 25px" class="textBP" align="right">Balance
                                                                                    </td>
                                                                                    <td style="width: 8px; height: 25px" class="colon" align="center">:
                                                                                    </td>
                                                                                    <td id="MBal" runat="server" style="height: 25px; width: 300px;" class="textBP" valign="middle"
                                                                                        align="left">0.00
                                                                                    </td>
                                                                                    <td style="height: 25px"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 7px; height: 15px" class="text" valign="top" align="right"></td>
                                                                                    <td style="width: 108px; height: 15px" class="text" valign="top" align="right"></td>
                                                                                    <td style="width: 8px; height: 15px" class="text" valign="top" align="center"></td>
                                                                                    <td style="height: 15px" class="text" valign="top" align="left"></td>
                                                                                    <td style="height: 15px" class="text" valign="middle" align="left"></td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        <div class="table-responsive">
                                                                            <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" RowStyle-Height="25px"
                                                                                GridLines="Both" AllowPaging="true" class="table datatable" HeaderStyle-CssClass="bg-primary"
                                                                                AllowSorting="true" ShowHeader="true" PageSize="20" EmptyDataText="No data to display." OnPageIndexChanging="RptDirects_PageIndexChanging">
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

