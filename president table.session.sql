CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(200),
    address VARCHAR(150),
    city VARCHAR(150),
    customer_state VARCHAR(100),
    zip_code VARCHAR(50)
);

CREATE TABLE "order"(
    order_id SERIAL PRIMARY KEY,
    order_date date DEFAULT CURRENT_DATE,
    amount NUMERIC(10,2),
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);