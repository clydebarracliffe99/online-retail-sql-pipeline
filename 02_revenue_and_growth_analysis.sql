--Customers who increased spending month over month 
WITH month_spend AS(SELECT customer_id, DATE_TRUNC('month', order_date) AS month, 
							SUM (amount) AS monthly_spending
				 FROM orders 
				 GROUP BY customer_id, DATE_TRUNC ('month', order_date)
),
prev_spend AS (SELECT
						customer_id,
						month,
						monthly_spending,
						LAG(monthly_spending) OVER (PARTITION BY customer_id ORDER BY month) AS prev_spending
				  FROM month_spend
)
SELECT DISTINCT customer_id 
FROM prev_spend 
WHERE prev_spending IS NOT NULL
GROUP BY customer_id 
HAVING MIN (CASE WHEN 
				monthly_spending > prev_spending
				THEN 1 
				ELSE 0
				END) = 1;

--Cumulative Spending per customer 
SELECT order_date, customer_id, amount, 
					SUM (amount) OVER(PARTITION BY customer_id ORDER BY order_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders;

--Query 6: Top 3 customers by revenue 
WITH revenue AS (SELECT customer_id, SUM(amount)AS total_revenue
					FROM orders 
					GROUP BY customer_id
),
ranked_customers AS (SELECT customer_id, total_revenue, 
						DENSE_RANK () OVER (ORDER BY total_revenue DESC) AS rnk
						FROM revenue)
SELECT customer_id, total_revenue
FROM ranked_customers
WHERE rnk <=3; 

--Orders Above average per customer 
SELECT customer_id, order_id, amount 
FROM (SELECT customer_id, order_id, amount, AVG(amount) OVER (PARTITION BY customer_id) AS average_amt
FROM orders)t
WHERE amount>average_amt;

--Monthly revenue growth analysis 
WITH monthly_revenue AS (SELECT DATE_TRUNC ('month', order_date)AS month,
						SUM(amount) AS revenue
					FROM orders 
					GROUP BY DATE_TRUNC ('month',order_date)
)
SELECT month, revenue, LAG (revenue) OVER (ORDER BY month) AS prev_month_revenue,
		ROUND ((revenue-LAG(revenue) OVER (ORDER BY month))*100.0/LAG(revenue) OVER (ORDER BY month),2) AS growth_percentage
FROM monthly_revenue
ORDER BY month;