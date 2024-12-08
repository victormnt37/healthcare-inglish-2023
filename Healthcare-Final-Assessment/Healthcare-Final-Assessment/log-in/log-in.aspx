<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        Label1.Text = "gahdlk vbuake";
    }
</script>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title></title>    
</head>
<body>
    <form id="form1" runat="server">
           
        
        <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
        <br />
        <div>
            <asp:Label runat="server" Text="Username:" ID="ctl02"></asp:Label><asp:TextBox runat="server"></asp:TextBox>
            <br />
            <asp:Label runat="server" Text="Password:" ID="ctl05"></asp:Label><asp:TextBox runat="server"></asp:TextBox>
        </div>
        
        <asp:Button runat="server" Text="Login"></asp:Button>
    </form>
</body>
</html>
