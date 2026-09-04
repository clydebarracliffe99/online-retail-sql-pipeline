--Online Retail Data Analysis Project (Customer Behaviour and retention)
--Customers with orders only in a single month 
SELECT customer_id 
FROM orders 
GROUP BY customer_id 
HAVING COUNT (DISTINCT DATE_TRUNC('month', order_date))=1;


--Customers with no orders in last month 
SELECT c.customer_id 
FROM customers c 
WHERE NOT EXISTS (SELECT 1
					FROM orders o 
					WHERE o.customer_id = c.customer_id 
					AND o.order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL '1 month'
);
					

--First and last order date per customer 
SELECT c.customer_id, MIN(o.order_date) AS first_order_date, MAX(o.order_date) AS last_order_date
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id; 


--Average Gap between orders 
SELECT customer_id, AVG (order_date - prev_order_date) AS avg_gap
FROM (SELECT customer_id, order_date, LAG (order_date) OVER (PARTITION BY customer_id ORDER BY order_date)AS prev_order_date
		FROM orders
)t
WHERE prev_order_date IS NOT NULL 
GROUP BY customer_id;

--Customer Retention / Repeat Rate (how many customers come back vs buy only once)
WITH customer_orders AS (SELECT customer_id, COUNT (order_id) AS total_orders
							FROM orders 
							GROUP BY customer_id
)
SELECT CASE WHEN total_orders = 1 THEN 'One-Time Customers'
				ELSE 'repeat customers'
				END AS customer_type,
				COUNT (*) AS total_customers,
				ROUND (COUNT (*) *100.0/SUM(COUNT(*)) OVER (),2) AS percentage
FROM customer_orders
GROUP BY customer_type
ORDER BY total_customers DESC;
