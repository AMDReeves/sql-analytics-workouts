/*
    SQL Analytics Workouts
    Section 01: SQL Fundamentals

    Topics Practiced:
    - SELECT
    - WHERE
    - Comparison operators
    - Multiple filter conditions
    - Date filtering
    - ORDER BY
    - SUM()
    - GROUP BY
*/


-- ============================================================
-- Query 1: Orders with revenue greater than $300
-- ============================================================

SELECT *
FROM orders
WHERE revenue > 300;

-- Returns all orders where revenue was strictly greater than $300.
-- Uses > rather than >= because exactly $300 should not be included.


-- ============================================================
-- Query 2: Electronics orders from February 2026
-- ============================================================

SELECT *
FROM orders
WHERE category = 'Electronics'
  AND order_date >= '2026-02-01'
  AND order_date < '2026-03-01';

-- Returns all Electronics orders placed during February 2026.
-- Uses a half-open date range to safely include the entire month.


-- ============================================================
-- Query 3: Furniture orders with at least $250 revenue
-- ============================================================

SELECT *
FROM orders
WHERE category = 'Furniture'
  AND revenue >= 250
ORDER BY revenue DESC;

-- Returns Furniture orders that generated at least $250 in revenue.
-- Results are sorted from highest to lowest revenue.


-- ============================================================
-- Query 4: Total revenue by category during March 2026
-- ============================================================

SELECT category, SUM(revenue) AS total_revenue
FROM orders
WHERE order_date >= '2026-03-01'
  AND order_date < '2026-04-01'
GROUP BY category;

-- Calculates total March 2026 revenue for each category.
-- GROUP BY creates one result per category.


-- ============================================================
-- Query 5: Electronics orders over $75 during January 2026
-- ============================================================

SELECT *
FROM orders
WHERE category = 'Electronics'
  AND revenue > 75
  AND order_date >= '2026-01-01'
  AND order_date < '2026-02-01'
ORDER BY revenue DESC;

-- Returns January Electronics orders generating more than $75.
-- Results are sorted from highest to lowest revenue.
-- Direct date-range filtering is generally SARGable and can allow
-- SQL Server to use an appropriate index efficiently.


-- ============================================================
-- Query 6: Furniture orders from March 2026
-- ============================================================

SELECT *
FROM orders
WHERE category = 'Furniture'
  AND quantity >= 1
  AND order_date >= '2026-03-01'
  AND order_date < '2026-04-01'
ORDER BY order_date ASC;

-- Returns March Furniture orders where at least one unit was purchased.
-- Results are sorted chronologically from oldest to newest.
-- The half-open date range safely handles DATETIME values.

-- ============================================================
-- Query 7: Customer 101 orders with at least $100 revenue
-- ============================================================

SELECT *
FROM orders
WHERE customer_id = 101
  AND revenue >= 100
ORDER BY order_date DESC;

-- Returns all orders placed by customer 101 that generated
-- at least $100 in revenue.
--
-- >= includes orders with exactly $100 in revenue.
-- DESC sorts the results from newest to oldest.


-- ============================================================
-- Query 8: Electronics orders with multiple units
-- ============================================================

SELECT order_id, customer_id, product, quantity, revenue
FROM orders
WHERE category = 'Electronics'
  AND quantity > 1
  AND revenue <= 350
ORDER BY revenue ASC;

-- Returns Electronics orders where more than one unit was purchased
-- and revenue was no more than $350.
--
-- > 1 excludes orders with exactly one unit.
-- <= 350 includes orders with exactly $350 in revenue.
-- ASC sorts revenue from lowest to highest.


-- ============================================================
-- Query 9: Furniture OR high-revenue orders
-- ============================================================

SELECT order_id, product, category, revenue
FROM orders
WHERE category = 'Furniture'
   OR revenue > 500
ORDER BY revenue DESC;

-- Returns orders that are either Furniture OR generated
-- more than $500 in revenue.
--
-- OR means an order only needs to satisfy one of the conditions.
-- DESC displays the highest-revenue orders first.


-- ============================================================
-- Query 10: January orders from multiple categories
-- ============================================================

SELECT order_id, order_date, product, category, revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-02-01'
  AND revenue > 100
  AND (
      category = 'Electronics'
      OR category = 'Furniture'
  )
ORDER BY revenue DESC;

-- Returns January 2026 orders with revenue greater than $100
-- that belong to either Electronics or Furniture.
--
-- Parentheses group the category conditions together.
-- SQL evaluates AND before OR, so failing to group these conditions
-- could allow Furniture orders outside the other requirements.


-- ============================================================
-- Query 11: Multiple AND conditions inside OR logic
-- ============================================================

SELECT order_id, product, category, quantity, revenue
FROM orders
WHERE quantity >= 2
  AND (
      (category = 'Electronics' AND revenue > 100)
      OR
      (category = 'Furniture' AND revenue > 300)
  )
ORDER BY revenue DESC;

-- Returns orders with at least two units where either:
-- 1. Electronics revenue was greater than $100, OR
-- 2. Furniture revenue was greater than $300.
--
-- Parentheses make the intended logical groups explicit.
-- The quantity requirement applies to BOTH alternatives.


-- ============================================================
-- Query 12: Revenue range across February and March
-- ============================================================

SELECT order_id, order_date, product, revenue
FROM orders
WHERE order_date >= '2026-02-01'
  AND order_date < '2026-04-01'
  AND revenue >= 100
  AND revenue <= 400
ORDER BY order_date ASC;

-- Returns February and March 2026 orders with revenue between
-- $100 and $400 inclusive.
--
-- February and March are consecutive, so they can be represented
-- as one continuous date range instead of two ranges joined by OR.
--
-- >= 100 AND <= 400 makes both revenue boundaries inclusive.


-- ============================================================
-- Query 13: Non-consecutive month filtering
-- ============================================================

SELECT order_id, customer_id, order_date, product, category, revenue
FROM orders
WHERE (
    (order_date >= '2026-01-01' AND order_date < '2026-02-01')
    OR
    (order_date >= '2026-03-01' AND order_date < '2026-04-01')
)
AND revenue >= 150
AND revenue < 500
ORDER BY revenue ASC;

-- Returns orders from January OR March 2026 with revenue
-- at least $150 but less than $500.
--
-- January and March are NOT consecutive, so separate date ranges
-- are required to prevent February records from being included.
--
-- The date ranges are grouped together so the revenue requirements
-- apply to orders from both months.


-- ============================================================
-- Query 14: February orders with compound category conditions
-- ============================================================

SELECT order_id, order_date, product, category, quantity, revenue
FROM orders
WHERE order_date >= '2026-02-01'
  AND order_date < '2026-03-01'
  AND (
      (category = 'Electronics' AND revenue >= 300)
      OR
      (category = 'Furniture' AND quantity > 1)
  )
ORDER BY order_date DESC;

-- Returns February 2026 orders where either:
-- 1. The order is Electronics with revenue of at least $300, OR
-- 2. The order is Furniture with more than one unit purchased.
--
-- The February date requirement applies to BOTH alternatives.
-- Parentheses prevent the OR condition from bypassing the date filter.


-- ============================================================
-- Query 15: January and February with compound business logic
-- ============================================================

SELECT order_id, order_date, product, category, quantity, revenue
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-03-01'
  AND (
      (category = 'Furniture' AND revenue > 250)
      OR
      (category = 'Electronics' AND quantity >= 2)
  )
ORDER BY revenue DESC;

-- Returns January and February 2026 orders where either:
-- 1. Furniture revenue was greater than $250, OR
-- 2. Electronics quantity was at least two units.
--
-- January and February are consecutive, allowing one continuous
-- date range to represent both months.


-- ============================================================
-- Query 16: Total revenue by customer
-- ============================================================

SELECT customer_id, SUM(revenue) AS total_revenue
FROM orders
GROUP BY customer_id
ORDER BY total_revenue DESC;

-- Calculates the total revenue generated by each customer
-- across all of their orders.
--
-- SUM(revenue) aggregates revenue.
-- GROUP BY customer_id creates one result per customer.
-- DESC displays the highest-spending customers first.


-- ============================================================
-- Query 17: Total units sold by product
-- ============================================================

SELECT product, SUM(quantity) AS total_units_sold
FROM orders
GROUP BY product
ORDER BY total_units_sold DESC;

-- Calculates the total number of units sold for each product.
--
-- SUM(quantity) is used because the business question asks for
-- units sold rather than the number of orders.
--
-- GROUP BY product creates one result per product.
-- DESC displays the products with the most units sold first.


-- ============================================================
-- Query 18: Number of orders by category
-- ============================================================

SELECT category, COUNT(category) AS total_orders
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-03-01'
GROUP BY category
ORDER BY total_orders DESC;

-- Counts categorized orders during January and February 2026
-- and returns the number associated with each category.
--
-- COUNT(category) counts records where category is NOT NULL.
-- This reflects the chosen business interpretation that the question
-- concerns orders assigned to a category.
--
-- COUNT(*) would have different behavior for a NULL category group,
-- so the appropriate COUNT expression depends on the business
-- definition and treatment of missing category values.
