<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ChangePass.aspx.cs" Inherits="ChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <div class="content-header">
            <h1>Change Password
            </h1>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                        </div>
                        <div id="ctl00_ContentPlaceHolder1_divgenexbusiness" class="clearfix gen-profile-box">
                            <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                            <div class="clearfix gen-profile-box">
                                <div class="profile-bar clearfix" style="background: #fff;">
                                    <div class="clearfix">
                                        <br>
                                        <div class="centered">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="inputdefault">
                                                        Old Password<span class="red">*</span></label>
                                                    <asp:TextBox ID="oldpass" class="form-control" TextMode="Password"
                                                        runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="oldpass"
                                                        runat="server">Old Password can't left blank</asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputdefault">
                                                        New Password<span class="red">*</span></label>
                                                    <asp:TextBox ID="pass1" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="pass1"
                                                        runat="server" ErrorMessage="RequiredFieldValidator"> New Password Can't left blank</asp:RequiredFieldValidator>

                                                </div>
                                                <div class="form-group">
                                                    <label for="inputdefault">
                                                        Confirm Password<span class="red">*</span></label>
                                                    <asp:TextBox ID="pass2" class="form-control"
                                                        TextMode="Password" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="pass1"
                                                        runat="server" ErrorMessage="RequiredFieldValidator">confirm New Password can't left blank</asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="CompareValidator1" ControlToValidate="Pass1" ControlToCompare="Pass2"
                                                        Type="String" Operator="Equal" Text="Passwords must match!" runat="Server" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Button ID="BtnUpdate" runat="server" Text="Submit" class="btn btn-primary" OnClick="BtnUpdate_Click" />
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

