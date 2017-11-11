using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        ibtn_yzm.ImageUrl = "ImageCode.aspx";
    }


    protected void btnSubmit_Click(object sender, EventArgs e)  //注册
    {
        string username = txtUsername.Text;
        string Pwd_O = txtPwd_O.Text;
        string Pwd_R = txtPwd_R.Text;
        string RealName = txtRealName.Text;
        string Sex = SelSex.Text;
        string Question = ProQuestion.Text;
        string Answer = txtProAnswer.Text;
        int lenName = username.Length;
        int lenPwd = Pwd_O.Length;
        int lenRealName = RealName.Length;
        int lenAnswer = Answer.Length;
        string code = tbx_yzm.Text;
        HttpCookie htco = Request.Cookies["ImageV"];
        string scode = htco.Value.ToString();
        if (code.ToLower() == scode.ToLower())
        {
            if (lenName == 0)
            {
                Response.Write("<script>alert('用户名不能为空!')</script>");
            }
            else if (lenName < 3)
            {
                Response.Write("<script>alert('用户名不能少于3个字符!')</script>");
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
                    Response.Write("<script>alert('用户名已存在!')</script>");
                }
                else if (Pwd_O == Pwd_R)
                {
                    if (lenPwd >= 6 && lenPwd <= 12)
                    {
                        sql = "insert into users values (N'" + username + "','" + Pwd_O + "',N'" + RealName + "','" + Sex + "','" + Question + "',N'" + Answer + "')";//sex中1代表男，0代表女
                        us.SQL(sql);
                        Session["username"] = username;
                        Response.Write("<script>alert('注册成功！');location='Login.aspx'</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('密码必须为6到12位的数字或字母！')</script>");
                    }
                }
                else
                    Response.Write("<script>alert('输入密码和确认密码不一致')</script>");
            }
        }
        else
            Response.Write("<script>alert('验证码输入不正确！')</script>");
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回注册页面到主页面
    {
        Response.Redirect("Login.aspx");
    }
}