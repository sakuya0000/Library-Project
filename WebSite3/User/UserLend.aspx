<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserLend.aspx.cs" Inherits="UserLend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divMain" runat="server" visible="true">
        <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
            <HeaderTemplate>
                <table border="2">
                    <tr>
                        <th>书名</th>
                        <th>借书日期</th>
                        <th>截止日期</th>
                        <th>状态</th>
                        <th>续借申请</th>
                        <th></th>
                        <th></th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                <td><%# Eval("BookName") %></td>
                <td><%# Eval("DateFrom") %></td>
                <td><%# Eval("DateTo") %></td>
                <td><%# Eval("DateTo_con") %></td>
                <td><%# Eval("Status") %></td>
                <td></td>
                <td><asp:LinkButton ID="btnLend_con" runat="server" Text="续借" OnClick="btnLend_con_Click" CommandName="Lend" CommandArgument='<%# Eval("id") %>'></asp:LinkButton></td>
                <td><asp:LinkButton ID="btnReturn" runat="server" Text="还书" CommandName="Return" CommandArgument='<%# Eval("BookID") %>'></asp:LinkButton></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Button ID="btnFirstPage" runat="server" Text="首页" OnClick="btnFirstPage_Click" />
        <asp:Button ID="btnUpPage" runat="server" Text="上一页" OnClick="btnUpPage_Click" />
        <asp:Button ID="btnDownPage" runat="server" Text="下一页" OnClick="btnDownPage_Click" />
        <asp:Button ID="btnLastPage" runat="server" Text="尾页" OnClick="btnLastPage_Click" />
        页次<asp:label ID="NowPage" runat="server" Text="1"></asp:label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    <div id="divLend" runat="server" visible="false">
        书名：<asp:TextBox ID="txtBookName" runat="server" ReadOnly></asp:TextBox>
        <br />
        借书日期：<asp:TextBox ID="txtDateFrom" runat="server" ReadOnly></asp:TextBox>
        <br />
        截止日期：<asp:TextBox ID="txtDateTo" runat="server" ReadOnly></asp:TextBox>
        <br />
        申请日期：<asp:TextBox ID="txtRequest" runat="server" ReadOnly></asp:TextBox>
        <br />
        <asp:Button ID="btnSumit" runat="server" Text="申请" OnClick="btnSumit_Click" />
        <asp:Button ID="btnBackMain" runat="server" Text="返回" OnClick="btnBackMain_Click" />
    </div>
    </form>
</body>
</html>
