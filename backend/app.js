const express = require('express');
const path = require('path');

// Portfolio routers
const indexRouter = require('./routes/index');

// Stork app routers
const storkCluster = require('../stork-app/frontend/routes/cluster');
const storkMetadata = require('../stork-app/frontend/routes/metadata');

const app = express();

// EJS setup for Portfolio
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Static files for Portfolio
app.use(express.static(path.join(__dirname, 'public')));

// Portfolio Routes
app.use('/', indexRouter);

// ----------------------------
// Stork App Setup
// ----------------------------
const storkAppPath = path.join(__dirname, '../stork-app/frontend');
const storkViews = path.join(storkAppPath, 'views');
const storkPublic = path.join(storkAppPath, 'public');

// Serve static assets for Stork app under /stork-app
app.use('/stork-app', express.static(storkPublic));

// Mount Stork API routes under /stork-app/api
app.use('/stork-app/api/cluster', storkCluster);
app.use('/stork-app/api/metadata', storkMetadata);

// Route to render Stork index.ejs
app.get('/stork-app', (req, res) => {
  res.render(path.join(storkViews, 'index.ejs'));
});

// ----------------------------

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Homepage running at http://localhost:${PORT}`);
});


