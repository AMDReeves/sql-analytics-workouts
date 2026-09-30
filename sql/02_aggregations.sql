/*
============================================================
02 - AGGREGATIONS
============================================================

PURPOSE
-------
Build on SQL fundamentals by using aggregate functions to answer
realistic business questions.

TOPICS
------
- AVG(), MIN(), MAX(), SUM(), COUNT()
- Multiple aggregates
- GROUP BY
- WHERE vs HAVING
- Aggregate filtering
- Basic arithmetic
- Percentages and ratios
- Business-request interpretation

KEY IDEA
--------
Determine what one row of the final result should represent,
then choose the appropriate grouping and calculations.
*/

-- Exercise 1:
-- Show the average, minimum, and maximum order revenue for each
-- product category during Q1 2026. Sort by highest average revenue.

SELECT category,
       AVG(revenue) AS avg_order_revenue,
       MIN(revenue) AS min_order_revenue,
       MAX(revenue) AS max_order_revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-04-01'
GROUP BY category
ORDER BY avg_order_revenue DESC;


-- Exercise 2:
-- Show each customer's total orders, average order revenue, and
-- total revenue during Q1 2026. Sort by highest total revenue.

SELECT customer_id,
       COUNT(order_id) AS total_orders,
       AVG(revenue) AS avg_order_revenue,
       SUM(revenue) AS total_revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-04-01'
GROUP BY customer_id
ORDER BY total_revenue DESC;

-- Exercise 3:
-- During Q1 2026, show each category's lowest order revenue,
-- highest order revenue, and average order revenue.
-- Sort by average order revenue from highest to lowest.

SELECT category,
       MIN(revenue) AS lowest_order_revenue,
       MAX(revenue) AS highest_order_revenue,
       AVG(revenue) AS avg_order_revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-04-01'
GROUP BY category
ORDER BY avg_order_revenue DESC;


-- Exercise 4:
-- During January and February 2026, show each product's
-- number of orders, total units sold, and average revenue per order.
-- Sort by number of orders from highest to lowest.
-- If tied, sort by total units sold from highest to lowest.

SELECT product,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_units_sold,
       AVG(revenue) AS avg_order_revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-03-01'
GROUP BY product
ORDER BY total_orders DESC,
         total_units_sold DESC;


-- Exercise 5:
-- During Q1 2026, show each customer's total revenue
-- and average order revenue.
-- Only show customers whose total revenue was greater than $500.
-- Sort by total revenue from highest to lowest.

SELECT customer_id,
       SUM(revenue) AS total_revenue,
       AVG(revenue) AS avg_order_revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-04-01'
GROUP BY customer_id
HAVING SUM(revenue) > 500
ORDER BY total_revenue DESC;




