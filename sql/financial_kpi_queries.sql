CREATE DATABASE startup_finance;
use  startup_finance;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date DATE,
    channel VARCHAR(50)
);

CREATE TABLE revenue (
    revenue_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    customer_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    category VARCHAR(50),
    amount DECIMAL(10,2)
);

CREATE TABLE marketing_spend (
    marketing_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    channel VARCHAR(50),
    spend DECIMAL(10,2)
);

CREATE TABLE cash_balance (
    as_of_date DATE,
    cash_balance DECIMAL(12,2)
);
-- Data Cleaning Check for NULL values
-- Customers
SELECT * FROM customers
WHERE customer_id IS NULL
   OR signup_date IS NULL
   OR channel IS NULL;
-- Revenue
SELECT * FROM revenue
WHERE date IS NULL
   OR customer_id IS NULL
   OR amount IS NULL;
DELETE FROM revenue WHERE amount IS NULL;
-- expenses
SELECT *
FROM expenses
WHERE date IS NULL
   OR category IS NULL
   OR amount IS NULL;
-- Validate date ranges
SELECT r.* FROM revenue r JOIN customers c ON r.customer_id = c.customer_id
WHERE r.date < c.signup_date;

SELECT MIN(date), MAX(date) FROM expenses;
SELECT MIN(date), MAX(date) FROM marketing_spend;
-- Check for negative or zero amounts
-- Revenue
SELECT * FROM revenue WHERE amount <= 0;
-- expenses
SELECT * FROM expenses WHERE amount <= 0;
DELETE FROM expenses WHERE amount <= 0;
-- Marketing
SELECT * FROM marketing_spend WHERE spend <= 0;
-- Validate categorical values
SELECT DISTINCT channel FROM customers;
-- Duplicate checks
-- Duplicate customers
SELECT customer_id, COUNT(*) FROM customers
GROUP BY customer_id HAVING COUNT(*) > 1;
-- Duplicate revenue rows
SELECT date, customer_id, amount, COUNT(*) FROM revenue
GROUP BY date, customer_id, amount HAVING COUNT(*) > 1;

SELECT * FROM vw_pnl_summary;
SELECT * FROM vw_monthly_burn ORDER BY month;
SELECT * FROM vw_runway;
SELECT * FROM vw_customers_by_channel;
SELECT * FROM vw_marketing_by_channel;
SELECT * FROM vw_cac_by_channel;
SELECT *  FROM vw_ltv_per_customer LIMIT 10;
SELECT * FROM vw_avg_ltv;
SELECT * FROM vw_unit_economics;
   