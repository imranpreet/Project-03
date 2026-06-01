const Progress = require('../models/Progress');
const Challenge = require('../models/Challenge');

exports.addProgress = async (req, res, next) => {
  try {
    const { challenge, date, note } = req.body;
    const exists = await Challenge.findById(challenge);
    if (!exists) return res.status(404).json({ message: 'Challenge not found' });
    const progress = new Progress({ user: req.user._id, challenge, date, note });
    await progress.save();
    res.status(201).json(progress);
  } catch (err) {
    next(err);
  }
};

exports.getUserProgress = async (req, res, next) => {
  try {
    const { userId } = req.params;
    // allow users to view their own progress or an admin (no admin implemented; only self)
    if (req.user._id.toString() !== userId.toString()) return res.status(403).json({ message: 'Not authorized to view this user progress' });
    const entries = await Progress.find({ user: userId }).populate('challenge', 'title startDate endDate');
    res.json(entries);
  } catch (err) {
    next(err);
  }
};
