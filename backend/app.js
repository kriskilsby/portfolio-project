const express = require('express');
const path = require('path');
require('dotenv').config({ path: __dirname + '/.env' });

const app = express();

const { createProxyMiddleware } = require('http-proxy-middleware');

// ----------------------------
// Local development API proxy
// ----------------------------
// In development, the frontend runs on port 3000 and the Nest backend runs on port 3001.
// To avoid CORS issues and keep the frontend code identical to production,
// we proxy all requests starting with /api to the backend on port 3001.
// In production, Nginx handles the routing, so this block is not used.
if (process.env.NODE_ENV !== 'production') {
  app.use(
    '/api',
    createProxyMiddleware({
      target: 'http://localhost:3001',
      changeOrigin: true,
    })
  );
}


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


// ----------------------------
// View engine setup
// ----------------------------

// Portfolio views
const portfolioViews = path.join(__dirname, 'views');

// Stork app paths
const storkAppPath = path.join(__dirname, '../stork-app/frontend');
const storkViews = path.join(storkAppPath, 'views');
const storkPublic = path.join(storkAppPath, 'public');


// Set main views (Portfolio + Stork)
app.set('views', [portfolioViews, storkViews]);
app.set('view engine', 'ejs');


// ----------------------------
// Static routes
// ----------------------------

// Static files for Portfolio
app.use(express.static(path.join(__dirname, 'public')));


// Serve static assets for Stork app under /stork-app
app.use('/stork-app', express.static(storkPublic));

// Competency Phase 1 static
app.use('/competency-phase1', express.static(path.join(__dirname, '../competency-phase1/public')));


// ----------------------------
// Mount Crown Hotel app
// ----------------------------
app.use('/crown-hotel', crownHotelApp);   // All Crown Hotel routes are now under /crown-hotel



// ----------------------------
// Stork App Setup
// ----------------------------

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


