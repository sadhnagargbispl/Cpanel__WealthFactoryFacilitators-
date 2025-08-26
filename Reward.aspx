<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Reward.aspx.cs" Inherits="Reward" %>

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
                                    <h3 class="box-title">Reward</h3>
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
                                                                <div class="table-responsive">
                                                                    <%--<div class="col-md-12">
                                                                        <asp:DataGrid ID="GrdRewardPair" runat="server" AutoGenerateColumns="False" ForeColor="Black"
                                                                            BackColor="White" HorizontalAlign="Center" CellPadding="3" Font-Size="Small"
                                                                            CssClass="table table-striped table-bordered">
                                                                            <Columns>
                                                                                <asp:BoundColumn DataField="LeftRp" HeaderText="Left BV ">
                                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" VerticalAlign="Middle"></HeaderStyle>
                                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                                                                                </asp:BoundColumn>
                                                                                <asp:BoundColumn DataField="RightRp" HeaderText="Right BV">
                                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" VerticalAlign="Middle"></HeaderStyle>
                                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                                                                                </asp:BoundColumn>
                                                                            </Columns>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" HorizontalAlign="Center" />
                                                                        </asp:DataGrid>
                                                                    </div>--%>
                                                                    <div class="col-md-12">
                                                                        <h4>Achieved Reward Status</h4>
                                                                        <br />
                                                                        <div id="Div2" class="table-responsive" runat="server">
                                                                            <asp:GridView ID="GrdRewards" runat="server" PageSize="50" CssClass="table table-striped table-bordered"
                                                                                CellPadding="3" HorizontalAlign="Center" AutoGenerateColumns="False" AllowPaging="True"
                                                                                Width="100%">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                                                        <ItemTemplate>
                                                                                            <%#Container.DataItemIndex + 1%>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>

                                                                                    <asp:BoundField DataField="Reward" HeaderText="Reward" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField DataField="achievedReward" HeaderText="Reward Type" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField DataField="AchieveDate" HeaderText="Achieve Date" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:TemplateField HeaderText="Redeem" Visible="false" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblreward" runat="server" Text='<%# Eval("Rewardid") %>' Visible="false"></asp:Label>
                                                                                            <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                                                            <asp:LinkButton ID="btnredm" runat="server" Text="Redeem" OnClick="Reedembtn" OnClientClick="return confirmation();"
                                                                                                Visible='<%# Eval("RedeemStaus") %>'></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="RedeemDate" HeaderText="Redeem Date" Visible="false" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" />
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                            <asp:GridView ID="GrdPending1" runat="server" CssClass="table table-striped table-bordered"
                                                                                CellPadding="2" HorizontalAlign="Center" AutoGenerateColumns="False" Width="100%"
                                                                                EmptyDataText="No Data Display">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                                                        <ItemTemplate>
                                                                                            <%#Container.DataItemIndex + 1%>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="Reward" HeaderText="Reward"></asp:BoundField>
                                                                                    <asp:BoundField DataField="NewPair" HeaderText="New Pair"></asp:BoundField>
                                                                                    <asp:BoundField DataField="AchieveDate" HeaderText="Achieve Date"></asp:BoundField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12" id="divNextreward" runat="server">
                                                                        <h4>Next Reward Status</h4>
                                                                        <div id="Div3" class="table-responsive" runat="server">
                                                                            <asp:GridView ID="GrdNext" runat="server" CssClass="table table-striped table-bordered"
                                                                                CellPadding="2" HorizontalAlign="Center" AutoGenerateColumns="true" Width="100%"
                                                                                EmptyDataText="No Data Display">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                                                        <ItemTemplate>
                                                                                            <%#Container.DataItemIndex + 1%>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-12" id="divpendingreward" runat="server">
                                                                        <h4>Pending Reward Status</h4>
                                                                        <div id="Div1" class="table-responsive" runat="server">
                                                                            <asp:GridView ID="GrdPending" runat="server" CssClass="table table-striped table-bordered"
                                                                                CellPadding="2" HorizontalAlign="Center" AutoGenerateColumns="False" Width="100%"
                                                                                EmptyDataText="No Data Display">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px">
                                                                                        <ItemTemplate>
                                                                                            <%#Container.DataItemIndex + 1%>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="RDays" HeaderText="Total Days"></asp:BoundField>
                                                                                    <asp:BoundField DataField="Newpair" HeaderText="Pair"></asp:BoundField>
                                                                                    <asp:BoundField DataField="Reward" HeaderText="Reward "></asp:BoundField>
                                                                                  <%--  <asp:BoundField DataField="Notimelimit" HeaderText="Reward (No Time Limits)"></asp:BoundField>--%>
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

