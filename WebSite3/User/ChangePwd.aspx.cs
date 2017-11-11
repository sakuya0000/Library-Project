using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePwd : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnChange_Click(object sender, EventArgs e)  //修改密码
    {
        string username = txtUsername.Text;
        string pwd = txtPwd.Text;
        string pwd_O = txtPwd_O.Text;
        string pwd_R = txtPwd_R.Text;
        int lenName = username.Length;
        int lenPwd = pwd.Length;
        int lenPwd_O = pwd_O.Length;
        int lenPwd_R = pwd_R.Length;
        if (lenName == 0)
            Response.Write("<script>alert('用户名不能为空！')</script>");
        else if (lenPwd < 6 && lenPwd > 12)
            Response.Write("<script>alert('原密码必须为6到12位的数字或字母！')</script>");
        else if (lenPwd_O < 6 && lenPwd_O > 12)
            Response.Write("<script>alert('输入密码必须为6到12位的数字或字母！')</script>");
        else if (lenPwd_R < 6 && lenPwd_R > 12)
            Response.Write("<script>alert('确认密码必须为6到12位的数字或字母！')</script>");
        else
        {
            string sql = "SELECT * FROM users WHERE username=N'" + username + "' AND password='" + pwd + "'";
            DataTable dt = us.SQL_dt(sql);
            int count = dt.Rows.Count;
            if (count == 0)
                Response.Write("<script>alert('用户名或密码错误！')</script>");
            else
            {
                if (pwd_O != pwd_R)
                    Response.Write("<script>alert('输入密码和确认密码不一致！')</script>");
                else
                {
                    sql = "UPDATE users SET password='" + pwd_O + "' WHERE username=N'" + username + "'";
                    us.SQL(sql);
                    Response.Write("<script>alert('修改成功！');location='Login.aspx'</script>");
                }
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回修改密码页面到主页面
    {
        Response.Redirect("Login.aspx");
    }
}