<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Downline.aspx.cs" Inherits="Downline" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxToolkit" %>
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
                                    <h3 class="box-title">DownLine Report</h3>
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
                                                                    <div class="basic-form">
                                                                        <div class="row">
                                                                            <div class="col-md-3">
                                                                                <div class="form-group ">
                                                                                    Select Downline :
                  <asp:DropDownList AutoPostBack="True" ID="rbleg" RepeatDirection="Horizontal"
                      runat="server" OnSelectedIndexChanged="rbleg_SelectedIndexChanged" CssClass="form-control">
                      <asp:ListItem Selected="True">Both</asp:ListItem>
                      <asp:ListItem>Left Downline</asp:ListItem>
                      <asp:ListItem>Right Downline</asp:ListItem>
                  </asp:DropDownList>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group ">
                                                                                    From date :
                   <asp:TextBox ID="TxtFromDate" CssClass="form-control" TabIndex="2" runat="server"></asp:TextBox>
                                                                                    <AjaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtFromDate"
                                                                                        Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtFromDate"
                                                                                        ErrorMessage="Invalid Start Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                        ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                        ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group ">
                                                                                    To Date :
                   <asp:TextBox ID="TxtToDate" CssClass="form-control" TabIndex="3" runat="server"></asp:TextBox>
                                                                                    <AjaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtToDate"
                                                                                        Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtToDate"
                                                                                        ErrorMessage="Invalid To Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                        ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                        ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3" style="padding: 1%">
                                                                                <asp:Button ID="BtnSearch" runat="server" Text="Search" TabIndex="3" class="btn btn-primary " OnClick="BtnSearch_Click" />
                                                                            </div>



                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table class="table table-bordered">
                                                                            <tbody>
                                                                                <tr valign="top">
                                                                                    <td class="box-body1-clear" align="center" colspan="6">
                                                                                        <b>Status</b>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr valign="top">
                                                                                    <td align="center">
                                                                                        <strong>Total Left Joined </strong>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <strong>Total Right Joined </strong>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <strong>Total Left Topup </strong>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <strong>Total Right Topup </strong>
                                                                                    </td>
                                                                                    <%-- <td align="center">
                      <strong>Total Left BV </strong>
                  </td>
                  <td align="center">
                      <strong>Total Right BV </strong>
                  </td>--%>
                                                                                </tr>
                                                                                <tr valign="top">
                                                                                    <td align="center">
                                                                                        <span id="LblMemLJ" runat="server">0</span>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <span id="LblMemRJ" runat="server">0</span>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <span id="LblMemLT" runat="server">0</span>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <span id="LblMemRT" runat="server">0</span>
                                                                                    </td>
                                                                                    <%-- <td align="center">
                      <span id="LblLeftBv" runat="server">0</span>
                  </td>
                  <td align="center">
                      <span id="LblRightBv" runat="server">0</span>
                  </td>--%>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <div id="DivSideA" runat="server" class="col-md-12">
                                                                            <h4>Left Downline</h4>
                                                                            <div class="form-group " style="display: none">
                                                                                <asp:Button ID="BtnExportA" runat="server" Text="Export" class="btn btn-primary" OnClick="BtnExportA_Click" />
                                                                            </div>
                                                                            <div class="spacedivider2">
                                                                            </div>
                                                                            <br />
                                                                            <div class="col-md-12">
                                                                                <div class="row">
                                                                                    <div class="table-responsive">
                                                                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                                                            <ContentTemplate>
                                                                                                <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered table-responsive-md"
                                                                                                    AllowPaging="false" PageSize="100" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="SNo">
                                                                                                            <ItemTemplate>
                                                                                                                <%#Container.DataItemIndex + 1%>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                </asp:GridView>

                                                                                            </ContentTemplate>
                                                                                            <Triggers>
                                                                                            </Triggers>
                                                                                        </asp:UpdatePanel>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div id="DivSideB" runat="server" class="col-md-12">
                                                                            <h4>Right Downline <span></span>
                                                                            </h4>
                                                                            <div class="form-group" style="display: none">
                                                                                <asp:Button ID="BtnExportB" runat="server" Text="Export" class="btn btn-primary" OnClick="BtnExportB_Click" />
                                                                            </div>
                                                                            <br />
                                                                            <div class="row">
                                                                                <div class="col-md-12">
                                                                                    <div class="table-responsive">
                                                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                            <ContentTemplate>
                                                                                                <asp:GridView ID="Repeater3" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered table-responsive-md"
                                                                                                    AllowPaging="false" PageSize="100" OnPageIndexChanging="Repeater3_PageIndexChanging">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="SNo">
                                                                                                            <ItemTemplate>
                                                                                                                <%#Container.DataItemIndex + 1%>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                </asp:GridView>

                                                                                            </ContentTemplate>
                                                                                            <Triggers>
                                                                                            </Triggers>
                                                                                        </asp:UpdatePanel>
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
            </div>
        </div>
    </div>
</asp:Content>

