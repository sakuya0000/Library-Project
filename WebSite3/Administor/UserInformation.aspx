<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserInformation.aspx.cs" Inherits="UserInformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    用户名：
        <asp:TextBox ID="txtUsername" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    密码：
        <asp:TextBox ID="txtPwd_O" runat="server"></asp:TextBox>
        <br />
    真实姓名：
        <asp:TextBox ID="txtRealName" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    <div id="divChange" runat="server" visible="true">
    性别：<asp:TextBox ID="txtSex" runat="server" ReadOnly></asp:TextBox>
        <br />
    密保问题：<asp:TextBox ID="txtQuestion" runat="server" ReadOnly></asp:TextBox>
        <br />
    密保答案：
        <asp:TextBox ID="txtProAnswer" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    <asp:Button ID="btnChange" runat="server" OnClick="btnChange_Click" Text="修改" />
    </div>
    <div id="divSubmit" runat="server" visible="false">
        性别：
        <asp:RadioButtonList ID="SelSex" runat="server" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem value="1" runat="server" Selected="True">男</asp:ListItem>
            <asp:ListItem value="0" runat="server">女</asp:ListItem>
        </asp:RadioButtonList>
        <br />
    密保问题：
         <asp:DropDownList ID="ProQuestion" runat="server">
            <asp:ListItem Value="1">你的高中班主任的名字是？</asp:ListItem>
            <asp:ListItem Value="2">你最喜欢的人是谁？</asp:ListItem>
            <asp:ListItem Value="3">你的母亲的名字是？</asp:ListItem>
        </asp:DropDownList>
        <br />
    密保答案：
        <asp:TextBox ID="txtAnswer" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="提交" />
    <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="取消" />
            </div>
    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="返回" />
    </div>
    </form>
</body>
</html>
