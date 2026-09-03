using Microsoft.EntityFrameworkCore;
using PivotTableBindToData.SalesDb;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddDevExpressBlazor();


var dataProviderSetting = builder.Configuration.GetValue("DataProvider", DataProviders.SQLite.ToString());
if (!Enum.TryParse(dataProviderSetting, ignoreCase: true, out DataProviders dataProvider)) {
    dataProvider = DataProviders.SQLite;
}

if (dataProvider == DataProviders.SQLite) {
    builder.Services.AddDbContextFactory<SalesContext>((sp, options) => {
        var env = sp.GetRequiredService<IWebHostEnvironment>();
        var dbPath = Path.Combine(env.ContentRootPath, "sales.db");
        options.UseSqlite("Data Source=" + dbPath);
    });
}
else if (dataProvider == DataProviders.SqlServer) {
    builder.Services.AddDbContextFactory<SalesContext>(options => {
        options.UseSqlServer(builder.Configuration.GetConnectionString("SalesDatabase"));
    });
}
else {
    throw new InvalidOperationException($"Unsupported data provider: '{dataProvider}'. Supported values are '{DataProviders.SQLite}' and '{DataProviders.SqlServer}'.");
}



var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();


app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
