# Quick Testing URLs Reference

## Server Status
✅ Running on http://localhost:5000
✅ Connected to MongoDB: mongodb://localhost:27017/fitness-challenge

---

## All Testing URLs (Copy & Paste Ready)

### Base URL
```
http://localhost:5000
```

---

## API Endpoints Summary Table

| # | Method | Endpoint | Protected | Description |
|---|--------|----------|-----------|-------------|
| 1 | POST | `/api/auth/register` | ❌ | Register new user |
| 2 | POST | `/api/auth/login` | ❌ | Login (returns JWT token) |
| 3 | GET | `/api/users/me` | ✅ | Get current user info |
| 4 | POST | `/api/challenges` | ✅ | Create challenge |
| 5 | GET | `/api/challenges` | ❌ | List all challenges |
| 6 | GET | `/api/challenges/:id` | ❌ | Get specific challenge |
| 7 | POST | `/api/challenges/:id/join` | ✅ | Join a challenge |
| 8 | PUT | `/api/challenges/:id` | ✅ | Update challenge (creator only) |
| 9 | DELETE | `/api/challenges/:id` | ✅ | Delete challenge (creator only) |
| 10 | POST | `/api/progress` | ✅ | Add progress entry |
| 11 | GET | `/api/progress/user/:userId` | ✅ | Get user progress |

---

## Quick Testing Methods

### Option 1: Using Postman (Recommended for UI)
1. Download Postman: https://www.postman.com/downloads/
2. Go to File → Import
3. Choose file: **Fitness-Tracker-Postman-Collection.json** (in your project folder)
4. Click Import
5. Set environment variable `baseUrl` to `http://localhost:5000`
6. Run requests in order (steps 1-13)

**Benefits**: Auto-saves token, easy to see responses, reusable collection

---

### Option 2: Using curl in Terminal (Direct)

**Step 1: Register**
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com","password":"password123"}'
```

**Step 2: Login** (saves token)
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"alice@example.com","password":"password123"}'
```

**Step 3: Get User** (use token from step 2)
```bash
curl -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  http://localhost:5000/api/users/me
```

**Step 4: Create Challenge** (use token from step 2)
```bash
curl -X POST http://localhost:5000/api/challenges \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{"title":"30 Day Run","description":"Run daily","startDate":"2026-05-10","endDate":"2026-06-09"}'
```

**Step 5: List Challenges**
```bash
curl http://localhost:5000/api/challenges
```

---

### Option 3: Using Automated Script (All Tests at Once)

```bash
cd '/home/sama/Desktop/project 3'
bash test-api.sh
```

This script:
- Registers a user
- Logs in
- Gets user info
- Creates 2 challenges
- Lists challenges
- Joins a challenge
- Adds 2 progress entries
- Gets progress
- Updates a challenge
- Deletes a challenge
- Tests error cases

**Output**: Pretty JSON responses for all endpoints

---

## Environment Variables You Need (in .env)

```
PORT=5000
MONGO_URI=mongodb://localhost:27017/fitness-challenge
JWT_SECRET=supersecret_local_jwt_key_please_change
JWT_EXPIRES_IN=7d
```

✅ Already set in your `/home/sama/Desktop/project 3/.env`

---

## Files in This Project

| File | Purpose |
|------|---------|
| `server.js` | Main Express server entry point |
| `config/db.js` | MongoDB connection config |
| `models/User.js` | User schema (name, email, password) |
| `models/Challenge.js` | Challenge schema (title, participants, dates) |
| `models/Progress.js` | Progress schema (user, challenge, date, note) |
| `routes/auth.js` | Register & login routes |
| `routes/users.js` | User profile routes |
| `routes/challenges.js` | Challenge CRUD routes |
| `routes/progress.js` | Progress tracking routes |
| `controllers/authController.js` | Auth business logic |
| `controllers/challengeController.js` | Challenge business logic |
| `controllers/progressController.js` | Progress business logic |
| `middleware/auth.js` | JWT authentication middleware |
| `middleware/logger.js` | Request logging middleware |
| `middleware/errorHandler.js` | Error handling middleware |
| `.env` | Environment variables (local) |
| `package.json` | Dependencies & npm scripts |
| `TESTING_GUIDE.md` | Detailed step-by-step testing guide |
| `Fitness-Tracker-Postman-Collection.json` | Postman collection (ready to import) |
| `test-api.sh` | Automated bash script for all tests |

---

## Most Important Testing URLs (Bare Minimum)

1. **Register**: POST http://localhost:5000/api/auth/register
2. **Login**: POST http://localhost:5000/api/auth/login
3. **Get User**: GET http://localhost:5000/api/users/me
4. **Create Challenge**: POST http://localhost:5000/api/challenges
5. **List Challenges**: GET http://localhost:5000/api/challenges
6. **Get Challenge**: GET http://localhost:5000/api/challenges/:id
7. **Join Challenge**: POST http://localhost:5000/api/challenges/:id/join
8. **Add Progress**: POST http://localhost:5000/api/progress
9. **Get Progress**: GET http://localhost:5000/api/progress/user/:userId
10. **Update Challenge**: PUT http://localhost:5000/api/challenges/:id
11. **Delete Challenge**: DELETE http://localhost:5000/api/challenges/:id

---

## Verifying Data in MongoDB

**Using mongosh** (terminal):
```bash
mongosh mongodb://localhost:27017/fitness-challenge
use fitness-challenge
show collections
db.users.find().pretty()
db.challenges.find().pretty()
db.progresses.find().pretty()
```

**Using MongoDB Compass** (GUI):
1. Download: https://www.mongodb.com/products/compass
2. Connect to: mongodb://localhost:27017
3. View database: fitness-challenge
4. Browse collections: users, challenges, progresses

---

## Common Errors & Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| `EADDRINUSE: address already in use :::5000` | Port 5000 occupied | Kill process: `pkill -f 'node server.js'` |
| `No token, authorization denied` | Missing Authorization header | Add: `Authorization: Bearer <token>` |
| `Token is not valid` | Invalid or expired JWT | Get new token from login endpoint |
| `Challenge not found` | Wrong challenge ID | Use actual ID from create response |
| `Failed to connect to MongoDB` | MongoDB not running | Start: `mongod` or use Atlas URI |

---

## Next Steps

✅ **Testing Workflow**:
1. Choose method (Postman, curl, or script)
2. Start with registration (step 1)
3. Save token from login response
4. Use token for all protected endpoints
5. Save challenge IDs for subsequent requests
6. Verify data in MongoDB

✅ **For Viva/Presentation**:
- Use Postman to show working endpoints with token
- Show MongoDB Compass with stored data
- Explain JWT authentication flow
- Show error handling with invalid requests

---

## Commands to Run Everything

**Terminal 1: Start Server** (if not already running)
```bash
cd '/home/sama/Desktop/project 3'
npm run dev
```

**Terminal 2: Run All Tests**
```bash
cd '/home/sama/Desktop/project 3'
bash test-api.sh | less
```

Or use Postman directly on the collection!

---

## Support Files

- **Full Testing Guide**: `TESTING_GUIDE.md` (13 detailed steps with examples)
- **Postman Collection**: `Fitness-Tracker-Postman-Collection.json` (ready to import)
- **Automated Script**: `test-api.sh` (runs all tests at once)
- **Project README**: `README.md` (overview & architecture)

---

**Status**: All APIs working and data persists to MongoDB ✅
