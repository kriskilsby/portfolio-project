// competency-phase1/public/js/competency-phase1.js

$(document).ready(function () {
  $('#competencyTable').DataTable({
    ajax: {
      url: 'https://competencyapp-api.azurewebsites.net/employees',       // Use the Azure API even in local dev:
      dataSrc: '',             // JSON array returned by API
    },
    columns: [
      { data: 'firstName' },
      { data: 'lastName' },
      { data: 'job' },
      { data: 'legalEntity' },
      { data: 'discipline' },
      { data: 'projectsCount' },
      { data: 'qualificationsCount' },
      { data: 'cpdCount' },
    ],
    responsive: true,
    paging: true,
    searching: true,
    order: [[0, 'asc']],       // sort by first name initially
  });
});

