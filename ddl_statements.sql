-- Create Table Syntax
-- CREATE TABLE table_name ( col_name DATA_TYPE, ... )

-- Create customer table
CREATE TABLE customer (
	-- column_name DATATYPE <CONSTRAINTS>, 
	customer_id SERIAL PRIMARY KEY, -- PK: NOT NULL AND UNIQUE
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email_address VARCHAR(50),
	image_url VARCHAR(100),
	loyalty_member BOOLEAN DEFAULT FALSE
);


-- Add column to a table
-- ALTER TABLE table_name ADD COLUMN column_name DATATYPE
ALTER TABLE customer
ADD COLUMN username VARCHAR(50);

-- Change datatype of a column e.g. email_address from VARCHAR(50) to VARCHAR(30)
ALTER TABLE customer
ALTER COLUMN email_address TYPE VARCHAR(30);


-- Change the name of a column
ALTER TABLE customer 
RENAME COLUMN email_address TO email;


SELECT *
FROM customer;


-- Create Order Table with a FK to Customer
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	customer_id INTEGER NOT NULL,  -- NOT NULL means that this COLUMN cannot be EMPTY
	-- Syntax: FOREIGN KEY(column_in_domestic_table) REFERENCES foreign_table_name(column_in_foreign_table)
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

--SELECT CURRENT_TIMESTAMP;

SELECT *
FROM order_;


-- Create Order-Product Table
CREATE TABLE order_product (
	order_id INTEGER NOT NULL,
	FOREIGN KEY(order_id) REFERENCES order_(order_id),
	product_id INTEGER NOT NULL
--	FOREIGN KEY(product_id) REFERENCES product(product_id) -- CANNOT REFERENCE TABLE THAT DOES NOT EXIST!
);


-- Create Vendor table
CREATE TABLE vendor (
	vendor_id SERIAL PRIMARY KEY,
	vendor_name VARCHAR(50) NOT NULL,
	description VARCHAR,
	email VARCHAR(50) NOT NULL,
	image_url VARCHAR(100)
);

SELECT *
FROM vendor;

-- Create Product Table
CREATE TABLE product (
	product_id SERIAL PRIMARY KEY,
	prod_name VARCHAR(25),
	description VARCHAR,
	price NUMERIC(5,2),
	vendor_id INTEGER NOT NULL,
	FOREIGN KEY(vendor_id) REFERENCES vendor(vendor_id)
);

-- Add image url to Product
ALTER TABLE product 
ADD COLUMN image_url VARCHAR(100);

-- Make our prod_name column in the product table not null
ALTER TABLE product 
ALTER COLUMN prod_name SET NOT NULL;

SELECT *
FROM product;


-- Add the foreign key to the order_product table now that Product exists
ALTER TABLE order_product 
ADD FOREIGN KEY(product_id) REFERENCES product(product_id);




-- Create a dummy table to eventually drop

CREATE TABLE dummy(
	dummy_id SERIAL PRIMARY KEY,
	col_1 INTEGER,
	col_2 BOOLEAN
);

-- RENAME a Table
--ALTER TABLE table_name RENAME TO new_table_name
ALTER TABLE dummy
RENAME TO test;


-- To remove a column from a table, we use the DROP statement
-- BE CAREFUL WITH DROP! NO UNDOING!
ALTER TABLE test
DROP COLUMN col_1;

SELECT *
FROM test;


-- Remove a table completely - also use DROP
DROP TABLE IF EXISTS test;
-- IF EXISTS will only drop if the table exists, otherwise skip command

CREATE TABLE IF NOT EXISTS post (
	post_id SERIAL PRIMARY KEY,
	title VARCHAR(50),
	body VARCHAR
);


DROP TABLE IF EXISTS post;
