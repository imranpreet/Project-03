Deployment notes:
- Ensure you set environment variables in the platform (MONGO_URI, JWT_SECRET, PORT).
- On Render/Heroku, add start script `node server.js` and supply env vars.
- Example Procfile for Heroku: `web: node server.js`

Testing tips:
- Use Postman to register -> login -> copy token -> create challenge -> join -> add progress.
- If running MongoDB locally, ensure mongod service is running.
