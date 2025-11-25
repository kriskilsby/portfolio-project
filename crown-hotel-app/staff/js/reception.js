console.log('Reception JS loaded');
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

document.addEventListener('DOMContentLoaded', async () => {
  // Set up DataTable sorted by Booking Ref (descending)
  const table = $('#bookingTable').DataTable({
    order: [[0, 'desc']],
    pageLength: getPageLengthFromStorage(), // Get saved page length from localStorage
    responsive: {
      details: {
        type: 'column' // Use columns for responsiveness
      }
    }, // Set the priority list of columns in the DataTable
    columnDefs: [
      { responsivePriority: 1, targets: 0 }, // Booking Ref - highest priority
      { responsivePriority: 2, targets: 10 }, // Actions - third most important
      { responsivePriority: 3, targets: 1 }, // Name - second most important
      { responsivePriority: 4, targets: 2 }, // Room No
      { responsivePriority: 5, targets: 3 }, // Room Type
      { responsivePriority: 6, targets: 4 }, // Check-in
      { responsivePriority: 7, targets: 5 }, // Check-out
      { responsivePriority: 8, targets: 6 }, // Nights
      { responsivePriority: 9, targets: 7 }, // Guests
      { responsivePriority: 10, targets: 8 }, // Total (£)
      { responsivePriority: 11, targets: 9 }  // Outstanding (£)
    ]
  });

  // Set dropdown to match stored value for page length
  $('#bookingTable_length select').val(getPageLengthFromStorage()).trigger('change');

  const filterSelect = document.getElementById('filter');
  let allBookings = [];

  // Filter logic separated into a reusable function
  function applyFilter(filter) {
    const today = new Date().toISOString().slice(0, 10);
    let filtered = [...allBookings];

    if (filter === 'checkin_today') {
      filtered = filtered.filter(b => b.check_in === today);
    } else if (filter === 'checkout_today') {
      filtered = filtered.filter(b => b.check_out === today);
    }

    renderTable(filtered);
  }

  try {
    // Fetch bookings from server
    const response = await fetch('/crown-hotel/api/bookings');
    allBookings = await response.json();

    //renderTable(allBookings); // Show all by default

  // Restore saved filter from localStorage
  const savedFilter = localStorage.getItem('bookingFilter');
  if (savedFilter) {
    filterSelect.value = savedFilter;
    applyFilter(savedFilter);
  } else {
    renderTable(allBookings); // Default if no saved filter
  }

  // Listen for dropdown changes and apply filter + save to localStorage
  filterSelect?.addEventListener('change', () => {
    const filter = filterSelect.value;
    localStorage.setItem('bookingFilter', filter); // Save selection
    applyFilter(filter);
  });

  } catch (err) {
    console.error('Error loading bookings:', err);
    document.querySelector('#bookingTable tbody').innerHTML = '<tr><td colspan="11">Error loading bookings</td></tr>';
  }

  // KK UPDATED TO ADD r_no TO ARGUEMENT TO ALLOW MUPLTIPLE ROOMS ON BOOKING
  // Render table with given booking data
function renderTable(data) {
  table.clear().draw();
  const today = new Date().toISOString().slice(0, 10); // Get today's date

  data.forEach(b => {
    let buttons = '';
    
    // Check first if the booking is paid in full
    if (b.b_paid === true) {
      buttons = `<button class="btn btn-sm btn-primary" disabled>Paid Full</button>`;
    }
    // If not paid in full, check if room is already checked-out
    else if (b.r_status === 'C') {
      buttons = `<button class="btn btn-sm btn-secondary" disabled>Checked Out</button>`;
    } else if (b.r_status === 'O') {
      // Room occupied — show a single redirect-based Check-Out button
      buttons = `
        <button class="btn btn-sm btn-danger"
                onclick="window.location.href='/crown-hotel/staff/reception/booking/${b.b_ref}?room=${b.r_no}&checkout=1'">
          Check-Out
        </button>
      `;
    } else {
      buttons = `
        <button class="btn btn-sm btn-success"
                onclick="checkIn('${b.b_ref}', '${b.r_no}')">
          Check-In
        </button>
      `;
    }

    const row = table.row.add([
      b.b_ref || 'N/A',
      b.c_name || 'N/A',
      b.r_no || 'N/A',
      ROOM_NAMES[b.r_class] || 'Unknown Room', // Use ROOM_NAMES for room type
      formatDate(b.check_in) || 'N/A',
      formatDate(b.check_out) || 'N/A',
      b.nights || 'N/A',
      b.guests || 'N/A',
      b.b_cost || 'N/A',
      b.b_outstanding || 'N/A',
      buttons  // <- Insert dynamic buttons
    ]).draw().node();

    row.classList.add('clickable-row');
    row.setAttribute('data-id', b.b_ref);
    row.setAttribute('data-room', b.r_no);

    // Highlight today's check-in/out using Bootstrap classes
    if (b.check_in === today) {
      row.classList.add('table-success');  // Green for check-ins
    } else if (b.check_out === today) {
      row.classList.add('table-danger'); // Red for check-outs
    }
  });
}
  // Handle row click > go to booking detail page
  $('#bookingTable tbody').on('click', 'tr.clickable-row', function (e) {
    if (!e.target.closest('button')) {
      const bookingRef = this.dataset.id;
      const roomNo = this.dataset.room;
      if (bookingRef && roomNo) {
        window.location.href = `/crown-hotel/staff/reception/booking/${bookingRef}?room=${roomNo}`;
      }
    }
  });
    
  // Fetch and update data periodically every 60 seconds
  setInterval(fetchData, 60000);

  // Manual refresh button logic
  document.getElementById('refreshButton').addEventListener('click', fetchData);

  async function fetchData() {
    try {
      const response = await fetch('/crown-hotel/api/bookings');
      const newBookings = await response.json();
      allBookings = newBookings; // Update the main data array
  
      const savedFilter = localStorage.getItem('bookingFilter');
      if (savedFilter) {
        applyFilter(savedFilter); // Apply saved filter to fresh data
      } else {
        renderTable(allBookings); // No filter, show all
      }
    } catch (err) {
      console.error('Error loading bookings data:', err);
      document.querySelector('#bookingTable tbody').innerHTML = '<tr><td colspan="11">Error loading bookings</td></tr>';
    }
  }

  // Handle page length change and save it to local storage
  $('#bookingTable_length select').on('change', function () {
      const selectedLength = $(this).val();
      table.page.len(selectedLength).draw();
      savePageLengthToStorage(selectedLength);
  });

});

// Function to save selected page length to local storage
function savePageLengthToStorage(pageLength) {
localStorage.setItem('pageLength', pageLength);
}

// Function to retrieve page length from local storage
function getPageLengthFromStorage() {
return localStorage.getItem('pageLength') || 10; // Default to 10 if no value found
}

// KK HAS UPDATED THE BELOW TO ALLOW FOR MORE THAN ONE ROOM ON BOOKING SO WE NEED TO PASS THE r.no
// Check-In (updates room status to occupied)
async function checkIn(b_ref, r_no) {
  if (!confirm(`Check guest in and mark room ${r_no} as occupied?`)) return;

  try {
      const res = await fetch(`/crown-hotel/api/booking/${b_ref}/checkin`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ r_no })  // send the room number
      });
      const result = await res.json();

    if (res.ok) {
      alert(result.message || `Room ${r_no} checked in.`);
      location.reload();
    } else {
      alert(result.message || 'Check-in failed.');
    }
  } catch (err) {
    alert('Error during check-in.');
  }
}

// KK HAS UPDATED THE BELOW TO ALLOW FOR MORE THAN ONE ROOM ON BOOKING SO WE NEED TO PASS THE r.no
// Check-Out a specific room (updates room status to cleaned + updates balance)
async function checkOut(b_ref, r_no) {
  if (!confirm(`Check out Room ${r_no} and mark for cleaning?`)) return;

  try {
    const res = await fetch(`/crown-hotel/api/booking/${b_ref}/checkout`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ r_no })
    });

    const result = await res.json();

    if (res.ok) {
      alert(`Room ${r_no} checked out.`);
      location.reload();
    } else {
      alert(result.message || 'Check-out failed.');
    }
  } catch (err) {
    console.error(err);
    alert('Error during check-out.');
  }
}
