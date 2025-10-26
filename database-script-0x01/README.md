#  Database Schema Design and Normalization

## Objective
The goal of this task was to **design and normalize** a relational database for a property booking system. The system manages users, properties, bookings, payments, reviews, and messages — ensuring data integrity and eliminating redundancy by applying normalization principles up to the **Third Normal Form (3NF)**.

---

## Step 1: Understanding the Entities

The database consists of six main entities derived from the ERD:

1. **USERS** – Stores account information for guests, hosts, and admins.
2. **PROPERTIES** – Represents listings hosted by users.
3. **BOOKINGS** – Links users to properties they have booked.
4. **PAYMENTS** – Tracks payment details for each booking.
5. **REVIEWS** – Contains feedback left by users about properties.
6. **MESSAGES** – Supports communication between users.

The relationships between them are as follows:

- A **User** can host many **Properties**.
- A **User** can make many **Bookings**.
- A **Property** can have many **Bookings** and **Reviews**.
- A **Booking** can have one or more **Payments**.
- Users can send and receive **Messages**.

---

## Step 2: Normalization Process

To ensure efficiency and eliminate redundancy, normalization was applied as follows:

### **First Normal Form (1NF)**
- Each table has a primary key (`UUID`).
- Each column contains atomic values (no repeating groups).
- Data types are clearly defined.

### **Second Normal Form (2NF)**
- All non-key attributes depend entirely on the primary key.
- No partial dependencies exist since all primary keys are single-column UUIDs.

### **Third Normal Form (3NF)**
- Removed transitive dependencies:
  - User details (name, email, etc.) are only in the `USERS` table.
  - Property details are in `PROPERTIES`, not repeated in `BOOKINGS`.
  - Payment info depends only on `BOOKINGS`, not on `USERS` or `PROPERTIES`.

---

## Step 3: SQL Schema Implementation

Using PostgreSQL syntax, the schema was defined with:

- **Primary Keys** for unique identification (UUIDs).
- **Foreign Keys** for relational integrity (with `ON DELETE CASCADE`).
- **CHECK constraints** for valid ranges (e.g., rating 1–5).
- **ENUM-like constraints** using string checks for roles, status, and payment methods.
- **Indexes** on frequently queried columns to optimize performance.

Example snippet:
```sql
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) CHECK (total_price >= 0),
    status VARCHAR(50) CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dates CHECK (end_date >= start_date)
);
```

## Step 4: Relationships Overview (ERD)

The Entity-Relationship Diagram (ERD) was represented in **Mermaid** format to visually show how entities are related:

>>

## Step 5: Summary of Key Design Choices

- **UUIDs** used as primary keys for scalability and distributed systems.  
- **Timestamps** track creation and update times for auditing.  
- **Role-based design** supports guests, hosts, and admin privileges.  
- **Indexing** improves performance for frequent lookups (`email`, `role`, foreign keys).  
- **Cascade deletion** ensures referential integrity without orphan records.  

---

## Outcome

- The final database schema is fully **normalized (3NF)**.  
- It enforces **data integrity**, **scalability**, and **maintainability**.  
- The schema can be directly implemented in **PostgreSQL** or adapted to **MySQL** or **SQLite** with minimal modification.  

---

## Next Steps

1. Add **sample data** using `INSERT INTO` statements for testing.  
2. Create **views** for reporting (e.g., total bookings per host).  
3. Implement **stored procedures** or **triggers** for automation (e.g., auto-calculate total price).  

---

**Author:** Stephen Vincent  
**Project:** Property Booking System Database  
**Date:** October 2025  
