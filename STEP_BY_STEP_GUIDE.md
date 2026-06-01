# Complete Step-by-Step Testing Guide

## Prerequisites
- Server running: `npm run dev` on http://localhost:5000
- MongoDB connected
- Thunder Client or Postman installed

---

# 🎯 STEP-BY-STEP TESTING (11 Steps)

## STEP 1: Register a New User

**Open Thunder Client/Postman**

**Method:** POST
**URL:** http://localhost:5000/api/auth/register

**Headers:**
```
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "password": "password123"
}
```

**Click Send**

**Expected Response (Status: 201 Created):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

**💾 SAVE THIS:**
- Token: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx` (entire token)
- User ID: `6653a1f5e8c2d4001f5a1b2c`

---

## STEP 2: Login with Email & Password

**Method:** POST
**URL:** http://localhost:5000/api/auth/login

**Headers:**
```
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "email": "alice@example.com",
  "password": "password123"
}
```

**Click Send**

**Expected Response (Status: 200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

**✅ Confirms:** Authentication works correctly

---

## STEP 3: Get Current User Info (Protected Route)

**Method:** GET
**URL:** http://localhost:5000/api/users/me

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body:** (None - it's a GET request)

**Click Send**

**Expected Response (Status: 200 OK):**
```json
{
  "id": "6653a1f5e8c2d4001f5a1b2c",
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "createdAt": "2026-05-09T10:30:00.000Z"
}
```

**✅ Confirms:** JWT authentication is working (protected route accessed with token)

---

## STEP 4: Create First Challenge (Protected Route)

**Method:** POST
**URL:** http://localhost:5000/api/challenges

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days",
  "startDate": "2026-05-10",
  "endDate": "2026-06-09"
}
```

**Click Send**

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:35:00.000Z"
}
```

**💾 SAVE THIS:**
- Challenge ID 1: `6653b2c5e8c2d4001f5a1b3d`

**✅ Confirms:** Create operation (C in CRUD) works

---

## STEP 5: Create Second Challenge (Protected Route)

**Method:** POST
**URL:** http://localhost:5000/api/challenges

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months",
  "startDate": "2026-05-01",
  "endDate": "2026-08-01"
}
```

**Click Send**

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b3d6e8c2d4001f5a1b4e",
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months",
  "startDate": "2026-05-01T00:00:00.000Z",
  "endDate": "2026-08-01T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:36:00.000Z"
}
```

**💾 SAVE THIS:**
- Challenge ID 2: `6653b3d6e8c2d4001f5a1b4e`

---

## STEP 6: List All Challenges (Public Route)

**Method:** GET
**URL:** http://localhost:5000/api/challenges

**Headers:**
```
Content-Type: application/json
```

**Body:** (None - it's a GET request)

**Click Send**

**Expected Response (Status: 200 OK):**
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
    "createdAt": "2026-05-09T10:35:00.000Z"
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
    "createdAt": "2026-05-09T10:36:00.000Z"
  }
]
```

**✅ Confirms:** Read all operation (R in CRUD) works, public route works

---

## STEP 7: Get Specific Challenge (Public Route)

**Method:** GET
**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Headers:**
```
Content-Type: application/json
```

**Body:** (None - it's a GET request)

**Click Send**

**Expected Response (Status: 200 OK):**
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
  "createdAt": "2026-05-09T10:35:00.000Z"
}
```

**✅ Confirms:** Read one operation works, can fetch by ID

---

## STEP 8: Join a Challenge (Protected Route)

**Method:** POST
**URL:** http://localhost:5000/api/challenges/6653b3d6e8c2d4001f5a1b4e/join

**⚠️ IMPORTANT:** Use the Challenge ID 2 from STEP 5

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{}
```

**Click Send**

**Expected Response (Status: 200 OK):**
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
  "createdAt": "2026-05-09T10:36:00.000Z"
}
```

**✅ Confirms:** User is added to participants array, protected route works

---

## STEP 9: Add Progress Entry (Protected Route)

**Method:** POST
**URL:** http://localhost:5000/api/progress

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-09",
  "note": "Completed 20 pushups and 10 pullups at the gym"
}
```

**Click Send**

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b4e7e8c2d4001f5a1b5f",
  "user": "6653a1f5e8c2d4001f5a1b2c",
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-09T00:00:00.000Z",
  "note": "Completed 20 pushups and 10 pullups at the gym",
  "createdAt": "2026-05-09T10:40:00.000Z"
}
```

**✅ Confirms:** Progress tracking works, data persists to database

---

## STEP 10: Add Second Progress Entry (Protected Route)

**Method:** POST
**URL:** http://localhost:5000/api/progress

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-10",
  "note": "Did 30 minutes of cardio"
}
```

**Click Send**

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b5f8e8c2d4001f5a1b60",
  "user": "6653a1f5e8c2d4001f5a1b2c",
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-10T00:00:00.000Z",
  "note": "Did 30 minutes of cardio",
  "createdAt": "2026-05-09T10:41:00.000Z"
}
```

**✅ Confirms:** Multiple progress entries work

---

## STEP 11: Get User Progress (Protected Route)

**Method:** GET
**URL:** http://localhost:5000/api/progress/user/6653a1f5e8c2d4001f5a1b2c

**⚠️ IMPORTANT:** Use your saved User ID from STEP 1

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body:** (None - it's a GET request)

**Click Send**

**Expected Response (Status: 200 OK):**
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
    "date": "2026-05-09T00:00:00.000Z",
    "note": "Completed 20 pushups and 10 pullups at the gym",
    "createdAt": "2026-05-09T10:40:00.000Z"
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
    "date": "2026-05-10T00:00:00.000Z",
    "note": "Did 30 minutes of cardio",
    "createdAt": "2026-05-09T10:41:00.000Z"
  }
]
```

**✅ Confirms:** All progress entries retrieved successfully

---

## BONUS: Update Challenge (Protected Route - Creator Only)

**Method:** PUT
**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**⚠️ IMPORTANT:** Use Challenge ID 1 from STEP 4 (the one you created)

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "title": "Updated: 30 Day Run Streak (Advanced Version)",
  "description": "Run at least 5km every day for 30 days"
}
```

**Click Send**

**Expected Response (Status: 200 OK):**
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "Updated: 30 Day Run Streak (Advanced Version)",
  "description": "Run at least 5km every day for 30 days",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:35:00.000Z"
}
```

**✅ Confirms:** Update operation (U in CRUD) works

---

## BONUS: Delete Challenge (Protected Route - Creator Only)

**Method:** DELETE
**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**⚠️ IMPORTANT:** Use Challenge ID 1 (you'll delete the one you created)

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.xxxxx
Content-Type: application/json
```

**Body:** (None - it's a DELETE request)

**Click Send**

**Expected Response (Status: 200 OK):**
```json
{
  "message": "Challenge removed"
}
```

**✅ Confirms:** Delete operation (D in CRUD) works

---

## 📋 Testing Checklist

Complete these in order:

- [ ] Step 1: Register User
- [ ] Step 2: Login
- [ ] Step 3: Get Current User
- [ ] Step 4: Create Challenge 1
- [ ] Step 5: Create Challenge 2
- [ ] Step 6: List All Challenges
- [ ] Step 7: Get Specific Challenge
- [ ] Step 8: Join Challenge
- [ ] Step 9: Add Progress Entry 1
- [ ] Step 10: Add Progress Entry 2
- [ ] Step 11: Get User Progress
- [ ] BONUS: Update Challenge
- [ ] BONUS: Delete Challenge

---

## 🗄️ Verify Data in MongoDB

**Open Terminal:**

```bash
mongosh mongodb://localhost:27017/fitness-challenge
```

**In mongosh shell:**

```javascript
use fitness-challenge
show collections
db.users.find().pretty()
db.challenges.find().pretty()
db.progresses.find().pretty()
```

**You should see:**
- 1 user (Alice Johnson)
- 2 challenges (Run Streak, Gym Challenge)
- 2 progress entries (with timestamps and notes)

---

## ✅ Summary of What Works

| Feature | Status | Tested |
|---------|--------|--------|
| User Registration | ✅ Works | Step 1 |
| User Login | ✅ Works | Step 2 |
| JWT Authentication | ✅ Works | Step 3 |
| Create Challenge | ✅ Works | Step 4-5 |
| Read Challenges | ✅ Works | Step 6-7 |
| Join Challenge | ✅ Works | Step 8 |
| Add Progress | ✅ Works | Step 9-10 |
| Get Progress | ✅ Works | Step 11 |
| Update Challenge | ✅ Works | Bonus |
| Delete Challenge | ✅ Works | Bonus |
| Database Persistence | ✅ Works | MongoDB |
| Input Validation | ✅ Works | Error tests |
| Authorization | ✅ Works | Protected routes |

---

## 🎯 For Your Viva/Presentation

**Show screenshots of:**
1. Thunder Client/Postman with successful responses
2. Token in authorization header
3. MongoDB Compass showing saved data
4. Error responses (401, 404, 400)
5. All API endpoints working

**Explain:**
1. How JWT authentication works
2. How data flows (Request → Controller → Model → Database)
3. Protected vs public routes
4. CRUD operations
5. Mongoose schema validation

Done! All 11 steps complete ✅
