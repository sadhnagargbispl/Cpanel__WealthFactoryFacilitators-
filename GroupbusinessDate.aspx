<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="GroupbusinessDate.aspx.cs" Inherits="GroupbusinessDate" %>

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
                                    <h3 class="box-title">Level Wise Direct Report</h3>
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
                                                                            <div class="mb-3 col-md-3">
                                                                                <label class="form-label">
                                                                                    From</label>
                                                                                <asp:TextBox ID="TxtFromDate" CssClass="form-control" TabIndex="2" runat="server"></asp:TextBox>
                                                                                <AjaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtFromDate"
                                                                                    Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtFromDate"
                                                                                    ErrorMessage="Invalid Start Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" id="lbllevel" runat="server">
                                                                                <label class="form-label">
                                                                                    To</label>
                                                                                <asp:TextBox ID="TxtToDate" CssClass="form-control" TabIndex="3" runat="server"></asp:TextBox>
                                                                                <AjaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtToDate"
                                                                                    Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtToDate"
                                                                                    ErrorMessage="Invalid To Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" style="padding: 2%">
                                                                                <asp:Button ID="BtnSearch" runat="server" Text="Search" TabIndex="3" class="btn btn-primary " OnClick="BtnSearch_Click" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                                        <ContentTemplate>
                                                                            <div class="table-responsive">
                                                                                <table class="table table-bordered table-responsive-md">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th>SNo
                                                                                            </th>
                                                                                            <th>User ID
                                                                                            </th>
                                                                                            <th>Name
                                                                                            </th>
                                                                                            <th>Activation Date
                                                                                            </th>
                                                                                            <th>Rank
                                                                                            </th>
                                                                                            <th>Self New Investment <%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Self Re-Investment<%-- (<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Team New Investment <%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Team Re-Investment <%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Total Investment <%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <asp:Repeater ID="Grdtotal" runat="server">
                                                                                            <ItemTemplate>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <%--  <asp:Label ID="lblID" runat="server" Text='<%#Eval("FormNo")%>' Visible="false"></asp:Label>--%>
                                                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("IDno")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("MemberName")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Activation Date")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Rank")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Investment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("REInvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("TeamInvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("TeamReinvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Total")%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                            <br />
                                                                            <div class="table-responsive">
                                                                                <table class="table table-bordered table-responsive-md">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th>SNo
                                                                                            </th>
                                                                                            <th>User ID
                                                                                            </th>
                                                                                            <th>Name
                                                                                            </th>
                                                                                            <th>Activation Date
                                                                                            </th>
                                                                                            <th>Rank
                                                                                            </th>
                                                                                            <th>S. New Investment<%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>S. Re-Investment<%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>T. New Investment<%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>T. Re-Investment<%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Total Investment<%--(<i class="las la-dollar-sign"></i>)--%>
                                                                                            </th>
                                                                                            <th>Downline
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <asp:Repeater ID="DLDirects" runat="server">
                                                                                            <ItemTemplate>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Label ID="lblID" runat="server" Text='<%#Eval("FormNo")%>' Visible="false"></asp:Label>
                                                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("IDno")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("MemFirstName")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("UpgradeDate")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Rank")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Investment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Reinvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("TeamInvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("TeamReinvestment")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%#Eval("Total")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="LblStatus" runat="server" Text="Downline"></asp:Label>
                                                                                                        <asp:ImageButton ID="edit" runat="server" ImageUrl="images/down.png" OnClick="PerformData"
                                                                                                            Style="background-color: White;" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="BtnSearch" EventName="Click" />
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
</asp:Content>

