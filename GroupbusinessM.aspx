<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="GroupbusinessM.aspx.cs" Inherits="GroupbusinessM" %>

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
                                    <h3 class="box-title">Direct Sponsors</h3>
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
                                                                                    <th>Self Business
                                                                                    </th>
                                                                                    <th>Team Business
                                                                                    </th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater ID="Grdtotal" runat="server">
                                                                                    <ItemTemplate>
                                                                                        <tr>
                                                                                            <td>
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
                                                                                                <%#Eval("Liquidity")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%#Eval("team")%>
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
                                                                                    <th>Joining Date
                                                                                    </th>
                                                                                    <th>Activation Date
                                                                                    </th>
                                                                                    <th>Rank
                                                                                    </th>
                                                                                    <th>Self Business
                                                                                    </th>
                                                                                    <th>Team Business
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
                                                                                                <%#Eval("Doj")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%#Eval("UpgradeDate")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%#Eval("Rank")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%#Eval("Amount")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%#Eval("team")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="LblStatus" runat="server" Text="Downline" Style="color: black;"></asp:Label>
                                                                                                <asp:ImageButton ID="edit" runat="server" ImageUrl="images/down.png" OnClick="PerformData"
                                                                                                    Style="background-color: White;" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                </asp:Repeater>
                                                                            </tbody>
                                                                        </table>
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

