using System.Reflection;
using System.Text.RegularExpressions;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace PivotTableBindToData.SalesDb {
    public static class SalesDataGenerator {

        public static async Task<bool> SalesTableExistsAsync(SalesContext context) {
            if (!await DatabaseExistsAsync(context))
                return false;
            return await SalesTableExistsInDatabaseAsync(context);
        }

        static async Task<bool> DatabaseExistsAsync(SalesContext context) {            
            return await context.Database.CanConnectAsync();
        }

        static async Task<bool> SalesTableExistsInDatabaseAsync(SalesContext context) {
            string sql = GetDataProvider(context) switch {
                DataProviders.SQLite =>
                    "SELECT count(*) AS [Value] FROM sqlite_master WHERE type = 'table' AND name = 'Sales'",
                DataProviders.SqlServer =>
                    "SELECT count(*) AS [Value] FROM sys.tables WHERE name = 'Sales'",
                var provider => throw new NotSupportedException($"Unsupported database provider: '{provider}'.")
            };

            int tableCount = await context.Database.SqlQueryRaw<int>(sql).SingleAsync();
            return tableCount > 0;
        }

        public static async Task GenerateAsync(SalesContext context) {
            var dataProvider = GetDataProvider(context);
            string resourceName = dataProvider switch {
                DataProviders.SQLite => "PivotTableBindToData.SalesDb.Scripts.SQLiteDbGenerator.sql",
                DataProviders.SqlServer => "PivotTableBindToData.SalesDb.Scripts.SqlServerDbGenerator.sql",
                _ => ""
            };

            string script = await ReadEmbeddedScriptAsync(resourceName);

            var batches = Regex.Split(script, @"^\s*GO\s*$", RegexOptions.Multiline | RegexOptions.IgnoreCase)
                .Select(batch => batch.Trim())
                .Where(batch => batch.Length > 0)
                .ToList();

            if (dataProvider == DataProviders.SqlServer) {
                var connectionStringBuilder = new SqlConnectionStringBuilder(context.Database.GetConnectionString()) {
                    InitialCatalog = "master"
                };

                await using var connection = new SqlConnection(connectionStringBuilder.ConnectionString);
                await connection.OpenAsync();

                foreach (var batch in batches) {
                    await using var command = connection.CreateCommand();
                    command.CommandText = batch;
                    command.CommandTimeout = 0;
                    await command.ExecuteNonQueryAsync();
                }
                return;
            }

            context.Database.SetCommandTimeout(0);

            foreach (var batch in batches)
                await context.Database.ExecuteSqlRawAsync(batch);
        }

        static DataProviders GetDataProvider(SalesContext context) =>
            DataProvidersExtensions.FromEFProviderName(context.Database.ProviderName);

        static async Task<string> ReadEmbeddedScriptAsync(string resourceName) {
            var assembly = Assembly.GetExecutingAssembly();
            using var stream = assembly.GetManifestResourceStream(resourceName);
            if (stream == null)
                throw new InvalidOperationException($"Embedded resource '{resourceName}' was not found.");

            using var reader = new StreamReader(stream);
            return await reader.ReadToEndAsync();
        }
    }
}
