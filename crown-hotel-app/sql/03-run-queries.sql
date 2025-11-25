SELECT * FROM hotelbooking.staff;
SELECT * FROM hotelbooking.room ORDER BY r_no ASC;
SELECT * FROM hotelbooking.booking ORDER BY b_ref ASC;
SELECT * FROM hotelbooking.customer;
SELECT * FROM hotelbooking.rates;
SELECT * FROM hotelbooking.roombooking
WHERE r_no = 108
ORDER BY r_no ASC,
      b_ref ASC,
      checkin ASC,
      checkout ASC;
SELECT * FROM hotelbooking.extras;
SELECT * FROM contact_messages;

-- DELETE A CONTACT MESSAGE
DELETE FROM contact_messages
WHERE id = 9;

-- ROOMS BY TYPE
SELECT r_class AS room_type, COUNT(*) AS total_rooms
FROM hotelbooking.room
GROUP BY r_class
ORDER BY r_class;

-- ROOMS AVAILABLE BY ROOM TYPE FOR DATE RANGE
SELECT r.r_no, r.r_class
FROM hotelbooking.room r
WHERE r.r_no NOT IN (
  SELECT rb.r_no
  FROM hotelbooking.roombooking rb
  WHERE NOT (
    '2025-05-05' >= rb.checkout OR
    '2025-05-07' <= rb.checkin
  )
)
ORDER BY r.r_class, r.r_no;


// ALL FUTURE BOOKINGS, INCL NAME & DATES BOOKED
SELECT 
  b.b_ref AS booking_ref,
  c.c_name AS name,
  c.c_email AS email,
  r.r_class AS room_type,
  rb.r_no AS room_no,
  TO_CHAR(rb.checkin, 'YYYY-MM-DD') AS check_in,
  TO_CHAR(rb.checkout, 'YYYY-MM-DD') AS check_out,
  rb.guests,
  COALESCE(b.b_cost, 0) AS total_cost,      -- total booking cost
  COALESCE(b.b_outstanding, 0) AS outstanding_balance  -- amount outstanding
FROM 
  hotelbooking.booking b
JOIN 
  hotelbooking.customer c ON b.c_no = c.c_no
JOIN 
  hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
JOIN 
  hotelbooking.room r ON rb.r_no = r.r_no
ORDER BY 
  rb.checkin ASC;


-- ROLES SET FOR STAFF
ALTER TABLE hotelbooking.staff
ADD COLUMN role TEXT CHECK (role IN ('receptionist', 'housekeeper')) NOT NULL DEFAULT 'receptionist';

UPDATE hotelbooking.staff
SET role = 'housekeeper'
WHERE username = 'tester';

SELECT username, role FROM hotelbooking.staff;

-- DROP CONSTRAINT TO ALLOW NEW ROLE
ALTER TABLE hotelbooking.staff
DROP CONSTRAINT staff_role_check;
-- CREATE CHECK CONSTRAINT INCLUIDNG NEW ROLE
ALTER TABLE hotelbooking.staff
ADD CONSTRAINT staff_role_check
CHECK (role IN ('receptionist', 'housekeeper', 'manager'));
-- ADD NEW MANAGER ROLE
INSERT INTO hotelbooking.staff (staff_id, username, password, full_name, role)
VALUES
(3, 'manager', '$2b$10$h.WJynHuHeFGl31NqTKhMuQ7MbhrhJG9TvC83glV8buF2uY/GDgxy', 'Manager User', 'manager');


-- RECEPTION DASHBOARD VIEW
SELECT 
  b.b_ref AS "Booking Ref",
  c.c_name AS "Guest",
  c.c_email AS "Email",
  r.r_no AS "Room Number",
  r.r_class AS "Room Type",
  TO_CHAR(rb.checkin, 'YYYY-MM-DD') AS "Check-In",
  TO_CHAR(rb.checkout, 'YYYY-MM-DD') AS "Check-Out",
  rb.checkout - rb.checkin AS "Nights",
  rb.guests AS "Guests"
FROM hotelbooking.booking b
JOIN hotelbooking.customer c ON b.c_no = c.c_no
JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
JOIN hotelbooking.room r ON rb.r_no = r.r_no
ORDER BY rb.checkin ASC;

-- LIST ALL BOOKINGS LIVE OR IN THE FUTURE
SELECT 
    b.b_ref AS "Booking Ref",
    c.c_name AS "Guest",
    r.r_no AS "Room Number",
    CASE
        WHEN r.r_class = 'std_d' THEN 'Standard Double'
        WHEN r.r_class = 'std_t' THEN 'Standard Twin'
        WHEN r.r_class = 'sup_d' THEN 'Superior Double'
        WHEN r.r_class = 'sup_t' THEN 'Superior Twin'
        ELSE 'Unknown'  -- In case of an unexpected value
    END AS "Room Type",
    rb.checkin AS "Check-in",
    rb.checkout AS "Check-out",
    rb.checkout - rb.checkin AS "Nights",
    rb.guests AS "Guests",
    '£' || TO_CHAR(b.b_cost, '999,999.99') AS "Booking Cost",
    '£' || TO_CHAR(b.b_outstanding, '999,999.99') AS "Outstanding Amount"
FROM hotelbooking.booking b
JOIN hotelbooking.customer c ON b.c_no = c.c_no
JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
JOIN hotelbooking.room r ON rb.r_no = r.r_no
WHERE rb.checkin >= CURRENT_DATE  -- Future bookings
   OR (rb.checkin <= CURRENT_DATE AND rb.checkout >= CURRENT_DATE)  -- Live bookings
ORDER BY rb.checkin;

-- LIST ALL CHECK-OUTS DUE TODAY AND PLACE THESE IN A SPECIFIC STATUS ORDER
SELECT 
    -- b.b_ref AS "Booking Ref", -- NOT REQUIRED
    -- c.c_name AS "Guest", -- NOT REQUIRED
    r.r_no AS "Room Number",
    CASE
        WHEN r.r_class = 'std_d' THEN 'Standard Double'
        WHEN r.r_class = 'std_t' THEN 'Standard Twin'
        WHEN r.r_class = 'sup_d' THEN 'Superior Double'
        WHEN r.r_class = 'sup_t' THEN 'Superior Twin'
        ELSE 'Unknown'  -- In case of an unexpected value
    END AS "Room Type",
    -- rb.checkin AS "Check-in", -- NOT REQUIRED
    rb.checkout AS "Check-out",
    -- rb.guests AS "Guests", -- NOT REQUIRED
    r.r_status AS "Room Status",
    CASE 
        WHEN r.r_status = 'C' THEN 'Checked-out and ready to clean'
        WHEN r.r_status = 'X' THEN 'Cleaning in progress'
        WHEN r.r_status = 'O' THEN 'Occupied'
        WHEN r.r_status = 'A' THEN 'Ready for next guest'
        ELSE 'Unknown Status'
    END AS "Room Status Description"
FROM hotelbooking.booking b
JOIN hotelbooking.customer c ON b.c_no = c.c_no
JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
JOIN hotelbooking.room r ON rb.r_no = r.r_no
WHERE rb.checkout = CURRENT_DATE
ORDER BY
    CASE 
        WHEN r.r_status = 'C' THEN 1
        WHEN r.r_status = 'X' THEN 2
        WHEN r.r_status = 'O' THEN 3
        WHEN r.r_status = 'A' THEN 4
        ELSE 5
    END,
    r.r_no ASC;

-- UPDATE ROOM TO CLEANING IN PROGRESS
UPDATE hotelbooking.room
SET r_status = 'X'  -- Cleaning in progress
WHERE r_status = 'C'  -- Only rooms that are currently checked-out
AND r_no IN ();  -- (Add room numbers as required)

-- UPDATE ROOM TO CLEANING FINISHED AND AVAILABLE FOR NEW GUEST
UPDATE hotelbooking.room
SET r_status = 'A'  -- Ready for next guest
WHERE r_status = 'X'  -- Only rooms that are currently being cleaned
AND r_no IN ();  -- (Add room numbers as required)

-- UPDATE ROOM TO CHECKED-OUT
UPDATE hotelbooking.room
SET r_status = 'C'  -- Checked-out and ready for cleaning
WHERE r_status = 'O'  -- Only rooms that are currently occupied
AND r_no IN ();  -- (Add room numbers as required)

-- UPDATE ROOM TO OCCUPIED CHECKED-IN
UPDATE hotelbooking.room
SET r_status = 'O'  -- Checked-in and occupied
WHERE r_status = 'A'  -- Only rooms that are ready for next guest
AND r_no IN ();  -- (Add room numbers as required)

-- BOOKING CALENDAR - CHECK FOR FULLY BOOKED DATES
WITH booked_dates AS ( --
    SELECT generate_series(checkin, checkout - INTERVAL '1 day', INTERVAL '1 day') AS day
    FROM hotelbooking.roombooking
),
room_counts AS (
    SELECT day::date, COUNT(*) AS booked_rooms
    FROM booked_dates
    GROUP BY day
)
SELECT day
FROM room_counts
WHERE booked_rooms >= 32
ORDER BY day;

-- ################# DEALING WITH MISSING B_REF DATA ####################
-- check for records in roombooking that have a b_ref that is not setup in the booking table
SELECT rb.b_ref
FROM hotelbooking.roombooking rb
LEFT JOIN hotelbooking.booking b ON rb.b_ref = b.b_ref
WHERE b.b_ref IS NULL;
--AADING A DUMMY CUSTOMER TO ADD TO MISSING RECORDS
INSERT INTO hotelbooking.customer (c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno)
VALUES ('Dummy Customer', 'dummy@example.com', 'Dummy Address', 'V', '12/26', '1234567890123456');
-- Insert Missing Bookings (with dummy customer and b_notes)
WITH missing_bookings AS (
    SELECT rb.b_ref
    FROM hotelbooking.roombooking rb
    LEFT JOIN hotelbooking.booking b ON rb.b_ref = b.b_ref
    WHERE b.b_ref IS NULL
)
INSERT INTO hotelbooking.booking (b_ref, c_no, b_cost, b_outstanding, b_notes)
SELECT mb.b_ref, 82, 100.00, 0.00, 'Auto-created missing booking (dummy)'
FROM missing_bookings mb
ON CONFLICT (b_ref) DO NOTHING;  -- Ensure we don't insert duplicates
-- ################# DEALING WITH MISSING B_REF DATA ####################
SELECT rb.checkin, rb.checkout, r.r_class, r.r_status
FROM hotelbooking.roombooking rb
JOIN hotelbooking.room r ON rb.r_no = r.r_no
WHERE rb.b_ref = 15975 AND rb.r_no = 204;

SELECT b_ref, r_no, checkin, checkout, COUNT(*)
FROM hotelbooking.roombooking
WHERE b_ref = 15975 AND r_no = 204
GROUP BY b_ref, r_no, checkin, checkout
HAVING COUNT(*) > 1;

SELECT * FROM hotelbooking.roombooking
WHERE b_ref = 15975 AND r_no = 204;
-- ################# DATA CLEANING ###########################################
-- identify where there are duplicate dates booked for the same room on different bookings

SELECT b_ref, r_no, checkin, checkout

FROM hotelbooking.roombooking
WHERE b_ref IN (
  SELECT b_ref
  FROM hotelbooking.roombooking
  GROUP BY b_ref
  HAVING COUNT(*) = 1
)
ORDER BY r_no, checkin;

-- ########################################################################################

-- Batch Update of the checkin and checkout dates
BEGIN;

UPDATE hotelbooking.roombooking SET checkin = '2025-04-30', checkout = '2025-05-01' WHERE b_ref = 161 AND r_no = 998;
UPDATE hotelbooking.roombooking SET checkin = '2025-04-30', checkout = '2025-05-01' WHERE b_ref = 160 AND r_no = 999;

COMMIT;

-- Batch Update of the b_cost

BEGIN;

UPDATE hotelbooking.booking SET b_cost = 154 WHERE b_ref = 119;

COMMIT;

-- Set all of b_outstanding to 0 (zero)
UPDATE hotelbooking.booking
SET b_outstanding = 154
WHERE b_ref = 223;

BEGIN;

-- Set Check-in/Checkout on a selection of r_no's 
UPDATE hotelbooking.roombooking 
SET checkin = '2025-04-30', checkout = '2025-05-01' 
WHERE r_no IN (998, 999);

-- Set Status to selection of room numbers
UPDATE hotelbooking.room 
SET r_status = 'A' 
WHERE r_no IN (306, 308);

-- Update all bookings in the past to show paid and nothing outstandiing
UPDATE hotelbooking.booking b
SET b_paid = TRUE,
    b_payment = b_cost,
    payment_date = CURRENT_TIMESTAMP,
    b_outstanding = 0
FROM hotelbooking.roombooking r
WHERE b.b_ref = r.b_ref
  AND r.checkout < CURRENT_DATE;
