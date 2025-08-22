<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ComplainSolution.aspx.cs" Inherits="ComplainSolution" %>

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
                                    <h3 class="box-title">Query Detail</h3>
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
                                                                        <div id="DivSideA" runat="server">
                                                                            <div class="table-responsive">
                                                                                <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-responsive-md"
                                                                                    AllowPaging="true" PageSize="20">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="SNo">
                                                                                            <ItemTemplate>
                                                                                                <%#Container.DataItemIndex + 1%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="   Complaint Id">
                                                                                            <ItemTemplate>
                                                                                                <%#Eval("CID")%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText=" Complaint Date">
                                                                                            <ItemTemplate>
                                                                                                <%#Eval("CDate")%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="   Complaint">
                                                                                            <ItemTemplate>
                                                                                                <%#Eval("Complaint")%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="   Reply Date">
                                                                                            <ItemTemplate>
                                                                                                <%#Eval("SDate")%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="  Reply">
                                                                                            <ItemTemplate>
                                                                                                <%#Eval("Solution")%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="   View">
                                                                                            <ItemTemplate>
                                                                                                <a class="btn btn-primary" href='<%# "Reply.aspx?CID=" + (Eval("VCid"))  %>' onclick="return hs.htmlExpand(this, { objectType: 'iframe',width: 470,height: 350,marginTop : 0 } )">
                                                                                                    <asp:Label ID="LBModify" runat="server" Text=" View Detail" />
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
        </div>
    </div>
</asp:Content>

