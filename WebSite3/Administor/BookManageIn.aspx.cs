using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookManageIn : System.Web.UI.Page
{
    static SQLHelper book = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Check")
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            Response.Write("<script>alert('你即将跳转到另一个页面');location='BookList.aspx?id=" + id + "'</script>");
        }
        else if (e.CommandName == "Delete")
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            string sql = "DELETE FROM BookDataBase WHERE id='" + id + "'";
            book.SQL(sql);
            Response.Write("<script>alert('删除成功！');location='BookManage.aspx'</script>");
        }
    }

    protected void btnAll_Click(object sender, EventArgs e)  //搜索图书
    {
        string BookName = txtBookName.Text;
        string Author = txtAuthor.Text;
        if (BookName.Length == 0&&Author.Length==0)  //不输入任何参数
        {
            string sql = "select id,BookName,Author,PubHouse,Num,LeftNum from BookDataBase";
            Session["sql"] = sql;
            DataBindToRepeater(1);
            divBookAll.Visible = true;
            divSearch.Visible = false;
        }
        else if(Author.Length==0)  //只输入书名
        {
            string sql = "select id,BookName,Author,PubHouse,Num,LeftNum from BookDataBase where BookName=N'" + BookName + "'";
            DataTable dt = book.SQL_dt(sql);
            if (dt.Rows.Count != 0) {
                Session["sql"] = sql;
                DataBindToRepeater(1);
                divBookAll.Visible = true;
                divSearch.Visible = false;
            }
            else
                Response.Write("<script>alert('该图书在该书库不存在！')</script>");
        }
        else if (BookName.Length == 0)  //只输入作者
        {
            string sql = "select id,BookName,Author,PubHouse,Num,LeftNum from BookDataBase where Author=N'" + Author + "'";
            DataTable dt = book.SQL_dt(sql);
            if (dt.Rows.Count != 0)
            {
                Session["sql"] = sql;
                DataBindToRepeater(1);
                divBookAll.Visible = true;
                divSearch.Visible = false;
            }
            else
                Response.Write("<script>alert('该作者不存在图书在此书库！')</script>");
        }
        else  //全部输入
        {
            string sql = "select id,BookName,Author,PubHouse,Num,LeftNum from BookDataBase where Author=N'" + Author + "' and BookName=N'" + BookName + "'";
            DataTable dt = book.SQL_dt(sql);
            if (dt.Rows.Count != 0)
            {
                Session["sql"] = sql;
                DataBindToRepeater(1);
                divBookAll.Visible = true;
                divSearch.Visible = false;
            }
            else
                Response.Write("<script>alert('该图书在此书库不存在！')</script>");
        }
    }

    protected void btnBackSearch_Click(object sender, EventArgs e)  //从书单页面返回查找页面
    {
        divBookAll.Visible = false;
        divSearch.Visible = true;
    }

    protected void btnScanf_Click(object sender, EventArgs e)  //从主页面到输入页面
    {
        divMain.Visible = false;
        divSearch.Visible = true;
    }

    protected void btnAddBook_Click(object sender, EventArgs e)  //返回增添图书页面到主页面
    {
        divMain.Visible = false;
        divAddBook.Visible = true;
    }

    protected void btnBackMain_Search_Click(object sender, EventArgs e)  //从输入页面返回到主页面
    {
        divMain.Visible = true;
        divSearch.Visible = false;
    }

    protected void btnAdd_Click(object sender, EventArgs e)  //添加图书
    {
        string BookName = txtBook_Name.Text;
        string Author = txt_Author.Text;
        string PubHouse = txtPubHouse.Text;
        string Class = txtClass.Text;
        string sql = "select id,Num,LeftNum from BookDataBase where Author=N'" + Author + "' and BookName=N'" + BookName + "'and PubHouse=N'"+PubHouse+"' and Class=N'"+Class+"'";
        DataTable dt = book.SQL_dt(sql);
        if (dt.Rows.Count == 0)
        {
            int NameLen = BookName.Length;
            int Aulen = Author.Length;
            int PubLen = PubHouse.Length;
            int Cllen = Class.Length;
            if (NameLen != 0 && Aulen != 0 && PubLen != 0 && Cllen != 0)
            {
                sql = "insert into BookDataBase values(N'" + BookName + "',N'" + Author + "',N'" + PubHouse + "',N'" + Class + "',1,1)";
                book.SQL(sql);
                Response.Write("<script>alert('添加成功！')</script>");
            }
            else
                Response.Write("<script>alert('信息不完全！')</script>");
        }
        else
        {
            int id = Convert.ToInt32(dt.Rows[0][0].ToString());
            int Num = Convert.ToInt32(dt.Rows[0][1].ToString());
            int LeftNum = Convert.ToInt32(dt.Rows[0][2].ToString());
            Num++;
            LeftNum++;
            sql = "update BookDataBase set Num='" + Num + "', LeftNum='" + LeftNum + "' where id='" + id + "'";
            book.SQL(sql);
            Response.Write("<script>alert('添加成功！')</script>");
        }
        }

    protected void btnBackMain_Add_Click(object sender, EventArgs e)  //从添加页面返回主页面
    {
        divMain.Visible = true;
        divAddBook.Visible = false;
    }

    protected void btnBackMain_Click(object sender, EventArgs e)  //从管理图书页面跳转到管理页面
    {
        Response.Write("<script>location='Administration.aspx'</script>");
    }
    protected void DataBindToRepeater(int current)  //数据捆绑
    {
        string sql = Session["sql"].ToString();
        DataTable dt = book.SQL_dt(sql);
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
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