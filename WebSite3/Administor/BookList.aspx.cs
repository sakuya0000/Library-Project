using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookList : System.Web.UI.Page
{
    static SQLHelper book = new SQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(Request.QueryString["id"].ToString());
        string sql = "SELECT * FROM BookDatabase WHERE id='" + id + "'";
        DataTable dt = book.SQL_dt(sql);
        txtBookName.Text = dt.Rows[0][1].ToString();
        txtAuthor.Text = dt.Rows[0][2].ToString();
        txtPubHouse.Text = dt.Rows[0][3].ToString();
        txtClass.Text = dt.Rows[0][4].ToString();
        txtNum.Text = dt.Rows[0][5].ToString();
        txtLeftNum.Text = dt.Rows[0][6].ToString();
        Session["Num"] = dt.Rows[0][5].ToString();
        Session["LeftNum"] = dt.Rows[0][6].ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(Request.QueryString["id"].ToString());
            string BookName = txtBookName.Text;
            string Author = txtAuthor.Text;
            string PubHouse = txtPubHouse.Text;
            string Class = txtClass.Text;
            int AddNum = Convert.ToInt32(txtAddNum.Text);
            int NameLen = BookName.Length;
            int Aulen = Author.Length;
            int Publen = PubHouse.Length;
            int Cllen = Class.Length;
            if (NameLen != 0 && Aulen != 0 && Publen != 0 && Cllen != 0)
            {
                int Num = Convert.ToInt32(Session["Num"].ToString());
                int LeftNum = Convert.ToInt32(Session["LeftNum"].ToString());
                Num += AddNum;
                LeftNum += AddNum;
                string sql = "UPDATE BookDatabase SET BookName=N'" + BookName + "',Author=N'" + Author + "',PubHouse=N'" + PubHouse + "',Class='" + Class + "',Num='" + Num + "',LeftNum='" + LeftNum + "' WHERE id='" + id + "'";
                book.SQL(sql);
                sql = "UPDATE BookEvent SET BookName=N'" + BookName + "'WHERE BookID='" + id + "'";
                book.SQL(sql);
                Response.Write("<script>alert('修改成功！');location='/Administor/BookManageIn.aspx'</script>");
            }
            else
            {
                Response.Write("<script>alert('请不要输入空串！');location='BookList.aspx?id=" + id + "'</script>");
            }
        }
        catch
        {
            Response.Write("<script>alert('请在添加数字处输入数字！')</script>");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location='/Administor/BookManageIn.aspx'</script>");
    }

    protected void btnChange_Click(object sender, EventArgs e)  //切换到增添数量页面
    {
        divSubmit.Visible = true;
        divChange.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)  //返回主页面
    {
        divChange.Visible = true;
        divSubmit.Visible = false;
    }
}