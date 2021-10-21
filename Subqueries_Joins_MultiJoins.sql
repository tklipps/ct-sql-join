-- Inner Join Actor with Film_actor table with multi join to film actor
SELECT first_name, last_name, film.title
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film.film_id = film_actor.film_id

-- Left Join on the Actor and Film_actor
SELECT *
FROM film_actor -- Table A
LEFT JOIN  actor -- Table B
ON actor.actor_id = film_actor.actor_id

-- Left Join on the Actor and Film_actor 
-- Just get ACTOR data that isn't linked to Film_actor
SELECT *
FROM film_actor -- Table A
LEFT JOIN  actor -- Table B
ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id is NULL


-- RIGHT Join on the Actor and Film_actor 
SELECT *
FROM film_actor -- Table A
RIGHT JOIN actor -- Table B
ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id is NULL


-- RIGHT Join on the Actor and Film_actor 
SELECT *
FROM film_actor -- Table A
RIGHT JOIN actor -- Table B
ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id is NULL

-- Join will produce info about a customer that
--from the country of Angola

SELECT customer.first_name, customer.last_name,customer.email,
address.address,city.city,country.country
FROM customer
FULL JOIN address
ON address.address_id = customer.address_id
FULL JOIN city
ON city.city_id = address.city_id
FULL JOIN country
ON country.country_id = city.country_id
WHERE country.country = 'Angola'
ORDER BY customer.first_name DESC

-- THIS IS WHERE YOU WANT TO MAKE YOUR OWN DATABSE not use the class test-db database
-- Customer Table for Presidents
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25),
	last_name VARCHAR(30),
	email VARCHAR(50),
	address VARCHAR(100),
	city VARCHAR(25),
	customer_state VARCHAR(2),
	zipcode VARCHAR(5)
);

-- Order Table for Presidents
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date DATE DEFAULT CURRENT_DATE,
	amount NUMERIC(5,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

SELECT * FROM customer;
SELECT * FROM order_;

-- Add Presidents into our Customer Table
INSERT INTO customer(first_name, last_name, email, address, city, customer_state, zipcode)
VALUES ('George', 'Washington', 'gwash@usa.gov', '32-- Mt. Vernon Hwy', 'Mt. Vernon', 'VA', '12323'),
('John', 'Adams', 'jadams@usa.gov', '1200 Hancock Rd', 'Quincy', 'MA', '02174'),
('Thomas', 'Jefferson', 'tjeff@usa.gov', '555 N Monticelle Drive', 'Monticello', 'VA', '34725'),
('James', 'Madison', 'maddog@usa.gov', '6362 S Constitution', 'Montpeller', 'VA', '22957'),
('James', 'Monroe', 'jman@whitehouse.gov', '1600 Pennsylvania Ave', 'Washington', 'DC', '87342')


-- Add orders to our Order Table
INSERT INTO order_(amount, customer_id)
VALUES(234.56, 1),
(74.34, 3),
(100.00, 2),
(42.32, 3),
(55.55, NULL)

-- INSERT INTO order_(amount, customer_id)
-- VALUES(10001, 1)


-- (Inner) Join
SELECT cus.customer_id, cus.first_name, cus.last_name, cus.email, o.amount, o.order_date
FROM order_ as o
JOIN customer as cus
ON cus.customer_id = o.customer_id;

-- Natural Join 
SELECT cus.customer_id, cus.first_name, cus.last_name, cus.email, o.amount, o.order_date
FROM order_ as o
NATURAL JOIN customer as cus;


-- Left Join
SELECT cus.customer_id, first_name, last_name, order_id, amount, order_date
FROM customer as cus -- Left Table
LEFT JOIN order_ as o -- Right Table
ON cus.customer_id = o.customer_id;

SELECT *
FROM customer
NATURAL LEFT JOIN order_;

-- Right Join
SELECT cus.customer_id, first_name, last_name, order_id, amount, order_date
FROM customer as cus -- Left Table
RIGHT JOIN order_ as o -- Right Table
ON cus.customer_id = o.customer_id;

SELECT *
FROM customer
NATURAL RIGHT JOIN order_;

-- Full Join
SELECT cus.customer_id, first_name, last_name, order_id, amount, order_date
FROM customer as cus
FULL JOIN order_ as o
ON cus.customer_id = o.customer_id;

SELECT *
FROM customer 
NATURAL FULL JOIN order_;

-- END STUFF WITH THE NEWLY CREATED TABLE



-- SubQuery Examples
-- Two queries split apart (which will become a subquery later)


-- SUBQUERY
-- get all the customers info that have spent more than $175

--Find all the customers
SELECT * 
FROM customer;

-- What customer have 175 or more in payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Combine as a subquery
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
    ORDER BY SUM(amount) DESC
)




-- Find all films with a language of English

--Outer Query
SELECT *
from film;

-- INNER QUERY
SELECT language_id
FROM language
WHERE name = 'English'

-- FULL QUERY
SELECT * 
FROM film 
WHERE language_id IN 
    (SELECT language_id
    FROM language
    WHERE name = 'English')
ORDER BY release_year DESC


-- Basic Subquery 
-- Find all films with a language of 'English'

SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);




SELECT store_id,first_name,last_name,address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola' AND customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

