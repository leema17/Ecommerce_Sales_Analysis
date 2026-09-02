USE ecommerce_analysis;
-- Find the top 5 states by total sales.
 SELECT State , SUM(Sales) AS Total_Sales FROM superstore
 group by state 
 order by Total_Sales DESC
 limit 5;
 -- Find categories where the total profit is greater than 50,000
 SELECT Category, SUM(Profit) AS Total_Profit FROM superstore
 GROUP BY Category 
 having SUM(Profit) > 50000
 order by Total_Profit DESC;
 -- Find the top 5 customers by total sales
 SELECT `Customer Name` , SUM(Sales) AS Total_Sales FROM superstore
 GROUP BY `Customer Name` 
 ORDER BY Total_Sales desc
 limit 5;
 -- Find products whose Sales are greater than the overall average Sales
 SELECT `Product Name` ,Sales FROM superstore
WHERE Sales > (
    SELECT AVG(Sales)
    FROM superstore
)
 ORDER BY Sales desc;
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
-- Find the top 3 customers by total profit within each Segment.
WITH CustomerRank AS (
    SELECT
        `Customer Name`,
        Segment,
        SUM(Profit) AS Total_Profit,
        ROW_NUMBER() OVER (
            PARTITION BY Segment
            ORDER BY SUM(Profit) DESC
        ) AS Rank_Profit
    FROM superstore
    GROUP BY `Customer Name`, Segment
)

SELECT
    `Customer Name`,
    Segment,
    Total_Profit,
    Rank_Profit
FROM CustomerRank
WHERE Rank_Profit <= 3
ORDER BY Segment, Rank_Profit;
-- Find the highest-selling product in each Category
WITH ProductRank AS (
    SELECT
        `Product Name`,
        Category,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Sales_Rank
    FROM superstore
    GROUP BY `Product Name`, Category
)

SELECT
        `Product Name`,
        Category,
        Total_Sales,
		Sales_Rank
FROM productRank
WHERE Sales_Rank =1
ORDER BY Category,Sales_Rank;
 -- Find customers who have more than 10 orders AND total sales greater than 10,000
SELECT `Customer Name`, COUNT(*) AS Total_Orders, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
HAVING COUNT(*) > 10 AND SUM(Sales) > 10000
ORDER BY Total_Sales DESC;
-- Find the top 2 most profitable products in each Category
With Product_Profit AS(
SELECT `Product Name`, SUM(Profit)as Total_Profit ,Category,
ROW_NUMBER() over (
partition by Category
order by sum(profit) desc
)as Profit_Rank
FROM superstore
group by `Product Name`,Category
)
SELECT `Product Name`, Total_Profit ,Category,Profit_Rank from Product_Profit
where Profit_Rank <=2
ORDER BY Category,Profit_Rank;
-- Find customers whose total sales are greater than the average total sales of all customers AND whose total profit is greater than the average total profit of all customers.
WITH CustomerMetrics AS (
    SELECT
        `Customer Name`,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM superstore
    GROUP BY `Customer Name`
),

CustomerAverages AS (
    SELECT
        AVG(Total_Sales) AS Avg_Sales,
        AVG(Total_Profit) AS Avg_Profit
    FROM CustomerMetrics
)

SELECT
    `Customer Name`,
    Total_Sales,
    Total_Profit
FROM CustomerMetrics
WHERE Total_Sales > (
    SELECT Avg_Sales
    FROM CustomerAverages
)
AND Total_Profit > (
    SELECT Avg_Profit
    FROM CustomerAverages
)
ORDER BY Total_Sales DESC;