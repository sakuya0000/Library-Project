<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookManageIn.aspx.cs" Inherits="BookManageIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divMain" runat="server" visible="true">
    请问您想对图书做什么？
        <br />
        <asp:Button ID="btnScanf" runat="server" Text="查找图书" OnClick="btnScanf_Click" />
        <asp:Button ID="btnAddBook" runat="server" Text="增加图书" OnClick="btnAddBook_Click" />
        <asp:Button ID="btnBackMain" runat="server" Text="返回" OnClick="btnBackMain_Click" />
    </div>
    <div id="divSearch" runat="server" visible="false">
        请输入书名：
        <asp:TextBox ID="txtBookName" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        请输入作者：
        <asp:TextBox ID="txtAuthor" runat="server" TextMode="SingleLine"></asp:TextBox>
        <asp:Button ID="btnAll" runat="server" OnClick="btnAll_Click" Text="查看" />
        <asp:Button ID="btnBackMain_Search" runat="server" OnClick="btnBackMain_Search_Click" Text="返回" />
    </div>
    <div id="divBookAll" runat="server" visible="false">
    <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
        <HeaderTemplate>
            <table border="2">
                <tr>
                    <th>ID</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>馆藏数量</th>
                    <th>可借数量</th>
                    <th>查看</th>
                    <th>删除</th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("id") %></td>
                <td><%# Eval("BookName") %></td>
                <td><%# Eval("Author") %></td>
                <td><%# Eval("PubHouse") %></td>
                <td><%# Eval("Num") %></td>
                <td><%# Eval("LeftNum") %></td>
                <td><asp:LinkButton ID="btnCheck" runat="server" CommandName="Check" CommandArgument='<%# Eval("id") %>' Text="查看"></asp:LinkButton></td>
                <td><asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' Text="删除" OnClientClick="return confirm('您确定删除吗？')"></asp:LinkButton></td>
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
    <asp:Button ID="btnBackSearch" runat="server" OnClick="btnBackSearch_Click" Text="返回" />
    </div>
    <div id="divAddBook" runat="server" visible="false">
        <h3>请输入：</h3>
        书名：
        <asp:TextBox ID="txtBook_Name" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        作者：
        <asp:TextBox ID="txt_Author" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        出版社：
        <asp:TextBox ID="txtPubHouse" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        类别：
        <asp:TextBox ID="txtClass" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        <asp:Button ID="btnAdd" runat="server" Text="添加" OnClick="btnAdd_Click" />
        <asp:Button ID="btnBackMain_Add" runat="server" Text="返回" OnClick="btnBackMain_Add_Click" />
    </div>
    </form>
</body>
</html>
