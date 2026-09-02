USE ecommerce_analysis;
-- show all data 
SELECT * FROM superstore;
-- show only 10 rows only 
SELECT *FROM superstore LIMIT 10;
-- show only customer name 
SELECT `Customer Name` FROM superstore;
-- show products with sales over 1000 
SELECT `Product Name`, Sales FROM superstore
WHERE Sales > 1000;
-- show products with negetive profit 
SELECT `Product Name`, Profit FROM superstore
WHERE Profit < 0;
-- show 10 productes with highest sales 
SELECT `Product Name`, Sales FROM superstore
ORDER BY Sales DESC
LIMIT 10;
-- show total orders 
SELECT COUNT(*) AS Total_Orders FROM superstore;
-- show average sales 
SELECT AVG(Sales) AS Average_Sales FROM superstore;
-- show hihgset profit 
SELECT MAX(Profit) AS Highest_Profit FROM superstore;
-- show loweset profit 
SELECT MIN(Profit) AS Biggest_Loss FROM superstore;