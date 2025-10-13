
const express = require('express');
const router = express.Router();

// Home page
router.get('/', (req, res) => {
  res.render('index', { title: 'Kris Kilsby Portfolio', page: 'index' });
});

// Profile page
router.get('/profile', (req, res) => {
  res.render('profile', { page: 'profile', title: 'My Profile' });
});

module.exports = router;