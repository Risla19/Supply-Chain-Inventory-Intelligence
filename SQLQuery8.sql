
USE SupplyChainDB;
GO

-- Task 1: Count records for each supplier

SELECT
    Supplier_ID,
    COUNT(*) AS Total_Records
FROM dbo.supply_chain_import_test
GROUP BY Supplier_ID
ORDER BY Total_Records DESC;


-- Task 2: Calculate average inventory by supplier

SELECT
    Supplier_ID,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2)))
        AS Average_Inventory
FROM dbo.supply_chain_import_test
GROUP BY Supplier_ID
ORDER BY Average_Inventory DESC;


-- Task 3: Calculate total recorded inventory value by supplier

SELECT
    Supplier_ID,
    SUM(Inventory_Level * Unit_Cost)
        AS Total_Recorded_Inventory_Value
FROM dbo.supply_chain_import_test
GROUP BY Supplier_ID
ORDER BY Total_Recorded_Inventory_Value DESC;


-- Task 4: Count below-reorder records by supplier

SELECT
    Supplier_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
GROUP BY Supplier_ID
ORDER BY Below_Reorder_Records DESC;


-- Task 5: Summarize supplier inventory risk

SELECT
    Supplier_ID,
    COUNT(*) AS Total_Records,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2)))
        AS Average_Inventory,
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
GROUP BY Supplier_ID
ORDER BY Below_Reorder_Percentage DESC;
