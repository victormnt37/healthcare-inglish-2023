<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {

    }
</script>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <header>

            <asp:Label ID="Label2" runat="server" Text="Healthcare center Gandia"></asp:Label>

            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Log-in" />

            <asp:Menu ID="Menu1" runat="server" OnMenuItemClick="Menu1_MenuItemClick">
            </asp:Menu>

        </header>
        <div>

            <asp:Image ID="Image1" runat="server" />
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
            <asp:Image ID="Image2" runat="server" />
            <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>

        </div>
        <footer>

            <asp:Label ID="Label1" runat="server" Text="© 2024 Healtcare Inc. by Victor &amp; Manu"></asp:Label>

        </footer>
    </form>

</body>
</html>
