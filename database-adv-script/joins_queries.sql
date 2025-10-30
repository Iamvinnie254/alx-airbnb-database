-- Inner join to retrieve all bookings and the respective users who made those bookings.

SELECT 
    users.user_id AS user_id,
    users.first_name AS user_name,
    bookings.booking_id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date
FROM bookings
INNER JOIN users 
    ON bookings.user_id = users.user_id;

-- LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    properties.property_id AS property_id,
    properties.name AS property_title,
    reviews.review_id AS review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews 
    ON properties.property_id = reviews.property_id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT 
    users.user_id AS user_id,
    users.first_name AS user_name,
    bookings.booking_id AS booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date
FROM users
FULL OUTER JOIN bookings 
    ON users.user_id = bookings.user_id;
