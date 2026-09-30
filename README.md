# Advanced SQL Assignment

## Assignment Overview

This assignment demonstrates advanced SQL concepts using **MySQL** and **MySQL Workbench**.

The assignment covers advanced querying, subqueries, set operations, window functions, Common Table Expressions (CTEs), views, indexes, stored procedures, functions, transactions, triggers, and SQL performance tuning.

The SQL script creates the database, tables, sample data, and implements all the required tasks.

---

## Database Schema

The database contains three main tables:

### Customers

Stores customer information.

| Column | Data Type | Description |
|---|---|---|
| `customer_id` | INT | Primary key |
| `customer_name` | VARCHAR(100) | Customer name |
| `city` | VARCHAR(100) | Customer city |
| `email` | VARCHAR(150) | Customer email |

### Products

Stores product information.

| Column | Data Type | Description |
|---|---|---|
| `product_id` | INT | Primary key |
| `product_name` | VARCHAR(100) | Product name |
| `category` | VARCHAR(100) | Product category |
| `price` | DECIMAL(10,2) | Product price |

### Orders

Stores customer orders.

| Column | Data Type | Description |
|---|---|---|
| `order_id` | INT | Primary key |
| `customer_id` | INT | Foreign key referencing `Customers` |
| `product_id` | INT | Foreign key referencing `Products` |
| `quantity` | INT | Quantity ordered |
| `order_date` | DATE | Order date |

### Relationships

- `Orders.customer_id` references `Customers.customer_id`
- `Orders.product_id` references `Products.product_id`

An additional `Order_Audit` table is created in Task 19 to store audit records for newly inserted orders.

---

## Steps to Execute the SQL Script

### Prerequisites

- MySQL Server
- MySQL Workbench

### Execution Steps

1. Open **MySQL Workbench**.
2. Connect to the local MySQL server.
3. Open the `sql_advanced_assignment.sql` file.
4. Execute the SQL statements in the order provided.
5. The script:
   - Creates the `sql_advanced_assignment` database.
   - Creates the `Customers`, `Products`, and `Orders` tables.
   - Inserts sample data.
   - Executes the required advanced SQL tasks.
   - Creates views, indexes, stored procedures, functions, and triggers.
   - Demonstrates transactions and performance tuning.
6. Verify the output of each task in the MySQL Workbench result panel.

> **Note:** If individual sections have already been executed, avoid executing the complete script again without resetting the database or handling existing objects.

---

## Advanced SQL Concepts Implemented

### 1. Advanced Joins

- `INNER JOIN`
- `CROSS JOIN`
- `LEFT JOIN`

### 2. Subqueries

- Scalar subqueries
- Aggregate subqueries
- Correlated subqueries

### 3. Set Operations

- `UNION`
- MySQL alternative for `INTERSECT` using `INNER JOIN`
- MySQL alternative for `EXCEPT` using `LEFT JOIN` and `IS NULL`

### 4. Window Functions

- `RANK()`
- `LAG()`
- Running totals using `SUM() OVER()`
- `PARTITION BY`

### 5. Common Table Expressions (CTEs)

- Non-recursive CTEs
- Recursive CTEs
- Generating a sequence from 1 to 10

### 6. Views

- Created a view for products priced above ₹1,000
- Retrieved data from the view

### 7. Indexes and Query Performance

- Created an index on the `Products.category` column
- Used `EXPLAIN` to analyze category filtering

### 8. Stored Procedures and Functions

- Stored procedure to retrieve products by category
- Function to calculate the total price of an order using `price × quantity`

### 9. Transactions

- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`

### 10. SQL Triggers

- Created an `Order_Audit` table
- Created an `AFTER INSERT` trigger on `Orders`
- Automatically records newly inserted orders

### 11. Performance Tuning

Applied SQL performance tuning best practices:

- Avoiding `SELECT *`
- Removing unnecessary `DISTINCT`
- Avoiding functions on indexed columns
- Using index-friendly filtering
- Creating a composite index on `Orders(product_id, order_date)`

