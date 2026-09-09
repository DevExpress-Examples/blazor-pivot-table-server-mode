using System.Reflection;
using System.Text.RegularExpressions;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage;

#nullable disable

namespace PivotTableBindToData.SalesDb {
    public static class SalesDataGenerator {

        public static async Task<bool> SalesTableExistsAsync(SalesContext context) {
            var databaseCreator = context.GetService<IRelationalDatabaseCreator>();
            return await databaseCreator.HasTablesAsync();
        }

        public static async Task GenerateAsync(SalesContext context, string dataProvider) {
            string resourceName = dataProvider switch {
                nameof(DataProviders.SQLite) => "PivotTableBindToData.SalesDb.Scripts.SQLiteDbGenerator.sql",
                nameof(DataProviders.SqlServer) => "PivotTableBindToData.SalesDb.Scripts.SqlServerDbGenerator.sql",
                _ => ""
            };

            string script = await ReadEmbeddedScriptAsync(resourceName);

            var batches = Regex.Split(script, @"^\s*GO\s*$", RegexOptions.Multiline | RegexOptions.IgnoreCase)
                .Select(batch => batch.Trim())
                .Where(batch => batch.Length > 0)
                .ToList();

            if (dataProvider == nameof(DataProviders.SqlServer)) {
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
