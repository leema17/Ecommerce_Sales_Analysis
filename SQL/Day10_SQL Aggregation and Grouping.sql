USE ecommerce_analysis;
-- -- Calculate the total sales for each product category
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;
-- Calculate the total profit for each product category
SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;
-- Count the total number of orders in each region
SELECT
    Region,
    COUNT(*) AS Total_Orders
FROM superstore
GROUP BY Region
ORDER BY Total_Orders DESC;
-- Calculate the average sales for each region
SELECT
    Region,
    ROUND(AVG(Sales), 2) AS Average_Sales
FROM superstore
GROUP BY Region
ORDER BY Average_Sales DESC;
-- Calculate the total sales for each customer segment
SELECT
    Segment,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;
-- Find the top 10 customers with the highest total sales
SELECT
    `Customer Name`,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;
-- Find the top 10 customers with the highest total profit
SELECT
    `Customer Name`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;
-- Calculate the average discount for each product category
SELECT
    Category,
    ROUND(AVG(Discount), 2) AS Average_Discount
FROM superstore
GROUP BY Category;
-- Count the number of records for each product sub-category
SELECT
    `Sub-Category`,
    COUNT(*) AS Total_Products
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Products DESC;
-- Count the number of Unique records for each product sub-category
SELECT
    `Sub-Category`,
    COUNT(DISTINCT `Product ID`) AS Total_Products
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Products DESC;
-- Find the top 10 states with the highest total sales
SELECT
    State,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;