---Online Retail Data Analysis Project (Product Affinity Analysis) 
--Most frequent product per customer 
WITH product_count AS (SELECT customer_id, 
						product_id, description, 
						COUNT (*) AS product_cnt
					FROM sales 
					GROUP BY customer_id, product_id, description
),
ranked_products AS (SELECT customer_id,
					product_id, description,
					product_cnt,
					ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY product_cnt DESC)AS rnk
					FROM product_count)

SELECT product_id, description, customer_id 
FROM ranked_products 
WHERE rnk = 1;


--Customers who bought at least 50% of products 
SELECT customer_id 
FROM sales 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_id) >= (SELECT COUNT(DISTINCT product_id)*0.5
FROM products);


--Customer product coverage analysis 
SELECT customer_id, 
	COUNT (DISTINCT product_id)*1.0/(SELECT COUNT (DISTINCT product_id) FROM products) AS product_coverage 
FROM sales 
GROUP BY customer_id 
ORDER BY product_coverage DESC;
