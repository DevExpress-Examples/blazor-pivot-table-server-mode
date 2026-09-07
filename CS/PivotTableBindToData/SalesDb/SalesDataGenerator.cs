using System.Reflection;
using System.Text.RegularExpressions;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace PivotTableBindToData.SalesDb {
    public static class SalesDataGenerator {

        public static async Task<bool> SalesTableExistsAsync(SalesContext context) {
            try {
                await context.Sales.Select(s => s.SaleId).Take(1).ToListAsync();
                return true;
            }
            catch {
                return false;
            }
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
                .Where(batch => batch.Length > 0);

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
