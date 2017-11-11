<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookRentManage.aspx.cs" Inherits="BookRentManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
        <HeaderTemplate>
            <table border="2">
                <tr>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>书名</th>
                    <th>借书时间</th>
                    <th>截止时间</th>
                    <th>申请时间</th>
                    <th></th>
                    <th></th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
            <td><%# Eval("UserID") %></td>
            <td><%# Eval("UserName") %></td>
            <td><%# Eval("BookName") %></td>
            <td><%# Eval("DateFrom") %></td>
            <td><%# Eval("DateTo") %></td>
            <td><%# Eval("DateTo_con") %></td>
            <td><asp:LinkButton ID="btnAgree" runat="server" Text="同意" CommandName="Agree" CommandArgument='<%# Eval("id") %>'></asp:LinkButton></td>
            <td><asp:LinkButton ID="btnDisagree" runat="server" Text="否决" CommandName="Disagree" CommandArgument='<%# Eval("id") %>'></asp:LinkButton></td>
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
        页次：<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Text="" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJumpPage" runat="server" Text="跳转" OnClick="btnJumpPage_Click" />
        <br />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
