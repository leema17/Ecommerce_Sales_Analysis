USE ecommerce_analysis;
-- Find the average sales for each customer
WITH CustomerSales AS (
    SELECT
        `Customer Name`,
        SUM(Sales) AS Total_Sales
    FROM superstore
    GROUP BY `Customer Name`
)

SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC;
-- Find customers whose total sales are above the average customer sales
WITH CustomerSales AS (
    SELECT
        `Customer Name`,
        SUM(Sales) AS Total_Sales
    FROM superstore
    GROUP BY `Customer Name`
),
AverageCustomerSales AS (
    SELECT
        AVG(Total_Sales) AS Avg_Customer_Sales
    FROM CustomerSales
)
SELECT
    `Customer Name`,
    Total_Sales
FROM CustomerSales
WHERE Total_Sales > (
    SELECT Avg_Customer_Sales
    FROM AverageCustomerSales
)
ORDER BY Total_Sales DESC;
-- Find the top 5 customers by total profit
WITH CustomerProfit AS (
    SELECT
        `Customer Name`,
        SUM(Profit) AS Total_Profit
    FROM superstore
    GROUP BY `Customer Name`
)
SELECT
    `Customer Name`,
    Total_Profit
FROM CustomerProfit
ORDER BY Total_Profit DESC
LIMIT 5;
-- Find the average profit by category
WITH CategoryProfit AS (
    SELECT
        Category,
        AVG(Profit) AS Avg_Profit
    FROM superstore
    GROUP BY Category
)
SELECT *
FROM CategoryProfit
ORDER BY Avg_Profit DESC;
-- Find customers whose total profit is greater than the average customer profit
WITH CustomerProfit AS (
    SELECT
        `Customer Name`,
        SUM(Profit) AS Total_Profit
    FROM superstore
    GROUP BY `Customer Name`
),

AverageCustomerProfit AS (
    SELECT
        AVG(Total_Profit) AS Avg_Customer_Profit
    FROM CustomerProfit
)

SELECT
    `Customer Name`,
    Total_Profit
FROM CustomerProfit
WHERE Total_Profit > (
    SELECT Avg_Customer_Profit
    FROM AverageCustomerProfit
)
ORDER BY Total_Profit DESC;