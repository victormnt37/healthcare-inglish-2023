<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title></title>    
</head>
<body>
    <form id="form1" runat="server">   
        <div>
            <asp:Label ID="Label1" runat="server" Text="Create user"></asp:Label>
            <div>
                <asp:Label ID="Label2" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label3" runat="server" Text="DOB"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label4" runat="server" Text="Address"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label5" runat="server" Text="Mobile"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="PIN"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
            </div>
        </div>
        <div>
            <asp:Label ID="Label7" runat="server" Text="Patients list"></asp:Label>
            <div>
               
                <asp:Label ID="Label8" runat="server" Text="Search:"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                <asp:ListBox ID="ListBox1" runat="server"></asp:ListBox>
            </div>
        </div>
    </form>
</body>
</html>
