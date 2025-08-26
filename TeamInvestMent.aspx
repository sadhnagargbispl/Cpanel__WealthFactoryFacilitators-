<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="TeamInvestMent.aspx.cs" Inherits="TeamInvestMent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content-wrapper">
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Team Business Report</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <!-- Genex Business -->
                        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                            <div>
                                <div class="profile-bar " style="background: #fff;">
                                    <br>
                                    <div class="basic-form">
                                        <div class="row">
                                            <div class="col-md-4">
                                                From:
    <asp:TextBox ID="TxtFromDate" CssClass="form-control" TabIndex="2" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtFromDate"
                                                    Format="dd-MMM-yyyy" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtFromDate"
                                                    ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-md-4">
                                                To :
    <asp:TextBox ID="TxtToDate" CssClass="form-control" TabIndex="3" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtToDate"
                                                    Format="dd-MMM-yyyy" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtToDate"
                                                    ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <asp:Button ID="BtnSearch" Text="Search" runat="server" class="btn btn-primary" OnClick="BtnSearch_Click" />

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="divR" runat="server" visible="false">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                            <div id="divtotal" runat="server">
                                                <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="Total Record : " Style="font-weight: bold; font-size: 14px;"></asp:Label>
                                                <asp:Label ID="LblttlRcd1" Font-Bold="true" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lblleftbv" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblbv" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <b style="font-weight: bold; font-size: 14px;">Total Business :
            
         
                                                </b>
                                                <asp:Label ID="lblTotalBV" Font-Bold="true" runat="server" Style="font-weight: bold; font-size: 14px;"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
                                            </div>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">



                                            <div class="row" style="display: none;">
                                                <div class="col-md-10">
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:DropDownList ID="ddlPazeSize" runat="server" CssClass="form-control" AutoPostBack="true">
                                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                        <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                        <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                        <asp:ListItem Text="150" Value="150"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div id="DivSideA" class="table-responsive" runat="server">
                                                <asp:DataGrid ID="GrdDirects" runat="server" PageSize="10" CssClass="table datatable"
                                                    CellPadding="3" HorizontalAlign="Center" AutoGenerateColumns="true" AllowPaging="True"
                                                    Width="100%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    HeaderStyle-VerticalAlign="Middle" ItemStyle-VerticalAlign="Middle" OnPageIndexChanged="GrdDirects_PageIndexChanged">
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="S.No">
                                                            <ItemTemplate>
                                                                <%#Container.DataSetIndex + 1%>.
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                    <PagerStyle Mode="NumericPages" CssClass="PagerStyle"></PagerStyle>
                                                    <ItemStyle CssClass="RowStyle" HorizontalAlign="Center" VerticalAlign="Top" Wrap="False" />
                                                </asp:DataGrid>
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

