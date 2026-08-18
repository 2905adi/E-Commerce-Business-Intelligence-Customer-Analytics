-- customer segmentation data:
-- customer_id,total_spend(sum_revenue),total_unit,
-- range between register and 1st day order,range of 1st and last day order


CREATE TABLE customer_summary AS 
WITH selected_data AS 
(
SELECT sd.customer_id,
       cd.registered_date,
       sd.order_date,
       sd.qty_ordered,
       sd.after_discount
FROM ecommerce_sales_data sd
LEFT JOIN customer_details cd
ON sd.customer_id = cd.id
WHERE sd.is_valid =1 
)
SELECT customer_id,
	DATEDIFF( MIN(registered_date), MIN(order_date)) AS registered_to_order_duration,
    DATEDIFF( MAX(order_date), MIN(order_date)) AS first_to_last_order_duration,
    SUM(qty_ordered) AS total_unit,
    SUM(after_discount) AS total_spent
       
FROM selected_data
GROUP BY customer_id;

