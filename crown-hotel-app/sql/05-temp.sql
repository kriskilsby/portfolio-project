SELECT r.r_class, r.r_no, rb.checkin, rb.checkout
FROM hotelbooking.roombooking rb
JOIN hotelbooking.room r ON rb.r_no = r.r_no
ORDER BY rb.checkin;
