-- Contact Form Saving to Database
CREATE TABLE hotelbooking.contact_messages (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM hotelbooking.contact_messages ORDER BY created_at DESC;

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


SELECT staff_id, username, role FROM hotelbooking.staff;

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

-- Create auto increment
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

-- Create auto increment
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
-- Check the function is setup run below
SELECT routine_name, routine_schema, routine_type
FROM information_schema.routines
WHERE routine_name = 'update_booking_cost';

-- Trigger to run update_booking_cost function upon insert into roombooking
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
-- Add columns to booking to allow efficent processing of payment
ALTER TABLE hotelbooking.booking
ADD COLUMN b_payment DECIMAL(6,2) DEFAULT 0.00 NOT NULL,
ADD COLUMN b_paid BOOLEAN DEFAULT FALSE,
ADD COLUMN payment_date TIMESTAMP;

-- MISSING FUNCTION - Create function and trigger to auto set payment date
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
-- Check the function is setup run below
SELECT routine_name, routine_schema, routine_type
FROM information_schema.routines
WHERE routine_name = 'set_payment_date';
-- Trigger to run set_payment_date when the b_paid changs to TRUE
CREATE TRIGGER trg_set_payment_date
BEFORE UPDATE ON hotelbooking.booking
FOR EACH ROW
WHEN (OLD.b_paid IS DISTINCT FROM NEW.b_paid)
EXECUTE FUNCTION set_payment_date();
