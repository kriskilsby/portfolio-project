const express = require('express');
const path = require('path');

// Portfolio routers
const indexRouter = require('./routes/index');

// Stork app routers
const storkCluster = require('../stork-app/frontend/routes/cluster');
const storkMetadata = require('../stork-app/frontend/routes/metadata');

const app = express();


// ----------------------------
// View engine setup
// ----------------------------

// Paths
const portfolioViews = path.join(__dirname, 'views');
const storkAppPath = path.join(__dirname, '../stork-app/frontend');
const storkViews = path.join(storkAppPath, 'views');

// EJS setup for Portfolio
// app.set('views', path.join(__dirname, 'views'));

// Register *both* the portfolio and Stork view folders
// This allows includes like <%- include('components/navbar') %> to work in either app
app.set('views', [portfolioViews, storkViews]);

app.set('view engine', 'ejs');


// ----------------------------
// Static files setup
// ----------------------------

// Static files for Portfolio
app.use(express.static(path.join(__dirname, 'public')));

// Stork app static files (served under /stork-app)
const storkPublic = path.join(storkAppPath, 'public');
// Serve static assets for Stork app under /stork-app
app.use('/stork-app', express.static(storkPublic));


// ----------------------------
// Stork App Setup
// ----------------------------

// Mount Stork API routes under /stork-app/api
app.use('/stork-app/api/cluster', storkCluster);
app.use('/stork-app/api/metadata', storkMetadata);


// Route to render Stork index.ejs
// app.get('/stork-app', (req, res) => {
//   res.render(path.join(storkViews, 'index.ejs'));
// });
// app.get('/stork-app', (req, res) => {
//   res.render('index', { page: 'stork-app' });
// });
// Main Stork page
app.get('/stork-app', (req, res) => {
  res.render(path.join(storkViews, 'index.ejs'), { page: 'stork-app' });
});

// Portfolio Routes
app.use('/', indexRouter);





// ----------------------------
// Server start
// ----------------------------

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Homepage running at http://localhost:${PORT}`);
});


