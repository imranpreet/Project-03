exports.getMe = async (req, res, next) => {
  try {
    // auth middleware attaches req.user
    const user = req.user;
    res.json({ id: user._id, name: user.name, email: user.email, createdAt: user.createdAt });
  } catch (err) {
    next(err);
  }
};
