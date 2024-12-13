<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Login" Font-Bold="True"></asp:Label>
        <br />
        <div>
            <asp:Label ID="Label2" runat="server" Text="PIN:"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" />
    </form>

    <script runat="server">
        protected void Button1_Click(object sender, EventArgs e)
        {
            string pin = TextBox1.Text;
            string password = TextBox2.Text;

            string databasePath = Server.MapPath("~/healthcare.db");
            string connectionString = $"Data Source={databasePath};Version=3;";

            string query = "SELECT isDoctor FROM Users WHERE pin = @pin AND password = @Password";

            try
            {
                using (var connection = new System.Data.SQLite.SQLiteConnection(connectionString))
                {
                    connection.Open();

                    using (var command = new System.Data.SQLite.SQLiteCommand(query, connection))
                    {

                        command.Parameters.AddWithValue("@pin", pin);
                        command.Parameters.AddWithValue("@Password", password);

                        object result = command.ExecuteScalar();

                        if (result != null)
                        {
                            int isDoctor = Convert.ToInt32(result);

                            Session["PIN"] = pin;

                            if (isDoctor == 0)
                            {
                                Session["UserRole"] = "Doctor";
                                Response.Redirect("~/doc/doc.aspx");
                            }
                            else
                            {
                                Session["UserRole"] = "Patient";
                                Response.Redirect("~/pat/pat.aspx");
                            }
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "LoginError", "alert('Invalid username or password. Please try again.');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "LoginError", "alert('Error connecting to the database: " + ex.Message + "');", true);
            }
        }
    </script>
</body>
</html>
