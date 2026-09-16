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




