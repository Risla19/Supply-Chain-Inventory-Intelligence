
USE SupplyChainDB;
GO

-- Task 1: Find the 10 lowest-stock records

SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Reorder_Point
FROM dbo.supply_chain_import_test
ORDER BY Inventory_Level ASC;


-- Task 2: Calculate total inventory value by warehouse

SELECT
    Warehouse_ID,
    SUM(Inventory_Level * Unit_Cost) AS Total_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Total_Inventory_Value DESC;


-- Task 3: Calculate average inventory by SKU

SELECT
    SKU_ID,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2))) AS Average_Inventory
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Average_Inventory ASC;


-- Task 4: Count records by inventory risk category

SELECT
    CASE
        WHEN Inventory_Level < Reorder_Point THEN 'Below Reorder Point'
        WHEN Inventory_Level = Reorder_Point THEN 'At Reorder Point'
        ELSE 'Above Reorder Point'
    END AS Inventory_Risk,
    COUNT(*) AS Record_Count
FROM dbo.supply_chain_import_test
GROUP BY
    CASE
        WHEN Inventory_Level < Reorder_Point THEN 'Below Reorder Point'
        WHEN Inventory_Level = Reorder_Point THEN 'At Reorder Point'
        ELSE 'Above Reorder Point'
    END
ORDER BY Record_Count DESC;


-- Task 5: Create a combined warehouse inventory summary

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Records,
    SUM(Inventory_Level) AS Total_Inventory_Units,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2))) AS Average_Inventory,
    SUM(Inventory_Level * Unit_Cost) AS Total_Inventory_Value,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Below_Reorder_Records DESC;
