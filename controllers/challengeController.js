const Challenge = require('../models/Challenge');
const User = require('../models/User');

exports.listChallenges = async (req, res, next) => {
  try {
    const filter = {};
    if (req.query.createdBy) filter.createdBy = req.query.createdBy;
    let query = Challenge.find(filter).populate('createdBy', 'name email').populate('participants', 'name email');
    if (req.query.sort === 'asc') query = query.sort({ startDate: 1 });
    if (req.query.sort === 'desc') query = query.sort({ startDate: -1 });
    const challenges = await query.exec();
    res.json(challenges);
  } catch (err) {
    next(err);
  }
};

exports.createChallenge = async (req, res, next) => {
  try {
    const { title, description, startDate, endDate } = req.body;
    const challenge = new Challenge({ title, description, startDate, endDate, createdBy: req.user._id });
    await challenge.save();
    res.status(201).json(challenge);
  } catch (err) {
    next(err);
  }
};

exports.getChallenge = async (req, res, next) => {
  try {
    const challenge = await Challenge.findById(req.params.id).populate('createdBy', 'name email').populate('participants', 'name email');
    if (!challenge) return res.status(404).json({ message: 'Challenge not found' });
    res.json(challenge);
  } catch (err) {
    next(err);
  }
};

exports.updateChallenge = async (req, res, next) => {
  try {
    const challenge = await Challenge.findById(req.params.id);
    if (!challenge) return res.status(404).json({ message: 'Challenge not found' });
    if (challenge.createdBy.toString() !== req.user._id.toString()) return res.status(403).json({ message: 'Not authorized' });
    const updates = req.body;
    Object.assign(challenge, updates);
    await challenge.save();
    res.json(challenge);
  } catch (err) {
    next(err);
  }
};

exports.deleteChallenge = async (req, res, next) => {
  try {
    const challenge = await Challenge.findById(req.params.id);
    if (!challenge) return res.status(404).json({ message: 'Challenge not found' });
    if (challenge.createdBy.toString() !== req.user._id.toString()) return res.status(403).json({ message: 'Not authorized' });
    await challenge.remove();
    res.json({ message: 'Challenge removed' });
  } catch (err) {
    next(err);
  }
};

exports.joinChallenge = async (req, res, next) => {
  try {
    const challenge = await Challenge.findById(req.params.id);
    if (!challenge) return res.status(404).json({ message: 'Challenge not found' });
    const userId = req.user._id;
    if (challenge.participants.includes(userId)) return res.status(400).json({ message: 'Already joined' });
    challenge.participants.push(userId);
    await challenge.save();
    res.json(challenge);
  } catch (err) {
    next(err);
  }
};
