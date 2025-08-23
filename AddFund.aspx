<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AddFund.aspx.cs" Inherits="AddFund" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <div class="content-header">
            <h1>Add Fund
            </h1>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <%--    <div class="box-header with-border">
                            <h3 class="box-title">Id Activation</h3>
                        </div>--%>
                        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                            <div class="clearfix gen-profile-box">
                                <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">
                                        <br>
                                        <div class="centered">
                                            <!-- Left Column: Form (col-8) -->
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label for="inputdefault">Enter Amount<span class="red">*</span></label>
                                                    <asp:TextBox runat="server" onkeypress="return isNumberKey(event);" MaxLength="8"
                                                        TabIndex="1" ID="TxtAmount" class="form-control validate[required]" Text="0"></asp:TextBox>
                                                    <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                </div>

                                                <div class="form-group">
                                                    <label for="inputdefault">Select Paymode<span class="red">*</span></label>
                                                    <asp:DropDownList ID="DdlPaymode" runat="server" AutoPostBack="true" CssClass="form-control"
                                                        TabIndex="2" OnSelectedIndexChanged="DdlPaymode_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="form-group" id="divDDno" runat="server" visible="false">
                                                    <label for="inputdefault">
                                                        <asp:Label ID="LblDDNo" runat="server" Text="Draft/CHEQUE No. *"></asp:Label>
                                                    </label>
                                                    <asp:TextBox ID="TxtDDNo" onkeypress="return isNumberKey(event);" class="form-control validate[required]"
                                                        TabIndex="3" runat="server" MaxLength="16" AutoPostBack="true" OnTextChanged="TxtDDNo_TextChanged"></asp:TextBox>
                                                </div>

                                                <div class="form-group" id="divDDDate" runat="server">
                                                    <label for="inputdefault">
                                                        <asp:Label ID="LblDDDate" runat="server" Text="Transaction Date *"></asp:Label>
                                                    </label>
                                                    <asp:TextBox ID="TxtDDDate" runat="server" class="form-control validate[required]" TabIndex="4"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="TxtDDDate"
                                                        Format="dd-MMM-yyyy" />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtDDDate"
                                                        ErrorMessage="Invalid Date" Font-Names="arial" Font-Size="10px" SetFocusOnError="True"
                                                        ValidationExpression="^(?:((31-(Jan|Mar|May|Jul|Aug|Oct|Dec))|((([0-2]\d)|30)-(Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))|(([01]\d|2[0-8])-Feb))|(29-Feb(?=-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))-((1[6-9]|[2-9]\d)\d{2})$"
                                                        ValidationGroup="Form-submit"></asp:RegularExpressionValidator>

                                                    <div class="form-group" id="divImage" runat="server">
                                                        <label for="inputdefault">Scanned Copy:</label>
                                                        <asp:FileUpload runat="server" ID="FlDoc" class="form-control" TabIndex="7" />
                                                        <asp:Label ID="LblImage" runat="server" Visible="false"></asp:Label>
                                                    </div>
                                                </div>

                                                <br />
                                                <asp:Button ID="BtnSaveDB" runat="server" Text="Confirmed" class="btn btn-primary" OnClick="BtnSaveDB_Click" />
                                            </div>

                                            <!-- Right Column: QR Code (col-4) -->
                                            <div class="col-md-6 col-12 text-center">
                                                <br />
                                                <div class="form-group" id="div1" runat="server" style="text-align: center;">
                                                    <img class="img-fluid" src="assets/img/QRcode.jpeg" alt="QR Code" width="320" />
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

