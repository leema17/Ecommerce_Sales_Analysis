USE ecommerce_analysis;
-- Find products with sales greater than the average sale
SELECT
    `Product Name`,
    Sales
FROM superstore
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM superstore
)
ORDER BY Sales DESC;
-- Find customers whose total sales exceed the average customer total sales
SELECT
    `Customer Name`,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
HAVING SUM(Sales) >
(
    SELECT AVG(Customer_Total)
    FROM
    (
        SELECT
            SUM(Sales) AS Customer_Total
        FROM superstore
        GROUP BY `Customer Name`
    ) AS CustomerSales
)
ORDER BY Total_Sales DESC;
-- Find products with the maximum profit
SELECT
    `Product Name`,
    Profit
FROM superstore
WHERE Profit =
(
    SELECT MAX(Profit)
    FROM superstore
);
-- Find orders with discounts above the average discount
SELECT
    `Order ID`,
    Discount
FROM superstore
WHERE Discount >
(
    SELECT AVG(Discount)
    FROM superstore
)
ORDER BY Discount DESC;
-- Find customers with above-average number of orders
SELECT
    `Customer Name`,
    COUNT(*) AS Total_Orders
FROM superstore
GROUP BY `Customer Name`
HAVING COUNT(*) >
(
    SELECT AVG(Order_Count)
    FROM
    (
        SELECT
            COUNT(*) AS Order_Count
        FROM superstore
        GROUP BY `Customer Name`
    ) AS CustomerOrders
)
ORDER BY Total_Orders DESC;