USE ecommerce_analysis;
-- Find the top products by sales.
SELECT
    `Product Name`,
    Sales,
    RANK() OVER (ORDER BY Sales DESC) AS Sales_Rank
FROM superstore;
-- Rank products within each category 
SELECT
    Category,
    `Product Name`,
    Sales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY Sales DESC
    ) AS Product_Rank
FROM superstore;
-- Running Total 
SELECT
    `Order Date`,
    Sales,
    SUM(Sales) OVER (
        ORDER BY `Order Date`
    ) AS Running_Sales
FROM superstore
ORDER BY `Order Date`;
-- Average within Category
SELECT
    Category,
    `Product Name`,
    Sales,
    ROUND(
        AVG(Sales) OVER (PARTITION BY Category), 2
    ) AS Category_Avg_Sales
FROM superstore;
-- Compare Product Sales with Category Average
WITH ProductData AS (
    SELECT
        Category,
        `Product Name`,
        Sales,
        AVG(Sales) OVER (
            PARTITION BY Category
        ) AS Category_Avg_Sales
    FROM superstore
)

SELECT
    Category,
    `Product Name`,
    Sales,
    ROUND(Category_Avg_Sales, 2) AS Category_Avg_Sales
FROM ProductData
WHERE Sales > Category_Avg_Sales
ORDER BY Sales DESC;
-- Find the top 5 customers ranked by total profit.
WITH CustomerProfit AS (
    SELECT
        `Customer Name`,
        SUM(Profit) AS Total_Profit
    FROM superstore
    GROUP BY `Customer Name`
)

SELECT
    `Customer Name`,
    Total_Profit,
    RANK() OVER (
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank
FROM CustomerProfit
ORDER BY Profit_Rank
limit 5;
-- Rank customers within each Segment based on their total sales
WITH CustomerRank AS (
    SELECT
        `Customer Name`,
        Segment,
        SUM(Sales) AS Total_Sales,
        RANK() OVER (
            PARTITION BY Segment
            ORDER BY SUM(Sales) DESC
        ) AS Sales_Rank
    FROM superstore
    GROUP BY `Customer Name`, Segment
)

SELECT
    `Customer Name`,
    Segment,
    Total_Sales,
    Sales_Rank
FROM CustomerRank
ORDER BY Segment, Sales_Rank;
-- Find the top 3 customers by sales within each Segment
WITH CustomerRank AS (
    SELECT
        `Customer Name`,
        Segment,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Segment
            ORDER BY SUM(Sales) DESC
        ) AS Sales_Rank
    FROM superstore
    GROUP BY `Customer Name`, Segment
)

SELECT
    `Customer Name`,
    Segment,
    Total_Sales,
    Sales_Rank
FROM CustomerRank
WHERE Sales_Rank <= 3
ORDER BY Segment, Sales_Rank;
-- Find the highest-selling product in each Category
WITH ProductRank AS (
    SELECT
		Category,
        `Product Name`,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Sales_Rank
    FROM superstore
    GROUP BY `Product Name`, Category
)

SELECT
     Category,
    `Product Name`,
    Total_Sales,
    Sales_Rank
FROM ProductRank
WHERE Sales_Rank =1
ORDER BY Category, Sales_Rank;
-- Find the top 2 products by profit within each Category
WITH ProductRank AS (
    SELECT
		Category,
        `Product Name`,
        SUM(Profit) AS Total_Profit,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY SUM(Profit) DESC
        ) AS Profit_Rank
    FROM superstore
    GROUP BY `Product Name`, Category
)

SELECT
     Category,
    `Product Name`,
    Total_Profit,
    Profit_Rank
FROM ProductRank
WHERE Profit_Rank <=2
ORDER BY Category, Profit_Rank;