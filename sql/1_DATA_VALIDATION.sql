/*====================================================================
                    SCRIPT 01 : DATA VALIDATION
======================================================================
Objective:
Validate the quality, completeness, and integrity of the e-commerce
database before performing business analysis.
======================================================================*/


/*--------------------------------------------------------------------
Q1. Dataset Overview
Count the total records available in each table.
--------------------------------------------------------------------*/

SELECT 'customer_details' AS table_name, COUNT(*) AS total_records
FROM customer_details

UNION ALL

SELECT 'order_details', COUNT(*)
FROM order_details

UNION ALL

SELECT 'sku_details', COUNT(*)
FROM sku_details

UNION ALL

SELECT 'payment_details', COUNT(*)
FROM payment_details;



/*--------------------------------------------------------------------
Q2. Missing Value Check
Check important business columns for missing values.
--------------------------------------------------------------------*/

SELECT
    SUM(customer_id IS NULL)      AS missing_customer_id,
    SUM(sku_id IS NULL)           AS missing_sku_id,
    SUM(payment_id IS NULL)       AS missing_payment_id,
    SUM(order_date IS NULL)       AS missing_order_date,
    SUM(qty_ordered IS NULL)      AS missing_quantity,
    SUM(before_discount IS NULL)  AS missing_before_discount,
    SUM(discount_amount IS NULL)  AS missing_discount_amount,
    SUM(after_discount IS NULL)   AS missing_after_discount

FROM order_details;



/*--------------------------------------------------------------------
Q3. Referential Integrity Check
Ensure every order references valid master records.
--------------------------------------------------------------------*/

-- Invalid Customer IDs
SELECT
    COUNT(*) AS invalid_customer_records
FROM order_details od
LEFT JOIN customer_details c
       ON od.customer_id = c.id
WHERE c.id IS NULL;

-- Invalid SKU IDs
SELECT
    COUNT(*) AS invalid_sku_records
FROM order_details od
LEFT JOIN sku_details s
       ON od.sku_id = s.id
WHERE s.id IS NULL;

-- Invalid Payment IDs
SELECT
    COUNT(*) AS invalid_payment_records
FROM order_details od
LEFT JOIN payment_details p
       ON od.payment_id = p.id
WHERE p.id IS NULL;



/*--------------------------------------------------------------------
Q4. Transaction Timeline
Verify the available analysis period.
--------------------------------------------------------------------*/

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    COUNT(DISTINCT YEAR(order_date)) AS years_available
FROM order_details;



/*--------------------------------------------------------------------
Q5. Valid vs Invalid Transactions
Check transaction quality before analysis.
--------------------------------------------------------------------*/

SELECT
    is_valid,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM order_details
GROUP BY is_valid
ORDER BY total_orders DESC;



/*--------------------------------------------------------------------
Q6. Revenue Validation
Validate key financial metrics before dashboard creation.
--------------------------------------------------------------------*/

SELECT
    ROUND(SUM(before_discount),2) AS gross_revenue,
    ROUND(SUM(after_discount),2) AS net_revenue,
    ROUND(AVG(after_discount),2) AS average_order_value
FROM order_details;