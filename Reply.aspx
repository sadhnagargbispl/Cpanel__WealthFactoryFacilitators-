<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Reply.aspx.cs" Inherits="Reply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <div class="content-header">
            <h1>Reply
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
                                                <div class="form-group">
                                                    <label for="inputdefault">Complaint type : </label>
                                                    <asp:Label class="form-control" ID="LblCType" runat="server"></asp:Label>
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputdefault">Complaint: </label>
                                                    <asp:TextBox class="form-control" ID="TxtComplaint" ReadOnly="true" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputdefault">Previous Reply</label>
                                                    <asp:TextBox class="form-control" ID="TxtPreReply" ReadOnly="true" TextMode="MultiLine" runat="server"></asp:TextBox>
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


