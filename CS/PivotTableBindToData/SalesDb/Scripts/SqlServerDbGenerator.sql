IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL
    DROP TABLE dbo.Sales;
GO

CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    StoreNumber INT NOT NULL,
    SaleDate DATE NOT NULL,
    [Year]  AS (datepart(year,CONVERT([date],[SaleDate]))) PERSISTED,
    [Quarter]  AS (datepart(quarter,CONVERT([date],[SaleDate]))) PERSISTED,
    Amount DECIMAL(18, 2) NOT NULL,
    [StoreName] [nvarchar](100) NULL
);

SET NOCOUNT ON;

-- 1. Prepare base date variables (from 2007-01-01 to 2025-12-31)
DECLARE @CurrentDate DATE = '2007-01-01';
DECLARE @EndDate DATE = '2025-12-31';

-- 2. Create a temporary table with a list of all 122 stores to speed up querying
IF OBJECT_ID('tempdb..#Stores') IS NOT NULL DROP TABLE #Stores;
CREATE TABLE #Stores (StoreNumber INT);

DECLARE @i INT = 1;
WHILE @i <= 122
BEGIN
    INSERT INTO #Stores (StoreNumber) VALUES (@i);
    SET @i = @i + 1;
END

-- Open a transaction to significantly speed up bulk inserts (executemany)
BEGIN TRAN;

-- 3. Loop through days
WHILE @CurrentDate <= @EndDate
BEGIN
    -- Random number of active stores on this day: from 2 to 122
    DECLARE @NumActiveStores INT = ABS(CHECKSUM(NEWID())) % 121 + 2;

    -- Bulk generate and insert data for the current day
    INSERT INTO Sales (StoreNumber, SaleDate, Amount)
    SELECT 
        s.StoreNumber,
        @CurrentDate,
        -- Generate a receipt amount from $15.00 to $950.00. 
        -- RAND(CHECKSUM(NEWID())) is used to recalculate the value for each row
        ROUND(15.0 + (RAND(CHECKSUM(NEWID())) * (950.0 - 15.0)), 2) AS Amount
    FROM (
        -- Select a random sample of stores (random.sample)
        SELECT TOP (@NumActiveStores) StoreNumber 
        FROM #Stores 
        ORDER BY NEWID()
    ) s
    CROSS APPLY (
        -- Generate from 1 to 4 transactions for each selected store (random.randint)
        SELECT TOP (ABS(CHECKSUM(NEWID())) % 4 + 1) 1 AS TransCount
        FROM (VALUES (1), (2), (3), (4)) AS t(N)
    ) trans;

    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END

COMMIT TRAN;

DROP TABLE #Stores;

update [Sales] set [StoreName] = 'Contoso Canberra Store' where [StoreNumber] = 1
update [Sales] set [StoreName] = 'Contoso Asia Online Store' where [StoreNumber] = 2
update [Sales] set [StoreName] = 'Contoso Asia Reseller' where [StoreNumber] = 3
update [Sales] set [StoreName] = 'Contoso Yerevan Store' where [StoreNumber] = 4
update [Sales] set [StoreName] = 'Contoso Baildon Store' where [StoreNumber] = 5
update [Sales] set [StoreName] = 'Contoso Carlisle Store' where [StoreNumber] = 6
update [Sales] set [StoreName] = 'Contoso Cheshire Store' where [StoreNumber] = 7
update [Sales] set [StoreName] = 'Contoso Edinburgh Store' where [StoreNumber] = 8
update [Sales] set [StoreName] = 'Contoso Glasgow Store' where [StoreNumber] = 9
update [Sales] set [StoreName] = 'Contoso Knotty Ash Store' where [StoreNumber] = 10
update [Sales] set [StoreName] = 'Contoso Lancashire Store' where [StoreNumber] = 11
update [Sales] set [StoreName] = 'Contoso Leeds Store' where [StoreNumber] = 12
update [Sales] set [StoreName] = 'Contoso Liverpool Store' where [StoreNumber] = 13
update [Sales] set [StoreName] = 'Contoso Manchester Store' where [StoreNumber] = 14
update [Sales] set [StoreName] = 'Contoso Northampton Store' where [StoreNumber] = 15
update [Sales] set [StoreName] = 'Contoso West Yorkshire Store' where [StoreNumber] = 16
update [Sales] set [StoreName] = 'Contoso York Store' where [StoreNumber] = 17
update [Sales] set [StoreName] = 'Contoso Baumholder Store' where [StoreNumber] = 18
update [Sales] set [StoreName] = 'Contoso Berlin Store' where [StoreNumber] = 19
update [Sales] set [StoreName] = 'Contoso Dusseldorf Store' where [StoreNumber] = 20
update [Sales] set [StoreName] = 'Contoso Giebelstadt Store' where [StoreNumber] = 21
update [Sales] set [StoreName] = 'Contoso Hofheim Store' where [StoreNumber] = 22
update [Sales] set [StoreName] = 'Contoso Landstuhl Store' where [StoreNumber] = 23
update [Sales] set [StoreName] = 'Contoso Minden Store' where [StoreNumber] = 24
update [Sales] set [StoreName] = 'Contoso Munich Store' where [StoreNumber] = 25
update [Sales] set [StoreName] = 'Contoso Catalog Store' where [StoreNumber] = 26
update [Sales] set [StoreName] = 'Contoso Athens Store' where [StoreNumber] = 27
update [Sales] set [StoreName] = 'Contoso Copenhagen Store' where [StoreNumber] = 28
update [Sales] set [StoreName] = 'Contoso Europe Online Store' where [StoreNumber] = 29
update [Sales] set [StoreName] = 'Contoso Europe Reseller' where [StoreNumber] = 30
update [Sales] set [StoreName] = 'Contoso Kolkata Store' where [StoreNumber] = 31
update [Sales] set [StoreName] = 'Contoso Mumbai Store' where [StoreNumber] = 32
update [Sales] set [StoreName] = 'Contoso New Delhi Store' where [StoreNumber] = 33
update [Sales] set [StoreName] = 'Contoso Dublin Store' where [StoreNumber] = 34
update [Sales] set [StoreName] = 'Contoso Madrid Store' where [StoreNumber] = 35
update [Sales] set [StoreName] = 'Contoso Firenze Store' where [StoreNumber] = 36
update [Sales] set [StoreName] = 'Contoso Milan Store' where [StoreNumber] = 37
update [Sales] set [StoreName] = 'Contoso Roma Store' where [StoreNumber] = 38
update [Sales] set [StoreName] = 'Contoso Torino Store' where [StoreNumber] = 39
update [Sales] set [StoreName] = 'Contoso Venezia Store' where [StoreNumber] = 40
update [Sales] set [StoreName] = 'Contoso Calgary  Store' where [StoreNumber] = 41
update [Sales] set [StoreName] = 'Contoso Bishkek Store' where [StoreNumber] = 42
update [Sales] set [StoreName] = 'Contoso Valletta Store' where [StoreNumber] = 43
update [Sales] set [StoreName] = 'Contoso Amsterdam Store' where [StoreNumber] = 44
update [Sales] set [StoreName] = 'Contoso Warsaw Store' where [StoreNumber] = 45
update [Sales] set [StoreName] = 'Contoso Lisbon Store' where [StoreNumber] = 46
update [Sales] set [StoreName] = 'Contoso Bucharest Store' where [StoreNumber] = 47
update [Sales] set [StoreName] = 'Contoso North America Online Store' where [StoreNumber] = 48
update [Sales] set [StoreName] = 'Contoso North America Reseller' where [StoreNumber] = 49
update [Sales] set [StoreName] = 'Contoso Singapore Store' where [StoreNumber] = 50
update [Sales] set [StoreName] = 'Contoso Ljubljana Store' where [StoreNumber] = 51
update [Sales] set [StoreName] = 'Contoso Alexandria Store' where [StoreNumber] = 52
update [Sales] set [StoreName] = 'Contoso Attleboro Store' where [StoreNumber] = 53
update [Sales] set [StoreName] = 'Contoso Austin Store' where [StoreNumber] = 54
update [Sales] set [StoreName] = 'Contoso Bacliff Store' where [StoreNumber] = 55
update [Sales] set [StoreName] = 'Contoso Bangor Store' where [StoreNumber] = 56
update [Sales] set [StoreName] = 'Contoso Bellevue Store' where [StoreNumber] = 57
update [Sales] set [StoreName] = 'Contoso Boston Store' where [StoreNumber] = 58
update [Sales] set [StoreName] = 'Contoso Buffalo Store' where [StoreNumber] = 59
update [Sales] set [StoreName] = 'Contoso Cambridge Store' where [StoreNumber] = 60
update [Sales] set [StoreName] = 'Contoso Cape May Store' where [StoreNumber] = 61
update [Sales] set [StoreName] = 'Contoso Cedar Park Store' where [StoreNumber] = 62
update [Sales] set [StoreName] = 'Contoso Charlottesville Store' where [StoreNumber] = 63
update [Sales] set [StoreName] = 'Contoso Dallas Store' where [StoreNumber] = 64
update [Sales] set [StoreName] = 'Contoso Edgerton Store' where [StoreNumber] = 65
update [Sales] set [StoreName] = 'Contoso Fall City Store' where [StoreNumber] = 66
update [Sales] set [StoreName] = 'Contoso Fond du Lac Store' where [StoreNumber] = 67
update [Sales] set [StoreName] = 'Contoso Fort Collins Store' where [StoreNumber] = 68
update [Sales] set [StoreName] = 'Contoso Fort Worth Store' where [StoreNumber] = 69
update [Sales] set [StoreName] = 'Contoso Fredericksburg Store' where [StoreNumber] = 70
update [Sales] set [StoreName] = 'Contoso Germantown Store' where [StoreNumber] = 71
update [Sales] set [StoreName] = 'Contoso Grand Prairie Store' where [StoreNumber] = 72
update [Sales] set [StoreName] = 'Contoso Haverhill Store' where [StoreNumber] = 73
update [Sales] set [StoreName] = 'Contoso Holyoke Store' where [StoreNumber] = 74
update [Sales] set [StoreName] = 'Contoso Humble Store' where [StoreNumber] = 75
update [Sales] set [StoreName] = 'Contoso Jacksonville Store' where [StoreNumber] = 76
update [Sales] set [StoreName] = 'Contoso Kennebunkport Store' where [StoreNumber] = 77
update [Sales] set [StoreName] = 'Contoso Key West Store' where [StoreNumber] = 78
update [Sales] set [StoreName] = 'Contoso Lafayette Store' where [StoreNumber] = 79
update [Sales] set [StoreName] = 'Contoso Leominster Store' where [StoreNumber] = 80
update [Sales] set [StoreName] = 'Contoso Lewisville Store' where [StoreNumber] = 81
update [Sales] set [StoreName] = 'Contoso Littleton Store' where [StoreNumber] = 82
update [Sales] set [StoreName] = 'Contoso Loveland Store' where [StoreNumber] = 83
update [Sales] set [StoreName] = 'Contoso Martinsville Store' where [StoreNumber] = 84
update [Sales] set [StoreName] = 'Contoso Montclair Store' where [StoreNumber] = 85
update [Sales] set [StoreName] = 'Contoso Nantucket Store' where [StoreNumber] = 86
update [Sales] set [StoreName] = 'Contoso New Brunswick Store' where [StoreNumber] = 87
update [Sales] set [StoreName] = 'Contoso New Haven Store' where [StoreNumber] = 88
update [Sales] set [StoreName] = 'Contoso Norfolk Store' where [StoreNumber] = 89
update [Sales] set [StoreName] = 'Contoso North Harford Store' where [StoreNumber] = 90
update [Sales] set [StoreName] = 'Contoso Orlando Store' where [StoreNumber] = 91
update [Sales] set [StoreName] = 'Contoso Oshkosh Store' where [StoreNumber] = 92
update [Sales] set [StoreName] = 'Contoso Parker Store' where [StoreNumber] = 93
update [Sales] set [StoreName] = 'Contoso Pasadena Store' where [StoreNumber] = 94
update [Sales] set [StoreName] = 'Contoso Paterson Store' where [StoreNumber] = 95
update [Sales] set [StoreName] = 'Contoso Poestenkill Store' where [StoreNumber] = 96
update [Sales] set [StoreName] = 'Contoso Provincetown Store' where [StoreNumber] = 97
update [Sales] set [StoreName] = 'Contoso Queens Store' where [StoreNumber] = 98
update [Sales] set [StoreName] = 'Contoso Redmond Store' where [StoreNumber] = 99
update [Sales] set [StoreName] = 'Contoso Richardson Store' where [StoreNumber] = 100
update [Sales] set [StoreName] = 'Contoso Roanoke Store' where [StoreNumber] = 101
update [Sales] set [StoreName] = 'Contoso Sheboygan Store' where [StoreNumber] = 102
update [Sales] set [StoreName] = 'Contoso South Portland Store' where [StoreNumber] = 103
update [Sales] set [StoreName] = 'Contoso Spring Store' where [StoreNumber] = 104
update [Sales] set [StoreName] = 'Contoso Sunnyside Store' where [StoreNumber] = 105
update [Sales] set [StoreName] = 'Contoso Thornton Store' where [StoreNumber] = 106
update [Sales] set [StoreName] = 'Contoso Virginia Beach Store' where [StoreNumber] = 107
update [Sales] set [StoreName] = 'Contoso Waterbury Store' where [StoreNumber] = 108
update [Sales] set [StoreName] = 'Contoso Wheat Ridge Store' where [StoreNumber] = 109
update [Sales] set [StoreName] = 'Contoso Yakima Store' where [StoreNumber] = 110
update [Sales] set [StoreName] = 'Contoso Lyon Store' where [StoreNumber] = 111
update [Sales] set [StoreName] = 'Contoso Marseille Store' where [StoreNumber] = 112
update [Sales] set [StoreName] = 'Contoso Nice Store' where [StoreNumber] = 113
update [Sales] set [StoreName] = 'Contoso Strasbourg Store' where [StoreNumber] = 114
update [Sales] set [StoreName] = 'Contoso Toulouse Store' where [StoreNumber] = 115
update [Sales] set [StoreName] = 'Contoso Berne Store' where [StoreNumber] = 116
update [Sales] set [StoreName] = 'Contoso Stockholm Store' where [StoreNumber] = 117
update [Sales] set [StoreName] = 'Contoso Busan Store' where [StoreNumber] = 118
update [Sales] set [StoreName] = 'Contoso Seoul Store' where [StoreNumber] = 119
update [Sales] set [StoreName] = 'Contoso Kyoto Store' where [StoreNumber] = 120
update [Sales] set [StoreName] = 'Contoso Sapporo Store' where [StoreNumber] = 121
update [Sales] set [StoreName] = 'Contoso Yokohama Store' where [StoreNumber] = 122



-- Indexes covering the grouping/aggregation used by the pivot table
-- (Row: StoreName, Columns: Year/Quarter, Data: Amount, Count: SaleID).
CREATE NONCLUSTERED INDEX [IX_Sales_Pivot_Full] ON [dbo].[Sales]
(
    [StoreName] ASC,
    [Year]      ASC,
    [Quarter]   ASC
)
INCLUDE ([Amount], [SaleID])
WITH (PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON);
GO

CREATE NONCLUSTERED INDEX [IX_Sales_SaleDate] ON [dbo].[Sales]
(
    [SaleDate] ASC
)
INCLUDE ([StoreName], [Amount], [SaleID])
WITH (PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON);
GO

CREATE NONCLUSTERED INDEX [IX_Sales_Year_Quarter] ON [dbo].[Sales]
(
    [Year]    ASC,
    [Quarter] ASC
)
INCLUDE ([StoreName], [Amount], [SaleID])
WITH (PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON);
GO

PRINT 'Data generation successfully completed!';
