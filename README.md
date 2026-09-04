                                                            SQL + Data Analysis Project
                                                        Online Retail Data Analysis (PostgreSQL)

Objective 

To focus on analyzing client behavior, revenue trends, performance of products, and retention patterns utilizing SQL-oriented analysis on retail data.


Tools Utilized 
* PostgreSQL (SQL)
* Window Functions (LAG, RANK, SUM OVER) 
* Common Table Expressions (CTEs)
* Aggregations & Joins 


Table of Contents 
* [Data Cleaning](#data-cleaning)
* [Data Modeling](#data-modeling)
* [Revenue and Growth Analysis](#revenue-and-growth-analysis)
* [Customer Behavior and Retention](#customer-behavior-and-retention) 
* [RFM Segmentation](#rfm-segmentation)
* [Product affinity Analysis](#product-affinity-analysis)
* [Insight Summary](#insight-summary)


Dataset used
* The online retail II dataset consists of all the transactions occurring for a UK-based, non-store online retail between 1/12/2009 and 9/12/2011. 
* It is comprised of 1,067,371 rows and eight columns. 
* The use of Kaggle has been done to acquire the dataset and the link for the dataset is https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci/data.


## Data Cleaning 
The main data cleaning steps have been listed below: 
* Removed nulls values from customer_id and order_date
* Handled duplicates by removing duplicate transactions
* Standardized date format utilising DATE_TRUNC
* Created and renamed columns 


The queries that have been used for data cleaning have been shown below:

<img width="538" height="694" alt="image" src="https://github.com/user-attachments/assets/e92648e2-d6d8-42af-9a48-6a918963de65" />

## Data Modeling 

The tables that have been utilized are orders, customers, products and sales. The queries used for data modeling have also been shown below:

<img width="723" height="885" alt="image" src="https://github.com/user-attachments/assets/520a767e-a4a1-4052-a9b4-26a3c2bd20b5" />

## Revenue and Growth Analysis 


Month Over Month spending rise 

This query is mainly related to finding out clients whose spending rose over time with the usage of LAG functions. 

<img width="734" height="521" alt="image" src="https://github.com/user-attachments/assets/9d656794-c955-4e38-b0cd-b30246ab487e" />

<img width="220" height="456" alt="image" src="https://github.com/user-attachments/assets/545110da-d010-445a-80f5-12ea12f53e8b" />


Cumulative spending per client

In this query, the total spending of clients over time has been tracked with the help of the window function SUM ( ) OVER.  

<img width="940" height="348" alt="image" src="https://github.com/user-attachments/assets/4e293c64-5e32-4d7a-8759-5d3504985f65" />


Top three clients by revenue

The use of CTE has been done to find out the top 3 clients who contribute highly towards revenue generation of the organisation.  

<img width="940" height="522" alt="image" src="https://github.com/user-attachments/assets/00edac98-2ff0-4fe1-9dbf-ba1040d82f26" /> 


Orders above average per client 

Calculates high value transactions compared to client average orders. 

<img width="940" height="302" alt="image" src="https://github.com/user-attachments/assets/1df2087e-7f8c-45a3-bc47-510e68c8b40f" />


Monthly revenue growth analysis 

Revenue trends over time have been shown in the form of final summary metrics. 

<img width="940" height="690" alt="image" src="https://github.com/user-attachments/assets/e46ba6a9-8b4e-49dc-9f43-2a35db862b62" />


## Customer Behavior and Retention 


Clients active for only 1 month 

This query helps in identifying low-engagement clients who bought in one month. 

<img width="823" height="165" alt="image" src="https://github.com/user-attachments/assets/ac19effc-295f-4718-8687-15d896f2bcb1" />

<img width="1030" height="336" alt="image" src="https://github.com/user-attachments/assets/1de6a4cc-daa4-4fb3-94b5-6ab38c4cad27" /> 


Clients with not a single order in the last month 

This query is all about detecting clients who have churned or are not active recently. 

<img width="879" height="558" alt="image" src="https://github.com/user-attachments/assets/b64d9825-a7e4-45ac-b0e4-80b0f29c6656" />


First and last order date per client  

This query shows the first and last order date of the client so it helps in showing the client life cycle duration

<img width="940" height="519" alt="image" src="https://github.com/user-attachments/assets/adadcd0a-4d29-4508-a100-503c05c9fb58" />


Average gap between orders 

The query that has been shown below examines clients’ purchasing behaviors by calculating average gap between orders in the case of each customer.  

<img width="973" height="439" alt="image" src="https://github.com/user-attachments/assets/3f51c4fa-a7e3-4ebe-8821-403c02864765" />


Customer Retention / Retention Rate  

Tracks business growth utilizing month over month revenue comparisons. 

<img width="940" height="491" alt="image" src="https://github.com/user-attachments/assets/fe7a1386-6089-42b2-9918-26d9527837e4" />


## RFM Segmentation


RFM Analysis 

This query helps in categorizing clients as per recency score, frequency score monetary score. 

The use of the NTILE ( ) over function has been done to calculate these scores. 

<img width="940" height="724" alt="image" src="https://github.com/user-attachments/assets/936f6dfe-70ed-4d47-ab06-46cd160380e4" />


RFM Segmentation 

In this query the clients have been segmented into groups such as champions, loyal customers, frequent customers etc. 

<img width="940" height="687" alt="image" src="https://github.com/user-attachments/assets/c8a2436c-84f2-4593-a48f-d9cb26ab8b70" />

<img width="709" height="503" alt="image" src="https://github.com/user-attachments/assets/14e8979c-3a5e-4d73-822f-5bb97e926693" />


## Product affinity Analysis


Most Frequent Product per client 

This query helps in identifying affinity of product per client, the use of ranking has been done to find out the most frequent product per client. 

<img width="661" height="769" alt="image" src="https://github.com/user-attachments/assets/11e4ee67-d8a9-42d6-8d68-6fa0356ba50a" />


Clients buying at least fifty percent of products

Calculate the client product coverage so clients buying about 50 percent of the product types have been shown in the output. Client with customer id 14911 seems to be the only customer who bought at least fifty percent of products.  

<img width="940" height="378" alt="image" src="https://github.com/user-attachments/assets/99bd97a0-59c6-45f4-a8dc-71064bf6be69" /> 


Product coverage analysis 

This query helps in calculating diversity of products bought per client which means that it shows how much of the products is bought by each customer.  

<img width="940" height="443" alt="image" src="https://github.com/user-attachments/assets/ff03138f-4d09-4567-84f6-8a6477a995d2" /> 


## Insight Summary

<img width="1857" height="607" alt="SALES AND CUSTOMER DASHBOARD" src="https://github.com/user-attachments/assets/e0488184-b033-4473-bc2d-3b4089d6961e" />


The main aim of this project is to recognize client behavior, revenue patterns and business performance utilizing real-time data of the retail industry. 


Client Behavior Insights 

The segmentation and behavioral queries help in revealing how clients focus on interacting with the firm over the passage of time. The main components that have been recognized are: 

* A segment of 1-time purchasers that indicates low engagement or weak retention rates 
* Repeat clients, who can be considered as the backbone of the firm’s revenue. 
* Clients with rising monthly expenditure shows the trust towards the firm among clients and its also indicates that a huge segment of the clients are satisfied with products provided. 
* Such kind of information is crucial for developing more efficient and targeted marketing approaches that will improve client retention. 


Revenue and Growth Analysis 

* Examining monthly revenue and checking their growth percentages helps in highlighting the performance of the business in the market over the passage of time. 
* Some months demonstrate positive growth trends, showing the success of the firm or an increase in the seasonal demands of the clients.
* However, it has been observed that there are some time-periods when there is a decline in the monthly revenue of the business which proves that client churn does occur. 
* This helps the firm to recognize when to scale marketing efforts and when to focus on performance drop investigations. 


Client Value Recognition

* The use of ranking and aggregation functions have helped in identifying high value clients. 
* The top three clients on the basis of revenue have been identified which signifies that these are the people who contribute a disproportionate share of the total earnings. 
* Running-total and above average purchases analyses show which clients purchase products more that other peer groups in a consistent manner.
* These clients are the main targets for loyalty-programs, premium offerings or customized engagements. 


Product and Purchase Patterns 

* Product coverage and frequency analysis help in providing information regarding purchasing diverseness. 
* Some clients buy narrow sets of products a numerous number of times which show strong preferences 
* Other individuals have high product-coverage showing exploratory buying behaviors. 
* Such insights can be utilized for recommendation systems and developing inventory plans. 


Retention and Churn Insights

* Retention related queries aid in identifying client stability 
* A 1-time buyer represents potential churn risks.
* Repeat clients reveal healthy retention.
* Average order gaps demonstrate how often clients return to buy products. 
Improvement of retention has a direct impact on long-term stability of the firm in the market. 
