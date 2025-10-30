-- query that retrieves all bookings along with the user details, property details, and payment details

SELECT 
    b.booking_id AS booking_id,
    u.first_name AS user_name,
    u.email AS user_email,
    p.name AS property_title,
    p.location AS property_location,
    pay.payment_id,
    pay.amount,
    b.start_date,
    b.end_date,
    b.total_price
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id;


--1. (unoptimized query)
-- Retrieve all bookings along with related user, property, and payment details
EXPLAIN ANALYZE
SELECT 
    b.booking_id AS booking_id,
    u.first_name AS user_name,
    u.email AS user_email,
    p.name AS property_title,
    p.location AS property_location,
    pay.payment_id,
    pay.amount,
    b.start_date,
    b.end_date,
    b.total_price
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id;

-- NOTE: This query retrieves all joined records but may be slow on large datasets
-- due to multiple full table scans and unindexed JOIN conditions.

--2. (optimized query with indexes)
-- Optimization Techniques:
--   - Ensure indexes exist on join columns (user_id, property_id, booking_id)
--   - Use SELECT with only necessary columns
--   - Replace unnecessary LEFT JOIN with INNER JOIN when appropriate
--   - Filter results using WHERE clauses if applicable
--   - Avoid SELECT *

EXPLAIN ANALYZE
SELECT 
    b.booking_id AS booking_id,
    u.first_name AS user_name,
    p.name AS property_title,
    pay.payment_id,
    pay.amount
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id;