// competency-phase1/public/js/competency-phase1.js

$(document).ready(function () {
    // Initialise the DataTable
    var table = $('#competencyTable').DataTable({
        ajax: {
            // url: 'https://competencyapp-api.azurewebsites.net/employees', // Older Azure API endpoint
            // url: 'http://46.101.40.132:3001/employees', // New Digital Ocean API endpoint
            url: '/api/employees',  // proxy will forward to DO API
            dataSrc: '', // JSON array returned by API
        },
        columns: [
            { data: 'firstName', responsivePriority: 1 },
            { data: 'lastName', responsivePriority: 2 },
            { data: 'job', responsivePriority: 1001 },           // hide first
            { data: 'legalEntity', responsivePriority: 1002 },
            { data: 'discipline', responsivePriority: 1003 },
            { data: 'projectsCount', responsivePriority: 1004 },
            { data: 'qualificationsCount', responsivePriority: 1005 },
            { data: 'cpdCount', responsivePriority: 1006 },
        ],
        responsive: true,
        paging: true,
        searching: true,
        order: [[0, 'asc']], // sort by first name initially
    });

    // Style the search input after table initialization
    $('#competencyTable_filter input').css({
        'background-color': '#fdfdfd',
        'border': '1px solid #ccc',
        'border-radius': '6px',
        'padding': '4px 8px',
        'font-size': '14px',
        'color': '#3A2F51'
    });

    // Activate all tooltips on the page
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

