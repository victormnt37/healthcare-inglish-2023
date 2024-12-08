<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void TextBox12_TextChanged(object sender, EventArgs e)
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
        <div>

            <asp:Label ID="Label16" runat="server" Text="Search:"></asp:Label>
            <asp:TextBox ID="TextBox12" runat="server" OnTextChanged="TextBox12_TextChanged"></asp:TextBox>
            <asp:ListBox ID="ListBox2" runat="server"></asp:ListBox>
        </div>
        <div>
            <asp:Label ID="Label23" runat="server" Text="ID:"></asp:Label>
            <asp:Label ID="labelid_record" runat="server" Text="00"></asp:Label>
            <br />
            <asp:Label ID="Label20" runat="server" Text="Date:"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text="fecha"></asp:Label>
            <br />
            <asp:Label ID="Label21" runat="server" Text="Diagnosis:"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="diagnosis"></asp:Label>
            <br />
            <asp:Label ID="Label22" runat="server" Text="Treatment:"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="treatment"></asp:Label>
        </div>
    </form>
</body>
</html>
