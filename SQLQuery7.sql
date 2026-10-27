
USE SupplyChainDB;
GO

-- Task 1: Find the 10 products with the highest total inventory value

SELECT TOP 10
    SKU_ID,
    SUM(Inventory_Level * Unit_Cost) AS Total_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Total_Inventory_Value DESC;


-- Task 2: Find the 10 products with the lowest total inventory value

SELECT TOP 10
    SKU_ID,
    SUM(Inventory_Level * Unit_Cost) AS Total_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Total_Inventory_Value ASC;


-- Task 3: Compare average inventory value by warehouse

SELECT
    Warehouse_ID,
    AVG(CAST(Inventory_Level * Unit_Cost AS DECIMAL(18,2)))
        AS Average_Record_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Average_Record_Inventory_Value DESC;


-- Task 4: Count below-reorder records for each product

SELECT
    SKU_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Below_Reorder_Records DESC;


-- Task 5: Create a combined product performance summary

SELECT
    SKU_ID,
    COUNT(*) AS Total_Records,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2)))
        AS Average_Inventory,
    SUM(Inventory_Level * Unit_Cost)
        AS Total_Inventory_Value,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Below_Reorder_Records DESC,
         Total_Inventory_Value DESC;
