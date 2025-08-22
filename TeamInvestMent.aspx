<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="TeamInvestMent.aspx.cs" Inherits="TeamInvestMent" %>

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
                                    <h3 class="box-title">Team Business Report</h3>
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
                                                                                <label>
                                                                                    From :</label>
                                                                                <asp:TextBox ID="TxtFromDate" CssClass="form-control" TabIndex="2" runat="server"></asp:TextBox>
                                                                                <AjaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtFromDate"
                                                                                    Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtFromDate"
                                                                                    ErrorMessage="Invalid Start Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" id="lbllevel" runat="server">
                                                                                <label>
                                                                                    To :</label>
                                                                                <asp:TextBox ID="TxtToDate" CssClass="form-control" TabIndex="3" runat="server"></asp:TextBox>
                                                                                <AjaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TxtToDate"
                                                                                    Format="dd-MMM-yyyy"></AjaxToolkit:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtToDate"
                                                                                    ErrorMessage="Invalid To Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                                                    ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                                                    ValidationGroup="Form-submit"></asp:RegularExpressionValidator>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3">
                                                                                <label>
                                                                                    Select :</label>
                                                                                <asp:DropDownList ID="ddltype" runat="server" class="form-control">
                                                                                    <asp:ListItem Selected="True" Value="A">Activation</asp:ListItem>
                                                                                    <asp:ListItem Value="R">Regular Investment</asp:ListItem>
                                                                                    <asp:ListItem Value="I">Stacking Investment</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" style="padding: 2%">
                                                                                <asp:Button ID="BtnShow" runat="server" Text="Show" class="btn btn-primary " OnClick="BtnShow_Click" />
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="table-responsive">
                                                                        <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" Class="table table-bordered"
                                                                            HeaderStyle-BackColor="#02a8d8" HeaderStyle-ForeColor="White" AllowPaging="true"
                                                                            PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="SNo">
                                                                                    <ItemTemplate>
                                                                                        <%#Container.DataItemIndex + 1%>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
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
</asp:Content>

