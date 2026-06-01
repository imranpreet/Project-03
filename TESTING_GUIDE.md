# Fitness Challenge Tracker - Complete Testing Guide

## Server Info
- **Base URL**: http://localhost:5000
- **Server Status**: Running with nodemon (port 5000)
- **Database**: MongoDB at mongodb://localhost:27017/fitness-challenge
- **Authentication**: JWT (Bearer token in Authorization header)

---

## Testing Steps (In Order)

### STEP 1: Register a New User

**Endpoint**: POST /api/auth/register

**URL**: http://localhost:5000/api/auth/register

**Method**: POST

**Headers**:
```
Content-Type: application/json
```

**Request Body**:
```json
{
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "password": "password123"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "password": "password123"
  }'
```

**Expected Response** (Status: 201 Created):
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

**💾 Save the token from the response - you'll need it for protected endpoints.**

**Also save the user id (from user.id) - you'll need it later.**

---

### STEP 2: Login with the User (Get JWT Token)

**Endpoint**: POST /api/auth/login

**URL**: http://localhost:5000/api/auth/login

**Method**: POST

**Headers**:
```
Content-Type: application/json
```

**Request Body**:
```json
{
  "email": "alice@example.com",
  "password": "password123"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "alice@example.com",
    "password": "password123"
  }'
```

**Expected Response** (Status: 200 OK):
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

**📌 Important**: From now on, use this token in the Authorization header for all protected endpoints.

**Example header format**:
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

### STEP 3: Get Current User Info (Protected Route)

**Endpoint**: GET /api/users/me

**URL**: http://localhost:5000/api/users/me

**Method**: GET

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**curl Command**:
```bash
curl -X GET http://localhost:5000/api/users/me \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Expected Response** (Status: 200 OK):
```json
{
  "id": "6653a1f5e8c2d4001f5a1b2c",
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "createdAt": "2026-05-08T10:30:00.000Z"
}
```

---

### STEP 4: Create a Challenge (Protected Route)

**Endpoint**: POST /api/challenges

**URL**: http://localhost:5000/api/challenges

**Method**: POST

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body**:
```json
{
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days",
  "startDate": "2026-05-10",
  "endDate": "2026-06-09"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/challenges \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "30 Day Run Streak",
    "description": "Run at least 3km every day for 30 days",
    "startDate": "2026-05-10",
    "endDate": "2026-06-09"
  }'
```

**Expected Response** (Status: 201 Created):
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-08T10:35:00.000Z"
}
```

**💾 Save the challenge _id - you'll need it for the next steps.**

---

### STEP 5: Create Another Challenge (for joining test)

**Endpoint**: POST /api/challenges

**URL**: http://localhost:5000/api/challenges

**Method**: POST

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body**:
```json
{
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months",
  "startDate": "2026-05-01",
  "endDate": "2026-08-01"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/challenges \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Gym Challenge - 50 Workouts",
    "description": "Complete 50 gym workouts in 3 months",
    "startDate": "2026-05-01",
    "endDate": "2026-08-01"
  }'
```

**Expected Response** (Status: 201 Created): Similar to Step 4

**💾 Save this challenge _id as well (CHALLENGE_ID_2).**

---

### STEP 6: List All Challenges (Public Route)

**Endpoint**: GET /api/challenges

**URL**: http://localhost:5000/api/challenges

**Method**: GET

**Headers**:
```
Content-Type: application/json
```

**Query Parameters** (Optional):
- `createdBy=<userId>` - filter by creator
- `sort=asc` - sort by startDate ascending
- `sort=desc` - sort by startDate descending

**curl Command** (List all):
```bash
curl http://localhost:5000/api/challenges
```

**curl Command** (With filters):
```bash
curl "http://localhost:5000/api/challenges?sort=asc"
```

**curl Command** (Filter by creator):
```bash
curl "http://localhost:5000/api/challenges?createdBy=6653a1f5e8c2d4001f5a1b2c"
```

**Expected Response** (Status: 200 OK):
```json
[
  {
    "_id": "6653b2c5e8c2d4001f5a1b3d",
    "title": "30 Day Run Streak",
    "description": "Run at least 3km every day for 30 days",
    "startDate": "2026-05-10T00:00:00.000Z",
    "endDate": "2026-06-09T00:00:00.000Z",
    "createdBy": {
      "_id": "6653a1f5e8c2d4001f5a1b2c",
      "name": "Alice Johnson",
      "email": "alice@example.com"
    },
    "participants": [],
    "createdAt": "2026-05-08T10:35:00.000Z"
  },
  {
    "_id": "6653b3d6e8c2d4001f5a1b4e",
    "title": "Gym Challenge - 50 Workouts",
    "description": "Complete 50 gym workouts in 3 months",
    "startDate": "2026-05-01T00:00:00.000Z",
    "endDate": "2026-08-01T00:00:00.000Z",
    "createdBy": {
      "_id": "6653a1f5e8c2d4001f5a1b2c",
      "name": "Alice Johnson",
      "email": "alice@example.com"
    },
    "participants": [],
    "createdAt": "2026-05-08T10:36:00.000Z"
  }
]
```

---

### STEP 7: Get Specific Challenge (Public Route)

**Endpoint**: GET /api/challenges/:id

**URL**: http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method**: GET

**Headers**:
```
Content-Type: application/json
```

**curl Command**:
```bash
curl http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d
```

**Expected Response** (Status: 200 OK):
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": {
    "_id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  },
  "participants": [],
  "createdAt": "2026-05-08T10:35:00.000Z"
}
```

---

### STEP 8: Join a Challenge (Protected Route)

**Endpoint**: POST /api/challenges/:id/join

**URL**: http://localhost:5000/api/challenges/6653b3d6e8c2d4001f5a1b4e/join

**Method**: POST

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body**: (empty)
```json
{}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/challenges/6653b3d6e8c2d4001f5a1b4e/join \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json"
```

**Expected Response** (Status: 200 OK):
```json
{
  "_id": "6653b3d6e8c2d4001f5a1b4e",
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months",
  "startDate": "2026-05-01T00:00:00.000Z",
  "endDate": "2026-08-01T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [
    "6653a1f5e8c2d4001f5a1b2c"
  ],
  "createdAt": "2026-05-08T10:36:00.000Z"
}
```

**Note**: Your user ID is now in the `participants` array.

---

### STEP 9: Add Progress Entry (Protected Route)

**Endpoint**: POST /api/progress

**URL**: http://localhost:5000/api/progress

**Method**: POST

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body**:
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-08",
  "note": "Completed 20 pushups and 10 pullups"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/progress \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "challenge": "6653b3d6e8c2d4001f5a1b4e",
    "date": "2026-05-08",
    "note": "Completed 20 pushups and 10 pullups"
  }'
```

**Expected Response** (Status: 201 Created):
```json
{
  "_id": "6653b4e7e8c2d4001f5a1b5f",
  "user": "6653a1f5e8c2d4001f5a1b2c",
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-08T00:00:00.000Z",
  "note": "Completed 20 pushups and 10 pullups",
  "createdAt": "2026-05-08T10:40:00.000Z"
}
```

---

### STEP 10: Add More Progress Entries

**Endpoint**: POST /api/progress

**URL**: http://localhost:5000/api/progress

**Method**: POST

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body**:
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-09",
  "note": "Did cardio for 30 minutes"
}
```

**curl Command**:
```bash
curl -X POST http://localhost:5000/api/progress \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "challenge": "6653b3d6e8c2d4001f5a1b4e",
    "date": "2026-05-09",
    "note": "Did cardio for 30 minutes"
  }'
```

**Expected Response** (Status: 201 Created): Similar to Step 9

---

### STEP 11: Get Your Progress (Protected Route)

**Endpoint**: GET /api/progress/user/:userId

**URL**: http://localhost:5000/api/progress/user/6653a1f5e8c2d4001f5a1b2c

**Method**: GET

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**curl Command**:
```bash
curl -X GET http://localhost:5000/api/progress/user/6653a1f5e8c2d4001f5a1b2c \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Expected Response** (Status: 200 OK):
```json
[
  {
    "_id": "6653b4e7e8c2d4001f5a1b5f",
    "user": "6653a1f5e8c2d4001f5a1b2c",
    "challenge": {
      "_id": "6653b3d6e8c2d4001f5a1b4e",
      "title": "Gym Challenge - 50 Workouts",
      "startDate": "2026-05-01T00:00:00.000Z",
      "endDate": "2026-08-01T00:00:00.000Z"
    },
    "date": "2026-05-08T00:00:00.000Z",
    "note": "Completed 20 pushups and 10 pullups",
    "createdAt": "2026-05-08T10:40:00.000Z"
  },
  {
    "_id": "6653b5f8e8c2d4001f5a1b60",
    "user": "6653a1f5e8c2d4001f5a1b2c",
    "challenge": {
      "_id": "6653b3d6e8c2d4001f5a1b4e",
      "title": "Gym Challenge - 50 Workouts",
      "startDate": "2026-05-01T00:00:00.000Z",
      "endDate": "2026-08-01T00:00:00.000Z"
    },
    "date": "2026-05-09T00:00:00.000Z",
    "note": "Did cardio for 30 minutes",
    "createdAt": "2026-05-08T10:41:00.000Z"
  }
]
```

---

### STEP 12: Update a Challenge (Protected Route - Only Creator)

**Endpoint**: PUT /api/challenges/:id

**URL**: http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method**: PUT

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**Request Body** (Update any fields):
```json
{
  "title": "Updated: 30 Day Run Streak (Advanced)",
  "description": "Run at least 5km every day for 30 days"
}
```

**curl Command**:
```bash
curl -X PUT http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated: 30 Day Run Streak (Advanced)",
    "description": "Run at least 5km every day for 30 days"
  }'
```

**Expected Response** (Status: 200 OK):
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "Updated: 30 Day Run Streak (Advanced)",
  "description": "Run at least 5km every day for 30 days",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-08T10:35:00.000Z"
}
```

---

### STEP 13: Delete a Challenge (Protected Route - Only Creator)

**Endpoint**: DELETE /api/challenges/:id

**URL**: http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method**: DELETE

**Headers**:
```
Authorization: Bearer <YOUR_TOKEN_HERE>
Content-Type: application/json
```

**curl Command**:
```bash
curl -X DELETE http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Expected Response** (Status: 200 OK):
```json
{
  "message": "Challenge removed"
}
```

---

## Error Cases & Expected Responses

### Invalid Token
**Request**:
```bash
curl -H "Authorization: Bearer invalid_token" http://localhost:5000/api/users/me
```

**Expected Response** (Status: 401 Unauthorized):
```json
{
  "message": "Token is not valid"
}
```

### Missing Token on Protected Route
**Request**:
```bash
curl http://localhost:5000/api/users/me
```

**Expected Response** (Status: 401 Unauthorized):
```json
{
  "message": "No token, authorization denied"
}
```

### Invalid Email Format on Register
**Request**:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Bob","email":"invalid-email","password":"pass123"}'
```

**Expected Response** (Status: 400 Bad Request):
```json
{
  "errors": [
    {
      "msg": "Please include a valid email",
      "param": "email"
    }
  ]
}
```

### Password Too Short on Register
**Request**:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Bob","email":"bob@example.com","password":"123"}'
```

**Expected Response** (Status: 400 Bad Request):
```json
{
  "errors": [
    {
      "msg": "Password must be 6 or more characters",
      "param": "password"
    }
  ]
}
```

### Challenge Not Found
**Request**:
```bash
curl http://localhost:5000/api/challenges/invalid_id_12345
```

**Expected Response** (Status: 404 Not Found):
```json
{
  "message": "Challenge not found"
}
```

---

## Quick Testing Checklist

✅ **Authentication Flow**
- [ ] Step 1: Register a user
- [ ] Step 2: Login and get token
- [ ] Step 3: Get current user info

✅ **Challenge Management (CRUD)**
- [ ] Step 4: Create first challenge
- [ ] Step 5: Create second challenge
- [ ] Step 6: List all challenges
- [ ] Step 7: Get specific challenge
- [ ] Step 12: Update a challenge
- [ ] Step 13: Delete a challenge

✅ **Challenge Participation**
- [ ] Step 8: Join a challenge (participants array updates)

✅ **Progress Tracking**
- [ ] Step 9: Add first progress entry
- [ ] Step 10: Add second progress entry
- [ ] Step 11: Get all progress entries for user

✅ **Error Handling**
- [ ] Try invalid token
- [ ] Try missing token on protected route
- [ ] Try invalid email format
- [ ] Try password too short
- [ ] Try non-existent challenge ID

---

## Using Postman (Alternative to curl)

1. Download and install Postman from https://www.postman.com/downloads/
2. Create a new collection named "Fitness Tracker"
3. For each step above, create a new request:
   - Set method (GET, POST, PUT, DELETE)
   - Set URL
   - Add headers (Content-Type, Authorization)
   - Add body (for POST/PUT)
4. Use Postman environment variables to store:
   - `token` (save from login response)
   - `userId` (save from login response)
   - `challengeId1` (save from create challenge response)
   - `challengeId2` (save from second create challenge response)
5. Reference variables in URLs/headers using `{{variable_name}}`

---

## Verifying Data in MongoDB

**Using mongosh**:
```bash
mongosh mongodb://localhost:27017/fitness-challenge
use fitness-challenge
db.users.find().pretty()
db.challenges.find().pretty()
db.progresses.find().pretty()
```

**Using MongoDB Compass**:
1. Open MongoDB Compass
2. Connect to: `mongodb://localhost:27017`
3. Navigate to database: `fitness-challenge`
4. View collections: `users`, `challenges`, `progresses`

---

## Summary

- **13 Main API Endpoints** tested in order
- **3 Authentication endpoints** (register, login, get me)
- **6 Challenge endpoints** (create, list, get, join, update, delete)
- **2 Progress endpoints** (add, get user progress)
- **Multiple error scenarios** covered
- All data is **persisted to MongoDB**
- **JWT Authentication** required for protected routes

Test each step sequentially and save IDs from responses to use in subsequent requests!
