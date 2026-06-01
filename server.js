require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const connectDB = require('./config/db');
const errorHandler = require('./middleware/errorHandler');
const logger = require('./middleware/logger');

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/users');
const challengeRoutes = require('./routes/challenges');
const progressRoutes = require('./routes/progress');

const app = express();

// Middleware
app.use(express.json());
app.use(cors());
app.use(morgan('dev'));
app.use(logger);

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/challenges', challengeRoutes);
app.use('/api/progress', progressRoutes);

app.use(errorHandler);

const PORT = process.env.PORT || 5000;

// Connect to DB and start server. If DB connection fails, server still starts but logs a warning.
connectDB()
  .then(() => {
    app.listen(PORT, () => console.log(`Server started on port ${PORT} and connected to DB`));
  })
  .catch((err) => {
    console.error('DB connection failed, starting server without DB:', err.message);
    app.listen(PORT, () => console.log(`Server started on port ${PORT} (DB not connected)`));
  });

module.exports = app; // for testing
