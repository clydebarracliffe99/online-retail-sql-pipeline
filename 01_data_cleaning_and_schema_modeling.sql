--ONLINE RETAIL DATA ANALYSIS PROJECT 
--Dataset: Kaggle Online Retail Dataset 
--Tools: PostgreSQL 
--Author: Clyde Barracliffe 

--Step 1 Developing the raw-table
DROP TABLE IF EXISTS online_retail;
CREATE TABLE online_retail (
	invoice TEXT, 
	stockcode TEXT,
	description TEXT, 
	quantity INT, 
	invoicedate TIMESTAMP,
	price NUMERIC,
	customer_id NUMERIC, 
	country TEXT
);

--STEP 2: Importing the raw dataset 
--Note: This copy command helps in improting the original 1 million row CSV
--A separate sample is present in this repository for schema preview 
COPY online_retail(invoice, stockcode, description, quantity, invoicedate, price, customer_id, country)
FROM 'C:\Users\Public\Documents\online_retail_II.csv'
DELIMITER ','
CSV HEADER;

--Confirming if the csv file has been imported into the table correctly 
SELECT * FROM online_retail; 
SELECT COUNT (*) FROM online_retail; 
SELECT * FROM online_retail LIMIT 5;

--Step 3 Data Cleaning 
-- i Checking null customer_ids 
SELECT COUNT (*)
FROM online_retail 
WHERE customer_id IS NULL;

--ii Removing NULL customer_ids
DELETE FROM online_retail 
WHERE customer_id IS NULL;

--iii Checking cancelled invoices 
SELECT COUNT (*)
FROM online_retail 
WHERE invoice LIKE 'C%';

--iv Removing cancelled invoices 
DELETE FROM online_retail
WHERE invoice LIKE 'C%';

--v Checking invalid values 
SELECT COUNT (*)
FROM online_retail 
WHERE quantity<=0 or price <=0;

--vi Removing invalid values 
DELETE FROM online_retail 
WHERE quantity<=0 or price <=0;

--vii Counting rows after cleaning 
SELECT COUNT (*)
FROM online_retail;

---Converting customer_id to INT 
ALTER TABLE online_retail 
ALTER COLUMN customer_id TYPE INT 
USING customer_id::INT;


--Step 4 Creating tables 
--Customers 
CREATE TABLE customers AS 
SELECT DISTINCT 
	customer_id, country 
FROM online_retail;

--Products 
CREATE TABLE products AS 
SELECT DISTINCT stockcode AS product_id, description 
FROM online_retail;

--Orders 
CREATE TABLE orders AS 
SELECT 
	invoice AS order_id, 
	customer_id,
	MIN (invoicedate) AS order_date,
	SUM (price*quantity) AS amount
FROM online_retail
GROUP BY invoice, customer_id;

--Sales 
CREATE TABLE sales AS 
SELECT 
	invoice AS order_id,
	customer_id,
	stockcode AS product_id,
	description,
	quantity,
	price, 
	invoicedate,
	(quantity * price) AS amount
FROM online_retail;
