<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Administration.aspx.cs" Inherits="Administration" %>

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
    <div>
        <asp:Button ID="UserManage" runat="server" Text="管理用户" OnClick="UserManage_Click" />
        <asp:Button ID="BookManage" runat="server" Text="管理图书" OnClick="BookManage_Click" />
        <asp:Button ID="BookRentManage" runat="server" Text="管理借书信息" OnClick="BookRentManage_Click" />
        <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
    </div>
    </form>
</body>
</html>
