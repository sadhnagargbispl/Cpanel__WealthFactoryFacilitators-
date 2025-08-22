<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Complain.aspx.cs" Inherits="Complain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <div class="content-header">
            <h1>Query
            </h1>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <%--                         <h3 class="box-title">Id Activation</h3>--%>
                        </div>
                        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                            <div class="clearfix gen-profile-box">
                                <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">
                                        <br>
                                        <div class="centered">
                                            <div class="col-md-6">
                                                <asp:Label ID="Label2" runat="server" CssClass="error"></asp:Label>
                                                <asp:HiddenField ID="HdnCheckTrnns" runat="server" />
                                                <div id="DivError" runat="server" visible="false">
                                                    <span id="spanError" runat="server"></span>
                                                </div>
                                                <asp:Label ID="LblCompalin" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="Lblgroup" runat="server" Visible="false"></asp:Label>
                                                <div class="row">
                                                    <div class="form-group">
                                                        Direct Seller ID :
                                         <asp:TextBox ID="TxtDirectSeller" Enabled="false" runat="server" CssClass="form-control"
                                             PlaceHolder="Direct Seller Id" AutoPostBack="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-sm-12" style="display: none;">
                                                        <div class="form-group">
                                                            Name : *
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="TxtName" Enabled="false" runat="server" class="form-control" PlaceHolder="Name"
                                                                ValidationGroup="Save"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-12" style="display: none;">
                                                        <div class="col-sm-6">
                                                            Mobile No : *
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <asp:TextBox ID="TxtMobl" Enabled="false" runat="server" class="form-control" PlaceHolder="Mobile No"
                                                                ValidationGroup="Save"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-12" style="display: none;">
                                                        <div class="col-sm-6">
                                                            Email ID : *
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="TxtEmail" Enabled="false" runat="server" class="form-control" PlaceHolder="Email Id"
                                                                ValidationGroup="Save"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        Nature of Grievance:
                                         <asp:DropDownList ID="CmbCmplntType" runat="server" placeholder="Nature of Grievance "
                                             class="form-control">
                                         </asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-12" style="display: none;">
                                                        <div class="col-sm-6">
                                                            Subject : *
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <asp:TextBox ID="TxtSubject" runat="server" CssClass="form-control validate[required]"
                                                                PlaceHolder="Subject" ValidationGroup="Save" Text="aa"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">

                                                        <label for="comment" class="form-label">Description : <span style="color: Red; font-weight: bold; font-size: 1.4em">*</span></label>
                                                        <asp:TextBox ID="TxtDesc" runat="server" TextMode="MultiLine" CssClass="form-control validate[required]"
                                                            ValidationGroup="Save" onkeyup="CountChar();" MaxLength="500"></asp:TextBox>
                                                    </div>

                                                </div>
                                                <asp:Button ID="BtnSubMit" runat="server" Text="Submit" class="btn btn-primary"
                                                    ValidationGroup="Save" OnClick="BtnSubmit_Click" />
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                                    ShowSummary="False" ValidationGroup="Save" />
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

