--###########################################--
-- RALET ENTERPRISE BUSINESS ANALYTICS
--###########################################--

--PROBLEM:
--Calculate 


--###########################################--
---1) week on week customer Retention.
--###########################################--

-- Customer Retention refers to the ability of a business to turn customers into repeat buyers.
-- View the data
SELECT *
FROM sale;

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM sale;

-- During which week was each purchase made?
SELECT customer_id, DATEPART(WEEK, sale_date) AS week_purchase
FROM sale
GROUP BY customer_id, DATEPART(WEEK, sale_date)
ORDER BY customer_id, week_purchase;

-- When was the first purchase made by each Customer?
SELECT customer_id, MIN(DATEPART(WEEK, sale_date)) AS first_purchase_week
FROM sale
GROUP BY customer_id
ORDER BY customer_id;


-- Merge the two tables
SELECT a.customer_id, b.first_purchase_week, a.week_purchase
FROM
(
SELECT customer_id, DATEPART(WEEK, sale_date) AS week_purchase
FROM sale
GROUP BY customer_id, DATEPART(WEEK, sale_date)
) a,
(
SELECT customer_id, MIN(DATEPART(WEEK, sale_date)) AS first_purchase_week
FROM sale
GROUP BY customer_id
) b
WHERE a.customer_id = b.customer_id
ORDER BY customer_id, first_purchase_week, week_purchase;



-- Calculate the week_number of purchase. Difference between current week purchase and first week purchase
SELECT 
	a.customer_id, b.first_purchase_week, a.week_purchase, 
	a.week_purchase - b.first_purchase_week AS week_repurchase_number
FROM
(
SELECT customer_id, DATEPART(WEEK, sale_date) AS week_purchase
FROM sale
GROUP BY customer_id, DATEPART(WEEK, sale_date)
) a,
(
SELECT customer_id, MIN(DATEPART(WEEK, sale_date)) AS first_purchase_week
FROM sale
GROUP BY customer_id
) b
WHERE a.customer_id = b.customer_id
ORDER BY customer_id, first_purchase_week, week_purchase;


-- Pivot the data. 
-- One row for first week purchase
-- One column for each week_number containing the number of customers who come back after ‘n’ weeks 
-- to use your product/service. 
SELECT first_purchase_week,
	SUM(CASE WHEN week_repurchase_number = 0 THEN 1 ELSE 0 END) AS week_0,
	SUM(CASE WHEN week_repurchase_number = 1 THEN 1 ELSE 0 END) AS week_1,
    SUM(CASE WHEN week_repurchase_number = 2 THEN 1 ELSE 0 END) AS week_2,
    SUM(CASE WHEN week_repurchase_number = 3 THEN 1 ELSE 0 END) AS week_3,
    SUM(CASE WHEN week_repurchase_number = 4 THEN 1 ELSE 0 END) AS week_4,
    SUM(CASE WHEN week_repurchase_number = 5 THEN 1 ELSE 0 END) AS week_5,
    SUM(CASE WHEN week_repurchase_number = 6 THEN 1 ELSE 0 END) AS week_6,
    SUM(CASE WHEN week_repurchase_number = 7 THEN 1 ELSE 0 END) AS week_7,
    SUM(CASE WHEN week_repurchase_number = 8 THEN 1 ELSE 0 END) AS week_8,
    SUM(CASE WHEN week_repurchase_number = 9 THEN 1 ELSE 0 END) AS week_9,
	SUM(CASE WHEN week_repurchase_number = 10 THEN 1 ELSE 0 END) AS week_10,
	SUM(CASE WHEN week_repurchase_number = 11 THEN 1 ELSE 0 END) AS week_11,
	SUM(CASE WHEN week_repurchase_number = 12 THEN 1 ELSE 0 END) AS week_12,
	SUM(CASE WHEN week_repurchase_number = 13 THEN 1 ELSE 0 END) AS week_13,
	SUM(CASE WHEN week_repurchase_number = 14 THEN 1 ELSE 0 END) AS week_14,
	SUM(CASE WHEN week_repurchase_number = 15 THEN 1 ELSE 0 END) AS week_15,
	SUM(CASE WHEN week_repurchase_number = 16 THEN 1 ELSE 0 END) AS week_16,
	SUM(CASE WHEN week_repurchase_number = 17 THEN 1 ELSE 0 END) AS week_17,
	SUM(CASE WHEN week_repurchase_number = 18 THEN 1 ELSE 0 END) AS week_18
FROM
(
SELECT 
	a.customer_id, b.first_purchase_week, a.week_purchase, 
	a.week_purchase - b.first_purchase_week AS week_repurchase_number
FROM
	(
	SELECT customer_id, DATEPART(WEEK, sale_date) AS week_purchase
	FROM sale
	GROUP BY customer_id, DATEPART(WEEK, sale_date)) a,
	(
	SELECT customer_id, MIN(DATEPART(WEEK, sale_date)) AS first_purchase_week
	FROM sale
	GROUP BY customer_id
	) b
	WHERE a.customer_id = b.customer_id
	) AS with_week_repurchase_number
GROUP BY first_purchase_week
ORDER BY first_purchase_week;



