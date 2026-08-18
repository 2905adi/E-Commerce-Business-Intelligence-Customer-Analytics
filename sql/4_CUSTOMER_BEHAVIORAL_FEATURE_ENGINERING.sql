/*
=========================================================

Objective:
Transform transaction-level data into customer-level
behavioral features. These features will serve as the
foundation for customer segmentation using K-Means.

Output:
customer_summary
(One Row = One Customer)
=========================================================
*/

-- =====================================================
-- STEP 1 : Drop Existing Table (If Exists)
-- =====================================================

DROP TABLE IF EXISTS customer_summary;


-- =====================================================
-- STEP 2 : Create Customer Behavioral Feature Table
-- =====================================================

CREATE TABLE customer_summary AS

WITH customer_features AS
(
    SELECT
        sd.customer_id,
        cd.registered_date,
        sd.order_date,
        sd.qty_ordered,
        sd.after_discount
    FROM ecommerce_sales_data sd
    LEFT JOIN customer_details cd
        ON sd.customer_id = cd.id
    WHERE sd.is_valid = 1
)

SELECT

    customer_id,

    /* Days taken to place the first order after registration */
    DATEDIFF(
        MIN(order_date),
        MIN(registered_date)
    ) AS register_to_first_order,

    /* Customer active duration */
    DATEDIFF(
        MAX(order_date),
        MIN(order_date)
    ) AS customer_lifespan_days,

    /* Purchase frequency */
    COUNT(order_date) AS total_orders,

    /* Total quantity purchased */
    SUM(qty_ordered) AS total_units,

    /* Total customer spending */
    ROUND(
        SUM(after_discount),
        2
    ) AS total_spent,

    /* Average spending per order */
    ROUND(
        AVG(after_discount),
        2
    ) AS average_order_value,

    /* Average quantity purchased per order */
    ROUND(
        SUM(qty_ordered) / COUNT(order_date),
        2
    ) AS average_units_per_order

FROM customer_features

GROUP BY customer_id;


-- =====================================================
-- STEP 3 : Validate Engineered Features
-- =====================================================

SELECT *
FROM customer_summary
LIMIT 10;


-- =====================================================
-- STEP 4 : Check Customer Feature Summary
-- =====================================================

SELECT

    COUNT(*) AS total_customers,

    ROUND(AVG(register_to_first_order),2) AS avg_days_to_first_purchase,
    ROUND(AVG(customer_lifespan_days),2) AS avg_customer_lifespan,

    ROUND(AVG(total_orders),2) AS avg_orders_per_customer,
    ROUND(AVG(total_units),2) AS avg_units_per_customer,

    ROUND(AVG(total_spent),2) AS avg_customer_spend,
    ROUND(AVG(average_order_value),2) AS avg_order_value,
    ROUND(AVG(average_units_per_order),2) AS avg_units_per_order

FROM customer_summary;


-- =====================================================
-- STEP 5 : Check Feature Ranges
-- Helps identify unusual values before segmentation.
-- =====================================================

SELECT

    MIN(register_to_first_order) AS min_days_to_first_purchase,
    MAX(register_to_first_order) AS max_days_to_first_purchase,

    MIN(customer_lifespan_days) AS min_customer_lifespan,
    MAX(customer_lifespan_days) AS max_customer_lifespan,

    MIN(total_orders) AS min_orders,
    MAX(total_orders) AS max_orders,

    MIN(total_units) AS min_units,
    MAX(total_units) AS max_units,

    ROUND(MIN(total_spent),2) AS min_spent,
    ROUND(MAX(total_spent),2) AS max_spent,

    ROUND(MIN(average_order_value),2) AS min_avg_order_value,
    ROUND(MAX(average_order_value),2) AS max_avg_order_value

FROM customer_summary;