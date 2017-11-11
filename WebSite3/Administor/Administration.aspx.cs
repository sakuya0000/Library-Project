using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BookRentManage_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location='BookRentManage.aspx'</script>");
    }

    protected void BookManage_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location='BookManageIn.aspx'</script>");
    }

    protected void UserManage_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location='UserManageIn.aspx'</script>");
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location='/User/Login.aspx'</script>");
    }
}