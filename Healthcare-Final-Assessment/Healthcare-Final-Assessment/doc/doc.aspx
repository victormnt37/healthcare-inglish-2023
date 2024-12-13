<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="doc.aspx.cs" Inherits="Healthcare_Final_Assessment.doc.doc" %>

<!DOCTYPE html>
<script runat="server">

    private string databasePath;
    private string connectionString;

    private static List<Patient> patients = new List<Patient>();
    private static List<Record> records = new List<Record>();
    private static int currentPatientId = 0;
    private static int currentRecordId = 0;

    private int CurrentPatientIndex
    {
        get
        {
            return Session["CurrentPatientIndex"] != null ? (int)Session["CurrentPatientIndex"] : -1;
        }
        set
        {
            Session["CurrentPatientIndex"] = value;
        }
    }

    public class Patient
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string DOB { get; set; }
        public string Address { get; set; }
        public int Mobile { get; set; }
        public string PIN { get; set; }
    }

    public class Record
    {
        public int Id { get; set; }
        public int idpat { get; set; }
        public string Date { get; set; }
        public string Diagnosis { get; set; }
        public string Treatment { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        databasePath = Server.MapPath("~/healthcare.db");

        connectionString = $"Data Source={databasePath};Version=3;";

        if (!IsPostBack)
        {
            UpdatePatientList();
        }
    }

    private void UpdatePatientList()
    {
        patients.Clear();
        ListBox1.Items.Clear();

        using (System.Data.SQLite.SQLiteConnection connection = new System.Data.SQLite.SQLiteConnection(connectionString))
        {
            connection.Open();
            string query = "SELECT * FROM users WHERE isDoctor != 0";

            using (System.Data.SQLite.SQLiteCommand command = new System.Data.SQLite.SQLiteCommand(query, connection))
            {
                using (System.Data.SQLite.SQLiteDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        try
                        {
                            Patient patient = new Patient
                            {
                                Id = reader.IsDBNull(reader.GetOrdinal("id")) ? 0 : Convert.ToInt32(reader["id"]),
                                Name = reader.IsDBNull(reader.GetOrdinal("name")) ? string.Empty : reader["name"].ToString(),
                                DOB = reader.IsDBNull(reader.GetOrdinal("DOB")) ? string.Empty : reader["DOB"].ToString(),
                                Address = reader.IsDBNull(reader.GetOrdinal("address")) ? string.Empty : reader["address"].ToString(),
                                Mobile = reader.IsDBNull(reader.GetOrdinal("mobile")) ? 0 : Convert.ToInt32(reader["mobile"]),
                                PIN = reader.IsDBNull(reader.GetOrdinal("PIN")) ? string.Empty : reader["PIN"].ToString()
                            };

                            patients.Add(patient);
                            ListBox1.Items.Add(reader.GetString(reader.GetOrdinal("name")));
                        }
                        catch (Exception ex)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error  in UpdatePatientList: {ex.Message}');", true);
                        }
                    }
                }
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        // crear paciente
        string name = TextBox1.Text;
        string dob = TextBox2.Text;
        string address = TextBox3.Text;
        string mobile = TextBox4.Text;
        string pin = TextBox5.Text;
        string password = TextBox16.Text;

        string passwordPattern = @"^(?=.*[A-Z])(?=.*[a-z])(?=(.*\d){2})[A-Za-z\d]{6,}$";
        Regex passwordRegex = new Regex(passwordPattern);
        if (!passwordRegex.IsMatch(password))
        {
            Response.Write("Error: La contraseña debe tener al menos 6 caracteres, contener al menos 2 números, una letra mayúscula y una letra minúscula.");
            return;
        }


        // Validación de dirección como correo electrónico
        string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
        Regex emailRegex = new Regex(emailPattern);
        if (!emailRegex.IsMatch(address))
        {
            Response.Write("Error: La dirección debe ser un correo electrónico válido.");
            return;
        }

        // Validación de número móvil
        if (!long.TryParse(mobile, out _))
        {
            Response.Write("Error: El número móvil debe contener solo caracteres numéricos.");
            return;
        }

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO Users (Name, DOB, Address, Mobile, PIN, Password) VALUES (@Name, @DOB, @Address, @Mobile, @PIN, @Password)";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@DOB", dob);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@PIN", pin);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.ExecuteNonQuery();
                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    TextBox4.Text = "";
                    TextBox5.Text = "";
                    TextBox16.Text = "";
                }
            }
            UpdatePatientList();
        }
        catch (Exception ex)
        {
            Response.Write($"Error: {ex.Message}");
        }
    }

    protected void TextBox6_TextChanged(object sender, EventArgs e)
    {
        // buscar pacientes
        string searchQuery = TextBox6.Text;

        patients.Clear();
        ListBox1.Items.Clear();

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "SELECT * FROM Users WHERE name LIKE @SearchQuery";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {

                            Patient patient = new Patient
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("id")),
                                Name = reader.GetString(reader.GetOrdinal("name")),
                                DOB = reader.GetString(reader.GetOrdinal("DOB")),
                                Address = reader.GetString(reader.GetOrdinal("address")),
                                Mobile = reader.GetInt32(reader.GetOrdinal("mobile")),
                                PIN = reader.GetString(reader.GetOrdinal("PIN"))
                            };

                            ListBox1.Items.Add(new ListItem(patient.Name, patient.Id.ToString()));
                            patients.Add(patient);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "SearchError", "alert('Error searching for patient: " + ex.Message + "');", true);
        }
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex >= 0)
        {
            int selectedIndex = ListBox1.SelectedIndex; // recibir por patient id

            Patient selectedPatient = patients[selectedIndex];
            currentPatientId = selectedPatient.Id;
            labelId.Text = selectedPatient.Id.ToString();
            TextBox7.Text = selectedPatient.Name;
            TextBox8.Text = selectedPatient.DOB;
            TextBox9.Text = selectedPatient.Address;
            TextBox10.Text = selectedPatient.Mobile.ToString();
            TextBox11.Text = selectedPatient.PIN.ToString();

            CurrentPatientIndex = selectedIndex;

            // Ahora cargar los registros médicos del paciente
            LoadMedicalRecords(selectedPatient.Id);
        }
    }

    private void LoadMedicalRecords(int patientId)
    {
        ListBox2.Items.Clear();
        records.Clear();

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "SELECT * FROM records WHERE idpat = @PatientId";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Record record = new Record
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("id")),
                                idpat = reader.GetInt32(reader.GetOrdinal("idpat")),
                                Date = reader.GetString(reader.GetOrdinal("Date")),
                                Diagnosis = reader.GetString(reader.GetOrdinal("Diagnosis")),
                                Treatment = reader.GetString(reader.GetOrdinal("Treatment"))
                            };

                            records.Add(record);
                            ListBox2.Items.Add(new ListItem($"Date: {record.Date}", record.Id.ToString()));

                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Manejo de errores si ocurre un problema con la base de datos
            ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error loading records: {ex.Message}');", true);
        }

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

        if (string.IsNullOrWhiteSpace(name))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('Name cannot be empty.');", true);
            return;
        }

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

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Patient patient = patients.FirstOrDefault(p => p.Id == currentPatientId);
                        if (patient != null)
                        {
                            patient.Name = name;
                            patient.DOB = dob;
                            patient.Address = address;
                            patient.Mobile = Convert.ToInt32(mobile);
                            patient.PIN = pin;
                        }

                        ClientScript.RegisterStartupScript(this.GetType(), "Success", "alert('Data submited successfully');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Couldn't update the user.');", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "LoginError", "alert(''Error connecting to the database: \" + ex.Message + \"'');", true);
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        // eliminar el usuario
        try
        {
            if (ListBox1.SelectedItem != null)
            {
                // Obtener el ID del usuario seleccionado
                int selectedId = patients[CurrentPatientIndex].Id;

                using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Users WHERE id = @Id";
                    using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", selectedId);
                        cmd.ExecuteNonQuery();

                    }
                }

                Response.Write("Usuario eliminado con éxito.");
            }
            else
            {
                Response.Write("Por favor, selecciona un usuario para eliminar.");
            }
        }
        catch (Exception ex)
        {
            Response.Write($"Error: {ex.Message}");
        }
    }

    protected void TextBox12_TextChanged(object sender, EventArgs e)
    {
        // buscar records del usuario
    }

    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ListBox2.SelectedIndex >= 0)
        {
            int selectedIndex = ListBox2.SelectedIndex;

            Record selectedRecord = null;

            if (selectedIndex >= 0 && selectedIndex < records.Count)
            {
                selectedRecord = records[selectedIndex];
            }

            if (selectedRecord != null)
            {
                labelid_record.Text = selectedRecord.Id.ToString();

                TextBox17.Text = selectedRecord.Date ?? "No disponible";
                TextBox18.Text = selectedRecord.Diagnosis ?? "No disponible";
                TextBox19.Text = selectedRecord.Treatment ?? "No disponible";
            }
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        if (CurrentPatientIndex < 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('Please select a patient first.');", true);
            return;
        }

        string date = TextBox13.Text;
        string diagnosis = TextBox14.Text;
        string treatment = TextBox15.Text;

        if (string.IsNullOrWhiteSpace(date) || string.IsNullOrWhiteSpace(diagnosis) || string.IsNullOrWhiteSpace(treatment))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('All fields must be filled out.');", true);
            return;
        }

        int patientId = patients[CurrentPatientIndex].Id;

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "INSERT INTO records (idpat, Date, Diagnosis, Treatment) VALUES (@PatientId, @Date, @Diagnosis, @Treatment)";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    cmd.Parameters.AddWithValue("@Date", date);
                    cmd.Parameters.AddWithValue("@Diagnosis", diagnosis);
                    cmd.Parameters.AddWithValue("@Treatment", treatment);

                    cmd.ExecuteNonQuery();
                }
            }

            LoadMedicalRecords(patientId);

            TextBox13.Text = "";
            TextBox14.Text = "";
            TextBox15.Text = "";
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error creating record: {ex.Message}');", true);
        }
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        if (ListBox2.SelectedIndex < 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('Please select a record first.');", true);
            return;
        }

        string date = TextBox17.Text;
        string diagnosis = TextBox18.Text;
        string treatment = TextBox19.Text;

        if (string.IsNullOrWhiteSpace(date) || string.IsNullOrWhiteSpace(diagnosis) || string.IsNullOrWhiteSpace(treatment))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('All fields must be filled out.');", true);
            return;
        }

        int recordId = Convert.ToInt32(labelid_record.Text);

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "UPDATE records SET Date = @Date, Diagnosis = @Diagnosis, Treatment = @Treatment WHERE id = @Id";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Date", date);
                    cmd.Parameters.AddWithValue("@Diagnosis", diagnosis);
                    cmd.Parameters.AddWithValue("@Treatment", treatment);
                    cmd.Parameters.AddWithValue("@Id", recordId);

                    cmd.ExecuteNonQuery();
                }
            }

            LoadMedicalRecords(currentPatientId);
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error updating record: {ex.Message}');", true);
        }
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        if (ListBox2.SelectedIndex < 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ValidationError", "alert('Please select a record first.');", true);
            return;
        }

        int recordId = Convert.ToInt32(labelid_record.Text);

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "DELETE FROM records WHERE id = @Id";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", recordId);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadMedicalRecords(currentPatientId);

            labelid_record.Text = "00";
            TextBox17.Text = "";
            TextBox18.Text = "";
            TextBox19.Text = "";
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error deleting record: {ex.Message}');", true);
        }
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
                <br />
                <asp:Label ID="Label24" runat="server" Text="Password:"></asp:Label>
                <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Create" OnClick="Button1_Click" />
            </div>
        </div>
        <asp:Label ID="Label7" runat="server" Text="Patients Info"></asp:Label>
        <div>
            <div>

                <asp:Label ID="Label8" runat="server" Text="Search:"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" OnTextChanged="TextBox6_TextChanged"></asp:TextBox>
                <asp:Button ID="Button7" runat="server" Text="Search" />
                <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
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

            <asp:Label ID="Label16" runat="server" Text="Search:" OnClick="Button8_Click"></asp:Label>
            <asp:TextBox ID="TextBox12" runat="server" OnTextChanged="TextBox12_TextChanged" Width="168px"></asp:TextBox>
            <asp:Button ID="Button8" runat="server" Text="Search" />
            <asp:ListBox ID="ListBox2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged"></asp:ListBox>
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

