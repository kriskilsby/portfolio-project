-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS hotelbooking;
SET search_path TO hotelbooking;

-- Create table: customer
CREATE TABLE hotelbooking.customer (
  c_no INTEGER UNIQUE NOT NULL,
  c_name VARCHAR(80) NOT NULL,
  c_email VARCHAR(60) NOT NULL,
  c_address VARCHAR(200) NOT NULL,
  c_cardtype VARCHAR(2),
  CHECK (c_cardtype IN ('V', 'MC', 'A')),
  c_cardexp VARCHAR(5),
  c_cardno VARCHAR(16),
  PRIMARY KEY (c_no)
);

-- Create auto increment on customer table
ALTER TABLE hotelbooking.customer
ALTER COLUMN c_cardtype TYPE VARCHAR(5);

ALTER TABLE hotelbooking.customer
ALTER COLUMN c_cardexp TYPE VARCHAR(10);

ALTER TABLE hotelbooking.customer
ALTER COLUMN c_no DROP DEFAULT;

DROP SEQUENCE IF EXISTS customer_c_no_seq;

CREATE SEQUENCE customer_c_no_seq;

ALTER TABLE hotelbooking.customer
ALTER COLUMN c_no SET DEFAULT nextval('customer_c_no_seq');

-- Create table: room
CREATE TABLE hotelbooking.room (
  r_no INTEGER UNIQUE NOT NULL,
  r_class CHAR(5) NOT NULL,
  CHECK (r_class IN ('std_d', 'std_t', 'sup_d', 'sup_t')),
  r_status CHAR(1) DEFAULT 'A',
  CHECK (r_status IN ('O', 'C', 'A', 'X')),
  r_notes VARCHAR(300),
  PRIMARY KEY (r_no)
);

-- Create table: rates
CREATE TABLE hotelbooking.rates (
  r_class CHAR(5),
  price DECIMAL(6,2)
);

-- Create table: booking
CREATE TABLE hotelbooking.booking (
  b_ref INTEGER UNIQUE NOT NULL,
  c_no INTEGER REFERENCES hotelbooking.customer(c_no),
  b_cost DECIMAL(6,2),
  b_outstanding DECIMAL(6,2),
  b_notes VARCHAR(300),
  PRIMARY KEY (b_ref)
);

-- Create auto increment on booking table
ALTER TABLE hotelbooking.booking
ALTER COLUMN b_ref DROP DEFAULT;

DROP SEQUENCE IF EXISTS booking_b_ref_seq;

CREATE SEQUENCE booking_b_ref_seq;

ALTER TABLE hotelbooking.booking
ALTER COLUMN b_ref SET DEFAULT nextval('booking_b_ref_seq');

-- Create table: roombooking
CREATE TABLE hotelbooking.roombooking (
  r_no INTEGER REFERENCES hotelbooking.room(r_no),
  b_ref INTEGER REFERENCES hotelbooking.booking(b_ref),
  checkin DATE NOT NULL,
  checkout DATE NOT NULL,
  PRIMARY KEY (r_no, b_ref)
);
-- Add 'guests' column to roombooking table
ALTER TABLE hotelbooking.roombooking
ADD COLUMN guests INTEGER DEFAULT 1;

-- MISSING FUNCTION - Create function and trigger for Book Now booking
-- Function to calculate b_cost with insertion of new booking
CREATE OR REPLACE FUNCTION hotelbooking.update_booking_cost()
RETURNS TRIGGER AS $$
DECLARE
    room_price DECIMAL(6,2);
    nights INTEGER;
BEGIN
    -- 1. Get the price of the room
    SELECT rt.price INTO room_price
    FROM hotelbooking.room r
    JOIN hotelbooking.rates rt ON r.r_class = rt.r_class
    WHERE r.r_no = NEW.r_no;

    -- 2. Calculate number of nights
    nights := NEW.checkout - NEW.checkin;

    -- 3. Update the b_cost
    UPDATE hotelbooking.booking
    SET 
      b_cost = b_cost + (room_price * nights)
    WHERE b_ref = NEW.b_ref;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ADDED OK - Trigger to run update_booking_cost function upon insert into roombooking
CREATE TRIGGER trg_update_booking_cost
AFTER INSERT ON hotelbooking.roombooking
FOR EACH ROW
EXECUTE FUNCTION hotelbooking.update_booking_cost();

-- ####### KK ADDING FUCTIONALITY TO CAPTURE EXTRAS AND TAKE PAYMENT ##########
-- Create table to allow extra items to be captured such as bar and meals
CREATE TABLE hotelbooking.extras (
  e_id SERIAL PRIMARY KEY,
  b_ref INTEGER REFERENCES hotelbooking.booking(b_ref),
  description TEXT,
  e_cost NUMERIC(10, 2),
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ADDED OK - Add columns to booking to allow efficent processing of payment
ALTER TABLE hotelbooking.booking
ADD COLUMN b_payment DECIMAL(6,2) DEFAULT 0.00 NOT NULL,
ADD COLUMN b_paid BOOLEAN DEFAULT FALSE,
ADD COLUMN payment_date TIMESTAMP;

-- MISSING FUNCTION -  Create function and trigger to auto set payment date
-- Function to automatically set payment_date when b_paid is changed to TRUE
CREATE OR REPLACE FUNCTION set_payment_date()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.b_paid = TRUE AND (OLD.b_paid IS DISTINCT FROM TRUE) THEN
    NEW.payment_date := CURRENT_TIMESTAMP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ADDED OK - Trigger to run set_payment_date when the b_paid changs to TRUE
CREATE TRIGGER trg_set_payment_date
BEFORE UPDATE ON hotelbooking.booking
FOR EACH ROW
WHEN (OLD.b_paid IS DISTINCT FROM NEW.b_paid)
EXECUTE FUNCTION set_payment_date();

-- Contact Form Saving to Database
CREATE TABLE hotelbooking.contact_messages (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table: staff (to enable login functionality)
CREATE TABLE hotelbooking.staff (
    staff_id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    full_name TEXT
);

-- Step 1: Add the role column with a CHECK constraint
ALTER TABLE hotelbooking.staff
ADD COLUMN role TEXT CHECK (role IN ('receptionist', 'housekeeper', 'manager'));

-- Step 2: Populate roles based on known usernames
UPDATE hotelbooking.staff SET role = 'receptionist' WHERE username = 'receptionist';
UPDATE hotelbooking.staff SET role = 'housekeeper' WHERE username = 'housekeeper';
UPDATE hotelbooking.staff SET role = 'manager'      WHERE username = 'manager';


-- Insert demo staff users with hashed passwords
INSERT INTO hotelbooking.staff (username, password, full_name, role)
VALUES (
    'receptionist',
    '$2b$10$zcpFJXYYyQxSjzLzUKLjh.E6c74i0fSLaycs8nYGtWf5ODIRyScJO',
    'Receptionist person',
    'receptionist'
);

INSERT INTO hotelbooking.staff (username, password, full_name, role)
VALUES (
    'housekeeper',
    '$2b$10$WKJfNMR83uwShwvql1oL5.UQXo40chqM6.0By7NQ2TRfRJIBWUBVG',
    'Housekeeping person',
    'housekeeper'
);

INSERT INTO hotelbooking.staff (username, password, full_name, role)
VALUES (
    'manager',
    '$2b$10$d1UWBvQK5yxMIXbvdb81Oeh05LRGUpFyKzgqSICbeKlk7CH/e5OXO',
    'Manager person',
    'manager'
);


-- insert demo room data
set schema 'hotelbooking';
insert into room values (101, 'sup_d', 'A', '');
insert into room values (102, 'sup_d', 'A', '');
insert into room values (103, 'std_d', 'A', '');
insert into room values (104, 'std_d', 'A', '');
insert into room values (105, 'std_d', 'A', '');
insert into room values (106, 'std_t', 'A', '');
insert into room values (107, 'std_t', 'A', '');
insert into room values (108, 'std_t', 'A', '');
insert into room values (201, 'sup_d', 'A', '');
insert into room values (202, 'sup_d', 'A', '');
insert into room values (203, 'sup_d', 'A', '');
insert into room values (204, 'std_t', 'A', '');
insert into room values (205, 'std_t', 'A', '');
insert into room values (206, 'std_t', 'A', '');
insert into room values (207, 'std_t', 'A', '');
insert into room values (208, 'sup_t', 'A', '');
insert into room values (209, 'sup_t', 'A', '');
insert into room values (210, 'sup_t', 'A', '');
insert into room values (211, 'std_d', 'A', '');
insert into room values (212, 'std_d', 'A', '');
insert into room values (301, 'std_d', 'A', '');
insert into room values (302, 'std_d', 'A', '');
insert into room values (303, 'sup_d', 'A', '');
insert into room values (304, 'sup_d', 'A', '');
insert into room values (305, 'sup_d', 'A', '');
insert into room values (306, 'sup_d', 'A', '');
insert into room values (307, 'sup_t', 'A', '');
insert into room values (308, 'sup_t', 'A', '');
insert into room values (309, 'sup_t', 'A', '');
insert into room values (310, 'sup_t', 'A', '');
insert into room values (311, 'sup_t', 'A', '');
insert into room values (312, 'sup_t', 'A', '');

SELECT * FROM hotelbooking.room;

-- insert demo rates data
set schema 'hotelbooking';
insert into rates values ('std_t', 62);
insert into rates values ('std_d', 65);
insert into rates values ('sup_t', 75);
insert into rates values ('sup_d', 77);

SELECT * FROM hotelbooking.rates;


-- Add data_origin column to all tables for tracking demo and temporary data
ALTER TABLE hotelbooking.booking        ADD COLUMN data_origin TEXT DEFAULT 'temp';
ALTER TABLE hotelbooking.roombooking    ADD COLUMN data_origin TEXT DEFAULT 'temp';
ALTER TABLE hotelbooking.customer        ADD COLUMN data_origin TEXT DEFAULT 'temp';
ALTER TABLE hotelbooking.contact_messages ADD COLUMN data_origin TEXT DEFAULT 'temp';
ALTER TABLE hotelbooking.extras         ADD COLUMN data_origin TEXT DEFAULT 'temp';



-- Create table: reset_template for demo data resetting
SET search_path TO hotelbooking;

CREATE TABLE IF NOT EXISTS reset_template (
    r_no        INTEGER      NOT NULL,
    b_ref       INTEGER      NOT NULL,
    ci_offsett  INTEGER      NOT NULL,
    co_offsett  INTEGER      NOT NULL,
    paid        BOOLEAN      NOT NULL,
    demo_status TEXT         NULL
);

