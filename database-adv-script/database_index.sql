-- ============================================================
-- DATABASE INDEX OPTIMIZATION SCRIPT
-- Objective: Create indexes to improve query performance
-- ============================================================

-- 1. Indexes on Users Table
-- Columns frequently used in authentication or lookups
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(name);

-- 2. Indexes on Bookings Table
-- user_id and property_id are commonly used in JOINs and WHERE clauses
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on check_in for date-range filtering
CREATE INDEX idx_bookings_check_in ON bookings(check_in);

-- 3. Indexes on Properties Table
-- Frequently filtered or sorted columns
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);
CREATE INDEX idx_properties_availability ON properties(availability);

-- ============================================================
-- PERFORMANCE TESTING (to be run manually in psql)
-- ============================================================

-- Example 1: Query performance before and after index creation
EXPLAIN ANALYZE
SELECT * 
FROM users
WHERE email = 'john@example.com';

-- Example 2: Query using JOINs on indexed columns
EXPLAIN ANALYZE
SELECT u.first_name, p.name, b.start_date
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE p.location = 'Nairobi, Kenya';

-- NOTE:
-- Use EXPLAIN or EXPLAIN ANALYZE before and after index creation
-- to compare query execution time and cost.

