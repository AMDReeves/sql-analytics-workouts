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
