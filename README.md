<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/1306596060/26.1.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T1332466)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
[![](https://img.shields.io/badge/💬_Leave_Feedback-feecdd?style=flat-square)](#does-this-example-address-your-development-requirementsobjectives)
<!-- default badges end -->
# Blazor Pivot Table – Data binding using Entity Framework Core in Server Mode

This example uses [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/) to bind the [DevExpress Blazor Pivot Table](https://docs.devexpress.com/Blazor/405245/components/pivot-table) to data in Server Mode. This example supports SQLite and SQL Server. The database engine is sonfigured in the `appsettings.json` file.

![Bind DevExpress Blazor Pivot Table to Data with Entity Framework Core](/images/bind-to-data.png)

## Files to Review

- [Index.razor](./CS/PivotTableBindToData/Pages/Index.razor)
- [Program.cs](./CS/PivotTableBindToData/Program.cs)
- [SalesDataGenerator.cs](./CS/PivotTableBindToData/SalesDb/SalesDataGenerator.cs)

If the `Sales` table (or the database file) is not found, the page displays a **Generate data**
button instead of the Pivot Table. After confirmation, the app runs the SQL script that matches
the configured data provider (SQLite or SQL Server) to create the table and populate it with around
1,000,000 sample rows.

## Documentation

- [Bind Blazor Components to Data with Entity Framework Core](https://docs.devexpress.com/Blazor/403167/common-concepts/data-binding/bind-components-to-data-with-entity-framework-core)
- [Get Started with the Pivot Table](https://docs.devexpress.com/Blazor/405246/components/pivottable/get-started-with-pivottable)
- [Bind the Pivot Table to Data](https://docs.devexpress.com/Blazor/405475/components/pivottable/bind-to-data)

<!-- feedback -->
## Does This Example Address Your Development Requirements/Objectives?

[<img src="https://www.devexpress.com/support/examples/i/yes-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=draft-blazor-pivot-table-server-mode&~~~was_helpful=yes) [<img src="https://www.devexpress.com/support/examples/i/no-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=draft-blazor-pivot-table-server-mode&~~~was_helpful=no)

(you will be redirected to DevExpress.com to submit your response)
<!-- feedback end -->


