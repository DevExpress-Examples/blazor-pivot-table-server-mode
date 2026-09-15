<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/1306596060/26.1.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T1332466)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
[![](https://img.shields.io/badge/💬_Leave_Feedback-feecdd?style=flat-square)](#does-this-example-address-your-development-requirementsobjectives)
<!-- default badges end -->
# Blazor Pivot Table – Server Mode Data Processing

This example binds the [DevExpress Blazor Pivot Table](https://docs.devexpress.com/Blazor/405245/components/pivot-table) component to a server mode data source. The data source loads data in small chunks on demand and delegates data shaping operations to [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/). Server Mode reduces memory consumption and improves overall performance when working with large collections.

![Bind DevExpress Blazor Pivot Table to Data with Entity Framework Core](/images/bind-to-data.png)

Refer to the following topic for additional information: [Bind the Pivot Table to Data](https://docs.devexpress.com/Blazor/405475/components/pivottable/bind-to-data).

## Quick Start

The example requires a specific SQLite/SQL Server database file. On the first run (and whenever the file is missing), the application displays a **Generate Data** button. Click the button to create the database and proceed.

This example binds the DevExpress Blazor Pivot Table to an SQLite database. To use a SQL Server database, set the `DataProvider` setting to `SqlServer` in [appsettings.json](./CS/PivotTableBindToData/appsettings.json).


## Files to Review

- [Index.razor](./CS/PivotTableBindToData/Pages/Index.razor)
- [Program.cs](./CS/PivotTableBindToData/Program.cs)
- [SalesDataGenerator.cs](./CS/PivotTableBindToData/SalesDb/SalesDataGenerator.cs)

## Documentation

- [Get Started with the Pivot Table](https://docs.devexpress.com/Blazor/405246/components/pivottable/get-started-with-pivottable)
- [Bind the Pivot Table to Data](https://docs.devexpress.com/Blazor/405475/components/pivottable/bind-to-data)
- [Bind Blazor Components to Data with Entity Framework Core](https://docs.devexpress.com/Blazor/403167/common-concepts/data-binding/bind-components-to-data-with-entity-framework-core)

<!-- feedback -->
## Does This Example Address Your Development Requirements/Objectives?

[<img src="https://www.devexpress.com/support/examples/i/yes-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=draft-blazor-pivot-table-server-mode&~~~was_helpful=yes) [<img src="https://www.devexpress.com/support/examples/i/no-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=draft-blazor-pivot-table-server-mode&~~~was_helpful=no)

(you will be redirected to DevExpress.com to submit your response)
<!-- feedback end -->
