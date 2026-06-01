const express = require('express');
const { check, validationResult } = require('express-validator');
const router = express.Router();
const auth = require('../middleware/auth');
const progressController = require('../controllers/progressController');

router.post(
  '/',
  auth,
  [
    check('challenge', 'challenge id is required').notEmpty(),
    check('date', 'date is required').notEmpty()
  ],
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });
    next();
  },
  progressController.addProgress
);

router.get('/user/:userId', auth, progressController.getUserProgress);

module.exports = router;
