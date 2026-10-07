-- ========================================================
-- PAYFLOW - DATABASE PERFORMANCE TUNING
-- EXPLAIN + INDEX + SARGable Query
-- ========================================================

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- ========================================================
-- LEGACY TABLE
-- ========================================================

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- ========================================================
-- 1. EXPLAIN QUERY CŨ
-- Non-SARGable: YEAR() / MONTH() được áp dụng lên created_at
-- ========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- ========================================================
-- 2. TẠO COMPOSITE INDEX
-- transaction_type: điều kiện equality
-- created_at: điều kiện range
-- ========================================================

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);

-- ========================================================
-- 3. EXPLAIN QUERY ĐÃ TỐI ƯU
-- Loại bỏ YEAR() / MONTH() và sử dụng điều kiện range
-- ========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- ========================================================
-- 4. QUERY ĐÃ TỐI ƯU
-- ========================================================

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';
