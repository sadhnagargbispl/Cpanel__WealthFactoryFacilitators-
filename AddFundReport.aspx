<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AddFundReport.aspx.cs" Inherits="AddFundReport" %>

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
                                    <h3 class="box-title">Add Fund Detail</h3>
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
                                                                        <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-responsive-md"
                                                                            HeaderStyle-BackColor="" HeaderStyle-ForeColor="White" AllowPaging="true"
                                                                            PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="ReqNo">
                                                                                    <ItemTemplate>
                                                                                        <%#Eval("ReqNo")%>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Request Date">
                                                                                    <ItemTemplate>
                                                                                        <%#Eval("ReqDate") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Payment Mode">
                                                                                    <ItemTemplate>
                                                                                        <%#Eval("PayMode") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Cheque/ TransactionNo">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("ChqNo") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Cheque/ Transaction Date">
                                                                                    <ItemTemplate>
                                                                                        <%#Eval("ChequeDate") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                               <%-- <asp:TemplateField HeaderText="Bank Name">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("BankName") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Branch Name">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("BranchName") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>--%>
                                                                                <asp:TemplateField HeaderText="Amount">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("Amount") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Remark">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("Remarks") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Status">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("Status") %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Image">
                                                                                    <ItemTemplate>
                                                                                        <a href='<%# "Img.aspx?type=Payment&ID=" + Eval("Reqno") %>'
                                                                                            onclick="return hs.htmlExpand(this, { objectType: 'iframe', width: 585, height: 380, marginTop: 0 })">
                                                                                            <asp:Image ID="Image1" runat="server"
                                                                                                ImageUrl='<%# Eval("ScannedFile") %>'
                                                                                                Height="100px"
                                                                                                Width="100px"
                                                                                                Visible='<%# Convert.ToBoolean(Eval("ScannedFileStatus")) %>' />
                                                                                        </a>
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

