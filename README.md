Project Overview

This project simulates a real-world e-commerce business database using MySQL.
The goal is to design a normalized database, insert transactional data, and solve business problems using SQL queries ranging from basic to advanced analytics.

This project demonstrates skills in:

Database Design
Table Relationships
SQL Joins
Aggregations
Window Functions
Business Analytics
Reporting Queries
Business Problem Statement

E-commerce companies generate large amounts of customer, product, order, and payment data.

The challenge is to answer key business questions such as:

Who are the most valuable customers?
Which products generate the highest sales?
What is the monthly revenue trend?
Which customers are repeat buyers?
Which orders failed due to payment issues?
Which customers never placed an order?
What products are top-selling?

Without structured analytics, businesses cannot make data-driven decisions.
1. customers

Stores customer details:

Customer ID
Name
Email
City
Signup Date
2. products

Stores product information:

Product ID
Product Name
Category
Price
3. orders

Stores order transactions:

Order ID
Customer ID
Order Date
Order Status
4. order_items

Stores product-level order details:

Quantity
Product mapping
5. payments

Stores payment information:

Payment Mode
Payment Status
Payment Date
SQL Concepts Used

This project covers:

SELECT
WHERE
GROUP BY
ORDER BY
INNER JOIN
LEFT JOIN
Subqueries
Aggregate Functions
Window Functions
RANK()
DENSE_RANK()
ROW_NUMBER()
HAVING clause
Business Questions Solved
Basic Analytics

✔ Customers from specific cities
✔ High-value products
✔ Total orders
✔ Delivered orders
✔ Customer count city-wise

Intermediate Analytics

✔ Orders per customer
✔ Total sales per product
✔ Customer order history
✔ Most expensive product
✔ Failed payments

Advanced Analytics

✔ Total revenue generated
✔ Highest spending customer
✔ Top 3 selling products
✔ Monthly sales report
✔ Customers with no orders
✔ Cancelled orders analysis
✔ Average order value
✔ Repeat customers
✔ Customer spending ranking

Key Insights

From the analysis:

Electronics category generated the highest revenue.
Repeat customers contribute significantly to sales.
Failed payments impact order completion.
Monthly sales trends help forecast demand.
Identifying inactive customers supports retention strategies.
Tools Used
MySQL
GitHub
Visual Studio Code
Project Outcome

This project demonstrates practical SQL skills for roles such as:

Data Analyst
Business Analyst
MIS Analyst
SQL Developer
Solution Approach

To solve this problem, I created a relational database with five interconnected tables:
