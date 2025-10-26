# ...Continuation

## Step 6: Populating the Database with Sample Data

After defining the schema, the next step is to populate the database with sample data that reflects realistic usage.  
This helps verify relationships, constraints, and queries before deploying to production.

---

### Sample Data Insertion Script

Below is the complete SQL script for inserting sample data into the **Property Booking System** database.

```sql
-- ============================================
--  SAMPLE DATA INSERTION SCRIPT
-- Property Booking System Database
-- ============================================

-- =======================
-- USERS
-- =======================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Stephen', 'Vincent', 'stephen.vincent@example.com', 'hashed_password_123', '+254700111222', 'admin'),
    (gen_random_uuid(), 'Alice', 'Njoroge', 'alice.njoroge@example.com', 'hashed_password_234', '+254711222333', 'host'),
    (gen_random_uuid(), 'Brian', 'Otieno', 'brian.otieno@example.com', 'hashed_password_345', '+254722333444', 'guest'),
    (gen_random_uuid(), 'Mary', 'Kamau', 'mary.kamau@example.com', 'hashed_password_456', '+254733444555', 'guest'),
    (gen_random_uuid(), 'David', 'Mutua', 'david.mutua@example.com', 'hashed_password_567', '+254744555666', 'host');

-- =======================
-- PROPERTIES
-- =======================
INSERT INTO properties (property_id, name, description, location, price_per_night, host_id)
SELECT
    gen_random_uuid(), 'Ocean Breeze Villa', 'A beautiful seaside villa with ocean views.', 'Mombasa', 12000.00, user_id
FROM users WHERE email = 'alice.njoroge@example.com';

INSERT INTO properties (property_id, name, description, location, price_per_night, host_id)
SELECT
    gen_random_uuid(), 'Mountain Escape Cabin', 'Cozy cabin located in the heart of Mount Kenya.', 'Nanyuki', 8500.00, user_id
FROM users WHERE email = 'david.mutua@example.com';

-- =======================
-- BOOKINGS
-- =======================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    gen_random_uuid(), p.property_id, u.user_id, '2025-11-10', '2025-11-15', 60000.00, 'confirmed'
FROM users u, properties p
WHERE u.email = 'brian.otieno@example.com' AND p.name = 'Ocean Breeze Villa';

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    gen_random_uuid(), p.property_id, u.user_id, '2025-12-01', '2025-12-03', 17000.00, 'pending'
FROM users u, properties p
WHERE u.email = 'mary.kamau@example.com' AND p.name = 'Mountain Escape Cabin';

-- =======================
-- PAYMENTS
-- =======================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(), b.booking_id, 60000.00, 'mobile_money'
FROM bookings b
WHERE b.status = 'confirmed';

INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(), b.booking_id, 17000.00, 'paypal'
FROM bookings b
WHERE b.status = 'pending';

-- =======================
-- REVIEWS
-- =======================
INSERT INTO reviews (review_id, user_id, property_id, rating, comment)
SELECT
    gen_random_uuid(), u.user_id, p.property_id, 5, 'Amazing stay! The view and service were excellent.'
FROM users u, properties p
WHERE u.email = 'brian.otieno@example.com' AND p.name = 'Ocean Breeze Villa';

INSERT INTO reviews (review_id, user_id, property_id, rating, comment)
SELECT
    gen_random_uuid(), u.user_id, p.property_id, 4, 'Lovely cabin, very peaceful and clean.'
FROM users u, properties p
WHERE u.email = 'mary.kamau@example.com' AND p.name = 'Mountain Escape Cabin';

-- =======================
-- MESSAGES
-- =======================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(), u1.user_id, u2.user_id, 'Hi Alice, is the Ocean Breeze Villa available next month?'
FROM users u1, users u2
WHERE u1.email = 'brian.otieno@example.com' AND u2.email = 'alice.njoroge@example.com';

INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(), u1.user_id, u2.user_id, 'Hi Brian, yes! The villa is open for bookings in December.'
FROM users u1, users u2
WHERE u1.email = 'alice.njoroge@example.com' AND u2.email = 'brian.otieno@example.com';

-- ============================================
-- ✅ SAMPLE DATA SUCCESSFULLY POPULATED
-- ============================================

### Setup Note

Enable UUID generation in PostgreSQL before running the script:

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

### Outcome

The database now contains real-world sample data for testing and demos.  

Relationships between users, properties, bookings, and payments are validated automatically.  

This dataset can be used to test frontend API integrations or backend logic.  

---

**Author:** Stephen Vincent  
**Project:** Property Booking System Database  
**Date:** October 2025
