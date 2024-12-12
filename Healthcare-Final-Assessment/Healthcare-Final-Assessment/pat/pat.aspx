<%@ Page Language="C#" %>

<!DOCTYPE html>
<script runat="server">

    private string databasePath;
    private string connectionString;

    private static List<Record> records = new List<Record>();

    public class Record
    {
        public int Id { get; set; }
        public int PatientId { get; set; }
        public string Date { get; set; }
        public string Diagnosis { get; set; }
        public string Treatment { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        databasePath = Server.MapPath("~/healthcare.db");

        connectionString = $"Data Source={databasePath};Version=3;";

        // lista pacientes
        if (!IsPostBack)
        {
            records.Clear();
            ListBox2.Items.Clear();

            string searchQuery = TextBox12.Text;

            using (System.Data.SQLite.SQLiteConnection connection = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                connection.Open();

                string pin = (string)(Session["PIN"]);

                string query = "SELECT r.* FROM users u JOIN records r ON u.id = r.idpat WHERE u.PIN = @PIN;";

                using (System.Data.SQLite.SQLiteCommand command = new System.Data.SQLite.SQLiteCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PIN", pin);

                    using (System.Data.SQLite.SQLiteDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            try
                            {
                                Record record = new Record
                                {
                                    Id = reader.IsDBNull(reader.GetOrdinal("id")) ? 0 : Convert.ToInt32(reader["id"]),
                                    PatientId = reader.IsDBNull(reader.GetOrdinal("idpat")) ? 0 : Convert.ToInt32(reader["id"]),
                                    Date = reader.IsDBNull(reader.GetOrdinal("date")) ? string.Empty : reader["date"].ToString(),
                                    Diagnosis = reader.IsDBNull(reader.GetOrdinal("diagnosis")) ? string.Empty : reader["diagnosis"].ToString(),
                                    Treatment = reader.IsDBNull(reader.GetOrdinal("treatment")) ? string.Empty : reader["treatment"].ToString(),
                                };

                                records.Add(record);
                                ListBox2.Items.Add(reader.GetString(reader.GetOrdinal("diagnosis")));
                            }
                            catch (Exception ex)
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error  in Page Load: {ex.Message}');", true);
                            }
                        }
                    }
                    object result = command.ExecuteScalar();
                }
            }
        }
    }

    protected void TextBox12_TextChanged(object sender, EventArgs e)
    {
        string searchQuery = TextBox12.Text;

        records.Clear();
        ListBox2.Items.Clear();

        try
        {
            using (var conn = new System.Data.SQLite.SQLiteConnection(connectionString))
            {
                conn.Open();

                string query = "SELECT * FROM records WHERE diagnosis LIKE @SearchQuery";
                using (var cmd = new System.Data.SQLite.SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {

                            Record patient = new Record
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("id")),
                                PatientId = reader.GetInt32(reader.GetOrdinal("idpat")),
                                Date = reader.GetString(reader.GetOrdinal("date")),
                                Diagnosis = reader.GetString(reader.GetOrdinal("diagnosis")),
                                Treatment = reader.GetString(reader.GetOrdinal("treatment")),
                            };

                            ListBox2.Items.Add(new ListItem(patient.Diagnosis, patient.Id.ToString()));
                            records.Add(patient);
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

                labeldate.Text = selectedRecord.Date ?? "Not avalaible";
                labelDiagnosis.Text = selectedRecord.Diagnosis ?? "Not avalaible"; 
                labelTreatment.Text = selectedRecord.Treatment ?? "Not avalaible"; 
            }
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

            <asp:Label ID="Label16" runat="server" Text="Search record:"></asp:Label>
            <asp:TextBox ID="TextBox12" runat="server" OnTextChanged="TextBox12_TextChanged"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Search" />
            <asp:ListBox ID="ListBox2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged"></asp:ListBox>
        </div>
        <div>
            <asp:Label ID="Label23" runat="server" Text="ID:"></asp:Label>
            <asp:Label ID="labelid_record" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="Label20" runat="server" Text="Date:"></asp:Label>
            <asp:Label ID="labeldate" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="Label21" runat="server" Text="Diagnosis:"></asp:Label>
            <asp:Label ID="labelDiagnosis" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="Label22" runat="server" Text="Treatment:"></asp:Label>
            <asp:Label ID="labelTreatment" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
