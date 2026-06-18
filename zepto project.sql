USE zepto;

-- Total records
SELECT COUNT(*) FROM zepto1;

-- First 10 rows
SELECT * FROM zepto1 LIMIT 10;

-- Different product categories
SELECT DISTINCT category
FROM zepto1
ORDER BY category;

-- Products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) AS total_products
FROM zepto1
GROUP BY outOfStock;

-- Products whose names appear multiple times
SELECT name, COUNT(sku_id) AS Number_of_SKUs
FROM zepto1
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY Number_of_SKUs DESC;

-- Products with zero price
SELECT *
FROM zepto1
WHERE mrp = 0
   OR discountedSellingPrice = 0;

-- Convert paise to rupees
UPDATE zepto1
SET mrp = mrp / 100,
    discountedSellingPrice = discountedSellingPrice / 100;

SELECT mrp, discountedSellingPrice
FROM zepto1;

-- Q1 Top 10 products with highest discount
SELECT DISTINCT name, mrp, discountPercent
FROM zepto1
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2 High MRP products that are out of stock
SELECT DISTINCT name, mrp
FROM zepto1
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;

-- Q3 Estimated revenue for each category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto1
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4 Products where MRP > 500 and discount < 10%
SELECT DISTINCT name,
                mrp,
                discountPercent
FROM zepto1
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY discountPercent DESC;

-- Q5 Top 5 categories with highest average discount
SELECT category,
       ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto1
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6 Price per gram for products above 100g
SELECT DISTINCT name,
       weightInGms,
       discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto1
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;

-- Q6 Categorize products by weight
SELECT DISTINCT name,
       weightInGms,
       CASE
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto1;

-- Q7 Total inventory weight per category
SELECT category,
       SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto1
GROUP BY category
ORDER BY total_weight DESC;




