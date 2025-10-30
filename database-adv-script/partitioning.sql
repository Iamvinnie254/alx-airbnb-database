-- Step 1: Drop existing table if it exists
DROP TABLE IF EXISTS bookings CASCADE;

-- Step 2: Create the parent table partitioned by RANGE on start_date
CREATE TABLE bookings (
    booking_id SERIAL,
    user_id UUID REFERENCES users(user_id),
    property_id UUID REFERENCES properties(property_id),
    start_date DATE NOT NULL,
    end_date DATE,
    total_amount DECIMAL(10, 2),
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions by month (example for Jan–Mar 2025)
CREATE TABLE bookings_2025_01 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE bookings_2025_02 PARTITION OF bookings
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE bookings_2025_03 PARTITION OF bookings
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

-- Step 4: Insert sample data
INSERT INTO bookings (user_id, property_id, start_date, end_date, total_amount)
VALUES 
(
  'b9545690-0aa9-478d-b8bc-ad03db8594bf',  
  '43694009-df6a-4d39-95b1-ff3251f2a0a3',  
  '2025-01-05',
  '2025-01-10',
  250.00
);

-- Step 5: Query to test performance on date range
EXPLAIN ANALYZE
SELECT * 
FROM bookings
WHERE start_date BETWEEN '2025-02-01' AND '2025-03-01';
