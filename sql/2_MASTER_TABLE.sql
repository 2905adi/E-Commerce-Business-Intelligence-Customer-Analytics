/*
=========================================================
Objective:
Create a master analytical dataset by combining all
normalized tables into a single table for analytics,
Power BI dashboards and Machine Learning.

Source Tables:
1. order_detail
2. sku_detail
3. payment_detail
4. customer_detail

Output Table:
ecommerce_sales_data
=========================================================
*/

-- ------------------------------------------------------
-- Drop existing table (if exists)
-- ------------------------------------------------------

DROP TABLE IF EXISTS ecommerce_sales_data;

-- ------------------------------------------------------
-- Create Master Analytical Dataset
-- ------------------------------------------------------

CREATE TABLE ecommerce_sales_data AS

SELECT

    -- Order Information
    od.id,
    od.customer_id,
    cd.registered_date,
    od.order_date,

    -- Product Information
    sd.sku_name,
    sd.category,

    CASE
        WHEN LOWER(sd.sku_name) LIKE '%samsung%' THEN 'Samsung'
        WHEN LOWER(sd.sku_name) LIKE '%apple%'
          OR LOWER(sd.sku_name) LIKE '%iphone%'
          OR LOWER(sd.sku_name) LIKE '%macbook%' THEN 'Apple'
        WHEN LOWER(sd.sku_name) LIKE '%sony%' THEN 'Sony'
        WHEN LOWER(sd.sku_name) LIKE '%huawei%' THEN 'Huawei'
        WHEN LOWER(sd.sku_name) LIKE '%lenovo%' THEN 'Lenovo'
        WHEN LOWER(sd.sku_name) LIKE '%dell%' THEN 'Dell'
        WHEN LOWER(sd.sku_name) LIKE '%hp%' THEN 'HP'
        WHEN LOWER(sd.sku_name) LIKE '%lg%' THEN 'LG'
        ELSE 'Other'
    END AS brand,

    -- Pricing Information
    od.price,
    sd.cogs,
    od.qty_ordered,

    od.before_discount,

    COALESCE(od.discount_amount,0) AS discount_amount,

    od.after_discount,

    -- Profit
    (od.after_discount - (sd.cogs * od.qty_ordered)) AS profit,

    -- Payment Information
    pd.payment_method,

    -- Transaction Flags
    od.is_gross,
    od.is_valid,
    od.is_net

FROM order_details od

LEFT JOIN sku_details sd
       ON od.sku_id = sd.id

LEFT JOIN payment_details pd
       ON od.payment_id = pd.id

LEFT JOIN customer_details cd
       ON od.customer_id = cd.id;

-- ------------------------------------------------------
-- Verify Dataset
-- ------------------------------------------------------

SELECT *
FROM ecommerce_sales_data
LIMIT 10;

-- ------------------------------------------------------
-- Verify Total Records
-- ------------------------------------------------------

SELECT
    COUNT(*) AS total_records
FROM ecommerce_sales_data;

-- ------------------------------------------------------
-- Verify Profit Calculation
-- ------------------------------------------------------

SELECT
    id,
    after_discount,
    cogs,
    qty_ordered,
    profit
FROM ecommerce_sales_data
LIMIT 10;

-- ------------------------------------------------------
-- Verify Brand Distribution
-- ------------------------------------------------------

SELECT
    brand,
    COUNT(*) AS total_orders
FROM ecommerce_sales_data
GROUP BY brand
ORDER BY total_orders DESC;