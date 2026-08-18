-- CLEANING NULL AND DUPLICATES.

-- order Detail

SELECT SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null,
       SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_null,
       SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_null,
       SUM(CASE WHEN sku_id IS NULL THEN 1 ELSE 0 END) AS sku_id_null,
       SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_null,
	   SUM(CASE WHEN qty_ordered IS NULL THEN 1 ELSE 0 END) AS qty_ordered_null,
       SUM(CASE WHEN before_discount IS NULL THEN 1 ELSE 0 END) AS before_discount_null,
       SUM(CASE WHEN after_discount IS NULL THEN 1 ELSE 0 END) AS after_discount_null,
       SUM(CASE WHEN is_gross IS NULL THEN 1 ELSE 0 END) AS is_gross_null,
       SUM(CASE WHEN is_valid IS NULL THEN 1 ELSE 0 END) AS is_valid_null,
       SUM(CASE WHEN is_net IS NULL THEN 1 ELSE 0 END) AS is_net_null,
	   SUM(CASE WHEN payment_id IS NULL THEN 1 ELSE 0 END) AS payment_id_null
    FROM order_details
    
    -- customer_detail
    
   SELECT SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null,
		  SUM(CASE WHEN registered_date IS NULL THEN 1 ELSE 0 END) AS registered_date_null
    FROM customer_detailds      
    
    -- payment_detail
    
 SELECT SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null,
           SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS payment_method_null
 FROM payment_details
 
 
    -- sku_detail
    
    SELECT SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null,
           SUM(CASE WHEN sku_name IS NULL THEN 1 ELSE 0 END) AS sku_name_null,
           SUM(CASE WHEN base_price IS NULL THEN 1 ELSE 0 END) AS base_price_null,
           SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs_null,
           SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category_null
    FROM sku_details
    
    
    -- DUPLICATES
    
    -- order_detail
    
    SELECT id,
         customer_id,
         order_date,
         sku_id,
         price,
         qty_ordered,
         before_discount,
         after_discount,
         is_gross,
         is_valid,
         is_net,
         payment_id,
         COUNT(*)
     FROM order_details
       GROUP BY id,
         customer_id,
         order_date,
         sku_id,
         price,
         qty_ordered,
         before_discount,
         after_discount,
         is_gross,
         is_valid,
         is_net,
         payment_id
      HAVING COUNT(*) > 1;
      
      -- customer_detail
      
      SELECT id,
             registered_date,
             COUNT(*)
         FROM customer_details
         GROUP BY id,
			 registered_date
		 HAVING COUNT(*) > 1
         
         -- payment_detail
         
         SELECT id,
                payment_method,
                COUNT(*)
          FROM payment_details
          GROUP BY id,
                  payment_method
           HAVING COUNT(*) > 1    
           
           
         -- sku_detail
         
         
         SELECT id,
                sku_name,
                base_price,
                cogs,
                category,
                COUNT(*)
	     FROM sku_details
         GROUP BY id,
				sku_name,
                base_price,
                cogs,
                category
         HAVING COUNT(*) >1;
                
                  
                  
                  
                  
           