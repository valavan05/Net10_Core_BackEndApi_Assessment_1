namespace Invoice.DAL.Test;

public class TestDatabase
{
    public static string ConnectionString =>

       Environment.GetEnvironmentVariable("TEST_DB_CONNECTION")

       ?? "Server=LAPTOP-INKMOE0V\\SQLEXPRESS,1435;" +

           "Database=Invoice_Assessment_1_Test;" +

          "User Id=sa;" +

          "Password=123456;" +

          "Encrypt=False;" +

          "TrustServerCertificate=True";
}
