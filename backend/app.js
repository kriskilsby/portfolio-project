const express = require('express');
const path = require('path');
require('dotenv').config({ path: __dirname + '/.env' });

const app = express();

// ----------------------------
// Routers and apps
// ----------------------------

// Portfolio routers
const indexRouter = require('./routes/index');

// Stork app routers
const storkCluster = require('../stork-app/frontend/routes/cluster');
const storkMetadata = require('../stork-app/frontend/routes/metadata');

// Crown Hotel app (Node/Express project)
const crownHotelApp = require('../crown-hotel-app/server');

// Competency Phase 1 router (we will mount it cleanly)
// const competencyPhase1Router = require('./routes/competencyPhase1');


// ----------------------------
// View engine setup
// ----------------------------

// Portfolio views
const portfolioViews = path.join(__dirname, 'views');

// Stork app paths
const storkAppPath = path.join(__dirname, '../stork-app/frontend');
const storkViews = path.join(storkAppPath, 'views');
const storkPublic = path.join(storkAppPath, 'public');



// const competencyPhase1Views = path.join(__dirname, '../competency-phase1/views');


// Set main views (Portfolio + Stork)
// This allows includes like <%- include('components/navbar') %> to work in either app
app.set('views', [portfolioViews, storkViews]);
app.set('view engine', 'ejs');


// ----------------------------
// Static files setup
// ----------------------------

// Static files for Portfolio
app.use(express.static(path.join(__dirname, 'public')));

// Stork app static files (served under /stork-app)

// Serve static assets for Stork app under /stork-app
app.use('/stork-app', express.static(storkPublic));

// Competency Phase 1 static
app.use('/competency-phase1', express.static(path.join(__dirname, '../competency-phase1/public')));


// ----------------------------
// Mount Crown Hotel app
// ----------------------------
app.use('/crown-hotel', crownHotelApp);   // All Crown Hotel routes are now under /crown-hotel

// app.use('/', crownHotelApp);   // Mount Crown Hotel at root



// ----------------------------
// Stork App Setup
// ----------------------------

// Mount Stork API routes under /stork-app/api
app.use('/stork-app/api/cluster', storkCluster);
app.use('/stork-app/api/metadata', storkMetadata);
app.get('/stork-app', (req, res) => {
  res.render(path.join(storkViews, 'index.ejs'), { page: 'stork-app' });
});

// Portfolio Routes
app.use('/', indexRouter);


// ---------------------------- 
// Competency Phase 1 App Setup
// ----------------------------

// Competency Phase 1 app
// app.use('/competency-phase1', competencyPhase1Router);

app.get('/competency-phase1', (req, res) => {
  res.render(path.join(__dirname, '../competency-phase1/views/index.ejs'), {
    title: 'Competency App – Phase 1',
    page: 'competency-phase1'
  });
});






// ----------------------------
// Server start
// ----------------------------

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Homepage running at http://localhost:${PORT}`);
  console.log(`Crown Hotel available at http://localhost:${PORT}/crown-hotel`);
  console.log(`Stork App available at http://localhost:${PORT}/stork-app`);
  console.log(`Competency Phase 1 available at http://localhost:${PORT}/competency-phase1`);
});


