DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    SaleID INTEGER PRIMARY KEY AUTOINCREMENT,
    StoreNumber INTEGER NOT NULL,
    SaleDate TEXT NOT NULL,
    Year INTEGER GENERATED ALWAYS AS (CAST(strftime('%Y', SaleDate) AS INTEGER)) STORED,
    Quarter INTEGER GENERATED ALWAYS AS ((CAST(strftime('%m', SaleDate) AS INTEGER) + 2) / 3) STORED,
    Amount REAL NOT NULL,
    StoreName TEXT NULL
);

BEGIN TRANSACTION;

WITH RECURSIVE
Dates(SaleDate) AS (
    VALUES('2007-01-01')
    UNION ALL
    SELECT date(SaleDate, '+1 day')
    FROM Dates
    WHERE SaleDate < '2025-12-31'
),
Stores(StoreNumber) AS (
    VALUES(1)
    UNION ALL
    SELECT StoreNumber + 1
    FROM Stores
    WHERE StoreNumber < 122
),
DayActivity AS (
    SELECT SaleDate, abs(random()) % 121 + 2 AS NumActiveStores
    FROM Dates
),
RandomizedStores AS (
    SELECT
        d.SaleDate,
        s.StoreNumber,
        ROW_NUMBER() OVER (PARTITION BY d.SaleDate ORDER BY random()) AS rn
    FROM DayActivity d
    CROSS JOIN Stores s
),
ActiveStores AS (
    SELECT
        rs.SaleDate,
        rs.StoreNumber,
        abs(random()) % 4 + 1 AS TransCount
    FROM RandomizedStores rs
    JOIN DayActivity d ON d.SaleDate = rs.SaleDate
    WHERE rs.rn <= d.NumActiveStores
),
Transactions(SaleDate, StoreNumber, TxNo, TransCount) AS (
    SELECT SaleDate, StoreNumber, 1, TransCount
    FROM ActiveStores
    UNION ALL
    SELECT SaleDate, StoreNumber, TxNo + 1, TransCount
    FROM Transactions
    WHERE TxNo < TransCount
)
INSERT INTO Sales (StoreNumber, SaleDate, Amount)
SELECT
    StoreNumber,
    SaleDate,
    ROUND(15.0 + ((abs(random()) / 9223372036854775807.0) * (950.0 - 15.0)), 2) AS Amount
FROM Transactions;

COMMIT;

WITH StoreNames(StoreNumber, StoreName) AS (
    VALUES
        (1, 'Contoso Canberra Store'),
        (2, 'Contoso Asia Online Store'),
        (3, 'Contoso Asia Reseller'),
        (4, 'Contoso Yerevan Store'),
        (5, 'Contoso Baildon Store'),
        (6, 'Contoso Carlisle Store'),
        (7, 'Contoso Cheshire Store'),
        (8, 'Contoso Edinburgh Store'),
        (9, 'Contoso Glasgow Store'),
        (10, 'Contoso Knotty Ash Store'),
        (11, 'Contoso Lancashire Store'),
        (12, 'Contoso Leeds Store'),
        (13, 'Contoso Liverpool Store'),
        (14, 'Contoso Manchester Store'),
        (15, 'Contoso Northampton Store'),
        (16, 'Contoso West Yorkshire Store'),
        (17, 'Contoso York Store'),
        (18, 'Contoso Baumholder Store'),
        (19, 'Contoso Berlin Store'),
        (20, 'Contoso Dusseldorf Store'),
        (21, 'Contoso Giebelstadt Store'),
        (22, 'Contoso Hofheim Store'),
        (23, 'Contoso Landstuhl Store'),
        (24, 'Contoso Minden Store'),
        (25, 'Contoso Munich Store'),
        (26, 'Contoso Catalog Store'),
        (27, 'Contoso Athens Store'),
        (28, 'Contoso Copenhagen Store'),
        (29, 'Contoso Europe Online Store'),
        (30, 'Contoso Europe Reseller'),
        (31, 'Contoso Kolkata Store'),
        (32, 'Contoso Mumbai Store'),
        (33, 'Contoso New Delhi Store'),
        (34, 'Contoso Dublin Store'),
        (35, 'Contoso Madrid Store'),
        (36, 'Contoso Firenze Store'),
        (37, 'Contoso Milan Store'),
        (38, 'Contoso Roma Store'),
        (39, 'Contoso Torino Store'),
        (40, 'Contoso Venezia Store'),
        (41, 'Contoso Calgary  Store'),
        (42, 'Contoso Bishkek Store'),
        (43, 'Contoso Valletta Store'),
        (44, 'Contoso Amsterdam Store'),
        (45, 'Contoso Warsaw Store'),
        (46, 'Contoso Lisbon Store'),
        (47, 'Contoso Bucharest Store'),
        (48, 'Contoso North America Online Store'),
        (49, 'Contoso North America Reseller'),
        (50, 'Contoso Singapore Store'),
        (51, 'Contoso Ljubljana Store'),
        (52, 'Contoso Alexandria Store'),
        (53, 'Contoso Attleboro Store'),
        (54, 'Contoso Austin Store'),
        (55, 'Contoso Bacliff Store'),
        (56, 'Contoso Bangor Store'),
        (57, 'Contoso Bellevue Store'),
        (58, 'Contoso Boston Store'),
        (59, 'Contoso Buffalo Store'),
        (60, 'Contoso Cambridge Store'),
        (61, 'Contoso Cape May Store'),
        (62, 'Contoso Cedar Park Store'),
        (63, 'Contoso Charlottesville Store'),
        (64, 'Contoso Dallas Store'),
        (65, 'Contoso Edgerton Store'),
        (66, 'Contoso Fall City Store'),
        (67, 'Contoso Fond du Lac Store'),
        (68, 'Contoso Fort Collins Store'),
        (69, 'Contoso Fort Worth Store'),
        (70, 'Contoso Fredericksburg Store'),
        (71, 'Contoso Germantown Store'),
        (72, 'Contoso Grand Prairie Store'),
        (73, 'Contoso Haverhill Store'),
        (74, 'Contoso Holyoke Store'),
        (75, 'Contoso Humble Store'),
        (76, 'Contoso Jacksonville Store'),
        (77, 'Contoso Kennebunkport Store'),
        (78, 'Contoso Key West Store'),
        (79, 'Contoso Lafayette Store'),
        (80, 'Contoso Leominster Store'),
        (81, 'Contoso Lewisville Store'),
        (82, 'Contoso Littleton Store'),
        (83, 'Contoso Loveland Store'),
        (84, 'Contoso Martinsville Store'),
        (85, 'Contoso Montclair Store'),
        (86, 'Contoso Nantucket Store'),
        (87, 'Contoso New Brunswick Store'),
        (88, 'Contoso New Haven Store'),
        (89, 'Contoso Norfolk Store'),
        (90, 'Contoso North Harford Store'),
        (91, 'Contoso Orlando Store'),
        (92, 'Contoso Oshkosh Store'),
        (93, 'Contoso Parker Store'),
        (94, 'Contoso Pasadena Store'),
        (95, 'Contoso Paterson Store'),
        (96, 'Contoso Poestenkill Store'),
        (97, 'Contoso Provincetown Store'),
        (98, 'Contoso Queens Store'),
        (99, 'Contoso Redmond Store'),
        (100, 'Contoso Richardson Store'),
        (101, 'Contoso Roanoke Store'),
        (102, 'Contoso Sheboygan Store'),
        (103, 'Contoso South Portland Store'),
        (104, 'Contoso Spring Store'),
        (105, 'Contoso Sunnyside Store'),
        (106, 'Contoso Thornton Store'),
        (107, 'Contoso Virginia Beach Store'),
        (108, 'Contoso Waterbury Store'),
        (109, 'Contoso Wheat Ridge Store'),
        (110, 'Contoso Yakima Store'),
        (111, 'Contoso Lyon Store'),
        (112, 'Contoso Marseille Store'),
        (113, 'Contoso Nice Store'),
        (114, 'Contoso Strasbourg Store'),
        (115, 'Contoso Toulouse Store'),
        (116, 'Contoso Berne Store'),
        (117, 'Contoso Stockholm Store'),
        (118, 'Contoso Busan Store'),
        (119, 'Contoso Seoul Store'),
        (120, 'Contoso Kyoto Store'),
        (121, 'Contoso Sapporo Store'),
        (122, 'Contoso Yokohama Store')
)
UPDATE Sales
SET StoreName = (
    SELECT sn.StoreName
    FROM StoreNames sn
    WHERE sn.StoreNumber = Sales.StoreNumber
)
WHERE StoreNumber IN (SELECT StoreNumber FROM StoreNames);


-- Indexes covering the grouping/aggregation used by the pivot table
-- (Row: StoreName, Columns: Year/Quarter, Data: Amount, Count: SaleID).
CREATE INDEX IX_Sales_Pivot_Full ON Sales (StoreName, Year, Quarter);
CREATE INDEX IX_Sales_SaleDate ON Sales (SaleDate);
CREATE INDEX IX_Sales_Year_Quarter ON Sales (Year, Quarter);

SELECT 'Data generation successfully completed!';
