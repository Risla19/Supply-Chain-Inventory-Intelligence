--Task 1
SELECT
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Unit_Cost
FROM dbo.supply_chain_import_test
WHERE Warehouse_ID = 'WH_1'
ORDER BY Inventory_Level ASC;

--Task 2
SELECT
    SKU_ID,
    SUM(Inventory_Level) AS TotalInventory
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY TotalInventory ASC;

--Task 3
SELECT
    Warehouse_ID,
    SUM(Inventory_Level * Unit_Cost) AS TotalInventoryValue
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY TotalInventoryValue DESC;

--Task 4
SELECT
    SKU_ID,
    AVG(Unit_Cost) AS AverageUnitCost
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY AverageUnitCost DESC;

--Task 5
SELECT
    Warehouse_ID,
    MAX(Unit_Cost) AS HighestUnitCost
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY HighestUnitCost DESC;