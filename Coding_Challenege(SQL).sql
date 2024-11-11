--Test 1--
--Ecommerce SQL--

--Creating Database--
CREATE DATABASE ECOM
USE ECOM

--Creating Tables--

--Customers--
CREATE TABLE customers (
customer_id INT IDENTITY PRIMARY KEY,
firstName VARCHAR(50),
lastName VARCHAR(50),
email VARCHAR(50) UNIQUE,
[address] VARCHAR(100)
)


--Products--
CREATE TABLE products (
product_id INT IDENTITY PRIMARY KEY,
[name] VARCHAR(50),
price DECIMAL(10,2),
[description] VARCHAR(100),
stockQuantity INT
)

--Cart--
CREATE TABLE cart(
cart_id INT IDENTITY PRIMARY KEY,
customer_id INT,
product_id INT,
quantity INT,
CONSTRAINT FK_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id), 
CONSTRAINT FK_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
)

--Orders--
CREATE TABLE orders (
order_id INT IDENTITY PRIMARY KEY,
customer_id INT,
order_date DATE,
total_price DECIMAL(20,2),
shipping_address VARCHAR(100),
CONSTRAINT FK_ordered_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)

--Order_items--
CREATE TABLE order_items (
order_item_id INT IDENTITY PRIMARY KEY,
order_id INT ,
product_id INT,
quantity INT,
itemAmount DECIMAL(10,2),
CONSTRAINT FK_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id)
)



--Inserting Values--

--Products--
INSERT INTO products ([name],[description],price,stockQuantity)
VALUES ('Laptop','High-performance laptop',800.00, 10),
('Smartphone','Latest smartphone',600.00,15),
('Tablet','Portable tablet',300.00,20),
('Headphones','Noise-canceling',150.00,30),
('TV','4K Smart TV',900.00,5),
('Coffee Maker','Automatic coffee maker',50.00,25),
('Refrigerator','Energy-efficient',700.00,10),
('Microwave Oven','Countertop microwave',80.00,15),
('Blender','High-speed blender',70.00,20),
('Vacuum Cleaner','Bagless vacuum cleaner',120.00,10)

--Customers--
INSERT INTO customers (firstName, lastName, Email, [address])
VALUES 
('John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
('Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
('Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
('Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
('David', 'Lee', 'david@example.com', '234 Cedar St, District'),
('Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
('Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
('Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
('William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
('Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory')

--Order--
INSERT INTO orders (customer_id, order_date, total_price)
VALUES 
(1, '2023-01-05', 1200.00),
(2, '2023-02-10', 900.00),
(3, '2023-03-15', 300.00),
(4, '2023-04-20', 150.00),
(5, '2023-05-25', 1800.00),
(6, '2023-06-30', 400.00),
(7, '2023-07-05', 700.00),
(8, '2023-08-10', 160.00),
(9, '2023-09-15', 140.00),
(10, '2023-10-20', 1400.00)

--order_items--
INSERT INTO Order_items (order_id, product_id, quantity, itemAmount)
VALUES 
(1, 1, 2, 1600.00), 
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00)

--cart--
INSERT INTO cart (customer_id, product_id, quantity)
VALUES 
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2)


--Questions--

/*1. Update refrigerator product price to 800.*/

UPDATE products
SET price=800.00
WHERE name='Refrigerator'

SELECT * FROM products

/*2. Remove all cart items for a specific customer.2. Remove all cart items for a specific customer.*/

DELETE  FROM cart
WHERE customer_id=7

SELECT * FROM cart

/*3. Retrieve Products Priced Below $100.*/

SELECT [name] FROM products
WHERE price <100.00

/*4. Find Products with Stock Quantity Greater Than 5.*/

SELECT [name] FROM products
WHERE stockQuantity>5

/*5. Retrieve Orders with Total Amount Between $500 and $1000.*/

SELECT order_id FROM orders
WHERE total_price BETWEEN 500 AND 1000

/*6. Find Products which name end with letter ‘r’.*/

SELECT [name] FROM products
WHERE [name] LIKE '%r'

/*7. Retrieve Cart Items for Customer 5.*/

SELECT * FROM cart
WHERE customer_id=5

/*8. Find Customers Who Placed Orders in 2023.*/

SELECT customer_id FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'

/*9.given= Determine the Minimum Stock Quantity for Each Product Category.
altered= Determine the Minimum Stock Quantity for Particular Product.*/


SELECT MIN(stockQuantity) AS min_stock_quantity FROM products
WHERE [name]='HeadPhones'

--for checking inserting values--
INSERT INTO products ([name],[description],price,stockQuantity)
VALUES ('Headphones','Noise-canceling',150.00,5) 

/*10. Calculate the Total Amount Spent by Each Customer.*/

SELECT CONCAT_WS ('',firstName,lastName) AS customer_name,o.customer_id ,SUM(total_price) AS total_amount FROM orders o
LEFT JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.firstName,c.lastName

--for checking inserting values--
INSERT INTO orders (customer_id, order_date, total_price)
VALUES (4, '2023-09-05', 150.00)

/*11. Find the Average Order Amount for Each Customer.*/

SELECT CONCAT_WS ('',firstName,lastName) AS customer_name,o.customer_id ,AVG(total_price) AS average_amount FROM orders o
LEFT JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.firstName,c.lastName

/*12. Count the Number of Orders Placed by Each Customer.*/

SELECT CONCAT_WS ('',firstName,lastName) AS customer_name,o.customer_id ,COUNT(order_id)AS no_of_orders FROM orders o
LEFT JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.firstName,c.lastName

/*13. Find the Maximum Order Amount for Each Customer*/

SELECT CONCAT_WS ('',firstName,lastName) AS customer_name,o.customer_id ,MAX(total_price)AS max_order_amount FROM orders o
LEFT JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.firstName,c.lastName

--for checking inserting values--
INSERT INTO orders (customer_id, order_date, total_price)
VALUES (4, '2023-09-05', 300.00)

/*14. Get Customers Who Placed Orders Totaling Over $1000.*/

SELECT CONCAT_WS ('',firstName,lastName) AS customer_name,o.customer_id ,SUM(total_price) AS total_amount FROM orders o
LEFT JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.firstName,c.lastName


/*15. Subquery to Find Products Not in the Cart.*/

SELECT product_id
FROM products
WHERE product_id NOT IN (SELECT product_id FROM Cart);

/*16. Subquery to Find Customers Who Haven't Placed Orders.*/

SELECT customer_id, firstName, lastName
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

/*17. Subquery to Calculate the Percentage of Total Revenue for a Product.*/

SELECT product_id, 
       (SUM(itemAmount) / (SELECT SUM(itemAmount) FROM order_items) * 100) AS revenuePercentage
FROM order_items
GROUP BY product_id;

/*18. Subquery to Find Products with Low Stock.*/
SELECT product_id,[name], stockQuantity
FROM products
WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM products);


/*19. Subquery to Find Customers Who Placed High-Value Orders*/
SELECT customer_id, firstName, lastName
FROM customers
WHERE customer_id IN (SELECT customer_id 
                     FROM orders 
                     WHERE total_price > (SELECT AVG(total_price) FROM orders));

