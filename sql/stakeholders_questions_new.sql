use ecommerce_db;
-- is valid = not cancelled or actual transaction

-- In 2024, in which month was the highest total transaction value (after_discount recorded)?

SELECT MONTH(order_date) AS month_num,
	   SUM(after_discount) AS total_transaction
FROM order_details
WHERE YEAR(order_date) = 2024 AND is_valid = 1
GROUP BY MONTH(order_date)
ORDER BY SUM(after_discount) DESC;

-- ANSWER: OCTOBER

-- 2. IN 2025, Which category generated the highest transaction value?

SELECT sd.category,
       SUM(od.after_discount) AS total_transaction
FROM order_details od
LEFT JOIN sku_details sd
ON od.sku_id = sd.id
WHERE YEAR(od.order_date) = 2025 AND od.is_valid = 1
GROUP BY sd.category
ORDER BY total_transaction DESC;

-- ANSWER: MOBILES AND TABLETS(100K)

-- 3. COMPARE TRANSACTION VALUES FOR EACH CATEGORY IN 2024 AND 2025.
-- IDENTIFY CATEGORIES WITH INCREASED OR DECREASED TRANSACTION VALUES FROM 2024 TO 2025.

WITH transaction_2024 AS 
(
SELECT sd.category,
       SUM(od.after_discount) AS total_transaction_2024
FROM order_details od
LEFT JOIN sku_details sd
ON od.sku_id = sd.id
WHERE od.is_valid = 1 AND YEAR(od.order_date) = 2024
GROUP BY sd.category
),
transaction_2025 AS 
(
SELECT sd.category,
       SUM(od.after_discount) AS total_transaction_2025
FROM order_details od
LEFT JOIN sku_details sd
ON od.sku_id = sd.id
WHERE od.is_valid = 1 AND YEAR(od.order_date) = 2025
GROUP BY sd.category
)
SELECT t1.category,
	   t1.total_transaction_2024,
       t2.total_transaction_2025,
       (t2.total_transaction_2025 - t1.total_transaction_2024) AS difference_value,
       CASE WHEN t2.total_transaction_2025 - t1.total_transaction_2024 > 0
       THEN 'Increased' ELSE 'Decreased' END AS status
FROM transaction_2024 t1 
LEFT JOIN transaction_2025 t2
ON t1.category  = t2.category


-- 4. SHOW THE TOP 5 MOST POPULAR PAYMENT METHODS USED IN 2025 (BASED ON TOTAL UNIQUE ORDERS)

SELECT pd.payment_method,
       COUNT(DISTINCT od.id) AS total_unique_order
FROM order_details od
LEFT JOIN payment_details pd
ON od.payment_id = pd.id
WHERE od.is_valid =1 AND YEAR(od.order_date) = 2025
GROUP BY pd.payment_method
ORDER BY COUNT(DISTINCT od.id) DESC
LIMIT 5;
 
-- ANSWER: COD,PAYAXIS,CUSTOMERCREDIT,EASYPAY,JAZZWALLET


-- 5. RANK THE FOLLOWING 5 PRODUCTS BY TRANSACTION VALUE : SAMSUNG,APPLE,SONY,HUAWEI,LENOVO. 

WITH product_sales AS 
(
SELECT CASE WHEN LOWER(sd.sku_name) LIKE '%samsung%' THEN 'samsung'
		    WHEN LOWER(sd.sku_name) LIKE '%apple%'
            OR LOWER(sd.sku_name) LIKE '%iphone%'
            OR LOWER(sd.sku_name) LIKE '%macbook%' THEN 'apple'
            WHEN LOWER(sd.sku_name) LIKE '%sony%' THEN 'sony'
            WHEN LOWER(sd.sku_name) LIKE '%huawei%' THEN 'huawei'
            WHEN LOWER(sd.sku_name) LIKE '%lenovo%' THEN 'lenovo'
            ELSE 'other'
         END AS product_name,
         SUM(od.after_discount) AS transaction_value
FROM  order_details od 
LEFT JOIN sku_details sd
ON od.sku_id = sd.id
WHERE od.is_valid = 1
GROUP BY  CASE WHEN LOWER(sd.sku_name) LIKE '%samsung%' THEN 'samsung'
		    WHEN LOWER(sd.sku_name) LIKE '%apple%'
            OR LOWER(sd.sku_name) LIKE '%iphone%'
            OR LOWER(sd.sku_name) LIKE '%macbook%' THEN 'apple'
            WHEN LOWER(sd.sku_name) LIKE '%sony%' THEN 'sony'
            WHEN LOWER(sd.sku_name) LIKE '%huawei%' THEN 'huawei'
            WHEN LOWER(sd.sku_name) LIKE '%lenovo%' THEN 'lenovo'
            ELSE 'other'
            END
      )
      SELECT *
      FROM product_sales 
      WHERE product_name != 'other'
      ORDER BY transaction_value DESC;