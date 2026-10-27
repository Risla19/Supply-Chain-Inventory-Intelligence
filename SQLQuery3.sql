--Task 1
SELECT
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    CASE
        WHEN Inventory_Level < 100 THEN 'Low Stock'
        WHEN Inventory_Level < 500 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS StockCategory
FROM dbo.supply_chain_import_test;

--Task 2
SELECT
    CASE
        WHEN Inventory_Level < 100 THEN 'Low Stock'
        WHEN Inventory_Level < 500 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS StockCategory,
    COUNT(*) AS RecordCount
FROM dbo.supply_chain_import_test
GROUP BY
    CASE
        WHEN Inventory_Level < 100 THEN 'Low Stock'
        WHEN Inventory_Level < 500 THEN 'Medium Stock'
        ELSE 'High Stock'
    END
ORDER BY RecordCount DESC;

--Task 3
SELECT
    Warehouse_ID,
    COUNT(*) AS LowStockRecords
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < 100
GROUP BY Warehouse_ID
ORDER BY LowStockRecords DESC;

--Task 4
SELECT
    Warehouse_ID,
    COUNT(*) AS TotalRecords,
    SUM(CASE
        WHEN Inventory_Level < 100 THEN 1
        ELSE 0
    END) AS LowStockRecords,
    CAST(
        100.0 * SUM(CASE
            WHEN Inventory_Level < 100 THEN 1
            ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS LowStockPercentage
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY LowStockPercentage DESC;

--Task 5
SELECT
    Warehouse_ID,
    COUNT(*) AS TotalRecords,
    SUM(CASE
        WHEN Inventory_Level < 100 THEN 1
        ELSE 0
    END) AS LowStockRecords,
    SUM(CASE
        WHEN Inventory_Level >= 100
         AND Inventory_Level < 500 THEN 1
        ELSE 0
    END) AS MediumStockRecords,
    SUM(CASE
        WHEN Inventory_Level >= 500 THEN 1
        ELSE 0
    END) AS HighStockRecords,
    AVG(Inventory_Level) AS AverageInventory
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Warehouse_ID;
