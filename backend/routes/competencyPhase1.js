const express = require('express');
const path = require('path');
const router = express.Router();

// Point this router to its own views folder
router.set('views', path.join(__dirname, '../../competency-phase1/views'));
router.set('view engine', 'ejs');

// Main Phase 1 page
router.get('/', (req, res) => {
  res.render('index', {
    title: 'Competency App – Phase 1',
    page: 'competency-phase1'
  });
});

module.exports = router;
