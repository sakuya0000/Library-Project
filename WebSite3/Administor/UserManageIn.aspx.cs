using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserManageIn : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        ibtn_yzm.ImageUrl = "/User/ImageCode.aspx";
    }
    

    protected void UserRevise_Click(object sender, EventArgs e)
    {
        divMain.Visible = false;
        divRevise.Visible = true;
    }

    protected void UserAdd_Click(object sender, EventArgs e)  //从主页面到添加用户页面
    {
        divMain.Visible = false;
        divAdd.Visible = true;
    }
    

    protected void btnAddSubmit_Click(object sender, EventArgs e)  //添加用户
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
                        Response.Write("<script>alert('注册成功！')</script>");
                        divMain.Visible = true;
                        divAdd.Visible = false;
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

    protected void btn_AddBack_Click(object sender, EventArgs e)  //从添加用户页面返回主页面
    {
        divMain.Visible = true;
        divAdd.Visible = false;
    }

    protected void btnBack_Click(object sender, EventArgs e)  //从管理用户页面跳转到管理页面
    {
        Response.Write("<script>location='Administration.aspx'</script>");
    }

    protected void btnUserSearch_Click(object sender, EventArgs e)  //查找用户
    {
        string ID = txtUserID.Text;
        string UserName = txtUser_Name.Text;
        string sql;
        int id;
        if (ID.Length == 0 && UserName.Length == 0)
            sql = "select * from users";
        else if (ID.Length == 0 && UserName.Length != 0)
            sql = "select * from users where username=N'" + UserName + "'";
        else if (ID.Length != 0 && UserName.Length == 0)
        {
            id = Convert.ToInt32(txtUserID.Text);
            sql = "select * from users where id='" + id + "'";
        }
        else
        {
            id = Convert.ToInt32(txtUserID.Text);
            sql = "select * from users where id='" + id + "'and username=N'" + UserName + "'";
        }
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count == 0)
            Response.Write("<script>alert('不存在该用户')</script>");
        else
        {
            Session["sql"] = sql;
            DataBindToRepeater(1);
            divUserList.Visible = true;
            divRevise.Visible = false;
        }
    }

    protected void rptUserList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Change")
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            if (id == 0)
            {
                Response.Write("<script>alert('管理员账户不可操作')</script>");
            }
            else
            {
                id = id + 142857;
                string idNum = Code.Encode(id.ToString(), "abc12345");
                Response.Write("<script>alert('即将跳转到下个页面');window.location('UserInformation.aspx?id="+idNum+"') </script>");
            }
        }
        else if (e.CommandName == "Delete")
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            if (id == 0)
            {
                Response.Write("<script>alert('管理员账户不可操作')</script>");
            }
            else
            {
                string sql = "DELETE FROM users WHERE id='" + id + "'";
                us.SQL(sql);
                Response.Write("<script>alert('即将跳转到下个页面');window.location('UserManageIn.aspx') </script>");
            }
        }
    }

    protected void btnBack_Revise_Click(object sender, EventArgs e)  //返回编辑页面到主页面
    {
        divMain.Visible = true;
        divRevise.Visible = false;
    }

    protected void btnUserListBack_Click(object sender, EventArgs e)  //返回用户页面到输入页面
    {
        divRevise.Visible = true;
        divUserList.Visible = false;
    }
    protected void DataBindToRepeater(int current)
    {
        string sql = Session["sql"].ToString();
        DataTable dt = us.SQL_dt(sql);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i][4].ToString() == "1")
                dt.Rows[i][4] = "男";
            else if (dt.Rows[i][4].ToString() == "0")
                dt.Rows[i][4] = "女";
            if (dt.Rows[i][5].ToString() == "1")
                dt.Rows[i][5] = "你的高中班主任的名字是？";
            else if (dt.Rows[i][5].ToString() == "2")
                dt.Rows[i][5] = "你最喜欢的人是谁？";
            else if (dt.Rows[i][5].ToString() == "3")
                dt.Rows[i][5] = "你的母亲的名字是？";
        }
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
        rptUserList.DataSource = pds;
        rptUserList.DataBind();
    }
    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        int current = 1;
        NowPage.Text = current.ToString();
        DataBindToRepeater(current);
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        int current = Convert.ToInt32(NowPage.Text) - 1;
        if (current >= 1)
        {
            NowPage.Text = current.ToString();
            DataBindToRepeater(current);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        int current = Convert.ToInt32(NowPage.Text);
        current++;
        if (current <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = current.ToString();
            DataBindToRepeater(current);
        }
    }

    protected void btnLastPage_Click(object sender, EventArgs e)
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindToRepeater(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)
    {
        try
        {
            int current = Convert.ToInt32(txtJumpPage.Text);
            if (current >= 1 && current <= Convert.ToInt32(TotalPage.Text))
            {
                NowPage.Text = current.ToString();
                DataBindToRepeater(current);
            }
            else
                Response.Write("<script>alert('请输入正确的数字！')</script>");
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }
}