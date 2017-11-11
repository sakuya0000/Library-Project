<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FindPwd.aspx.cs" Inherits="FindPwd" %>

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
    真实姓名：
        <asp:TextBox ID="txtRealName" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
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
         <asp:TextBox ID="txtProAnswer" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    验证码：
    <asp:TextBox ID="tbx_yzm" runat="server" Width="70px"></asp:TextBox>
    <asp:ImageButton ID="ibtn_yzm" runat="server" Width="70px" />
    <a href="javascript:changeCode()"style="text-decoration: underline; font-size:10px;">换一张</a>
    <script type="text/javascript">
        function changeCode() 
        {
            document.getElementById('ibtn_yzm').src = document.getElementById('ibtn_yzm').src + '?';
        }
    </script>
         <br />
        <asp:Button ID="btnFind" runat="server" Text="提交" OnClick="btnFind_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
