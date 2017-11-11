<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManageIn.aspx.cs" Inherits="UserManageIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divMain" runat="server" visible="true">
        <asp:Label ID="labWel" runat="server" Text="请问你想对用户进行什么操作"></asp:Label>
        <br />
        <asp:Button ID="UserRevise" runat="server" Text="修改用户信息" OnClick="UserRevise_Click" />
        <asp:Button ID="UserAdd" runat="server" Text="添加用户" OnClick="UserAdd_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    <div id="divAdd" runat="server" visible="false">
    用户名：
        <asp:TextBox ID="txtUsername" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
    密码：
        <asp:TextBox ID="txtPwd_O" runat="server" TextMode="Password"></asp:TextBox>
        <br />
    确认密码：
        <asp:TextBox ID="txtPwd_R" runat="server" TextMode="Password"></asp:TextBox>
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
        <div>
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
        </div>
    <asp:Button ID="btnAddSubmit" runat="server" Text="提交" OnClick="btnAddSubmit_Click" />
    <asp:Button ID="btn_AddBack" runat="server" Text="返回" OnClick="btn_AddBack_Click" />
    </div>
    <div  id="divRevise" runat="server" visible="false">
        请输入：
        <br />
        用户ID：<asp:TextBox ID="txtUserID" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        用户名：<asp:TextBox ID="txtUser_Name" runat="server" TextMode="SingleLine"></asp:TextBox>
        <br />
        <asp:Button ID="btnUserSearch" runat="server" Text="查找用户" OnClick="btnUserSearch_Click" />
        <asp:Button ID="btnBack_Revise" runat="server" Text="返回" OnClick="btnBack_Revise_Click" />
    </div>
    <div id="divUserList" runat="server" visible="false">
        <asp:Repeater ID="rptUserList" runat="server" OnItemCommand="rptUserList_ItemCommand">
            <HeaderTemplate>
                <table border="2">
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>密码</th>
                        <th>真实姓名</th>
                        <th>性别</th>
                        <th>密保问题</th>
                        <th>密保答案</th>
                        <th></th>
                        <th></th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                <td><%# Eval("id") %></td>
                <td><%# Eval("username") %></td>
                <td><%# Eval("password") %></td>
                <td><%# Eval("RealName") %></td>
                <td><%# Eval("Sex") %></td>
                <td><%# Eval("PwdQuestion") %></td>
                <td><%# Eval("PwdAnswer") %></td>
                <td><asp:LinkButton ID="btnChange" runat="server" Text="编辑" CommandName="Change" CommandArgument='<%# Eval("id") %>'></asp:LinkButton></td>
                <td><asp:LinkButton ID="btnDelete" runat="server" Text="删除" CommandName="Delete" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('您确定要删除吗？')"></asp:LinkButton></td>
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
        <asp:Button ID="btnUserListBack" runat="server" Text="返回" OnClick="btnUserListBack_Click" />
    </div>
    </form>
</body>
</html>
