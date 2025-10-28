-- Inner join to retrieve all bookings and the respective users who made those bookings.

SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.check_in,
    bookings.check_out
FROM bookings
INNER JOIN users 
    ON bookings.user_id = users.id;

-- LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SELECT 
    properties.id AS property_id,
    properties.title AS property_title,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews 
    ON properties.id = reviews.property_id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.check_in,
    bookings.check_out
FROM users
FULL OUTER JOIN bookings 
    ON users.id = bookings.user_id;
