# Fitness Challenge Tracker - Backend

Objective

Build a RESTful backend API for tracking fitness challenges: registration/login, challenge CRUD, joining challenges, and posting progress.

Tools & Technologies

- Node.js, Express
- MongoDB with Mongoose
- JWT for authentication
- dotenv for configuration
- bcryptjs for password hashing

System Architecture

Client -> Express Server -> MongoDB (Mongoose)

Project Structure (MVC-ish)

- server.js (entry)
- config/db.js
- models/ (Mongoose models)
- controllers/ (business logic)
- routes/ (Express routes)
- middleware/ (auth, logger, error handler)

Quick start

1. Copy `.env.example` to `.env` and set values (MONGO_URI, JWT_SECRET).
2. Install dependencies: npm install
3. Start the server for development: npm run dev

API Endpoints (overview)

- POST /api/auth/register - register new user
- POST /api/auth/login - login (returns JWT)
- GET /api/users/me - get current user (protected)

- GET /api/challenges - list challenges (filter/sort query supported)
- POST /api/challenges - create challenge (protected)
- GET /api/challenges/:id - get challenge
- PUT /api/challenges/:id - update challenge (protected)
- DELETE /api/challenges/:id - delete challenge (protected)
- POST /api/challenges/:id/join - join a challenge (protected)

- POST /api/progress - add progress entry (protected)
- GET /api/progress/user/:userId - get progress for a user (protected)

Sample Request & Response and Postman testing URLs are provided in the "Testing" section of this README (after you run the server).

Authentication Method

JWT tokens returned on login. Include header: Authorization: Bearer <token>

Notes

This project is prepared to deploy to services like Render/Heroku. Use environment variables in production.
