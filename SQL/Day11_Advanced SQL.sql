USE ecommerce_analysis;
-- Find categories with total sales greater than 700,000
SELECT Category, SUM(Sales) AS Total_Sales FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 700000
ORDER BY Total_Sales DESC;
-- Find customers whose total profit is greater than 5000
SELECT `Customer Name`, SUM(Profit) AS Total_Profit FROM superstore
GROUP BY `Customer Name`
HAVING SUM(Profit) > 5000
ORDER BY Total_Profit DESC;
-- Find regions with average sales greater than 230
SELECT Region, AVG(Sales) AS Average_Sales FROM superstore
GROUP BY Region
HAVING AVG(Sales) > 230
ORDER BY Average_Sales DESC;
-- Classify each order as Profit or Loss
SELECT `Order ID`, Profit,
    CASE
        WHEN Profit > 0 THEN 'Profit'
        ELSE 'Loss'
    END AS Profit_Status
FROM superstore;
-- Display all unique cities
SELECT DISTINCT City
FROM superstore
ORDER BY City;
-- Find orders with sales between 500 and 1000
SELECT `Order ID`, Sales FROM superstore
WHERE Sales BETWEEN 500 AND 1000
ORDER BY Sales DESC;
-- Display orders from East and West regions only
SELECT `Order ID`, Region, Sales FROM superstore
WHERE Region IN ('East','West');
-- Find customers who placed more than 20 orders
SELECT `Customer Name`, COUNT(*) AS Total_Orders FROM superstore
GROUP BY `Customer Name`
HAVING COUNT(*) > 20
ORDER BY Total_Orders DESC;
-- Find the top 5 states with the highest total profit
SELECT State, SUM(Profit) AS Total_Profit FROM superstore
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 5;