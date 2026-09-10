using System;

namespace PivotTableBindToData.SalesDb {
    public enum DataProviders {
        SQLite,
        SqlServer
    }

    public static class DataProvidersExtensions {
        public static DataProviders FromEFProviderName(string efProviderName) => efProviderName switch {
            "Microsoft.EntityFrameworkCore.Sqlite" => DataProviders.SQLite,
            "Microsoft.EntityFrameworkCore.SqlServer" => DataProviders.SqlServer,
            _ => throw new NotSupportedException($"Unsupported database provider: '{efProviderName}'.")
        };
    }
}
