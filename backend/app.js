const express = require('express');
const path = require('path');
const indexRouter = require('./routes/index');

const app = express();

// EJS setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Static files
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.use('/', indexRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Homepage running at http://localhost:${PORT}`);
});


