using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Welcome : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsCrossPagePostBack)
            {
                string username = Session["username"].ToString();
                txtUsername.Text = username;
            }
        }
        catch
        {
            Response.Write("<script>location='Login.aspx'</script>");
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)  //切换用户页面到搜索页面
    {
        divMain.Visible = false;
        divSearch.Visible = true;
    }

    protected void btnLend_Click(object sender, EventArgs e)
    {
        try
        {
            string username = Session["username"].ToString();
            Response.Write("<script>alert('即将跳转到查看借书情况页面！');location='UserLend.aspx'</script>");
        }
        catch
        {
            Response.Write("<script>location='Login.aspx'</script>");
        }
    }

    protected void btnChange_Click(object sender, EventArgs e)  //从用户页面到修改信息页面
    {
        divChange.Visible = true;
        divMain.Visible = false;
    }

    protected void btnBack_Click(object sender, EventArgs e)  //切换用户页面到登录页面
    {
        
        Session.Clear();//session值清空.
        Response.Write("<script>location='Login.aspx'</script>");
    }

    protected void btnSearchBook_Click(object sender, EventArgs e)  //搜索书籍
    {
        string BookName = txtBookName.Text;
        string Author = txtAuthor.Text;
        int Namelen = BookName.Length;
        int Aulen = Author.Length;
        string sql;
        if (Namelen != 0 && Aulen != 0)
            sql = "SELECT * FROM BookDatabase WHERE BookName=N'" + BookName + "'and Author=N'" + Author + "'";
        else if (Namelen == 0 && Aulen != 0)
            sql = "SELECT * FROM BookDatabase WHERE Author=N'" + Author + "'";
        else if (Namelen != 0 && Aulen == 0) 
            sql = "SELECT * FROM BookDatabase WHERE BookName=N'" + BookName + "'";
        else
            sql = "SELECT * FROM BookDatabase";
        DataTable dt = us.SQL_dt(sql);
        if (dt.Rows.Count != 0)
        {
            Session["sql"] = sql;
            DataBindToRepeater(1);
            divBookList.Visible = true;
            divSearch.Visible = false;
        }
        else
        {
            Response.Write("<script>alert('无此书！')</script>");
        }
    }

    protected void btnSearchBack_Click(object sender, EventArgs e)  //从搜索页面到主页面
    {
        divSearch.Visible = false;
        divMain.Visible = true;
    }

    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Lend")
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            string username = Session["username"].ToString();
            string sql = "SELECT BookName,LeftNum FROM BookDatabase WHERE id='" + id + "'";
            DataTable dt = us.SQL_dt(sql);
            string BookName = dt.Rows[0][0].ToString();
            int LeftNum = Convert.ToInt32(dt.Rows[0][1].ToString());
            sql = "SELECT * FROM BookEvent WHERE BookID='" + id + "'and UserName='"+username+"'";
            dt = us.SQL_dt(sql);
            int flag = dt.Rows.Count;
            if (flag == 0)
            {
                if (LeftNum == 0)
                {
                    Response.Write("<script>alert('本书没有库存！')</script>");
                }
                else
                {
                    LeftNum--;
                    sql = "UPDATE BookDatabase SET LeftNum='" + LeftNum + "'WHERE id='" + id + "'";
                    us.SQL(sql);
                    string From = DateTime.Now.ToLongDateString().ToString();
                    string To = DateTime.Now.AddDays(15).ToLongDateString().ToString();
                    sql = "SELECT id FROM users WHERE username='" + username + "'";
                    dt = us.SQL_dt(sql);
                    int UserID = Convert.ToInt32(dt.Rows[0][0].ToString());
                    sql = "INSERT INTO BookEvent(UserID,BookID,UserName,BookName,DateFrom,DateTo) VALUES('" + UserID + "','" + id + "','" + username + "','" + BookName + "','" + From + "','" + To + "')";
                    us.SQL(sql);
                    Response.Write("<script>alert('借书成功！');location='Welcome.aspx'</script>");
                }
            }
            else
                Response.Write("<script>alert('您已借过此书！')</script>");
        } 
    }

    protected void btnBackSearch_Click(object sender, EventArgs e)  //从书单页面返回搜索页面
    {
        divBookList.Visible = false;
        divSearch.Visible = true;
    }

    protected void btnChangName_Click(object sender, EventArgs e)  //修改用户名
    {
        string UserName = txtUserName_R.Text;
        string username = Session["username"].ToString();
        int len = UserName.Length;
        if (username == UserName)
        {
            Response.Write("<script>alert('用户名没变')</script>");
        }
        else if (len == 0)
        {
            Response.Write("<script>alert('用户名不能为空!')</script>");
        }
        else if (len < 3)
        {
            Response.Write("<script>alert('用户名不能少于3个字符!')</script>");
        }
        else if (len > 20)
        {
            Response.Write("<script>alert('用户名不能多于20个字符!')</script>");
        }
        else {
            string sql = "SELECT * FROM users WHERE username=N'" + UserName + "'";
            DataTable dt = us.SQL_dt(sql);
            int count = dt.Rows.Count;
            if (count == 1)
                Response.Write("<script>alert('用户名已被使用！')</script>");
            else
            {
                sql = "UPDATE users SET username=N'" + UserName + "'WHERE username=N'" + username + "'";
                us.SQL(sql);
                sql = "UPDATE BookEvent SET UserName=N'" + UserName + "'WHERE UserName=N'" + username + "'";
                us.SQL(sql);
                Response.Write("<script>alert('修改成功！');location='Welcome.aspx'</script>");
            }
        }
    }

    protected void btnBackChange_Click(object sender, EventArgs e)  //从修改页面到输入页面
    {
        divChange.Visible = false;
        divMain.Visible = true;
    }
    protected void DataBindToRepeater(int currentPage)  //数据捆绑
    {
        string sql = Session["sql"].ToString();
        DataTable dt = us.SQL_dt(sql);
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = currentPage - 1;
        rptList.DataSource = pds;
        rptList.DataBind();
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