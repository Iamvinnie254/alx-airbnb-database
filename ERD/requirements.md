# ERD DIAGRAM FOR AIRBNB DATABASE

```mermaid
erDiagram
  USERS {
    uuid user_id PK
    string first_name
    string last_name
    string email
    string password_hash
    string phone_number
    enum role
    timestamp created_at
  }

  PROPERTIES {
    uuid property_id PK
    string name
    text description
    string location
    decimal price_per_night
    timestamp created_at
    timestamp updated_at
    uuid host_id FK
  }

  BOOKINGS {
    uuid booking_id PK
    uuid property_id FK
    uuid user_id FK
    date start_date
    date end_date
    decimal total_price
    enum status
    timestamp created_at
  }

  PAYMENTS {
    uuid payment_id PK
    uuid booking_id FK
    decimal amount
    timestamp payment_date
    enum payment_method
  }

  REVIEWS {
    uuid review_id PK
    uuid user_id FK
    uuid property_id FK
    integer rating
    text comment
    timestamp created_at
  }

  MESSAGES {
    uuid message_id PK
    uuid sender_id FK
    uuid recipient_id FK
    text message_body
    timestamp sent_at
  }

  USERS ||--o{ PROPERTIES : "hosts"
  USERS ||--o{ BOOKINGS : "makes"
  USERS ||--o{ REVIEWS : "writes"
  USERS ||--o{ MESSAGES : "sends/receives"

  PROPERTIES ||--o{ BOOKINGS : "has"
  PROPERTIES ||--o{ REVIEWS : "receives"
  
  BOOKINGS ||--|{ PAYMENTS : "includes"
