
USE SupplyChainDB;
GO

-- Task 1: Overall inventory risk summary

SELECT
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records,
    SUM(CASE
        WHEN Inventory_Level >= Reorder_Point THEN 1
        ELSE 0
    END) AS At_Or_Above_Reorder_Records,
    CAST(
        100.0 * SUM(CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS Below_Reorder_Percentage
FROM dbo.supply_chain_import_test;


-- Task 2: Inventory risk by warehouse

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records,
    CAST(
        100.0 * SUM(CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS Below_Reorder_Percentage
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Below_Reorder_Percentage DESC;


-- Task 3: Inventory value by warehouse

SELECT
    Warehouse_ID,
    SUM(Inventory_Level * Unit_Cost) AS Recorded_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Recorded_Inventory_Value DESC;


-- Task 4: Products with the most below-reorder records

SELECT TOP 10
    SKU_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Below_Reorder_Records DESC;


-- Task 5: Final warehouse performance summary

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Records,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2)))
        AS Average_Inventory,
    SUM(Inventory_Level * Unit_Cost) AS Recorded_Inventory_Value,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records,
    SUM(CASE
        WHEN Inventory_Level < Demand_Forecast THEN 1
        ELSE 0
    END) AS Potential_Demand_Risk_Records
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Below_Reorder_Records DESC;
