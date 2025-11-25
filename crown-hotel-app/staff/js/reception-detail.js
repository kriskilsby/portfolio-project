console.log("RECEPTION DETAIL JS LOADED");
// Original details were inbetween <script> tags in reception-detail.ejs file - KK moved it to this seperate file.

function updateRoomInfoDisplay() {
  // Get the room type value from the input element
  const r_class = document.getElementById('room-type')?.value;
  
  // Use ROOM_NAMES to display the full room name or default to r_class if not found
  const fullRoomName = ROOM_NAMES[r_class] || r_class;

  // Get the check-in value from the reception-checkin input element
  const checkinValue = document.getElementById('reception-checkin')?.value;
  
  // If check-in value exists, format it
  if (checkinValue) {
    const formattedCheckin = formatDate(checkinValue);

    // Get the elements where the data will be displayed
    const roomNameDisplay = document.getElementById('room-name-display');
    const checkinDisplay = document.getElementById('formatted-checkin-display');

    // Update the room name display
    if (roomNameDisplay) {
      roomNameDisplay.textContent = `Room Type: ${fullRoomName}`;
    }

    // Update the check-in display
    if (checkinDisplay) {
      checkinDisplay.textContent = `Formatted Check-In: ${formattedCheckin}`;
    }
  }
}

// Function to map r_class short codes to full room names
const ROOM_NAMES = {
  'std_d': 'Standard Double',
  'std_t': 'Standard Twin',
  'sup_d': 'Superior Double',
  'sup_t': 'Superior Twin'
};

// Function to format date from YYYY-MM-DD to DD/MM/YYYY
function formatDate(dateString) {
  const [year, month, day] = dateString.split('-');
  return `${day}/${month}/${year}`;
}

// Update nights and costs
async function updateNightsAndCost() {
  const checkinDate = new Date(document.getElementById('reception-checkin').value);
  const checkoutDate = new Date(document.getElementById('reception-checkout').value);
  const nights = Math.max((checkoutDate - checkinDate) / (1000 * 60 * 60 * 24), 0);
  const nightsInput = document.getElementById('nights');
  nightsInput.value = isNaN(nights) ? 0 : Math.floor(nights);

  const r_no = document.getElementById('room-selector').value;
  if (!r_no || isNaN(nights) || nights < 1) return;

  try {
    const res = await fetch(`/crown-hotel/api/room-rate?r_no=${r_no}`);
    const data = await res.json();

    const rate = data.rate;
    const cost = Math.floor(nights) * rate;

    document.getElementById('b_cost').value = cost.toFixed(2);
  } catch (err) {
    console.error('Rate fetch failed:', err);
  }
}

// Create event listeners
document.getElementById('reception-checkin').addEventListener('change', updateNightsAndCost);
document.getElementById('reception-checkout').addEventListener('change', updateNightsAndCost);
document.getElementById('room-selector').addEventListener('change', updateNightsAndCost);

document.getElementById('room-selector').addEventListener('change', async function () {
  const roomNo = this.value;
  const bookingId = document.getElementById('booking-id').value;

  if (!roomNo || !bookingId) return;

  try {
    const res = await fetch(`/crown-hotel/staff/reception/booking/${bookingId}/room-type`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ roomNo: roomNo })
    });

    const data = await res.json();
    if (data.roomClass) {
      document.getElementById('room-type').value = data.roomClass;
      updateRoomInfoDisplay();
    }
  } catch (err) {
    console.error('❌ Failed to fetch room type:', err);
  }
});

// Update night and costs, and load room details
document.addEventListener('DOMContentLoaded', () => {
  updateNightsAndCost();
  updateRoomInfoDisplay();
});

// Fetch & render the 'Rooms on This Booking' table dynamically
document.addEventListener('DOMContentLoaded', async () => {
  const bRef = document.getElementById('booking-id')?.value;
  const tbody = document.querySelector('#relatedRoomsTable tbody');
  if (!bRef || !tbody) return;

  tbody.innerHTML = '<tr><td colspan="7">Loading…</td></tr>';

  try {
    const res = await fetch(`/crown-hotel/api/bookings/${bRef}/rooms`);
    if (!res.ok) {
      const text = await res.text();
      console.error(`❌ /crown-hotel/api/bookings/${bRef}/rooms returned ${res.status}:\n`, text);
      tbody.innerHTML = '<tr><td colspan="7">Error loading rooms</td></tr>';
      return;
    }

    const rooms = await res.json();
    tbody.innerHTML = '';

    if (rooms.length === 0) {
      tbody.innerHTML = '<tr><td colspan="7">No other rooms on this booking</td></tr>';
    } else {
      rooms.forEach(rm => {
        // console.log("Rooms received:", rooms);
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td><a href="/crown-hotel/staff/reception/booking/${bRef}?room=${rm.r_no}">${rm.r_no}</a></td>
          <td>${rm.r_class}</td>
          <td>${rm.check_in}</td>
          <td>${rm.check_out}</td>
          <td>${rm.guests}</td>
          <td>${rm.nights}</td>
          <td>
            <a href="/crown-hotel/staff/reception/booking/${bRef}?room=${rm.r_no}" class="btn btn-sm btn-primary">
              View
            </a>
          </td>
        `;
        tbody.appendChild(tr);
      });
    }
  } catch (err) {
    console.error('💥 Failed to load related rooms:', err);
    tbody.innerHTML = '<tr><td colspan="7">Error loading rooms</td></tr>';
  }
});




