<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
         Response.Redirect("~/login.aspx");
    }

    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {

    }
</script>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>
    <link href="css/index.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header>

            <asp:Label ID="Label2" runat="server" Text="Healthcare center Gandia"></asp:Label>

            <asp:Menu ID="Menu1" runat="server" OnMenuItemClick="Menu1_MenuItemClick">
            </asp:Menu>

        </header>
        <div id="main">
            <asp:Image ID="Image1" runat="server" ImageUrl="img/stockImageHealthCenter.jpg" />

            <div id="loginLayout">
                <asp:Label ID="Label3" runat="server" Text="Welcome to our page!"></asp:Label>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" />
            </div>

            <asp:Image ID="Image2" runat="server" ImageUrl="img/stockImageHealthCenter2.jpg" />

        </div>
        <footer>

            <asp:Label ID="Label1" runat="server" Text="© 2024 Healtcare Inc. by Victor &amp; Manu"></asp:Label>

        </footer>
    </form>

</body>
</html>
