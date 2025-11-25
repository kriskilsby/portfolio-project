// server.js - Express Server with PostgreSQL Connection
require('dotenv').config();
const express = require('express');
const session = require('express-session');
const path = require('path');
const bcrypt = require('bcrypt');
const pool = require('./db'); // PostgreSQL connection

const app = express();
// Removed due to being mounted in portfolio server
// const PORT = 3000;

// // Re-enable the PORT definition (if removed earlier)
// const PORT = process.env.PORT || 5001;

// EJS View Engine Setup
app.set('view engine', 'ejs');

app.set("views", [
  path.join(__dirname, "views"),                 // default
  path.join(__dirname, "views/public"),          // public-facing pages
  path.join(__dirname, "views/public/partials"), // public partials
  path.join(__dirname, "views/staff"),           // staff-facing pages
  path.join(__dirname, "views/partials")         // staff partials
]);

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(session({
    secret: process.env.SESSION_SECRET || 'supersecret',
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false }
}));

console.log("Loaded Crown Hotel routes");

// Static Files
// app.use(express.static(path.join(__dirname, 'public')));
// app.use('/staff', express.static(__dirname + '/staff'));
// changed as mounted in portfolio
// app.use('/', express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));


// app.use('/staff', express.static(path.join(__dirname, 'staff')));

// Static files for STAFF pages
app.use('/staff/css', express.static(path.join(__dirname, 'staff/css')));
app.use('/staff/js', express.static(path.join(__dirname, 'staff/js')));


// Middleware for login check
function requireLogin(req, res, next) {
    if (req.session && req.session.staffUser) return next();
    res.redirect('/login');
}

function requireRole(role) {
    return function (req, res, next) {
        if (req.session?.staffUser?.role === role) return next();
        res.status(403).send('⛔ Access denied: insufficient permissions.');
    };
}

// ########## REMOVED BELOW AS NO LONGER USING JS TO INJECT PARTIALS TO REMOVE FOUC ###############
// Public Routes
// app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'public/index.html')));
// app.get('/rooms', (req, res) => res.sendFile(path.join(__dirname, 'public/rooms.html')));
// app.get('/facilities', (req, res) => res.sendFile(path.join(__dirname, 'public/facilities.html')));
// app.get('/restaurant', (req, res) => res.sendFile(path.join(__dirname, 'public/restaurant.html')));
// app.get('/bar', (req, res) => res.sendFile(path.join(__dirname, 'public/bar.html')));
// app.get('/gym', (req, res) => res.sendFile(path.join(__dirname, 'public/gym.html')));
// app.get('/conference', (req, res) => res.sendFile(path.join(__dirname, 'public/conference.html')));
// app.get('/outandabout', (req, res) => res.sendFile(path.join(__dirname, 'public/outandabout.html')));
// app.get('/contact', (req, res) => res.sendFile(path.join(__dirname, 'public/contact.html')));

// PUBLIC EJS ROUTES
app.get("/", (req, res) => res.render("public/index", { title: "Crown Hotel" }));
app.get("/rooms", (req, res) => res.render("public/rooms", { title: "Rooms" }));
app.get("/facilities", (req, res) => res.render("public/facilities", { title: "Facilities" }));
app.get("/restaurant", (req, res) => res.render("public/restaurant", { title: "Restaurant" }));
app.get("/bar", (req, res) => res.render("public/bar", { title: "Bar" }));
app.get("/gym", (req, res) => res.render("public/gym", { title: "Gym" }));
app.get("/conference", (req, res) => res.render("public/conference", { title: "Conference" }));
app.get("/outandabout", (req, res) => res.render("public/outAndAbout", { title: "Out & About" }));
app.get("/contact", (req, res) => res.render("public/contact", { title: "Contact" }));
app.get("/confirmation", (req, res) => res.render("public/confirmation", { title: "Confirmation" }));


// =================== STOP API THROTTLING WEATHER APP ON EVERY PAGE LOAD ============
const fetch = require('node-fetch'); // npm install node-fetch

let weatherCache = { data: null, timestamp: 0 };
const CACHE_DURATION = 10 * 60 * 1000; // 10 minutes

app.get('/api/weather', async (req, res) => {
  try {
    const now = Date.now();
    if (weatherCache.data && now - weatherCache.timestamp < CACHE_DURATION) {
      return res.json(weatherCache.data);
    }

    const city = 'Norwich,UK';
    const apiKey = 'bd5e378503939ddaee76f12ad7a97608';
    const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`);
    const data = await response.json();

    weatherCache = { data, timestamp: now };
    res.json(data);
  } catch (err) {
    console.error('Weather API error:', err);
    res.status(500).json({ error: 'Unable to fetch weather data' });
  }
});


// =================== CONTACT FORM SAVE ===================
// Contact Form Handler
app.post('/contact', async (req, res) => {
  console.log('Contact form submitted:', req.body);
  const { name, email, subject, message } = req.body;

  try {
      await pool.query(`
          INSERT INTO hotelbooking.contact_messages (name, email, subject, message, created_at)
          VALUES ($1, $2, $3, $4, NOW())
      `, [name, email, subject, message]);

      res.json({ success: true });
  } catch (err) {
      console.error('❌ Failed to save contact form message:', err.stack);
      res.status(500).json({ success: false, message: 'Internal Server Error' });
  }
});


// #####################################################################################
//                              STAFF AUTH HELPERS
// #####################################################################################

function requireLogin(req, res, next) {
  if (!req.session.staffUser) {
    return res.redirect('/staff/login');
  }
  next();
}

function requireRole(role) {
  return (req, res, next) => {
    if (!req.session.staffUser || req.session.staffUser.role !== role) {
      return res.status(403).send("Access denied");
    }
    next();
  };
}


// #####################################################################################
//                        AUTO-DEMO LOGIN ROUTES (used by animation)
// #####################################################################################

// Generic helper for demo login
async function performDemoLogin(username, res, req, redirectPath) {
  try {
    const result = await pool.query(
      `SELECT * FROM hotelbooking.staff WHERE username = $1`,
      [username]
    );
    const user = result.rows[0];

    if (!user) return res.status(404).send("Demo user not found");

    // Check bcrypt hash against demo password
    const match = await bcrypt.compare("Demo123!", user.password);
    if (!match) return res.status(401).send("Invalid demo password");

    // Store session
    req.session.staffUser = {
      username: user.username,
      full_name: user.full_name,
      role: user.role
    };

    // Extra: For management, preload message count
    if (username === "manager") {
      const msgResult = await pool.query(
        "SELECT COUNT(*) FROM hotelbooking.contact_messages"
      );
      req.session.messageCount = parseInt(msgResult.rows[0].count, 10);
    }

    res.redirect(redirectPath);
  } catch (err) {
    console.error("❌ Demo login error:", err);
    res.status(500).send("Internal Server Error");
  }
}


// --- Reception Demo ---
app.get("/staff/reception/demo", (req, res) => {
  performDemoLogin("receptionist", res, req, "/staff/reception");
});

// --- Housekeeping Demo ---
app.get("/staff/housekeeping/demo", (req, res) => {
  performDemoLogin("housekeeper", res, req, "/staff/housekeeping");
});

// --- Management Demo ---
app.get("/staff/management/demo", (req, res) => {
  performDemoLogin("manager", res, req, "/staff/management");
});



// ✅ END Contact Form Handling

// Staff Pages
// app.get('/staff/reception', requireLogin, requireRole('receptionist'), (req, res) => {
//     res.render('staff/reception', { title: 'Reception Dashboard (in server.js)', staffUser: req.session.staffUser });
// });

// app.get('/staff/housekeeping', requireLogin, requireRole('housekeeper'), (req, res) => {
//     res.render('staff/housekeeping', { title: 'Housekeeping Dashboard', staffUser: req.session.staffUser });
// });

// app.get('/staff/management', requireLogin, requireRole('manager'), async (req, res) => {
//   try {
//       const result = await pool.query('SELECT COUNT(*) FROM hotelbooking.contact_messages');
//       const messageCount = parseInt(result.rows[0].count, 10);

//       res.render('staff/management', { 
//         title: 'Management Dashboard', 
//         staffUser: req.session.staffUser,
//         messageCount 
//       });
//   } catch (err) {
//       console.error('❌ Failed to fetch message count:', err);
//       res.status(500).send('Internal Server Error');
//   }
// });

// #####################################################################################
//                        PROTECTED STAFF DASHBOARD ROUTES
// #####################################################################################

// --- Reception Dashboard ---
app.get( "/staff/reception", requireLogin, requireRole("receptionist"), (req, res) => {
    res.render("staff/reception", { title: "Reception Dashboard", staffUser: req.session.staffUser });
});

// --- Housekeeping Dashboard ---
app.get("/staff/housekeeping", requireLogin, requireRole("housekeeper"), (req, res) => {
    res.render("staff/housekeeping", { itle: "Housekeeping Dashboard", staffUser: req.session.staffUser });
});

// --- Management Dashboard ---
app.get( "/staff/management", requireLogin, requireRole("manager"), async (req, res) => {
    try {
      // Re-fetch message count (session copy may be old)
      const result = await pool.query( "SELECT COUNT(*) FROM hotelbooking.contact_messages");
      const messageCount = parseInt(result.rows[0].count, 10);

      res.render("staff/management", {
        title: "Management Dashboard",
        staffUser: req.session.staffUser,
        messageCount
      });
    } catch (err) {
      console.error("❌ Failed to load management dashboard:", err);
      res.status(500).send("Internal Server Error");
    }
});






// [STAFF] View Contact Messages
app.get('/staff/messages', requireLogin, requireRole('manager'), async (req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT id, name, email, subject, message, TO_CHAR(created_at, 'YYYY-MM-DD HH24:MI') AS submitted
      FROM hotelbooking.contact_messages
      ORDER BY created_at DESC
    `);
    res.render('staff/messages', { messages: rows, staffUser: req.session.staffUser });
  } catch (err) {
    console.error('❌ Failed to fetch contact messages:', err);
    res.status(500).send('Internal Server Error');
  }
});


//  REPLACED WITH ERROR FREINDLY VERSION BELOW
// Booking Page (EJS Form)
// app.get('/booking', async (req, res) => {
//     try {
//       const { rows } = await pool.query("SELECT DISTINCT r_class AS type FROM hotelbooking.room ORDER BY r_class");
//         res.render('booking', { roomTypes: rows });
//     } catch (err) {
//         console.error(err);
//         res.status(500).send('Internal Server Error');
//     }
// });

// Booking Page (EJS Form) -- Safe version with DB fallback
app.get('/booking', async (req, res) => {
    console.log("Rendering /booking page");
    try {
        const { rows } = await pool.query(
            "SELECT DISTINCT r_class AS type FROM hotelbooking.room ORDER BY r_class"
        );

        res.render('booking', {
            roomTypes: rows,
            error: null
        });

    } catch (err) {
        console.error("Database error on /booking:", err);

        // Render page with no room types instead of a 500 error
        res.render('booking', {
            roomTypes: [],
            error: "Database connection unavailable — showing placeholder options."
        });
    }
});

// API: Get fully booked dates for a room type
app.get('/api/unavailable-dates/:roomType', async (req, res) => {
  const roomType = req.params.roomType;

  try {
    const result = await pool.query(`
      WITH all_dates AS (
        SELECT generate_series(
          CURRENT_DATE,
          CURRENT_DATE + interval '12 months',
          interval '1 day'
        )::date AS date
      ),
      total_rooms AS (
        SELECT COUNT(*) AS count
        FROM hotelbooking.room
        WHERE r_class = $1
      ),
      bookings_per_day AS (
        SELECT d.date, COUNT(DISTINCT rb.r_no) AS booked
        FROM all_dates d
        JOIN hotelbooking.roombooking rb ON d.date >= rb.checkin AND d.date <= rb.checkout
        JOIN hotelbooking.room r ON rb.r_no = r.r_no
        WHERE r.r_class = $1
        GROUP BY d.date
      )
      SELECT d.date
      FROM all_dates d
      JOIN total_rooms tr ON true
      LEFT JOIN bookings_per_day bpd ON d.date = bpd.date
      WHERE COALESCE(bpd.booked, 0) >= tr.count
    `, [roomType]);

    const disabledDates = result.rows.map(row => row.date.toISOString().split('T')[0]);

    res.json(disabledDates);
  } catch (err) {
    console.error('❌ Failed to fetch unavailable dates:', err);
    res.status(500).json({ message: 'Server error while fetching unavailable dates' });
  }
});


// Check available room types
app.post('/api/available-room-types', async (req, res) => {
  const { checkInDate, checkOutDate } = req.body;

  console.log('Checking available room types for:', checkInDate, checkOutDate); 

  try {
    const result = await pool.query(`
      SELECT r_class, COUNT(*) AS total_rooms
      FROM hotelbooking.room
      WHERE r_no NOT IN (
        SELECT r_no
        FROM hotelbooking.roombooking
        WHERE NOT ($1::date >= checkout OR $2::date <= checkin)
      )
      GROUP BY r_class
    `, [checkInDate, checkOutDate]);

    res.json(result.rows); // e.g. [{ r_class: 'std_d', total_rooms: 2 }, ...]
  } catch (err) {
    console.error('❌ Error checking available room types:', err);
    res.status(500).json({ message: 'Failed to check availability' });
  }
});


// Check Availability for multiple room types
app.post('/api/check-availability', async (req, res) => {
  const { selectedRooms, checkInDate, checkOutDate } = req.body;

  try {
    for (const { roomType, quantity } of selectedRooms) {
      const result = await pool.query(`
        SELECT COUNT(*) AS available_count
        FROM hotelbooking.room
        WHERE r_class = $1
          AND r_no NOT IN (
            SELECT r_no
            FROM hotelbooking.roombooking
            WHERE NOT ($2::date >= checkout OR $3::date <= checkin)
          )
      `, [roomType, checkInDate, checkOutDate]);

      const available = parseInt(result.rows[0].available_count, 10);

      if (available < quantity) {
        return res.json({ 
          available: false, 
          message: `Only ${available} ${roomType} room(s) available for your dates.` 
        });
      }
    }

    res.json({ available: true }); // ✅ All requested rooms are available
  } catch (err) {
    console.error('❌ Error checking availability:', err);
    res.status(500).json({ message: 'Server error during availability check' });
  }
});


// Confirm booking (multi-room version)
app.post('/api/book', async (req, res) => {
  const {
    customerName, email, address,
    cardType, cardNumber, cardExpiry,
    checkInDate, checkOutDate, guests,
    selectedRooms
  } = req.body;

  try {
    // 1. Insert customer
    const customerResult = await pool.query(`
      INSERT INTO hotelbooking.customer (c_name, c_email, c_address, c_cardtype, c_cardno, c_cardexp)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING c_no
    `, [customerName, email, address, cardType, cardNumber, cardExpiry]);

    const customerId = customerResult.rows[0].c_no;

    // 2. Create booking record
    const bookingResult = await pool.query(`
      INSERT INTO hotelbooking.booking (c_no, b_cost, b_outstanding)
      VALUES ($1, 0, 0)
      RETURNING b_ref
    `, [customerId]);

    const bookingRef = bookingResult.rows[0].b_ref;

    // 3. Insert each room
    for (const { roomType, quantity } of selectedRooms) {
      const availableRooms = await pool.query(`
        SELECT r_no FROM hotelbooking.room
        WHERE r_class = $1
          AND r_no NOT IN (
            SELECT r_no FROM hotelbooking.roombooking
            WHERE NOT ($2::date >= checkout OR $3::date <= checkin)
          )
        LIMIT $4
      `, [roomType, checkInDate, checkOutDate, quantity]);

      if (availableRooms.rowCount < quantity) {
        return res.status(409).json({ 
          message: `Only ${availableRooms.rowCount} ${roomType} room(s) available at booking time.` 
        });
      }

      for (const row of availableRooms.rows) {
        await pool.query(`
          INSERT INTO hotelbooking.roombooking (b_ref, r_no, checkin, checkout, guests)
          VALUES ($1, $2, $3, $4, $5)
        `, [bookingRef, row.r_no, checkInDate, checkOutDate, 2]);
      }
    }

    res.json({ bookingRef }); // Booking successful
  } catch (err) {
    console.error('❌ Booking failed:', err);
    res.status(500).json({ message: 'Booking failed on server' });
  }
});


// Fetch booking details for confirmation page
app.get('/api/booking/:b_ref', async (req, res) => {
  const bookingId = req.params.b_ref;

  try {
    const result = await pool.query(`
      SELECT 
        b.b_ref, 
        c.c_name, 
        c.c_email,
        r.r_class, 
        r.r_no,
        TO_CHAR(rb.checkin, 'YYYY-MM-DD') AS check_in,
        TO_CHAR(rb.checkout, 'YYYY-MM-DD') AS check_out,
        (rb.checkout - rb.checkin) AS nights,
        rb.guests
      FROM hotelbooking.booking b
      JOIN hotelbooking.customer c ON b.c_no = c.c_no
      JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE b.b_ref = $1
      ORDER BY r.r_no
    `, [bookingId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Booking not found' });
    }

    res.json(result.rows);  // Return all matching rooms
  } catch (err) {
    console.error('❌ Error fetching booking for confirmation page:', err);
    res.status(500).json({ message: 'Error retrieving booking data' });
  }
});


// [RECEPTION DASHBOARD] Get All Bookings or Filtered by Check-in/Check-out Today
app.get('/api/bookings', async (req, res) => {
  try {
    const { filter } = req.query;
    // Log the filter parameter to ensure its being passed correctly
    //console.log('Received filter:', filter);

    // Base SQL query
    let query = `
      SELECT 
        b.b_ref, 
        c.c_name, 
        c.c_email, 
        r.r_no, 
        r.r_class,
        r.r_status,
        TO_CHAR(rb.checkin, 'YYYY-MM-DD') AS check_in,
        TO_CHAR(rb.checkout, 'YYYY-MM-DD') AS check_out,
        rb.checkout - rb.checkin AS nights, 
        rb.guests,
        b.b_cost, 
        b.b_outstanding,
        b.b_paid
      FROM hotelbooking.booking b
      JOIN hotelbooking.customer c ON b.c_no = c.c_no
      JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
    `;

    // Filter logic (if any)
    if (filter === 'checkin-today') {
      query += ` WHERE rb.checkin::DATE = CURRENT_DATE`;
      //console.log('Applied filter: checkin-today');
    } else if (filter === 'checkout-today') {
      query += ` WHERE rb.checkout::DATE = CURRENT_DATE`;
      //console.log('Applied filter: checkout-today');
    }

    query += ` ORDER BY rb.checkin DESC`; // Sort by check-in date
    //console.log('Generated SQL query:', query); // Log the generated SQL query for debugging

    // Execute the query
    const result = await pool.query(query);

    // Log the number of rows returned
    //console.log('Query result row count:', result.rowCount);

    // Check if any rows were returned
    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'No bookings found' });
    }

    // Log the result data before sending it to the front-end
    //console.log('Query result:', result.rows);

    // Return the result rows as JSON
    res.json(result.rows);
  } catch (err) {
    console.error('❌ Error fetching bookings:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// [RECEPTION DASHBOARD] Route for Reception CheckIn
// KK HAS EXTENDED THIS TO ALLOW MULTIPLE ROOMS TO BE CHECKED IN INDEPENDANLY FOR SAME BOOKING
app.put('/api/booking/:b_ref/checkin', async (req, res) => {
  const { b_ref } = req.params;
  const { r_no } = req.body;

  // console.log('Incoming check-in request:', { b_ref, r_no });

  try {
    // 1. Fetch room booking information
    const roomResult = await pool.query(`
      SELECT
        (rb.checkin AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/London') AS checkin,
        (rb.checkout AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/London') AS checkout,
        r.r_class,
        r.r_status
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE rb.b_ref = $1 AND rb.r_no = $2
    `, [b_ref, r_no]);

    if (roomResult.rowCount === 0) {
      console.log(`No room found for booking ref ${b_ref} and room ${r_no}`);
      return res.status(404).json({ message: 'Room not found for this booking' });
    }

    const { checkin, checkout, r_class, r_status } = roomResult.rows[0];

    // console.log('Room Result:', roomResult.rows);

    // 2. Ensure room is available for check-in
    if (r_status !== 'A') {
      console.log(`Room ${r_no} is not available for check-in (status: ${r_status})`);
      return res.status(400).json({ message: `Room ${r_no} is not available for check-in.` });
    }

    // 3. Calculate nights stayed
    const checkinDate = new Date(checkin);
    const checkoutDate = new Date(checkout);
    const nights = Math.round((checkoutDate - checkinDate) / (1000 * 60 * 60 * 24)); // Ensure whole number
    // console.log(`Nights calculated: ${nights}`);

    // 4. Get price for the room class
    const priceResult = await pool.query(`
      SELECT price FROM hotelbooking.rates WHERE r_class = $1
    `, [r_class]);

    if (priceResult.rowCount === 0) {
      console.log(`Rate not found for room class: ${r_class}`);
      return res.status(404).json({ message: 'Rate not found for room class' });
    }

    const price = priceResult.rows[0].price;

    // 5. Calculate room cost
    let roomCost = parseFloat((price * nights).toFixed(2));
    // console.log(`Room cost calculated: £${roomCost}`);

    // Debug - check the type of `roomCost` to see if it is a valid number
    // console.log(`Type of roomCost: ${typeof roomCost}`);
    
    // 6. Update room status to 'O' (Occupied)
    await pool.query(`
      UPDATE hotelbooking.room SET r_status = 'O' WHERE r_no = $1
    `, [r_no]);

    // 7. Get current booking balance and cost
    const bookingResult = await pool.query(`
      SELECT b_outstanding, b_cost FROM hotelbooking.booking WHERE b_ref = $1
    `, [b_ref]);

    if (bookingResult.rowCount === 0) {
      return res.status(404).json({ message: 'Booking not found' });
    }

    // let { b_outstanding, b_cost } = bookingResult.rows[0];
    let b_outstanding = bookingResult.rows[0].b_outstanding;
    let b_cost = bookingResult.rows[0].b_cost;
    if (b_outstanding === null) b_outstanding = 0;  // Default to 0 if null
    if (b_cost === null) b_cost = 0;  // Default to 0 if null

    // Debug - Check b_outstanding and b_cost values
    // console.log(`b_outstanding: £${b_outstanding}, b_cost: £${b_cost}`);

    // 8. Fetch current booking details and calculate new outstanding balance

    // Ensure both roomCost and b_outstanding are valid numbers BEFORE calculation
    if (isNaN(roomCost)) {
      console.log('roomCost was NaN, defaulting to 0');
      roomCost = 0;
    }

    if (isNaN(b_outstanding)) {
      console.log('b_outstanding was NaN, defaulting to 0');
      b_outstanding = 0;
    }

    // Ensure both roomCost and b_outstanding are valid numbers BEFORE calculation
    roomCost = isNaN(roomCost) ? 0 : parseFloat(roomCost);
    b_outstanding = isNaN(b_outstanding) ? 0 : parseFloat(b_outstanding);

    // Add room cost to existing outstanding
    let newOutstanding = b_outstanding + roomCost;

    // Round to two decimal places
    newOutstanding = Math.round(newOutstanding * 100) / 100;

    // console.log(`Updated Outstanding (with new room cost): £${newOutstanding}`);

    // Now, proceed to update the database with the correct value
    await pool.query(`
      UPDATE hotelbooking.booking
      SET b_outstanding = $1
      WHERE b_ref = $2
    `, [newOutstanding, b_ref]);
    
    // 10. Respond back to the front-end
    // console.log(`Check-in complete. Outstanding updated to: £${newOutstanding}`);
    res.json({ message: `Room ${r_no} checked in successfully.`, addedCost: roomCost });

  } catch (err) {
    console.error('Check-in error:', err.stack);
    res.status(500).json({ error: 'Check-in failed' });
  }
});


// KK HAS EXTENDED THIS TO ALLOW MULTIPLE ROOMS TO BE CHECKED OUT INDEPENDANLY FOR SAME BOOKING
// [RECEPTION DASHBOARD] Route for Reception to CheckOut a specific room
app.put('/api/booking/:b_ref/checkout', async (req, res) => {
  const { b_ref } = req.params;
  const { r_no } = req.body;

  // console.log('Incoming checkout request:', { b_ref, r_no });

  try {
    // 1. Fetch room booking information
    const roomResult = await pool.query(`
      SELECT rb.checkin, rb.checkout, r.r_class, r.r_status
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE rb.b_ref = $1 AND rb.r_no = $2
    `, [b_ref, r_no]);

    if (roomResult.rowCount === 0) {
      console.log(`No room found for booking ref ${b_ref} and room ${r_no}`);
      return res.status(404).json({ message: 'Room not found for this booking' });
    }

    const { checkin, checkout, r_status } = roomResult.rows[0];

    // console.log('Room Result:', roomResult.rows);

    // 2. Format dates safely
    const currentDate = new Date().toLocaleDateString('en-CA'); // 'YYYY-MM-DD'
    const checkoutDate = new Date(checkout).toLocaleDateString('en-CA');

    // console.log(`Current Date (local): ${currentDate}`);
    // console.log(`Checkout Date (local): ${checkoutDate}`);

    // 3. Confirm checkout date matches today
    // KK TEMP RELAXED TO ALLOW CHECKOUT ON DIFFERENT DAYS TO PROCESS SOME ROOMS
    // if (checkoutDate !== currentDate) {
    if (new Date(checkoutDate) > new Date(currentDate)) {  // REMOVE THIS WHEN ROOMS ARE PROCESSED
      console.log(`Room ${r_no} cannot be checked out because checkout date (${checkoutDate}) is not today (${currentDate}).`);
      return res.status(400).json({ message: `Check-out can only be done for today's date.` });
    }

    // 4. Check room is currently occupied
    if (r_status !== 'O') {
      console.log(`Room ${r_no} is not occupied (current status: ${r_status}).`);
      return res.status(400).json({ message: `Room ${r_no} cannot be checked out because it is not occupied.` });
    }

    // 5. Update room status to 'C' (Checked-out)
    await pool.query(`
      UPDATE hotelbooking.room 
      SET r_status = 'C' 
      WHERE r_no = $1
    `, [r_no]);

    // 6. Check if any rooms in this booking are still occupied
    const remainingRooms = await pool.query(`
      SELECT COUNT(*) 
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE rb.b_ref = $1 AND r.r_status = 'O'
    `, [b_ref]);

    if (parseInt(remainingRooms.rows[0].count) === 0) {
      // All rooms checked out — this is the FINAL checkout
      await pool.query(`
        UPDATE hotelbooking.booking
        SET b_outstanding = 0
        WHERE b_ref = $1
      `, [b_ref]);

      console.log(`Booking ${b_ref} is now fully checked out. Balance cleared.`);
      res.json({ message: `Booking ${b_ref} is now fully checked out.` });
    } else {
      // Other rooms still occupied — don’t clear balance yet
      console.log(`Room ${r_no} checked out, others still occupied.`);
      res.json({ message: `Room ${r_no} checked out. Other rooms still occupied.` });
    }

  } catch (err) {
    console.error('Check-out error:', err.stack);
    res.status(500).json({ error: 'Check-out failed' });
  }
});

// [RECEPTION-DETAILS] Get Single Booking for Detail Page
app.get('/api/bookings/:b_ref/rooms', async (req, res) => {
  const { b_ref } = req.params;
  // console.log(`📡 API CALLED: /api/bookings/${b_ref}/rooms`);
  try {
    const rooms = await pool.query(`
      SELECT 
        rb.r_no,
        TO_CHAR(rb.checkin,'YYYY-MM-DD') AS check_in,
        TO_CHAR(rb.checkout,'YYYY-MM-DD') AS check_out,
        rb.checkout - rb.checkin AS nights,
        rb.guests,
        r.r_class,
        rt.price AS r_cost
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      JOIN hotelbooking.rates rt ON r.r_class = rt.r_class
      WHERE rb.b_ref = $1
      ORDER BY rb.checkin
    `, [b_ref]);
    res.json(rooms.rows);
    // console.log("📦 Data returned from DB:", rooms.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Could not load rooms' });
  }
});


// [RECEPTION-DETAILS] Show one room’s details (and list all rooms on that booking)
app.get('/staff/reception/booking/:b_ref', async (req, res) => {
  // console.log('📍 Route hit: /staff/reception/booking/:b_ref');
  //console.log('Params:', req.params);
  //console.log('Query:', req.query);

  const bRef = req.params.b_ref;
  const rNo = req.query.room;
  const checkout = req.query.checkout === '1'; // boolean flag

  try {
    // 1) Fetch single room booking with customer/booking/room info
    let sql = `
      SELECT
        rb.r_no, rb.b_ref, rb.guests,
        TO_CHAR(rb.checkin, 'YYYY-MM-DD') AS check_in,
        TO_CHAR(rb.checkout, 'YYYY-MM-DD') AS check_out,
        (rb.checkout - rb.checkin) AS nights,
        r.r_class, r.r_status,
        c.c_name, c.c_email, c.c_address,
        c.c_cardtype, c.c_cardexp, c.c_cardno,
        b.b_cost, b.b_outstanding, b.b_payment, b.b_paid
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      JOIN hotelbooking.booking b ON rb.b_ref = b.b_ref
      JOIN hotelbooking.customer c ON b.c_no = c.c_no
      WHERE rb.b_ref = $1
    `;
    const params = [bRef];
    if (rNo) {
      sql += ` AND rb.r_no = $2`;
      params.push(rNo);
    }
    sql += ` LIMIT 1;`;

    const single = await pool.query(sql, params);
    if (single.rowCount === 0) {
      return res.status(404).send('Room booking not found');
    }
    const booking = single.rows[0];

    // 2) Fetch all rooms for the booking
    const allRoomsResult = await pool.query(`
      SELECT r.r_no, r.r_status, rb.checkout
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE rb.b_ref = $1
    `, [bRef]);

    // 3) Check if all OTHER rooms are checked out (C)
    const allRoomsCheckedOut = allRoomsResult.rows.every(room =>
      !rNo || String(room.r_no) === String(rNo) || room.r_status === 'C'
    );
    
    // 4) Allow payment only if all rooms (except current) are checked out
    const canProcessPayment = allRoomsCheckedOut && !booking.b_paid;

    // 5) Fetch master room list
    const roomsResult = await pool.query(`
      SELECT r_no, r_class FROM hotelbooking.room ORDER BY r_no
    `);

    // 6) Fetch extras
    const extrasResult = await pool.query(
      'SELECT e_id, description, e_cost, added_at FROM hotelbooking.extras WHERE b_ref = $1 ORDER BY added_at ASC',
      [bRef]
    );
    const extras = extrasResult.rows;

    // 7) Determine if this is the last room to check out
    const latestCheckout = allRoomsResult.rows.reduce((latest, room) => {
      return room.check_out > latest.check_out ? room : latest;
    }, allRoomsResult.rows[0]);

    const isLastRoomToCheckout =
      latestCheckout.r_no === booking.r_no && booking.r_status === 'O';

    const autoCheckoutAndPay = checkout && isLastRoomToCheckout;

    // 8) Totals
    const extrasTotal = extras.reduce((sum, e) => sum + parseFloat(e.e_cost || 0), 0);
    const bookingTotal = parseFloat(booking.b_cost);

    
    // Log for debugging
    // console.log('Check this runs: ',{
    //   bRef,
    //   rNo,
    //   allRoomsCheckedOut,
    //   canProcessPayment
    // });

    // 9) Render view
    res.render('staff/reception-detail', {
      booking, // the selected room booking
      relatedRooms: allRoomsResult.rows,
      rooms: roomsResult.rows,
      extras,
      isLastRoomToCheckout,
      autoCheckoutAndPay,
      canProcessPayment,
      bookingTotal,
      extrasTotal,
      staffUser: req.session.staffUser,
      req
    });

    // Debug - Check data is being returned
    // console.log('Check these details: ',{
    //   booking,
    //   relatedRooms: allRoomsResult.rows,
    //   rooms: roomsResult.rows,
    //   extras,
    //   isLastRoomToCheckout,
    //   autoCheckoutAndPay,
    //   canProcessPayment,
    //   bookingTotal,
    //   extrasTotal,
    //   staffUser: req.session.staffUser,
    //   req
    // });

  } catch (err) {
    console.error(err);
    res.status(500).send('Internal Server Error');
  }
});


//In Reception Detail ADD extra
console.log("Registering: POST /staff/reception/extras/add");
app.post('/staff/reception/extras/add', async (req, res) => {
  // console.log('✅ Extras add POST triggered');
  // console.log(req.body);
  const { b_ref, description } = req.body;
  const e_cost = parseFloat(req.body.e_cost);

  // Validate e_cost
  if (isNaN(e_cost) || e_cost < 0) {
    console.warn('❌ Invalid cost value:', req.body.e_cost);
    return res.status(400).send('Invalid cost value provided.');
  }

  try {
    await pool.query(`
      INSERT INTO hotelbooking.extras (b_ref, description, e_cost)
      VALUES ($1, $2, $3)
    `, [b_ref, description, e_cost]);

    res.redirect(`/crown-hotel/staff/reception/booking/${b_ref}?extraAdded=1`);
  } catch (err) {
    console.error('Error adding extra:', err);
    res.redirect(`/crown-hotel/staff/reception/booking/${b_ref}?extraError=Failed+to+add+extra`);
  }
});

// In Reception Detail DELETE extra
app.post('/staff/reception/extras/delete', async (req, res) => {
  const { e_id } = req.body;
  try {
    const result = await pool.query('DELETE FROM hotelbooking.extras WHERE e_id = $1 RETURNING b_ref', [e_id]);
    if (result.rowCount === 0) return res.status(404).send('Extra not found');
    const b_ref = result.rows[0].b_ref;
    res.redirect(`/crown-hotel/staff/reception/booking/${b_ref}`);
  } catch (err) {
    console.error('Error deleting extra:', err);
    res.status(500).send('Failed to delete extra');
  }
});

// [RECEPTION-DETAILS] Update Booking from Detail Page
app.post('/staff/reception/booking/:id/update', async (req, res) => {
  const bookingId = req.params.id;
  const {
    c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno,
    room, checkin, checkout, guests
  } = req.body;

  try {
    // Step 1: Get customer number from booking
    const customerResult = await pool.query(`
      SELECT c_no FROM hotelbooking.booking WHERE b_ref = $1
    `, [bookingId]);

    if (customerResult.rowCount === 0) {
      return res.redirect(`/crown-hotel/staff/reception/booking/${bookingId}?error=customer-not-found`);
    }

    const c_no = customerResult.rows[0].c_no;

    // Step 2: Update customer details
    await pool.query(`
      UPDATE hotelbooking.customer
      SET c_name = $1,
          c_email = $2,
          c_address = $3,
          c_cardtype = $4,
          c_cardexp = $5,
          c_cardno = $6
      WHERE c_no = $7
    `, [c_name, c_email, c_address, c_cardtype, c_cardexp, c_cardno, c_no]);

    // Step 3: Update room booking details if valid
    if (room) {
      const roomCheck = await pool.query(`
        SELECT 1 FROM hotelbooking.roombooking WHERE b_ref = $1 AND r_no = $2
      `, [bookingId, room]);

      if (roomCheck.rowCount > 0) {
        await pool.query(`
          UPDATE hotelbooking.roombooking
          SET checkin = $1,
              checkout = $2,
              guests = $3
          WHERE b_ref = $4
            AND r_no = $5
        `, [checkin, checkout, guests, bookingId, room]);
      }
    }

    // Step 4: Recalculate and update booking cost
    const rateResult = await pool.query(`
      SELECT r.r_class, rt.price
      FROM hotelbooking.room r
      JOIN hotelbooking.rates rt ON r.r_class = rt.r_class
      WHERE r.r_no = $1
    `, [room]);

    if (rateResult.rowCount > 0) {
      const { price } = rateResult.rows[0];
      const nights = Math.floor((new Date(checkout) - new Date(checkin)) / (1000 * 60 * 60 * 24));
      const newCost = price * nights;

      await pool.query(`
        UPDATE hotelbooking.booking
        SET b_cost = $1
        WHERE b_ref = $2
      `, [newCost, bookingId]);
    }

    // Step 5: Redirect with success
    res.redirect(`/crown-hotel/staff/reception/booking/${bookingId}?updated=1`);

  } catch (err) {
    console.error('❌ Failed to update booking:', err);
    res.redirect(`/crown-hotel/staff/reception/booking/${bookingId}?error=1`);
  }
});

// API for reception calander
app.get('/api/unavailable-dates', async (req, res) => {
  const roomNo = req.query.room;
  if (!roomNo) {
    return res.status(400).json({ error: "Missing room number" });
  }

  try {
    const result = await pool.query(`
      SELECT 
        (rb.checkin AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/London') AS checkin,
        (rb.checkout AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/London') AS checkout
      FROM hotelbooking.roombooking rb
      WHERE r_no = $1 AND rb.checkout > CURRENT_DATE
    `, [roomNo]);

    const unavailableDates = result.rows.map(row => ({
      checkin: row.checkin.toLocaleDateString('en-CA'),
      checkout: row.checkout.toLocaleDateString('en-CA')
    }));

    res.json(unavailableDates);
  } catch (err) {
    console.error('❌ Error fetching unavailable dates:', err);
    res.status(500).send('Error fetching unavailable dates');
  }
});

// [API] Get Room Rate for a Given Room Number
app.get('/api/room-rate', async (req, res) => {
  const r_no = req.query.r_no;

  if (!r_no) {
    return res.status(400).json({ error: 'Missing room number' });
  }

  try {
    const result = await pool.query(
      `SELECT rt.price AS rate
       FROM hotelbooking.room r
       JOIN hotelbooking.rates rt ON r.r_class = rt.r_class
       WHERE r.r_no = $1`,
      [r_no]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Room not found or rate not set' });
    }

    const rate = result.rows[0].rate;
    res.json({ rate });
  } catch (err) {
    console.error('❌ Error fetching room rate:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});


app.post('/staff/reception/take-payment', async (req, res) => {
  const { b_ref } = req.body;

  try {
    // Get booking and extras
    const bookingResult = await pool.query(`
      SELECT b_cost FROM hotelbooking.booking WHERE b_ref = $1
    `, [b_ref]);
    if (bookingResult.rowCount === 0) return res.status(404).send('Booking not found');
    const b_cost = parseFloat(bookingResult.rows[0].b_cost);

    const extrasResult = await pool.query(`
      SELECT e_cost FROM hotelbooking.extras WHERE b_ref = $1
    `, [b_ref]);
    const extrasTotal = extrasResult.rows.reduce((sum, extra) => sum + parseFloat(extra.e_cost), 0);

    const totalAmount = b_cost + extrasTotal;

    // Check all rooms for this booking
    const roomStatuses = await pool.query(`
      SELECT r.r_no, r.r_status
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      WHERE rb.b_ref = $1
    `, [b_ref]);

    const anyStillOccupied = roomStatuses.rows.some(r => r.r_status !== 'C');
    if (anyStillOccupied) {
      // Mark all as checked out now (final step)
      await pool.query(`
        UPDATE hotelbooking.room
        SET r_status = 'C'
        WHERE r_no IN (
          SELECT r_no FROM hotelbooking.roombooking WHERE b_ref = $1
        )
      `, [b_ref]);
    }

    // Update booking as paid
    await pool.query(`
      UPDATE hotelbooking.booking
      SET b_outstanding = 0, b_payment = $1, b_paid = TRUE
      WHERE b_ref = $2
    `, [totalAmount, b_ref]);

    res.redirect('/crown-hotel/staff/reception');

  } catch (err) {
    console.error('❌ Error in take-payment:', err);
    res.status(500).send('Failed to process payment');
  }
});


// Login
app.get('/login', (req, res) => res.render('login', { error: null }));

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const result = await pool.query('SELECT * FROM hotelbooking.staff WHERE username = $1', [username]);
        if (result.rowCount === 0) return res.render('login', { error: 'User not found' });

        const staff = result.rows[0];

        // 👇 ADD THIS HERE
        console.log("Role from DB:", staff.role);
        console.log("Staff row:", staff);

        const match = await bcrypt.compare(password, staff.password);
        if (!match) return res.render('login', { error: 'Incorrect password' });

        req.session.staffUser = {
            id: staff.staff_id,
            username: staff.username,
            name: staff.full_name,
            role: staff.role
        };

    // Redirect paths
    const roleRedirects = {
        receptionist: '/crown-hotel/staff/reception',
        housekeeper: '/crown-hotel/staff/housekeeping',
        manager: '/crown-hotel/staff/management'
      };
  
      const redirectPath = roleRedirects[staff.role] || '/login';
      res.redirect(redirectPath);
  
    } catch (err) {
        console.error(err);
        res.render('login', { error: 'An error occurred' });
    }
});


// Logout
app.get('/logout', (req, res) => {
    req.session.destroy(() => res.redirect('/crown-hotel/login'));
});


// Fetch Today's Check-Outs for Housekeeping (GET /api/housekeeping)
app.get('/api/housekeeping', async (req, res) => {
  try {
      const result = await pool.query(`
          SELECT
            r.r_no,
            CASE
                WHEN r.r_class = 'std_d' THEN 'Standard Double'
                WHEN r.r_class = 'std_t' THEN 'Standard Twin'
                WHEN r.r_class = 'sup_d' THEN 'Superior Double'
                WHEN r.r_class = 'sup_t' THEN 'Superior Twin'
                ELSE 'Unknown'
            END AS r_class,
            MAX(TO_CHAR(rb.checkout, 'YYYY-MM-DD')) AS checkout,
            CAST(r.r_status AS TEXT) AS r_status,
            CASE 
                WHEN r.r_status = 'C' THEN 'Checked-out'
                WHEN r.r_status = 'X' THEN 'Cleaning'
                WHEN r.r_status = 'O' THEN 'Occupied'
                WHEN r.r_status = 'A' THEN 'Ready for next guest'
                ELSE 'Unknown Status'
            END AS r_status_desc
          FROM hotelbooking.booking b
          JOIN hotelbooking.customer c ON b.c_no = c.c_no
          JOIN hotelbooking.roombooking rb ON b.b_ref = rb.b_ref
          JOIN hotelbooking.room r ON rb.r_no = r.r_no
          WHERE 
            (rb.checkout = CURRENT_DATE)
            OR (r.r_status = 'C' AND rb.checkout <= CURRENT_DATE)
            OR (r.r_status = 'X' AND rb.checkout <= CURRENT_DATE)
          GROUP BY r.r_no, r.r_class, r.r_status
          ORDER BY 
              CASE r.r_status 
                  WHEN 'C' THEN 1
                  WHEN 'X' THEN 2
                  WHEN 'O' THEN 3
                  WHEN 'A' THEN 4
                  ELSE 5
              END,
              r.r_no ASC
      `);
      res.json(result.rows);
  } catch (err) {
      console.error('❌ Housekeeping query error:', err);
      res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Housekeeping status change route
app.put('/api/room/:r_no/status', async (req, res) => {
    const { r_no } = req.params;
    const { newStatus } = req.body;

    try {
        if (newStatus === 'X') {
            await pool.query(
                `UPDATE hotelbooking.room
                 SET r_status = 'X'
                 WHERE r_status = 'C'
                 AND r_no = $1`, [r_no]
            );
        } else if (newStatus === 'A') {
            await pool.query(
                `UPDATE hotelbooking.room
                 SET r_status = 'A'
                 WHERE r_status = 'X'
                 AND r_no = $1`, [r_no]
            );
        } else {
            return res.status(400).json({ message: 'Invalid status change requested' });
        }

        res.json({ message: `Room ${r_no} updated to status ${newStatus}` });
    } catch (err) {
        console.error('❌ Room status update error:', err);
        res.status(500).json({ message: 'Failed to update room status' });
    }
});

// Management Occupancy report
app.get('/api/reports/occupancy', async (req, res) => {
  const { start, end } = req.query;

  try {
    const result = await pool.query(`
      SELECT 
        r.r_no,
        CASE
            WHEN r.r_class = 'std_d' THEN 'Standard Double'
            WHEN r.r_class = 'std_t' THEN 'Standard Twin'
            WHEN r.r_class = 'sup_d' THEN 'Superior Double'
            WHEN r.r_class = 'sup_t' THEN 'Superior Twin'
            ELSE 'Unknown'
        END AS r_class,
        COUNT(rb.r_no) AS days_occupied,
        7 AS total_available,
        ROUND((COUNT(rb.r_no)::decimal / 7) * 100, 1) AS occupancy_percentage
      FROM hotelbooking.room r
      LEFT JOIN hotelbooking.roombooking rb 
        ON r.r_no = rb.r_no 
        AND rb.checkin <= $2 
        AND rb.checkout >= $1
      GROUP BY r.r_no, r.r_class
      ORDER BY r.r_no;
    `, [start, end]);

    res.json(result.rows);
  } catch (err) {
    console.error('❌ Occupancy report error:', err);
    res.status(500).json({ error: 'Failed to fetch occupancy report' });
  }
});


// Management Income report
app.get('/api/reports/income', async (req, res) => {
  const { start, end } = req.query;

  try {
    const result = await pool.query(`
      SELECT 
        rb.checkin AS date,
        b.b_ref,
        r.r_class,
        ra.price AS nightly_rate,
        (rb.checkout - rb.checkin) AS nights,
        (rb.checkout - rb.checkin) * ra.price AS room_revenue,
        COALESCE(SUM(e.e_cost), 0) AS extras,
        ((rb.checkout - rb.checkin) * ra.price + COALESCE(SUM(e.e_cost), 0)) AS total_income
      FROM hotelbooking.roombooking rb
      JOIN hotelbooking.booking b ON rb.b_ref = b.b_ref
      JOIN hotelbooking.room r ON rb.r_no = r.r_no
      JOIN hotelbooking.rates ra ON r.r_class = ra.r_class
      LEFT JOIN hotelbooking.extras e ON b.b_ref = e.b_ref
      WHERE rb.checkin BETWEEN $1 AND $2
      GROUP BY rb.checkin, b.b_ref, r.r_class, ra.price, rb.checkout, rb.checkin
      ORDER BY rb.checkin;
    `, [start, end]);

    res.json(result.rows);
  } catch (err) {
    console.error('❌ Income report error:', err);
    res.status(500).json({ error: 'Failed to fetch income report' });
  }
});


// Contact Form Saving to Database


// Removed due to being mounted in portfolio server
// ✅ Start the server
// app.listen(PORT, () => console.log(`🚀 Server running at http://localhost:${PORT}`));

// Start the server normally
// app.listen(PORT, () => {
//   console.log(`🚀 Crown Hotel backend running at http://localhost:${PORT}`);
// });

// Only start server if this file is run directly, not if mounted
if (require.main === module) {
    const PORT = process.env.PORT || 5001;
    app.listen(PORT, () => {
        console.log(`🚀 Crown Hotel backend running at http://localhost:${PORT}`);
    });
}

// Always export the app so it can be mounted
module.exports = app;