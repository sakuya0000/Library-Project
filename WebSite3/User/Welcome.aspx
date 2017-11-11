<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script language="JavaScript"> 
<!-- 
javascript:window.history.forward(1); 
//--> 
</script>
    <div id="divMain" runat="server" visible="true">
    欢迎你！<asp:Label ID="txtUsername" runat="server"  Text="txtUsername"></asp:Label>,请问您想做什么？
    <br />
    <asp:Button ID="btnSearch" runat="server" Text="搜索图书" OnClick="btnSearch_Click" />
    <asp:Button ID="btnLend" runat="server" Text="查看借书信息" OnClick="btnLend_Click" />
    <asp:Button ID="btnChange" runat="server" Text="修改用户名" OnClick="btnChange_Click" />
    <asp:Button ID="btnBack" runat="server" Text="回到登录页" OnClick="btnBack_Click" OnClientClick="return confirm('请问您是否要回到登录页？')" />
    </div>
    <div id="divSearch" runat="server" visible="false">
        <h2>请输入：</h2>
        <br />
        书名：<asp:TextBox ID="txtBookName" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        作者：<asp:TextBox ID="txtAuthor" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        <asp:Button ID="btnSearchBook" runat="server" Text="搜索" OnClick="btnSearchBook_Click" />
        <asp:Button ID="btnSearchBack" runat="server" Text="返回" OnClick="btnSearchBack_Click" />
    </div>
    <div id="divBookList" runat="server" visible="false">
        <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
            <HeaderTemplate>
                <table border="2">
                    <tr>
                        <th>书名</th>
                        <th>作者</th>
                        <th>出版社</th>
                        <th>类别</th>
                        <th>馆藏数量</th>
                        <th>剩余数量</th>
                        <th></th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("BookName") %></td>
                    <td><%# Eval("Author")%></td>
                    <td><%# Eval("PubHouse") %></td>
                    <td><%# Eval("Class") %></td>
                    <td><%# Eval("Num") %></td>
                    <td><%# Eval("LeftNum") %></td>
                    <td><asp:LinkButton ID="btnLendBook" runat="server" CommandName="Lend" Text="借书" CommandArgument='<%# Eval("id") %>'></asp:LinkButton></td>
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
        页次<asp:Label ID="NowPage" runat="server" Text="1"></asp:Label>
        /<asp:Label ID="TotalPage" runat="server" Text="1"></asp:Label>
        转<asp:TextBox ID="txtJumpPage" runat="server" Width="16px"></asp:TextBox>
        <asp:Button ID="btnJump" runat="server" Text="跳转" OnClick="btnJump_Click" />
        <br />
        <asp:Button ID="btnBackSearch" runat="server" Text="返回" OnClick="btnBackSearch_Click" />
    </div>
        <div id="divChange" runat="server" visible="false">
            请输入：
            <br />
            用户名：<asp:TextBox ID="txtUserName_R" runat="server" TextMode="SingleLine"></asp:TextBox>
            <br />
            <asp:Button ID="btnChangName" runat="server" Text="修改" OnClick="btnChangName_Click" />
            <asp:Button ID="btnBackChange" runat="server" Text="返回" OnClick="btnBackChange_Click" />
        </div>
    </form>
</body>
</html>
