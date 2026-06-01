const express = require('express');
const { check, validationResult } = require('express-validator');
const router = express.Router();
const auth = require('../middleware/auth');
const challengeController = require('../controllers/challengeController');

// List with optional filtering: ?createdBy=userid & sort=asc|desc (by startDate)
router.get('/', challengeController.listChallenges);

router.post(
  '/',
  auth,
  [
    check('title', 'Title is required and min 3 chars').isLength({ min: 3 }),
    check('startDate', 'startDate is required').notEmpty(),
    check('endDate', 'endDate is required').notEmpty()
  ],
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });
    next();
  },
  challengeController.createChallenge
);

router.get('/:id', challengeController.getChallenge);
router.put('/:id', auth, challengeController.updateChallenge);
router.delete('/:id', auth, challengeController.deleteChallenge);

router.post('/:id/join', auth, challengeController.joinChallenge);

module.exports = router;
