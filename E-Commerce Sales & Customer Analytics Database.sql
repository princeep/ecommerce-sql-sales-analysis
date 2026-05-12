create database assignment_2;
use assignment_2;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
	foreign key (customer_id) references customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_mode VARCHAR(30),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers VALUES
(1,'Amit Sharma','amit@gmail.com','Delhi','2024-01-10'),
(2,'Neha Verma','neha@gmail.com','Mumbai','2024-01-12'),
(3,'Rohit Singh','rohit@gmail.com','Bangalore','2024-02-01'),
(4,'Pooja Mehta','pooja@gmail.com','Pune','2024-02-10'),
(5,'Rahul Kumar','rahul@gmail.com','Gurgaon','2024-03-05');

INSERT INTO products VALUES
(101,'iPhone 15','Electronics',75000),
(102,'Samsung TV','Electronics',45000),
(103,'Nike Shoes','Fashion',6000),
(104,'Laptop Bag','Accessories',2000),
(105,'Bluetooth Headphones','Electronics',3000);

INSERT INTO orders VALUES
(1001,1,'2024-03-10','Delivered'),
(1002,2,'2024-03-12','Delivered'),
(1003,1,'2024-03-15','Cancelled'),
(1004,3,'2024-03-18','Delivered'),
(1005,4,'2024-03-20','Pending');

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,104,2),
(3,1002,102,1),
(4,1003,103,1),
(5,1004,105,2),
(6,1004,103,1),
(7,1005,104,1);

INSERT INTO payments VALUES
(201,1001,'UPI','Success','2024-03-10'),
(202,1002,'Credit Card','Success','2024-03-12'),
(203,1003,'Debit Card','Failed','2024-03-15'),
(204,1004,'UPI','Success','2024-03-18'),
(205,1005,'Net Banking','Pending','2024-03-20');


-- List all customers from Delhi 
SELECT 
    *
FROM
    customers
WHERE
    city = 'Delhi';

-- Show all products with price > 5000
select * from products where  price > 5000;

-- Find total number of orders
 select count(order_id) as 'total order'  from orders; 
 
 -- Display all delivered orders
 select * from orders where order_status = 'Delivered';
 
 --   Count total customers city-wise
select city,count(customer_name) as 'total customer' from customers group by city;

select *  ,dense_rank() over(partition by order_status order by order_status) as order_status_rank
from orders;

 select product_name,category,price,
 row_number() over(partition by category order by price ) as row_Num
 from products;
 
--  Easy Level
 -- Find total orders placed by each customer
 select c.customer_name,count(o.order_id) as 'total_order' from customers as c
 join orders as o
 on c.customer_id = o.customer_id
 group by c.customer_name
 order by 'total_order' desc;
 
 -- Find total sales amount per order
 select o.product_id,sum(p.price) as 'total_price' from products as p
 join order_items as o
 on p.product_id = o.product_id
 group by p.product_id
 order by 'total_price';
 
 -- Show customer name and their order date
 
 select c.customer_name,o.order_date from customers as c
 join orders as o
 on c.customer_id = o.customer_id;
 
--  Find most expensive product
select * from products where price = (select max(price) from products);

-- Show all orders where payment failed
 select o.customer_id,o.order_date,o.order_status,p.payment_status from orders as o
 join payments as p
 on o.order_id = p.order_id
 where p.payment_status = 'failed';
 
--  Advanced Level (Interview Level)
--  Find total revenue generated
SELECT 
    o.order_status,
    SUM(p.price * oi.quantity) AS 'total revenue'
FROM
    products p
        JOIN
    order_items AS oi ON p.product_id = oi.product_id
        JOIN
    orders AS o ON o.order_id = oi.order_id
        JOIN
    payments AS pmt ON pmt.order_id = o.order_id
WHERE
    o.order_status = 'Delivered'
        AND pmt.payment_status = 'Success';
        
-- Find customer who spent the most money        
select c.customer_name,sum(p.price*oi.quantity) as 'total_spent_money' from  customers as c
join orders as o
on c.customer_id = o.customer_id
join order_items as oi
on o.order_id = oi.order_id
join products as p
on p.product_id = oi.product_id
group by c.customer_id,c.customer_name order by total_spent_money desc limit 1;


-- Find top 3 selling products by quantity
select p.product_name,sum(oi.quantity) as 'total_quantity' from products as p
join order_items as oi
on p.product_id = oi.product_id
group by p.product_name order by total_quantity desc limit 3;

-- Find monthly sales report
select month(o.order_date)as 'months',sum(p.price*oi.quantity) as 'total_sales' from orders as o
join order_items  as oi
on o.order_id  = oi.order_id
join products as p
on p.product_id = oi.product_id
group by months;

-- Find customers who never placed any order
select c.customer_id,c.customer_name from customers as c
left join orders as o
on c.customer_id = o.customer_id 
where o.order_id is null;

-- Find cancelled orders with payment status
select o.order_status,pmt.payment_status from orders as o
join payments as pmt 
on o.order_id = pmt.order_id
where o.order_status = 'cancelled';

-- Find average order value
select  avg(p.price * oi.quantity) as 'ave_price' from products  as p
join order_items as oi
on p.product_id = oi.product_id;


-- Find orders with more than 1 item
select o.order_id,sum(oi.quantity) as'total_item' from orders as o
join order_items as oi
on o.order_id = oi.order_id
group by o.order_id
having sum(oi.quantity) > 1;

-- Find repeat customers
select c.customer_name,count(o.order_id) as 'total_order',o.customer_id from customers  as c
join orders  as o
on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name 
having count(o.order_id)>1;


SELECT
    customer_id,
    customer_name,
    total_spending,
    RANK() OVER (ORDER BY total_spending DESC) AS rank_num
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * oi.quantity) AS total_spending
    FROM customers c
    JOIN orders o 
        ON o.customer_id = c.customer_id
    JOIN order_items oi 
        ON oi.order_id = o.order_id
    JOIN products p 
        ON p.product_id = oi.product_id
    GROUP BY c.customer_id, c.customer_name
) t;



 select * from customers;
select * from orders;
select * from products;
select * from order_items;
select * from payments;
