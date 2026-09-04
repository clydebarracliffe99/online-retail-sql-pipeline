--Online Retail Data Analysis Project (RFM segmentation logic)

--RFM Analysis 
WITH max_date AS (SELECT MAX(order_date) AS max_order_date
			FROM orders 		
),
rfm AS (SELECT customer_id,
			MAX(order_date) AS customer_last_order_date,
			COUNT (DISTINCT order_id) AS frequency,
			SUM (amount) AS monetary 
			FROM orders
			GROUP BY customer_id
),
recency_calc AS (SELECT r.*,
				m.max_order_date - r.customer_last_order_date AS recency
				FROM rfm r 
				CROSS JOIN max_date m 
			)
SELECT *, 
 NTILE (5) OVER (order BY recency DESC) AS r_score,
 NTILE (5) OVER (ORDER BY frequency ASC) AS f_score, 
 NTILE (5) OVER (ORDER BY monetary ASC) AS m_score
FROM recency_calc;

--RFM Segmentation 
WITH max_date AS (SELECT MAX(order_date) AS max_order_date
					FROM orders
),
rfm AS (SELECT customer_id, MAX (order_date)  AS customer_last_order_date,
		COUNT(DISTINCT order_id) AS frequency, 
		SUM(amount) AS monetary
		FROM orders 
		GROUP BY customer_id
),
recency_calc AS (SELECT r.*, m.max_order_date - r.customer_last_order_date AS recency
					FROM rfm r
					CROSS JOIN max_date m
),
recency_score AS (SELECT *,
 					NTILE (5) OVER (ORDER BY recency DESC)AS r_score,
					NTILE (5) OVER (ORDER BY frequency ASC) AS f_score,
					NTILE (5) OVER (ORDER BY monetary ASC) AS m_score
					FROM recency_calc
)
SELECT customer_id, r_score, f_score, m_score,
		CASE 
			WHEN r_score >=4 AND f_score >=4 AND m_score >=4 THEN 'Champions'
			WHEN r_score >=3 AND f_score >=3 THEN 'Loyal Customers'
			WHEN r_score >= 4 THEN 'Recent customers'
			WHEN f_score >= 4 THEN 'Frequent Customers'
			ELSE 'At Risk'
		END AS segment
FROM recency_score
ORDER BY r_score DESC, f_score DESC, m_score DESC; 
