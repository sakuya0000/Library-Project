using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserLend : System.Web.UI.Page
{
    static SQLHelper us = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBindToRepeater(1);
        }
    }

    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string sql;
        if (e.CommandName == "Return")
        {
            string username = Session["username"].ToString();
            int BookID = Convert.ToInt32(e.CommandArgument.ToString());
            sql = "DELETE FROM BookEvent WHERE BookID='" + BookID + "'";
            us.SQL(sql);
            sql = "SELECT LeftNum FROM BookDatabase WHERE id='" + BookID + "'";
            DataTable dt = us.SQL_dt(sql);
            int LeftNum =Convert.ToInt32(dt.Rows[0][0].ToString());
            LeftNum++;
            sql = "UPDATE BookDatabase SET LeftNum='" + LeftNum + "' WHERE id='" + BookID + "'";
            us.SQL(sql);
            Response.Write("<script>alert('还书成功');location='UserLend.aspx'</script>");
        }
        else if (e.CommandName == "Lend")
        {
            int ID = Convert.ToInt32(e.CommandArgument.ToString());
            Session["ID"] = ID.ToString();
            sql = "SELECT BookName,DateFrom,DateTo FROM BookEvent WHERE id='" + ID + "'";
            DataTable dt = us.SQL_dt(sql);
            string DateTo_con = Convert.ToDateTime(dt.Rows[0][2].ToString()).AddDays(15).ToLongDateString().ToString();
            txtBookName.Text = dt.Rows[0][0].ToString();
            txtDateFrom.Text = dt.Rows[0][1].ToString();
            txtDateTo.Text = dt.Rows[0][2].ToString();
            txtRequest.Text = DateTo_con;
        }
    }

    protected void btnLend_con_Click(object sender, EventArgs e)  //切换到续借申请页面
    {
        divLend.Visible = true;
        divMain.Visible = false;
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回用户页面
    {
        Response.Write("<script>location='Welcome.aspx'</script>");
    }

    protected void btnSumit_Click(object sender, EventArgs e)  //申请续借
    {
        string username = Session["username"].ToString();
        int id = Convert.ToInt32(Session["ID"].ToString());
        string sql = "SELECT DateTo,Status FROM BookEvent WHERE id='" + id + "'";
        DataTable dt = us.SQL_dt(sql);
        string DateTo_con = Convert.ToDateTime(dt.Rows[0][0].ToString()).AddDays(15).ToLongDateString().ToString();
        if (dt.Rows[0][1].ToString()!="R")
        {
            sql = "UPDATE BookEvent SET DateTo_con=N'" + DateTo_con + "',Status='R' WHERE id='" + id + "'";
            us.SQL(sql);
            Response.Write("<script>alert('申请成功！');location='UserLend.aspx'</script>");
        }
        else
        {
            Response.Write("<script>alert('您已借过此书！')</script>");
        }
    }

    protected void btnBackMain_Click(object sender, EventArgs e)  //返回
    {
        Response.Write("<script>location='UserLend.aspx'</script>");
    }

    protected void DataBindToRepeater(int current)  //数据绑定
    {
        string username = Session["username"].ToString();
        string sql = "SELECT id,BookName,DateFrom,DateTo,DateTo_con,Status,BookID FROM BookEvent WHERE UserName='" + username + "'";
        DataTable dt = us.SQL_dt(sql);
        string Now = DateTime.Now.ToLongDateString().ToString();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            int result = String.CompareOrdinal(Now, dt.Rows[0][3].ToString());
            if (result >= 0)
            {
                dt.Rows[i][4] = "未到期";
            }
            else
                dt.Rows[i][4] = "已逾期";
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string Status = dt.Rows[i][5].ToString();
            if (Status == "R")
                dt.Rows[i][5] = "申请中";
            else if (Status == "A")
                dt.Rows[i][5] = "已通过";
            else if (Status == "D")
                dt.Rows[i][5] = "未通过";
            else if (Status.Length==0)
                dt.Rows[i][5] = "未申请";
        }
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = current - 1;
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

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int current = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = current.ToString();
        DataBindToRepeater(current);
    }

    protected void btnJump_Click(object sender, EventArgs e)  //跳页
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