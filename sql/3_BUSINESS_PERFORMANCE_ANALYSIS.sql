/*
=========================================================

Objective:
Analyze overall business performance, identify growth
trends, revenue drivers, profitability and customer
contribution using the analytical dataset.

Dataset:
ecommerce_sales_data
=========================================================
*/

-- =====================================================
-- Q1. Executive Business KPIs
-- =====================================================

SELECT
    ROUND(SUM(after_discount),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(after_discount),2) AS average_order_value
FROM ecommerce_sales_data
WHERE is_valid = 1;


-- =====================================================
-- Q2. Monthly Revenue & Profit Trend
-- =====================================================

SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS month,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    COUNT(id) AS total_orders
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY month
ORDER BY month;


-- =====================================================
-- Q3. Month-over-Month Revenue Growth
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        DATE_FORMAT(order_date,'%Y-%m') AS month,
        SUM(after_discount) AS revenue
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY month
)

SELECT
    month,
    ROUND(revenue,2) AS revenue,
    ROUND(
        (
            revenue -
            LAG(revenue) OVER(ORDER BY month)
        ) * 100 /
        LAG(revenue) OVER(ORDER BY month),
        2
    ) AS revenue_growth_percent
FROM monthly_sales;


-- =====================================================
-- Q4. Category Performance Analysis
-- =====================================================

SELECT
    category,
    COUNT(id) AS total_orders,
    SUM(qty_ordered) AS units_sold,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY category
ORDER BY revenue DESC;


-- =====================================================
-- Q5. Brand Performance Analysis
-- =====================================================

SELECT
    brand,
    SUM(qty_ordered) AS units_sold,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY brand
ORDER BY revenue DESC;


-- =====================================================
-- Q6. Payment Method Analysis
-- =====================================================

SELECT
    payment_method,
    COUNT(id) AS total_transactions,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(AVG(after_discount),2) AS average_transaction_value
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY payment_method
ORDER BY revenue DESC;


-- =====================================================
-- Q7. Top 10 Customers by Revenue
-- =====================================================

SELECT
    customer_id,
    COUNT(id) AS total_orders,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(AVG(after_discount),2) AS average_order_value
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- Q8. Category Profit Margin Analysis
-- =====================================================

SELECT
    category,
    ROUND(SUM(after_discount),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(
        (SUM(profit) / SUM(after_discount)) * 100,
        2
    ) AS profit_margin_percent
FROM ecommerce_sales_data
WHERE is_valid = 1
GROUP BY category
ORDER BY profit_margin_percent DESC;


-- =====================================================
-- Q9. Pareto Analysis (80/20 Principle)
-- Identify categories contributing the majority
-- of business revenue.
-- =====================================================

WITH category_sales AS
(
    SELECT
        category,
        SUM(after_discount) AS revenue
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY category
)

SELECT
    category,
    ROUND(revenue,2) AS revenue,
    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ),
        2
    ) AS cumulative_revenue,
    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ) * 100 /
        SUM(revenue) OVER(),
        2
    ) AS cumulative_revenue_percent
FROM category_sales
ORDER BY revenue DESC;


-- CUSTOMER V REVENUE 

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(after_discount) AS revenue
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY customer_id
),
ranked AS (
    SELECT
        customer_id,
        revenue,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue,
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_sales
)

SELECT
    customer_id,
    revenue,
    ROUND(cumulative_revenue * 100.0 / total_revenue,2) AS cumulative_revenue_percent,
    ROUND(customer_rank * 100.0 / total_customers,2) AS customer_percent
FROM ranked
ORDER BY revenue DESC;



WITH yearly_revenue AS
(
    SELECT
        YEAR(order_date) AS order_year,
        SUM(after_discount) AS revenue
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY YEAR(order_date)
)

SELECT
    order_year,
    ROUND(revenue,2) AS revenue,
    ROUND(
        (
            revenue -
            LAG(revenue) OVER(ORDER BY order_year)
        ) * 100.0
        /
        LAG(revenue) OVER(ORDER BY order_year),
        2
    ) AS yoy_growth_percent
FROM yearly_revenue
ORDER BY order_year;



WITH yearly_orders AS
(
    SELECT
        YEAR(order_date) AS order_year,
        COUNT(DISTINCT id) AS total_orders
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY YEAR(order_date)
)

SELECT
    order_year,
    total_orders,
    ROUND(
        (
            total_orders -
            LAG(total_orders) OVER(ORDER BY order_year)
        ) *100.0/
        LAG(total_orders) OVER(ORDER BY order_year),
        2
    ) AS order_growth_percent
FROM yearly_orders;




WITH yearly_profit AS
(
    SELECT
        YEAR(order_date) AS order_year,
        SUM(profit) AS profit
    FROM ecommerce_sales_data
    WHERE is_valid = 1
    GROUP BY YEAR(order_date)
)

SELECT
    order_year,
    ROUND(profit,2) AS profit,
    ROUND(
        (
            profit -
            LAG(profit) OVER(ORDER BY order_year)
        )*100.0/
        LAG(profit) OVER(ORDER BY order_year),
        2
    ) AS yoy_profit_growth
FROM yearly_profit;