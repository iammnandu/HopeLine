const express = require('express');
const SongController = require('../controller/SongController');

const router = express.Router();

router.get('/all', SongController.all);
router.post('/initialize', SongController.initialize);
router.post('/add', SongController.add);

module.exports = router;