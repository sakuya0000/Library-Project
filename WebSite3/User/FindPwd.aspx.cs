using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FindPwd : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        ibtn_yzm.ImageUrl = "ImageCode.aspx";
    }

    protected void btnFind_Click(object sender, EventArgs e)  //找回密码
    {
        string username = txtUsername.Text;
        string RealName = txtRealName.Text;
        string sex = SelSex.Text;
        string question = ProQuestion.Text;
        string answer = txtProAnswer.Text;
        int lenName = username.Length;
        int lenRealName = RealName.Length;
        int lenAnswer = answer.Length;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code.ToLower() == scode.ToLower())
        {
            if (lenName == 0)
            {
                Response.Write("<script>alert('用户名不能为空!')</script>");
            }
            else if (lenName > 20)
            {
                Response.Write("<script>alert('用户名不能多于20个字符!')</script>");
            }
            else if (lenRealName == 0)
            {
                Response.Write("<script>alert('真实姓名不能为空!')</script>");
            }
            else if (lenAnswer == 0)
            {
                Response.Write("<script>alert('密保答案不能为空!')</script>");
            }
            else
            {
                string sql = "SELECT * FROM users WHERE username=N'" + username + "'";
                DataTable dt = us.SQL_dt(sql);
                int count = dt.Rows.Count;
                if (count == 1)
                {
                    sql = "select password from users where username = N'" + username + "'and RealName=N'" + RealName + "'and Sex='" + sex + "'and PwdQuestion='" + question + "'and PwdAnswer=N'" + answer + "'";
                    dt = us.SQL_dt(sql);
                    string password = dt.Rows[0][0].ToString();
                    if (password != null)
                    {
                        Response.Write("<script>alert('" + password + "');location='Login.aspx'</script>");
                    }
                    else
                        Response.Write("<script>alert('找回失败')</script>");
                }
                else
                    Response.Write("<script>alert('用户不存在！')</script>");
            }
        }
        else
            Response.Write("<script>alert('验证码不正确！')</script>");
    }

    protected void btnBack_Click(object sender, EventArgs e)  //切换找回密码页面到主页面
    {
        Response.Redirect("Login.aspx");
    }
}