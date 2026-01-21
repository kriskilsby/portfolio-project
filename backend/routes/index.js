
const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');

// Home page
router.get('/', (req, res) => {
  res.render('index', { title: 'Kris Kilsby Portfolio', page: 'index' });
});

// Profile page
router.get('/profile', (req, res) => {
  res.render('profile', { page: 'profile', title: 'My Profile' });
});


// Crownhotel launch page
router.get('/launch-hotel', (req, res) => {
  res.render('launch-hotel', { page: 'launch-hotel', title: 'Launch Hotel App' });
});


// ------------------------
// Search route
// ------------------------

router.get('/search', (req, res) => {
  const query = req.query.q?.trim();
  
  if (!query) {
    return res.redirect('/');
  }

  // Load the search index JSON
  const searchIndexPath = path.join(__dirname, '../public/searchIndex.json');
  let searchIndex = [];
  try {
    const rawData = fs.readFileSync(searchIndexPath, 'utf-8');
    searchIndex = JSON.parse(rawData);
  } catch (err) {
    console.error('Error reading search index:', err);
  }

  // Filter results based on query (case-insensitive)
  const results = searchIndex.filter(item =>
    (item.title && item.title.toLowerCase().includes(query.toLowerCase())) ||
    (item.text && item.text.toLowerCase().includes(query.toLowerCase()))
  );
  
  res.render('search-results', { 
    query, 
    results, 
    title: `Search results for "${query}"`,
    page: 'search'  // ✅ add this line
  });
});

module.exports = router;