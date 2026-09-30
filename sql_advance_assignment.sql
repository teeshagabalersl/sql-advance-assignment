-- Create database
CREATE DATABASE sql_advanced_assignment;

-- Select the database
USE sql_advanced_assignment;

-- create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    email VARCHAR(150) UNIQUE
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Data: Customers
INSERT INTO Customers (customer_id, customer_name, city, email)
VALUES
    (1, 'Aarav Sharma', 'Pune', 'aarav.sharma@example.com'),
    (2, 'Priya Patil', 'Mumbai', 'priya.patil@example.com'),
    (3, 'Rahul Verma', 'Delhi', 'rahul.verma@example.com'),
    (4, 'Sneha Joshi', 'Pune', 'sneha.joshi@example.com'),
    (5, 'Amit Kulkarni', 'Bangalore', 'amit.kulkarni@example.com'),
    (6, 'Neha Gupta', 'Hyderabad', 'neha.gupta@example.com'),
    (7, 'Rohan Mehta', 'Mumbai', 'rohan.mehta@example.com'),
    (8, 'Ananya Deshmukh', 'Nagpur', 'ananya.deshmukh@example.com'),
    (9, 'Vikram Singh', 'Delhi', 'vikram.singh@example.com'),
    (10, 'Kavya Nair', 'Chennai', 'kavya.nair@example.com');
    
-- Sample Data: Products
INSERT INTO Products (product_id, product_name, category, price)
VALUES
    (1, 'Laptop Pro 14', 'Electronics', 85000.00),
    (2, 'Wireless Headphones', 'Electronics', 7500.00),
    (3, 'Smartphone X', 'Electronics', 55000.00),
    (4, 'Mechanical Keyboard', 'Electronics', 4500.00),
    (5, 'Office Chair', 'Furniture', 12000.00),
    (6, 'Standing Desk', 'Furniture', 18000.00),
    (7, 'Bookshelf', 'Furniture', 8500.00),
    (8, 'Running Shoes', 'Sports', 6000.00),
    (9, 'Yoga Mat', 'Sports', 2500.00),
    (10, 'Smart Watch', 'Electronics', 15000.00);
    
-- Sample Data: Orders
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date)
VALUES
    (1, 1, 1, 1, '2026-09-01'),
    (2, 1, 2, 2, '2026-09-02'),
    (3, 2, 3, 1, '2026-09-03'),
    (4, 2, 5, 1, '2026-09-04'),
    (5, 3, 4, 2, '2026-09-05'),
    (6, 3, 8, 1, '2026-09-06'),
    (7, 4, 6, 1, '2026-09-07'),
    (8, 4, 9, 2, '2026-09-08'),
    (9, 5, 10, 1, '2026-09-09'),
    (10, 5, 7, 1, '2026-09-10'),
    (11, 6, 1, 1, '2026-09-11'),
    (12, 6, 3, 1, '2026-09-12'),
    (13, 7, 2, 1, '2026-09-13'),
    (14, 7, 5, 2, '2026-09-14'),
    (15, 8, 8, 1, '2026-09-15'),
    (16, 8, 10, 1, '2026-09-16'),
    (17, 9, 6, 1, '2026-09-17'),
    (18, 9, 4, 1, '2026-09-18'),
    (19, 10, 3, 1, '2026-09-19'),
    (20, 10, 9, 3, '2026-09-20');

-- ----------------------------------------------------------------------------------------------
-- Section 1: Advanced Joins

-- Task 1: Display each customer along with the products they ordered.
SELECT
    c.customer_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    o.order_date
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Products p
    ON o.product_id = p.product_id
ORDER BY c.customer_id, o.order_date;

-- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name
FROM Customers c
CROSS JOIN Products p
ORDER BY c.customer_id, p.product_id;

-- Task 3: Display all customers and their orders, including customers who have not placed any orders.
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.product_id,
    o.quantity,
    o.order_date
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- ----------------------------------------------------------------------------------------------
-- Section 2: Subqueries

-- Task 4: Find products priced above the average product price.
SELECT
    product_id,
    product_name,
    category,
    price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
)
ORDER BY price DESC;

-- Task 5: Display customers whose total purchase amount is greater than the 
-- average customer purchase amount.
SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * o.quantity) AS total_purchase_amount
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Products p
    ON o.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(p.price * o.quantity) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            SUM(p2.price * o2.quantity) AS customer_total
        FROM Orders o2
        JOIN Products p2
            ON o2.product_id = p2.product_id
        GROUP BY o2.customer_id
    ) AS customer_totals
)
ORDER BY total_purchase_amount DESC;

-- Task 6: Find the highest-priced product in each category using a correlated subquery.
SELECT
    p1.product_id,
    p1.product_name,
    p1.category,
    p1.price
FROM Products p1
WHERE p1.price = (
    SELECT MAX(p2.price)
    FROM Products p2
    WHERE p2.category = p1.category
)
ORDER BY p1.category, p1.price DESC;

-- ----------------------------------------------------------------------------------------------
-- Section 3: Set Operations

-- Task 7: Combine products from two different categories using UNION.
SELECT
    product_id,
    product_name,
    category,
    price
FROM Products
WHERE category = 'Electronics'

UNION

SELECT
    product_id,
    product_name,
    category,
    price
FROM Products
WHERE category = 'Furniture'
ORDER BY category, product_id;

-- Task 8A: Write MySQL alternative for INTERSECT alternative using INNER JOIN.
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category,
    p.price
FROM Products p
INNER JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.customer_id = 1
  AND p.category = 'Electronics';
  
-- Task 8B: Write MySQL alternative for EXCEPT alternative using LEFT JOIN.
SELECT
    p1.product_id,
    p1.product_name,
    p1.category,
    p1.price
FROM Products p1
LEFT JOIN Orders o
    ON p1.product_id = o.product_id
    AND o.customer_id = 1
WHERE p1.category = 'Electronics'
  AND o.product_id IS NULL;

-- ----------------------------------------------------------------------------------------------  
-- Section 4: Window Functions

-- Task 9: Rank products by price within each category.
SELECT
    product_id,
    product_name,
    category,
    price,
    RANK() OVER (
        PARTITION BY category
        ORDER BY price DESC
    ) AS price_rank
FROM Products
ORDER BY category, price_rank;

-- Task 10: Display the previous product price (LAG) and a running total of 
-- product prices using window functions.
SELECT
    product_id,
    product_name,
    category,
    price,
    LAG(price) OVER (
        ORDER BY product_id
    ) AS previous_product_price,
    SUM(price) OVER (
        ORDER BY product_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_price
FROM Products
ORDER BY product_id;

-- ----------------------------------------------------------------------------------------------  
-- Section 5: Common Table Expressions (CTEs)

-- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * o.quantity) AS total_purchase_amount
    FROM Customers c
    INNER JOIN Orders o
        ON c.customer_id = o.customer_id
    INNER JOIN Products p
        ON o.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_purchase_amount
FROM customer_totals
WHERE total_purchase_amount > (
    SELECT AVG(total_purchase_amount)
    FROM customer_totals
)
ORDER BY total_purchase_amount DESC;

-- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
WITH RECURSIVE number_sequence AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM number_sequence
    WHERE number < 10
)
SELECT number
FROM number_sequence;

-- ----------------------------------------------------------------------------------------------  
-- Section 6: Views

-- Task 13: Create a view that displays products priced above ₹1,000 and 
-- retrieve data from the view.
CREATE VIEW Products_Above_1000 AS
SELECT
    product_id,
    product_name,
    category,
    price
FROM Products
WHERE price > 1000;

SELECT *
FROM Products_Above_1000;

-- ----------------------------------------------------------------------------------------------  
-- Section 7: Indexes and Query Performance

-- Task 14: Create an index on the category column of the Products table.
CREATE INDEX idx_products_category
ON Products(category);

SHOW INDEX FROM Products;

-- Task 15: Use EXPLAIN to analyze a query that filters products by category.
EXPLAIN
SELECT
    product_id,
    product_name,
    category,
    price
FROM Products
WHERE category = 'Electronics';

-- ----------------------------------------------------------------------------------------------  
-- Section 8: Stored Procedures and Functions

-- Task 16: Create a stored procedure to retrieve products by category.
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(
    IN p_category VARCHAR(100)
)
BEGIN
    SELECT
        product_id,
        product_name,
        category,
        price
    FROM Products
    WHERE category = p_category;
END //

DELIMITER ;

CALL GetProductsByCategory('Electronics');

-- Task 17: Create a function to calculate the total price of an order (price × quantity).
DELIMITER //

CREATE FUNCTION CalculateOrderTotal(
    p_price DECIMAL(10,2),
    p_quantity INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_price * p_quantity;
END //

DELIMITER ;

SELECT
    o.order_id,
    p.product_name,
    p.price,
    o.quantity,
    CalculateOrderTotal(p.price, o.quantity) AS total_price
FROM Orders o
INNER JOIN Products p
    ON o.product_id = p.product_id
ORDER BY o.order_id;

-- ----------------------------------------------------------------------------------------------  
-- Section 9: Transactions

-- Task 18: Write a transaction that updates a product's price and demonstrate the use of COMMIT and ROLLBACK.

-- Task 18A: Commit
SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE product_id = 1;

START TRANSACTION;

UPDATE Products
SET price = price + 1000
WHERE product_id = 1;

-- Verify the updated price before committing
SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE product_id = 1;

COMMIT;

-- Verify the committed price
SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE product_id = 1;

-- Task 18B: ROLLBACK
START TRANSACTION;

UPDATE Products
SET price = price + 5000
WHERE product_id = 1;

-- Verify the temporary price change
SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE product_id = 1;

ROLLBACK;

-- Verify that the temporary change was undone
SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE product_id = 1;

-- ----------------------------------------------------------------------------------------------  
-- Section 10: SQL Triggers

-- Task 19: Create a trigger that automatically records new orders in an 
-- Order_Audit table whenever a new order is inserted.

-- Create order audit table
CREATE TABLE Order_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create trigger to audit new orders
DELIMITER //

CREATE TRIGGER trg_order_audit
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Audit (
        order_id,
        customer_id,
        product_id,
        quantity,
        order_date
    )
    VALUES (
        NEW.order_id,
        NEW.customer_id,
        NEW.product_id,
        NEW.quantity,
        NEW.order_date
    );
END //

DELIMITER ;

-- Test the trigger
INSERT INTO Orders (
    order_id,
    customer_id,
    product_id,
    quantity,
    order_date
)
VALUES (
    21,
    1,
    1,
    2,
    '2026-09-30'
);

-- Verify the audit record
SELECT *
FROM Order_Audit
WHERE order_id = 21;

-- ----------------------------------------------------------------------------------------------  
-- Section 11: Performance Tuning

-- Task 20: Optimize the queries by applying SQL performance tuning best practices.

-- BEFORE: Query with performance anti-patterns
SELECT DISTINCT *
FROM Orders
WHERE YEAR(order_date) = 2026
  AND product_id = 3;

-- Supporting index
CREATE INDEX idx_orders_product_date
ON Orders(product_id, order_date);

-- AFTER: Optimized query
   -- 1. Explicit columns instead of SELECT *
   -- 2. DISTINCT removed (order_id is the primary key, so rows are already unique)
   -- 3. No YEAR() function on order_date
   -- 4. Range condition on order_date so the composite index can be used
SELECT
    order_id,
    customer_id,
    product_id,
    quantity,
    order_date
FROM Orders
WHERE product_id = 3
  AND order_date >= '2026-01-01'
  AND order_date < '2027-01-01';