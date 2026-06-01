# Complete Testing Guide with Full JSON Bodies

## Server Running
✅ http://localhost:5000
✅ MongoDB: mongodb://localhost:27017/fitness-challenge

---

# STEP 1: Register User

**URL:** http://localhost:5000/api/auth/register

**Method:** POST

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "password": "password123"
}
```

**Expected Response (Status: 201 Created):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

**📌 SAVE:**
- Token: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1`
- User ID: `6653a1f5e8c2d4001f5a1b2c`

---

# STEP 2: Login

**URL:** http://localhost:5000/api/auth/login

**Method:** POST

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "email": "alice@example.com",
  "password": "password123"
}
```

**Expected Response (Status: 200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1",
  "user": {
    "id": "6653a1f5e8c2d4001f5a1b2c",
    "name": "Alice Johnson",
    "email": "alice@example.com"
  }
}
```

---

# STEP 3: Get Current User (Protected)

**URL:** http://localhost:5000/api/users/me

**Method:** GET

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:** 
```json
```
(Empty - GET request has no body)

**Expected Response (Status: 200 OK):**
```json
{
  "id": "6653a1f5e8c2d4001f5a1b2c",
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "createdAt": "2026-05-09T10:30:00.000Z"
}
```

---

# STEP 4: Create Challenge 1 (Protected)

**URL:** http://localhost:5000/api/challenges

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days consecutive",
  "startDate": "2026-05-10",
  "endDate": "2026-06-09"
}
```

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days consecutive",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:35:00.000Z"
}
```

**📌 SAVE:**
- Challenge ID 1: `6653b2c5e8c2d4001f5a1b3d`

---

# STEP 5: Create Challenge 2 (Protected)

**URL:** http://localhost:5000/api/challenges

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months with proper form",
  "startDate": "2026-05-01",
  "endDate": "2026-08-01"
}
```

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b3d6e8c2d4001f5a1b4e",
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months with proper form",
  "startDate": "2026-05-01T00:00:00.000Z",
  "endDate": "2026-08-01T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:36:00.000Z"
}
```

**📌 SAVE:**
- Challenge ID 2: `6653b3d6e8c2d4001f5a1b4e`

---

# STEP 6: List All Challenges (Public)

**URL:** http://localhost:5000/api/challenges

**Method:** GET

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
```
(Empty - GET request has no body)

**Expected Response (Status: 200 OK):**
```json
[
  {
    "_id": "6653b2c5e8c2d4001f5a1b3d",
    "title": "30 Day Run Streak",
    "description": "Run at least 3km every day for 30 days consecutive",
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
    "description": "Complete 50 gym workouts in 3 months with proper form",
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

---

# STEP 7: Get Specific Challenge (Public)

**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method:** GET

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
```
(Empty - GET request has no body)

**Expected Response (Status: 200 OK):**
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "30 Day Run Streak",
  "description": "Run at least 3km every day for 30 days consecutive",
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

---

# STEP 8: Join Challenge (Protected)

**URL:** http://localhost:5000/api/challenges/6653b3d6e8c2d4001f5a1b4e/join

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{}
```

**Expected Response (Status: 200 OK):**
```json
{
  "_id": "6653b3d6e8c2d4001f5a1b4e",
  "title": "Gym Challenge - 50 Workouts",
  "description": "Complete 50 gym workouts in 3 months with proper form",
  "startDate": "2026-05-01T00:00:00.000Z",
  "endDate": "2026-08-01T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [
    "6653a1f5e8c2d4001f5a1b2c"
  ],
  "createdAt": "2026-05-09T10:36:00.000Z"
}
```

**✅ Notice:** Your user ID is now in the `participants` array!

---

# STEP 9: Add Progress Entry 1 (Protected)

**URL:** http://localhost:5000/api/progress

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-09",
  "note": "Completed 20 pushups and 10 pullups at the gym"
}
```

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

---

# STEP 10: Add Progress Entry 2 (Protected)

**URL:** http://localhost:5000/api/progress

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-10",
  "note": "Did 30 minutes of cardio on the treadmill"
}
```

**Expected Response (Status: 201 Created):**
```json
{
  "_id": "6653b5f8e8c2d4001f5a1b60",
  "user": "6653a1f5e8c2d4001f5a1b2c",
  "challenge": "6653b3d6e8c2d4001f5a1b4e",
  "date": "2026-05-10T00:00:00.000Z",
  "note": "Did 30 minutes of cardio on the treadmill",
  "createdAt": "2026-05-09T10:41:00.000Z"
}
```

---

# STEP 11: Get User Progress (Protected)

**URL:** http://localhost:5000/api/progress/user/6653a1f5e8c2d4001f5a1b2c

**Method:** GET

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
```
(Empty - GET request has no body)

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
    "note": "Did 30 minutes of cardio on the treadmill",
    "createdAt": "2026-05-09T10:41:00.000Z"
  }
]
```

---

# BONUS: Update Challenge (Protected - Creator Only)

**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method:** PUT

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{
  "title": "Updated: 30 Day Run Streak (Advanced Version)",
  "description": "Run at least 5km every day for 30 days - Advanced Challenge"
}
```

**Expected Response (Status: 200 OK):**
```json
{
  "_id": "6653b2c5e8c2d4001f5a1b3d",
  "title": "Updated: 30 Day Run Streak (Advanced Version)",
  "description": "Run at least 5km every day for 30 days - Advanced Challenge",
  "startDate": "2026-05-10T00:00:00.000Z",
  "endDate": "2026-06-09T00:00:00.000Z",
  "createdBy": "6653a1f5e8c2d4001f5a1b2c",
  "participants": [],
  "createdAt": "2026-05-09T10:35:00.000Z"
}
```

---

# BONUS: Delete Challenge (Protected - Creator Only)

**URL:** http://localhost:5000/api/challenges/6653b2c5e8c2d4001f5a1b3d

**Method:** DELETE

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
```
(Empty - DELETE request has no body)

**Expected Response (Status: 200 OK):**
```json
{
  "message": "Challenge removed"
}
```

---

# ERROR TEST CASES

## Error 1: Invalid Token

**URL:** http://localhost:5000/api/users/me

**Method:** GET

**Headers:**
```
Authorization: Bearer invalid_token_xyz123
Content-Type: application/json
```

**Request Body:**
```json
```

**Expected Response (Status: 401 Unauthorized):**
```json
{
  "message": "Token is not valid"
}
```

---

## Error 2: Missing Token

**URL:** http://localhost:5000/api/users/me

**Method:** GET

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
```

**Expected Response (Status: 401 Unauthorized):**
```json
{
  "message": "No token, authorization denied"
}
```

---

## Error 3: Invalid Email Format

**URL:** http://localhost:5000/api/auth/register

**Method:** POST

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Bob Smith",
  "email": "invalid-email-no-at-sign",
  "password": "password123"
}
```

**Expected Response (Status: 400 Bad Request):**
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

---

## Error 4: Password Too Short

**URL:** http://localhost:5000/api/auth/register

**Method:** POST

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Bob Smith",
  "email": "bob@example.com",
  "password": "123"
}
```

**Expected Response (Status: 400 Bad Request):**
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

---

## Error 5: Duplicate Email

**URL:** http://localhost:5000/api/auth/register

**Method:** POST

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Alice Johnson",
  "email": "alice@example.com",
  "password": "password123"
}
```

**Expected Response (Status: 400 Bad Request):**
```json
{
  "message": "User already exists"
}
```

---

## Error 6: Challenge Not Found

**URL:** http://localhost:5000/api/challenges/invalid_id_xyz123

**Method:** GET

**Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
```

**Expected Response (Status: 404 Not Found):**
```json
{
  "message": "Challenge not found"
}
```

---

## Error 7: Already Joined Challenge

**URL:** http://localhost:5000/api/challenges/6653b3d6e8c2d4001f5a1b4e/join

**Method:** POST

**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTNhMWY1ZThjMmQ0MDAxZjVhMWIyYyIsImlhdCI6MTcxNjMwNTAwMH0.2zAkv5nP9qX8tY3mZ1
Content-Type: application/json
```

**Request Body:**
```json
{}
```

**Expected Response (Status: 400 Bad Request):**
```json
{
  "message": "Already joined"
}
```

---

# 📋 COMPLETE TESTING CHECKLIST

Copy and paste each JSON body exactly as shown:

- [ ] **STEP 1**: Register with provided JSON body
- [ ] **STEP 2**: Login with provided JSON body
- [ ] **STEP 3**: Get user (empty body, with token header)
- [ ] **STEP 4**: Create challenge 1 with provided JSON body
- [ ] **STEP 5**: Create challenge 2 with provided JSON body
- [ ] **STEP 6**: List challenges (empty body)
- [ ] **STEP 7**: Get specific challenge (empty body)
- [ ] **STEP 8**: Join challenge with empty JSON body
- [ ] **STEP 9**: Add progress entry 1 with provided JSON body
- [ ] **STEP 10**: Add progress entry 2 with provided JSON body
- [ ] **STEP 11**: Get user progress (empty body, with token header)
- [ ] **BONUS**: Update challenge with provided JSON body
- [ ] **BONUS**: Delete challenge (empty body)
- [ ] **Error 1**: Test invalid token
- [ ] **Error 2**: Test missing token
- [ ] **Error 3**: Test invalid email
- [ ] **Error 4**: Test short password
- [ ] **Error 5**: Test duplicate email
- [ ] **Error 6**: Test challenge not found
- [ ] **Error 7**: Test already joined

---

# ✅ VERIFICATION IN MONGODB

After completing all steps, verify in MongoDB:

```bash
mongosh mongodb://localhost:27017/fitness-challenge
use fitness-challenge
db.users.find().pretty()
db.challenges.find().pretty()
db.progresses.find().pretty()
```

**Expected results:**
- 1 user: Alice Johnson with email alice@example.com
- 2 challenges: Run Streak and Gym Challenge
- 2 progress entries: with dates and notes

---

**All JSON bodies provided - Copy & Paste ready!** ✅
