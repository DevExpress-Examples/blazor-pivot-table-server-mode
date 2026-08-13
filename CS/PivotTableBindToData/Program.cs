using PivotTableBindToData.Data;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.EntityFrameworkCore;
using PivotTableBindToData.Northwind;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddDevExpressBlazor();
builder.Services.AddSingleton<WeatherForecastService>();


bool UseSqlite = true; // Set to false to use SQL Server

if (UseSqlite) {
    // SQLITE:
    builder.Services.AddDbContextFactory<NorthwindContext>((sp, options) => {
        var env = sp.GetRequiredService<IWebHostEnvironment>();
        //var dbPath = Path.Combine(env.ContentRootPath, "Northwind.db");
        var dbPath = Path.Combine(env.ContentRootPath, "sales.db");
        options.UseSqlite("Data Source=" + dbPath);
    });
}
else {
    // SQL SERVER:
    builder.Services.AddDbContextFactory<NorthwindContext>(options => {
        options.UseSqlServer(builder.Configuration.GetConnectionString("Northwind"));
    });
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
