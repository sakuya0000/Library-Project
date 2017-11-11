using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserInformation : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        string idCode = Request.QueryString["id"].ToString();
        idCode = Code.Decode(idCode, "abc12345");
        int id = Convert.ToInt32(idCode);
        id = id - 142857;
        string sql = "SELECT * FROM users WHERE id='" + id + "'";
        DataTable dt = us.SQL_dt(sql);
        txtUsername.Text = dt.Rows[0][1].ToString();
        txtPwd_O.Text = dt.Rows[0][2].ToString();
        txtRealName.Text = dt.Rows[0][3].ToString();
        if (dt.Rows[0][4].ToString() == "1")
            txtSex.Text = "男";
        else
            txtSex.Text = "女";
        if (dt.Rows[0][5].ToString() == "1")
            txtQuestion.Text = "你的高中班主任的名字是？";
        else if (dt.Rows[0][5].ToString() == "2")
            txtQuestion.Text = "你最喜欢的人是谁？";
        else
            txtQuestion.Text = "你的母亲的名字是？";
        txtAnswer.Text = dt.Rows[0][6].ToString();
        txtProAnswer.Text = dt.Rows[0][6].ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text;
        string Password = txtPwd_O.Text;
        string RealName = txtRealName.Text;
        string Sex = SelSex.Text;
        string Question = ProQuestion.Text;
        string Answer = txtProAnswer.Text;
        int lenName = username.Length;
        int lenPwd = Password.Length;
        int lenRealName = RealName.Length;
        int lenAnswer = Answer.Length;
        string sql = "SELECT * FROM users WHERE username='" + username + "'";
        DataTable dt= us.SQL_dt(sql);
        if (dt.Rows.Count == 0)
        {
            Response.Write("<script>alert('用户名已存在!')</script>");
        }
        else if (lenName == 0)
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
            if (lenPwd >= 6 && lenPwd <= 12)
            {
                string idCode = Request.QueryString["id"].ToString();
                idCode = Code.Decode(idCode, "abc12345");
                int id = Convert.ToInt32(idCode);
                id = id - 142857;
                sql = "UPDATE users SET username=N'" + username + "',password='" + Password + "',RealName=N'" + RealName + "',Sex='" + Sex + "',PwdQuestion='" + Question + "',PwdAnswer=N'" + Answer + "'WHERE id='"+id+"'" ;
                us.SQL(sql);
                sql = "UPDATE BookEvent SET UserName=N'" + username + "'WHERE UserID='" + id + "'" ;
                us.SQL(sql);
                Response.Write("<script>alert('修改成功');location='UserManageIn.aspx'</script>");
            }
            else
            {
                Response.Write("<script>alert('密码必须为6到12位的数字或字母！')</script>");
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回
    {
        Response.Write("<script>location='UserManageIn.aspx'</script>");
    }

    protected void btnChange_Click(object sender, EventArgs e)  //进入修改页面
    {
        divSubmit.Visible = true;
        divChange.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)  //取消修改
    {
        divChange.Visible = true;
        divSubmit.Visible = false;
    }
}