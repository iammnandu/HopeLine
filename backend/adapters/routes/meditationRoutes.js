const express = require('express');
const MeditationController = require('../controller/MeditationController');

const router = express.Router()

router.get('/dailyQuote', MeditationController.dailyQuote);
router.get('/myMood/:mood', MeditationController.myMood);

module.exports = router;
