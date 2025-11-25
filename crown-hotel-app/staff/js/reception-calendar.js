console.log("RECEPTION CALENDAR JS LOADED");
// KK ADDED THIS FILE TO CREATE A SEPERATE SCRIPT USING FLATPICKR (ENABLING GREYED-OUT UNAVILABLE DATES)

// Functions converts YYYY-MM-DD string into a JavaScript Date object in local time (not UTC)
function parseDateLocal(dateStr) {
    const [year, month, day] = dateStr.split('-').map(Number);
    return new Date(year, month - 1, day); // No UTC, local time only
  }

// Disable check-in: Funtion to get checkin disabled date ranges
function getCheckinDisabledDateRanges(bookings) {
    return bookings.map(({ checkin, checkout }) => {
      const from = parseDateLocal(checkin);
      const to = parseDateLocal(checkout);
      to.setDate(to.getDate() - 1); // guests stay until day before checkout
      return { from, to };
    });
  }

// Disable check-out: Funtion to get checkout disabled date ranges
function getCheckoutDisabledDateRanges(bookings) {
    return bookings.map(({ checkin, checkout }) => {
      const from = parseDateLocal(checkin);
      from.setDate(from.getDate() + 1); // prevent checkout on next checkin
      const to = parseDateLocal(checkout);
      return { from, to };
    });
  }

// Ensures this only runs after the DOM is fully loaded
document.addEventListener("DOMContentLoaded", async function () {
  // Selects the HTML elements
  const checkinEl = document.getElementById("reception-checkin");
  const checkoutEl = document.getElementById("reception-checkout");
  const roomEl = document.querySelector("#room-selector");

  if (!checkinEl || !checkoutEl || !roomEl) return;

  const roomNo = roomEl.value;
  let bookings = [];

  // Fetch the unavailable dates from the backend API
  try {
    const res = await fetch(`/crown-hotel/api/unavailable-dates?room=${encodeURIComponent(roomNo)}`);
    if (res.ok) {
      bookings = await res.json();
      // console.log("📆 Bookings:", bookings);
    } // Catch errors 
  } catch (err) {
    console.error("❌ 🚨 Error fetching unavailable dates:", err);
  }

  const checkinDisabled = getCheckinDisabledDateRanges(bookings);
  const checkoutDisabled = getCheckoutDisabledDateRanges(bookings);

  // Initialises check-in flatpickr for disabled booked ranges
  const checkinPicker = flatpickr(checkinEl, {
      dateFormat: "Y-m-d",
      minDate: "today",
      disable: checkinDisabled,
      onChange: function (selectedDates, dateStr) {
        checkoutPicker.set("minDate", dateStr); // Enforce checkout after checkin
      }
    });
  // Initialises check-out flatpickr for disabled booked ranges
  const checkoutPicker = flatpickr(checkoutEl, {
      dateFormat: "Y-m-d",
      minDate: "today",
      disable: checkoutDisabled
      });
  });
  