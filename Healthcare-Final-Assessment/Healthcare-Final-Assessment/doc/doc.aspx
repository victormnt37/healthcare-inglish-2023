﻿<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    private string databasePath;
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        string databasePath = Server.MapPath("~/../healthcare.db");
        string connectionString = $"Data Source={databasePath};Version=3;";

        using (System.Data.SQLite.SQLiteConnection connection = new System.Data.SQLite.SQLiteConnection(connectionString))
        {
            connection.Open();

            string query = "SELECT * FROM usuarios";

            using (System.Data.SQLite.SQLiteCommand command = new System.Data.SQLite.SQLiteCommand(query, connection))
            {
                using (System.Data.SQLite.SQLiteDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Crear un nuevo objeto Patient y asignar los valores desde la base de datos
                        Patient patient = new Patient
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("id")),
                            Name = reader.GetString(reader.GetOrdinal("name")),
                            DOB = reader.GetString(reader.GetOrdinal("DOB")),
                            Address = reader.GetString(reader.GetOrdinal("address")),
                            Mobile = reader.GetString(reader.GetOrdinal("mobile")),
                            PIN = reader.GetString(reader.GetOrdinal("PIN"))
                        };

                        // Añadir el paciente a la lista
                        patients.Add(patient);
                    }
                }
            }
        }
    }

    private static List<Patient> patients = new List<Patient>();
    private static List<Record> records = new List<Record>();
    private static int currentPatientId = 0;
    private static int currentRecordId = 0;

    public class Patient
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string DOB { get; set; }
        public string Address { get; set; }
        public string Mobile { get; set; }
        public string PIN { get; set; }
    }

    public class Record
    {
        public int Id { get; set; }
        public int PatientId { get; set; }
        public string Date { get; set; }
        public string Diagnosis { get; set; }
        public string Treatment { get; set; }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        string name = TextBox1.Text;
        string dob = TextBox2.Text;
        string address = TextBox3.Text;
        string mobile = TextBox4.Text;
        string pin = TextBox5.Text;

        using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
        {
            conn.Open();
            string query = "INSERT INTO Patients (Name, DOB, Address, Mobile, PIN) VALUES (@Name, @DOB, @Address, @Mobile, @PIN)";
            System.Data.SQLite.SQLiteCommand cmd = new System.Data.SQLite.SQLiteCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@DOB", dob);
            cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.Parameters.AddWithValue("@PIN", pin);
            cmd.ExecuteNonQuery();
        }
    }

    protected void TextBox6_TextChanged(object sender, EventArgs e)
    {
        // buscar paciente
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // seleccionar usuario

        // pedir un usuario
        // mostrar info en los labels
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        // guardar cambios del usuario
         if (currentPatientId == 0)
         {
            return;
         }

        string name = TextBox7.Text;
        string dob = TextBox8.Text;
        string address = TextBox9.Text;
        string mobile = TextBox10.Text;
        string pin = TextBox11.Text;

        string query = "UPDATE users SET name = @Name, DOB = @DOB, address = @Address, mobile = @Mobile, PIN = @PIN WHERE id = @Id";

        try
        {
            using (var connection = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                connection.Open();

                using (var command = new System.Data.SQLite.SQLiteCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@DOB", dob);
                    command.Parameters.AddWithValue("@Address", address);
                    command.Parameters.AddWithValue("@Mobile", mobile);
                    command.Parameters.AddWithValue("@PIN", pin);
                    command.Parameters.AddWithValue("@Id", currentPatientId);

                    object result = command.ExecuteScalar();
                }
            }

            // modificar datos clase Patient
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "LoginError", "alert(''Error connecting to the database: \" + ex.Message + \"'');", true);
        }
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
