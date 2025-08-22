<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="Mydirects.aspx.cs" Inherits="Mydirects" %>

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
                                                                                    Search By</label>
                                                                                <asp:DropDownList ID="rbtnsearch" runat="server" class="form-control">
                                                                                    <asp:ListItem Text="Level Wise" Selected="True" Value="L"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" id="lbllevel" runat="server">
                                                                                <label class="form-label">
                                                                                    Level</label>
                                                                                <asp:DropDownList ID="DdlLevel" CssClass="form-control" TabIndex="1" runat="server">
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3">
                                                                                <label class="form-label">
                                                                                    Search</label>
                                                                                <asp:DropDownList ID="DDlSearchby" CssClass="form-control" TabIndex="2" runat="server">
                                                                                    <asp:ListItem Text="All" Value="" Selected="True"></asp:ListItem>
                                                                                    <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                                                                    <asp:ListItem Text="Deactive" Value="N"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                            <div class="mb-3 col-md-3" style="padding: 2%">
                                                                                <asp:Button ID="BtnSubmit" runat="server" Text="Search" TabIndex="3" class="btn btn-primary " OnClick="BtnSubmit_Click" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table id="ctl00_ContentPlaceHolder2_DGVReferral" class="table table-bordered">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <th style="text-align: center">Metrics
                                                                                    </th>
                                                                                    <th style="text-align: center">Direct
                                                                                    </th>
                                                                                    <th style="text-align: center">Indirect
                                                                                    </th>
                                                                                    <th style="text-align: center">Total
                                                                                    </th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <th>Joining
                                                                                    </th>
                                                                                    <td id="tdDirectleft" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="tdDirectright" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="TotalDirect" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <th>Active
                                                                                    </th>
                                                                                    <td id="tddirectActive" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="tdindirectActive" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="TotalActive" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="Tr1" runat="server" visible="false">
                                                                                    <th>BV
                                                                                    </th>
                                                                                    <td id="Directunit" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="indirectunit" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                    <td id="totalunit" runat="server" style="text-align: center">0
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <div id="DivSideA" runat="server">
                                                                            <asp:Label ID="Label1" runat="server" Text="Total Records"></asp:Label>
                                                                            <asp:Label ID="lbltotal" runat="server"></asp:Label>
                                                                            <div class="table-responsive">
                                                                                <asp:GridView ID="RptDirects" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered table-responsive-md"
                                                                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="RptDirects_PageIndexChanging">
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
        </div>
    </div>
</asp:Content>

