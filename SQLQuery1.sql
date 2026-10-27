--Task 1
USE SupplyChainDB;
GO

SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    [Date],
    Inventory_Level
FROM dbo.supply_chain_import_test
ORDER BY Inventory_Level ASC;

--Task 2
SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    Inventory_Level
FROM dbo.supply_chain_import_test
ORDER BY Inventory_Level ASC;

--Task 3
SELECT
    SKU_ID,
    Warehouse_ID,
    Inventory_Level
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < 100
ORDER BY Inventory_Level ASC;


--Task 4
SELECT
    Warehouse_ID,
    AVG(Inventory_Level) AS AverageInventory,
    MIN(Inventory_Level) AS LowestInventory,
    MAX(Inventory_Level) AS HighestInventory
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY AverageInventory DESC;

--Task 5
SELECT
    Warehouse_ID,
    SUM(Inventory_Level) AS TotalInventory
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY TotalInventory DESC;

--Task 6
SELECT
    Warehouse_ID,
    COUNT(*) AS LowStockRecords,
    AVG(Inventory_Level) AS AverageLowStock
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < 100
GROUP BY Warehouse_ID
ORDER BY LowStockRecords DESC;

