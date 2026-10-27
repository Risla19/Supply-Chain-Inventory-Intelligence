-- Day 14, Task 1: Find the 10 lowest-stock records

USE SupplyChainDB;
GO
SELECT TOP 10
SKU_ID,
WareHouse_ID,
Inventory_Level,
Reorder_Point
FROM dbo.supply_chain_import_test
ORDER BY Inventory_Level ASC;

-- Task 2: Rank inventory records from lowest to highest

SELECT
SKU_ID,
Warehouse_ID,
Inventory_Level,
RANK() OVER(
ORDER BY Inventory_Level ASC
) AS Inventory_Rank
FROM dbo.supply_chain_import_test;

-- Task 3: Find the 10 highest-stock records

SELECT TOP 10
SKU_ID,
Warehouse_ID,
Inventory_Level,
Reorder_Point
FROM dbo.supply_chain_import_test
ORDER BY Inventory_Level DESC;

-- Task 4: Find products closest to their reorder point

SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Reorder_Point,
    Inventory_Level - Reorder_Point AS Stock_Difference
FROM dbo.supply_chain_import_test
WHERE Inventory_Level <> Reorder_Point;

-- Task 5: Calculate average inventory by warehouse

SELECT
    Warehouse_ID,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2))) AS Average_Inventory,
    MIN(Inventory_Level) AS Lowest_Inventory,
    MAX(Inventory_Level) AS Highest_Inventory
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Average_Inventory DESC;