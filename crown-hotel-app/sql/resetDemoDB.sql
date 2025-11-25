-- ============================================
--  NIGHTLY RESET SCRIPT FOR DEMO DATA
--  Crown Hotel App
-- ============================================

SET search_path TO hotelbooking;

-- 1. Define the reset reference date (today)
--    All offsets in reset_template are applied relative to reset_date - 7
DO $$
DECLARE
    reset_date DATE := current_date;
BEGIN
    RAISE NOTICE 'Resetting demo data for %', reset_date;
END$$;

-- 2. Delete temporary data (frontend-added or test data)
DELETE FROM roombooking WHERE data_origin = 'temp';
DELETE FROM booking WHERE data_origin = 'temp';
DELETE FROM customer WHERE data_origin = 'temp';
DELETE FROM contact_messages WHERE data_origin = 'temp';
DELETE FROM extras WHERE data_origin = 'temp';

-- 3. Reset room statuses for demo rooms
UPDATE hotelbooking.room SET r_status = CASE r_no
    WHEN 101 THEN 'A'
    WHEN 102 THEN 'O'
    WHEN 103 THEN 'O'
    WHEN 104 THEN 'O'
    WHEN 105 THEN 'O'
    WHEN 106 THEN 'A'
    WHEN 107 THEN 'O'
    WHEN 108 THEN 'O'
    WHEN 201 THEN 'O'
    WHEN 202 THEN 'O'
    WHEN 203 THEN 'O'
    WHEN 204 THEN 'O'
    WHEN 205 THEN 'O'
    WHEN 206 THEN 'O'
    WHEN 207 THEN 'O'
    WHEN 208 THEN 'O'
    WHEN 209 THEN 'C'
    WHEN 210 THEN 'O'
    WHEN 211 THEN 'O'
    WHEN 212 THEN 'O'
    WHEN 301 THEN 'O'
    WHEN 302 THEN 'O'
    WHEN 303 THEN 'O'
    WHEN 304 THEN 'O'
    WHEN 305 THEN 'O'
    WHEN 306 THEN 'A'
    WHEN 307 THEN 'O'
    WHEN 308 THEN 'C'
    WHEN 309 THEN 'A'
    WHEN 310 THEN 'A'
    WHEN 311 THEN 'A'
    WHEN 312 THEN 'O'
END,
r_notes = 'demo data';

-- 4. Update demo booking dates using reset_template offsets
--    (ci_offsett and co_offsett are days relative to reset_date - 7)
UPDATE hotelbooking.roombooking rb
SET 
    checkin  = (current_date - 7) + rt.ci_offsett,
    checkout = (current_date - 7) + rt.co_offsett
FROM hotelbooking.reset_template rt
WHERE rb.b_ref = rt.b_ref
  AND rb.r_no = rt.r_no
  AND rb.data_origin = 'demo';

-- 5. Update booking payments & outstanding balances
-- 5a: Paid bookings
UPDATE hotelbooking.booking b
SET 
    b_payment = b_cost,
    b_outstanding = 0,
    b_paid = TRUE,
    payment_date = rb.checkout
FROM hotelbooking.roombooking rb,
     hotelbooking.reset_template rt
WHERE b.b_ref = rb.b_ref
  AND rb.b_ref = rt.b_ref
  AND rb.r_no = rt.r_no
  AND rt.paid = TRUE
  AND b.data_origin = 'demo';

-- 5b: Unpaid bookings
UPDATE hotelbooking.booking b
SET 
    b_payment = 0,
    b_outstanding = b_cost,
    b_paid = FALSE,
    payment_date = NULL
FROM hotelbooking.reset_template rt
WHERE b.b_ref = rt.b_ref
  AND rt.paid = FALSE
  AND b.data_origin = 'demo';

-- 6. Recalculate b_cost totals for all demo bookings (multi-room bookings)
UPDATE hotelbooking.booking b
SET b_cost = COALESCE(sub.total_cost, 0)
FROM (
    SELECT rb.b_ref, SUM((rb.checkout - rb.checkin) * rt.price) AS total_cost
    FROM hotelbooking.roombooking rb
    JOIN hotelbooking.room r ON rb.r_no = r.r_no
    JOIN hotelbooking.rates rt ON r.r_class = rt.r_class
    WHERE rb.data_origin = 'demo'
    GROUP BY rb.b_ref
) AS sub
WHERE b.b_ref = sub.b_ref
  AND b.data_origin = 'demo';

-- 7. All booking.b_outstanding amounts should be '0' until they are checked-in
UPDATE hotelbooking.booking
SET b_outstanding = CASE
    WHEN b_notes IN ('Remain Occupied', 'Due to Checkout') THEN b_cost
    ELSE 0
END;

-- 8. Update booking.b_paid to 'True' on b_ref 107 and 110 only (checked-out, payment taken, and ready to clean)
UPDATE hotelbooking.booking
SET 
	b_paid = TRUE,
	b_payment = b_cost
WHERE b_ref IN ('107', '110');


-- ============================================
-- Reset complete
DO $$
BEGIN
    RAISE NOTICE 'Demo data reset completed successfully.';
END$$;
-- ============================================
