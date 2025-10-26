# Database Normalization Report

## 1. Objective

The objective of this task is to ensure that the database design follows **Third Normal Form (3NF)** to minimize redundancy and maintain data integrity.

---

## 2. Initial Schema (Before Normalization)

Below is the initial schema that contained some redundancy:

**Orders Table**

| order_id | customer_name | customer_phone | product_id | product_name | product_price | quantity |
| -------- | ------------- | -------------- | ---------- | ------------ | ------------- | -------- |

Issues identified:

- Customer details are repeated for every order.
- Product details are repeated for every purchase.
- This violates 2NF and 3NF because non-key attributes depend on other non-key attributes.

---

## 3. Normalization Process

### **Step 1: First Normal Form (1NF)**

- Ensure atomicity (each cell holds one value only).
- Removed repeating groups by splitting customer and product data.

**Revised Tables:**

- `Customers(customer_id, customer_name, customer_phone)`
- `Products(product_id, product_name, product_price)`
- `Orders(order_id, customer_id, product_id, quantity)`

✅ **Achieved 1NF**

---

### **Step 2: Second Normal Form (2NF)**

- Remove partial dependencies (attributes depending on part of a composite key).

Since each table now has a single-column primary key (`customer_id`, `product_id`, `order_id`), there are no partial dependencies.

✅ **Achieved 2NF**

---

### **Step 3: Third Normal Form (3NF)**

- Remove transitive dependencies (non-key attributes depending on other non-key attributes).

Example of violation:  
If we had a field like `total_price` in the Orders table that depends on `product_price * quantity`, this would be a derived attribute.

**Fix:** Remove `total_price` and compute it during queries or in application logic.

✅ **Achieved 3NF**

---

## 4. Final Normalized Schema (3NF)

**Customers**

| customer_id | customer_name | customer_phone |
| ----------- | ------------- | -------------- |

**Products**

| product_id | product_name | product_price |
| ---------- | ------------ | ------------- |

**Orders**

| order_id | customer_id | product_id | quantity |
| -------- | ----------- | ---------- | -------- |

---

## 5. Explanation

- Redundancy has been removed by isolating entities.
- Each non-key attribute depends **only** on the primary key.
- Data anomalies (insertion, update, deletion) are eliminated.
- The design is efficient and scalable.

---

## 6. ER Diagram (Optional)

If you want to visualize this using **Mermaid**, add the following code snippet:

```mermaid
erDiagram
    CUSTOMERS {
        int customer_id PK
        string customer_name
        string customer_phone
    }
    PRODUCTS {
        int product_id PK
        string product_name
        float product_price
    }
    ORDERS {
        int order_id PK
        int customer_id FK
        int product_id FK
        int quantity
    }

    CUSTOMERS ||--o{ ORDERS : places
    PRODUCTS ||--o{ ORDERS : contains
