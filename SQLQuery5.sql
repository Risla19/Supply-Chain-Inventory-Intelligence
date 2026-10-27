-- Day 15, Task 1: Count records below reorder point

SELECT
    COUNT(*) AS Below_Reorder_Point_Records
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < Reorder_Point;

-- Task 2: Count records below reorder point by warehouse

SELECT
    Warehouse_ID,
    COUNT(*) AS Below_Reorder_Records
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < Reorder_Point
GROUP BY Warehouse_ID
ORDER BY Below_Reorder_Records DESC;

-- Task 3: Calculate below-reorder percentage by warehouse

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

-- Task 4: Find the biggest stock shortages

SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Reorder_Point,
    Reorder_Point - Inventory_Level AS Shortage_Units
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < Reorder_Point
ORDER BY Shortage_Units DESC;

-- Task 5: Inventory risk summary by warehouse

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS Below_Reorder_Records,
    SUM(CASE
        WHEN Inventory_Level >= Reorder_Point THEN 1
        ELSE 0
    END) AS At_Or_Above_Reorder_Records,
    AVG(CAST(Inventory_Level AS DECIMAL(18,2))) AS Average_Inventory
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Below_Reorder_Records DESC;