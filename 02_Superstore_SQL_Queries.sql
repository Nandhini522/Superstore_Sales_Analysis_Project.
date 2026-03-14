/*
PROJECT: End-to-End Superstore Sales Analysis
ANALYST: Nandhini Kondaparthi
OBJECTIVE: Clean 50k+ records and extract business insights for stakeholders.
/*

-- 1) TOTAL SALES & TOTAL PROFIT
-- Goal: Provide a high-level financial check of the business.

SELECT
     sum(sales) AS Total_Sales,
     sum(profit) AS Total_Profit
     FROM superstore_sales2;
SELECT
     concat('$', FORMAT (SUM(sales),2)) AS Total_Sales,
     concat('$', FORMAT (SUM(Profit),2)) AS Total_Profit
     FROM superstore_sales2;



-- 2) DATA CLEANING: DATE FORMAT CONVERSION
-- Goal: Fix the "Date Issue" where dates were in two different formats.
-- This ensures time-series charts in Power BI are accurate.

SELECT*FROM superstore_sales2;
     ALTER TABLE superstore_sales2 
     ADD order_date_clean DATE; 
UPDATE superstore_sales2 SET order_date_clean=CASE
     WHEN order_date LIKE '%/%'
        THEN str_to_date(TRIM(order_date),'%c/%e/%Y')
     WHEN order_date LIKE '%-%'
        THEN str_to_date(TRIM(order_date),'%d-%m-%Y')
ELSE null
END
WHERE order_date IS NOT NULL; 



-- 3) MONTHLY SALES TREND
-- Goal: Identify seasonal peaks to help with inventory planning.

SELECT 
     date_format(order_date_clean,'%Y-%m') AS Month,
     ROUND(SUM(Sales),2) AS Monthly_sales
FROM superstore_sales2
GROUP BY Month 
ORDER BY Month; 
COMMIT;



-- 4) TOTAL SALES BY CATEGORY
-- Goal: Determine which product categories drive the most revenue.

SELECT
     Category,
     ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore_sales2
GROUP BY Category
ORDER BY Total_Sales DESC; 



-- 5) TOP 10 CUSTOMERS BY SALES
-- Goal: Identify high-value customers for a potential loyalty program.

SELECT
     Customer_Name,
     ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore_sales2
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;







