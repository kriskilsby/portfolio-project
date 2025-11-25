console.log("MANAGEMENT JS LOADED");
// Function to format the week dates for the report selection
function formatWeekDates(weekValue) {
    const [year, week] = weekValue.split('-W');
    const jan1 = new Date(`${year}-01-01`);
  
    // Get the day of the week for January 1st
    const jan1Day = jan1.getDay();
  
    // Calculate the offset: Move to the first Monday of the year
    const daysOffset = (parseInt(week) - 1) * 7;
  
    // If Jan 1st is a Sunday, the first Monday will be on Jan 2nd, otherwise adjust the offset
    const firstMonday = jan1.setDate(jan1.getDate() + (jan1Day === 0 ? 1 : 1 - jan1Day));
  
    const weekStart = new Date(firstMonday + daysOffset * 24 * 60 * 60 * 1000); // Multiply by 24h to get days into milliseconds
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekStart.getDate() + 6); // End of the week, Sunday
  
    return {
      start: weekStart.toISOString().split('T')[0],
      end: weekEnd.toISOString().split('T')[0],
    };
  }
  // Occupancy Report: Set up a DataTable and calculate the sums for the bottom of the table
  // Wait for the DataTable to fully load before running
  document.addEventListener('DOMContentLoaded', () => {
    const occupancyTable = $('#occupancyTable').DataTable({
        // Function to call the footer sums after every data change
        footerCallback: function (row, data, start, end, display) {
          const api = this.api();
      
          let totalDaysOccupied = 0;
          let totalAvailable = 0;
          let occupancySum = 0;
      
          // Parse numerical values from the relevant column row numbers
          data.forEach(row => {
            const daysOccupied = parseInt(row[2]) || 0;
            const totalAvailableRoom = parseInt(row[3]) || 0;
            const occupancyPercent = parseFloat(row[4].replace('%', '')) || 0;
      
            totalDaysOccupied += daysOccupied;
            totalAvailable += totalAvailableRoom;
            occupancySum += occupancyPercent;
          });
      
          // Calculate average occupancy
          const averageOccupancy = data.length ? (occupancySum / data.length) : 0;
      
          // Display the results in the footer
          $('#totalDaysOccupied').html(totalDaysOccupied);
          $('#totalAvailable').html(totalAvailable);
          $('#totalOccupancyPercentage').html(`${averageOccupancy.toFixed(2)}%`);
        }
      });

    // Income Report: Set up a DataTable and calculate the sums for the bottom of the table
    // Wait for the DataTable to fully load before running
    const incomeTable = $('#incomeTable').DataTable({
      footerCallback: function (row, data, start, end, display) {
        const api = this.api();
        
        // Fortmats the input value so it vcan be converted to a float
        const parseCurrency = val => parseFloat(val.replace(/£|,/g, '')) || 0;
        // Total Room Revenue
        const totalRoomRev = api
          .column(2, { page: 'current' })
          .data()
          .reduce((sum, val) => sum + parseCurrency(val), 0);

        // Total Extras
        const totalExtras = api
          .column(3, { page: 'current' }) // column index for extras
          .data()
          .reduce((sum, val) => sum + parseCurrency(val), 0);

        // Total Income
        const totalIncome = api
          .column(4, { page: 'current' })
          .data()
          .reduce((sum, val) => sum + parseCurrency(val), 0);
  
        // Update footer totals using ID selectors to match footer columns
        $('#totalRoomRev').html(`£${totalRoomRev.toFixed(2)}`);
        $('#totalExtras').html(`£${totalExtras.toFixed(2)}`);
        $('#totalIncome').html(`£${totalIncome.toFixed(2)}`);
      }
    });
  
    // Dynamic report section to allow the selection of a different report
    const sections = {
      occupancy: document.getElementById('occupancyReport'),
      income: document.getElementById('incomeReport'),
    };
    // Drop-down change listener
    document.getElementById('reportSelect').addEventListener('change', (e) => {
      const selected = e.target.value;
      // Hides all report sections before showing the selected one
      Object.values(sections).forEach(el => el.style.display = 'none');
      // Show Selected Section
      if (sections[selected]) {
        sections[selected].style.display = 'block';
      }
    });
  
    // fetch and display the income report data
    // Button click listener and get user selection
    document.getElementById('fetchReport').addEventListener('click', async () => {
      const selected = document.getElementById('reportSelect').value;
      const week = document.getElementById('weekPicker').value;

      // Ensures that a report and week are selected 
      if (!selected || !week) {
        alert('Please select a report and a week.');
        return;
      }
      // Converts the selected week into start and end dates using formatWeekDates function
      const { start, end } = formatWeekDates(week);
      // Displays the week dates in a more readable format
      const rangeText = `Week range: ${start.split('-').reverse().join('/')} to ${end.split('-').reverse().join('/')}`;
      document.getElementById('reportWeekRange').innerText = rangeText;
  
      // Obtain income data from the backend API in server.js
      if (selected === 'income') {
        try {
          const res = await fetch(`/crown-hotel/api/reports/income?start=${start}&end=${end}`);
          const data = await res.json();
          console.log('Income Data:', data);
          
          // Clear the table and format each row of data from the API
          incomeTable.clear();
          data.forEach(row => {
            const date = new Date(row.date);
            const formattedDate = `${date.getDate().toString().padStart(2, '0')}/${
              (date.getMonth() + 1).toString().padStart(2, '0')}/${date.getFullYear()}`;
            // Insert each row from the API
            incomeTable.row.add([
              formattedDate,
              row.b_ref,
              `£${parseFloat(row.room_revenue).toFixed(2)}`,
              `£${parseFloat(row.extras).toFixed(2)}`, // extras now added
              `£${parseFloat(row.total_income).toFixed(2)}`
            ]);
          });
          // Create the table
          incomeTable.draw();
          // Error handling
        } catch (err) {
          console.error('Error fetching income:', err);
        }
      }
  
    // Obtain occupancy data from the backend API in server.js
    if (selected === 'occupancy') {
        try {
          const res = await fetch(`/crown-hotel/api/reports/occupancy?start=${start}&end=${end}`);
          const data = await res.json();
          // console.log('Occupancy Data:', data);
      
          // Clear the table and insert each row of data from the API
          occupancyTable.clear();
          data.forEach(row => {
            occupancyTable.row.add([
              row.r_no,
              row.r_class,
              row.days_occupied,
              row.total_available,
              `${row.occupancy_percentage}%`
            ]);
          });
          // Create the table
          occupancyTable.draw();
          // Error handling
        } catch (err) {
          console.error('Error fetching occupancy:', err);
        }
      }
    });
  });
  
  