console.log("HOUSEKEEPING JS LOADED");
// Run this when the page is fully loaded
document.addEventListener('DOMContentLoaded', async () => {
    // Confirm DataTable on the housekeeping table
    const table = $('#bookingTable').DataTable({
        order: [], // Disable automatic intial sort
        pageLength: getPageLengthFromStorage(), // Get saved page length from localStorage
        responsive: {
            details: {
                type: 'column'  // Change to 'column' or 'inline' depending on how the rows should be displayed
            }
        },
        // defines the order to show the columns, in particular when responsive
        columnDefs: [
            { responsivePriority: 1, targets: 0 }, // Room No — always shown
            { responsivePriority: 2, targets: 4 }, // Description — next most important
            { responsivePriority: 3, targets: 5 }, // Actions — try to keep visible
            { responsivePriority: 4, targets: 1 }, // Room Type
            { responsivePriority: 5, targets: 2 }, // Checkout
            { responsivePriority: 6, targets: 3 }, // Room Status
        ]
    });

    // Set dropdown to match stored value
    $('#bookingTable_length select').val(getPageLengthFromStorage()).trigger('change');

    const tableBody = document.querySelector('#bookingTable tbody');
    
    // Fetch and update data function
    async function fetchData() {
        try {
            // Fetch todays checkouts from the API
            const res = await fetch('/crown-hotel/api/housekeeping');
            const rooms = await res.json();
            console.log("🧹 Housekeeping data received:", rooms);
  
            if (rooms.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="6">✅ No check-outs for today.</td></tr>';
                return;
            }

            // Clear the table before updating
            table.clear();

            rooms.forEach(r => {
                const r_no = r.r_no ?? 'N/A';
                const r_class = r.r_class ?? 'N/A';
                const checkout = formatDate(r.checkout);
                const status = r.r_status ?? 'Dirty';
                const desc = r.r_status_desc ?? 'Unknown';

                table.row.add([
                    r_no,
                    r_class,
                    checkout,
                    status,
                    desc,
                    generateActionButton(r_no, status)  // dynamically generate the button
                ]);
            });
  
            table.draw(); // Show the data
        } catch (err) {
            console.error("❌ Error loading housekeeping data:", err);
            tableBody.innerHTML = '<tr><td colspan="6" class="text-danger">Error loading housekeeping data.</td></tr>';
        }
    }
  
    // Fetch data immediately when the page loads
    fetchData();

    // Refresh data every 60 seconds
    setInterval(fetchData, 60000); 

    // Manual refresh button logic
    document.getElementById('refreshButton').addEventListener('click', fetchData);

    // Handle button clicks
    $('#bookingTable tbody').on('click', '.action-btn', async function () {
        const r_no = $(this).data('room');
        const newStatus = $(this).data('next');
        const statusMessage = $(this).data('message');

        if (statusMessage && !confirm(statusMessage)) return;

        try {
            const res = await fetch(`/crown-hotel/api/room/${r_no}/status`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ newStatus })
            });

            const result = await res.json();

            if (res.ok) {
                alert(`✅ Room ${r_no} status updated.`);
                fetchData(); // Reload the table without reloading the full page
            } else {
                alert(result.message || 'Failed to update room status.');
            }
        } catch (err) {
            console.error("❌ Error updating room status:", err);
            alert('⚠️ Error updating room status.');
        }
    });
    
    // Save DataTables page length
    $('#bookingTable_length select').on('change', function () {
        const selectedLength = $(this).val();
        table.page.len(selectedLength).draw();
        savePageLengthToStorage(selectedLength);
    });
});

// Format date to readable string
function formatDate(dateStr) {
const date = new Date(dateStr);
return date.toLocaleDateString('en-GB'); // e.g. "13/04/2025"
}

// Function to save selected page length to localStorage
function savePageLengthToStorage(pageLength) {
    localStorage.setItem('pageLength', pageLength);
}

// Function to retrieve page length from localStorage
function getPageLengthFromStorage() {
    return localStorage.getItem('pageLength') || 10; // Default to 10 if no value found
}

// Generate action buttons based on room status
function generateActionButton(r_no, status) {
    let label = '';
    let btnClass = '';
    let nextStatus = '';
    let statusMessage = ''; // This will hold the message for the confirmation prompt

    if (status === 'C') {
        label = 'Start Cleaning';
        btnClass = 'btn-danger';  // Red button for "Start Cleaning"
        nextStatus = 'X';  // Cleaning in progress
        statusMessage = 'Start cleaning for room ' + r_no + '?';  // Message when status is C
    } else if (status === 'X') {
        label = 'Cleaning';
        btnClass = 'btn-warning';  // Amber button for "Cleaning"
        nextStatus = 'A';  // Ready for next guest
        statusMessage = 'Finish cleaning and make room available for room ' + r_no + '?';  // Message when status is X
    } else if (status === 'A') {
        label = 'Room Cleaned';
        btnClass = 'btn-success';  // Green button for "Room Cleaned"
        nextStatus = null;  // No more status update needed
        statusMessage = null;  // No prompt when status is already A
    } else {
        return ''; // No action for other statuses
    }

    // If no next status, make the button disabled
    if (!nextStatus) {
        return `<button class="btn btn-sm ${btnClass}" disabled>${label}</button>`;
    }

    return `<button 
        class="btn btn-sm ${btnClass} action-btn"
        data-room="${r_no}"
        data-next="${nextStatus}"
        data-message="${statusMessage}">
        ${label}
    </button>`;
}
