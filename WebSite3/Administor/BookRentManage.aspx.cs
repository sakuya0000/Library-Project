using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookRentManage : System.Web.UI.Page
{
    static SQLHelper book = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBindToRepeater(1);
        }
    }

    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Agree")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            string sql = "SELECT DateTo_con FROM BookEvent WHERE id='" + id + "'";
            DataTable dt = book.SQL_dt(sql);
            string DateTo = dt.Rows[0][0].ToString();
            sql = "UPDATE BookEvent SET DateTo ='" + DateTo + "',DateTo_con =NULL,Status='A' WHERE id='" + id + "'";
            book.SQL(sql);
            DataBindToRepeater(Convert.ToInt32(NowPage.Text));
            Response.Write("<script>alert('操作成功！')</script>");
        }
        else if (e.CommandName == "Disagree")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            string sql = "UPDATE BookEvent SET DateTo_con=NULL,Status='D' WHERE id='" + id + "'";
            book.SQL(sql);
            DataBindToRepeater(Convert.ToInt32(NowPage.Text));
            Response.Write("<script>alert('操作成功！')</script>");
        }
    }
    protected void DataBindToRepeater(int currentPage)  //数据捆绑
    {
        string sql = "select * from BookEvent where DateTo_con <> 'NULL'";
        DataTable dt = book.SQL_dt(sql);
        PagedDataSource pds = new PagedDataSource();
        pds.AllowPaging = true;
        pds.PageSize = 5;
        pds.DataSource = dt.DefaultView;
        TotalPage.Text = pds.PageCount.ToString();
        pds.CurrentPageIndex = currentPage - 1;
        rptList.DataSource = pds;
        rptList.DataBind();
    }

    protected void btnUpPage_Click(object sender, EventArgs e)  //上一页
    {
        string nowPage = NowPage.Text;
        int UpPage = Convert.ToInt32(nowPage) - 1;
        if (UpPage >= 1)
        {
            NowPage.Text = Convert.ToString(UpPage);
            DataBindToRepeater(UpPage);
        }
    }

    protected void btnDownPage_Click(object sender, EventArgs e)  //下一页
    {
        string nowPage = NowPage.Text;
        int NextPage = Convert.ToInt32(nowPage) + 1;
        if (NextPage <= Convert.ToInt32(TotalPage.Text))
        {
            NowPage.Text = Convert.ToString(NextPage);
            DataBindToRepeater(NextPage);
        }
    }

    protected void btnFirstPage_Click(object sender, EventArgs e)  //首页
    {
        NowPage.Text = "1";
        DataBindToRepeater(1);
    }

    protected void btnLastPage_Click(object sender, EventArgs e)  //尾页
    {
        int LastPage = Convert.ToInt32(TotalPage.Text);
        NowPage.Text = LastPage.ToString();
        DataBindToRepeater(LastPage);
    }

    protected void btnJumpPage_Click(object sender, EventArgs e)  //跳页
    {
        int nowPage;
        try
        {
            nowPage = Convert.ToInt32(txtJumpPage.Text);
            if (nowPage <= Convert.ToInt32(TotalPage.Text) && nowPage >= 1)
            {
                NowPage.Text = txtJumpPage.Text;
                DataBindToRepeater(nowPage);
            }
            else
            {
                Response.Write("<script>alert('请输入正确的数字！')</script>");
            }
        }
        catch
        {
            Response.Write("<script>alert('请输入数字！')</script>");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)  //返回
    {
        Response.Write("<script>location='Administration.aspx'</script>");
    }
}