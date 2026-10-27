
USE SupplyChainDB;
GO

-- Task 1: Find the 10 records with the highest forecast demand

SELECT TOP 10
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Demand_Forecast
FROM dbo.supply_chain_import_test
ORDER BY Demand_Forecast DESC;


-- Task 2: Find records where inventory is below forecast demand

SELECT
    SKU_ID,
    Warehouse_ID,
    Inventory_Level,
    Demand_Forecast,
    Inventory_Level - Demand_Forecast AS Stock_Forecast_Difference
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < Demand_Forecast
ORDER BY Stock_Forecast_Difference ASC;


-- Task 3: Count potential demand-risk records by warehouse

SELECT
    Warehouse_ID,
    COUNT(*) AS Potential_Risk_Records
FROM dbo.supply_chain_import_test
WHERE Inventory_Level < Demand_Forecast
GROUP BY Warehouse_ID
ORDER BY Potential_Risk_Records DESC;


-- Task 4: Calculate potential demand-risk percentage by warehouse

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN Inventory_Level < Demand_Forecast THEN 1
        ELSE 0
    END) AS Potential_Risk_Records,
    CAST(
        100.0 * SUM(CASE
            WHEN Inventory_Level < Demand_Forecast THEN 1
            ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS Potential_Risk_Percentage
FROM dbo.supply_chain_import_test
GROUP BY Warehouse_ID
ORDER BY Potential_Risk_Percentage DESC;


-- Task 5: Summarize demand risk by SKU

SELECT
    SKU_ID,
    COUNT(*) AS Total_Records,
    AVG(CAST(Demand_Forecast AS DECIMAL(18,2)))
        AS Average_Forecast_Demand,
    SUM(CASE
        WHEN Inventory_Level < Demand_Forecast THEN 1
        ELSE 0
    END) AS Potential_Risk_Records
FROM dbo.supply_chain_import_test
GROUP BY SKU_ID
ORDER BY Potential_Risk_Records DESC;
