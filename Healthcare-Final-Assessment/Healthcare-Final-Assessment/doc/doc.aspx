<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        // crear paciente
    }

    protected void TextBox6_TextChanged(object sender, EventArgs e)
    {
        // buscar paciente
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // seleccionar usuario
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        // guardar cambios del usuario
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        // eliminar el usuario
    }

    protected void TextBox12_TextChanged(object sender, EventArgs e)
    {
        // buscar records del usuario
    }

    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        // seleccionar record
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        // crear record
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        // guardar cambios del record
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        // eliminar record
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
            <asp:Label ID="Label1" runat="server" Text="Create patient"></asp:Label>
            <div>
                <asp:Label ID="Label2" runat="server" Text="Name:"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label3" runat="server" Text="DOB:"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label4" runat="server" Text="Address:"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label5" runat="server" Text="Mobile:"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="PIN:"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Create" OnClick="Button1_Click" />
            </div>
        </div>
        <asp:Label ID="Label7" runat="server" Text="Patients Info"></asp:Label>
        <div>
            <div>

                <asp:Label ID="Label8" runat="server" Text="Search:"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" OnTextChanged="TextBox6_TextChanged"></asp:TextBox>
                <asp:ListBox ID="ListBox1" runat="server" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
            </div>
            <div>
                <asp:Label ID="Label14" runat="server" Text="ID:"></asp:Label>
                <asp:Label ID="labelId" runat="server" Text="00"></asp:Label>
                <br />
                <asp:Label ID="Label9" runat="server" Text="Name:"></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label10" runat="server" Text="DOB:"></asp:Label>
                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label11" runat="server" Text="Address:"></asp:Label>
                <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label12" runat="server" Text="Mobile:"></asp:Label>
                <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="Label13" runat="server" Text="PIN:"></asp:Label>
                <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>
                <asp:Button ID="Button2" runat="server" Text="Save" OnClick="Button2_Click" />
                <asp:Button ID="Button3" runat="server" Text="Delete" OnClick="Button3_Click" />
            </div>

        </div>
        <asp:Label ID="Label15" runat="server" Text="Medical Records"></asp:Label>
        <div>

            <asp:Label ID="Label16" runat="server" Text="Search:"></asp:Label>
            <asp:TextBox ID="TextBox12" runat="server" OnTextChanged="TextBox12_TextChanged"></asp:TextBox>
            <asp:ListBox ID="ListBox2" runat="server" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged"></asp:ListBox>
        </div>
        <div>
            <asp:Label ID="Label17" runat="server" Text="Date:"></asp:Label>
            <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label18" runat="server" Text="Diagnosis:"></asp:Label>
            <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label19" runat="server" Text="Treatment:"></asp:Label>
            <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button4" runat="server" Text="Create" OnClick="Button4_Click" />
        </div>
        <div>
            <asp:Label ID="Label23" runat="server" Text="ID:"></asp:Label>
            <asp:Label ID="labelid_record" runat="server" Text="00"></asp:Label>
            <br />
            <asp:Label ID="Label20" runat="server" Text="Date:"></asp:Label>
            <asp:TextBox ID="TextBox17" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label21" runat="server" Text="Diagnosis:"></asp:Label>
            <asp:TextBox ID="TextBox18" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label22" runat="server" Text="Treatment:"></asp:Label>
            <asp:TextBox ID="TextBox19" runat="server"></asp:TextBox>
            <asp:Button ID="Button5" runat="server" Text="Save" OnClick="Button5_Click" />
            <asp:Button ID="Button6" runat="server" Text="Delete" OnClick="Button6_Click" />
        </div>
    </form>
</body>
</html>
