<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookList.aspx.cs" Inherits="BookList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h3>请输入：</h3>
        书名：
        <asp:TextBox ID="txtBookName" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        作者：
        <asp:TextBox ID="txtAuthor" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        出版社：
        <asp:TextBox ID="txtPubHouse" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        类别：
        <asp:TextBox ID="txtClass" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    <div id="divChange" runat="server" visible="true">
        馆藏数量：
        <asp:TextBox ID="txtNum" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        剩余数量：
        <asp:TextBox ID="txtLeftNum" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        <asp:Button ID="btnChange" runat="server" Text="修改" OnClick="btnChange_Click" />
    </div>
    <div id="divSubmit" runat="server" visible="false">
        增加数量：<asp:TextBox ID="txtAddNum" runat="server" TextMode="Number"></asp:TextBox>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="提交" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="取消" OnClick="btnCancel_Click" />
    </div>
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
