USE ecommerce_analysis;
-- Find the state with the highest total profit
SELECT
    State,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 1;
-- Find the region with the highest sales
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;
-- Find the most frequently used shipping mode
SELECT
    `Ship Mode`,
    COUNT(*) AS Total_Orders
FROM superstore
GROUP BY `Ship Mode`
ORDER BY Total_Orders DESC;
-- Find the customer who purchased the highest quantity
SELECT
    `Customer Name`,
    SUM(Quantity) AS Total_Quantity
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Quantity DESC;
-- Find the most profitable sub-category
SELECT
    `Sub-Category`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC;
-- Find the least profitable sub-category
SELECT
    `Sub-Category`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC;
-- Find the average discount for each state;
SELECT
    State,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount
FROM superstore
GROUP BY State
ORDER BY Avg_Discount DESC;
-- Calculate profit margin for each segment
SELECT
    Segment,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM superstore
GROUP BY Segment
ORDER BY Profit_Margin DESC;
-- Calculate average sales for each year
SELECT
    YEAR(`Order Date`) AS Order_Year,
    ROUND(AVG(Sales),2) AS Average_Order_Value
FROM superstore
GROUP BY Order_Year
ORDER BY Average_Order_Value DESC;
-- Find products with high sales but low profit
SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Product Name`
HAVING SUM(Sales) > 10000
   AND SUM(Profit) < 1000
ORDER BY Total_Sales DESC;
