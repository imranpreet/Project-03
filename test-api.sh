#!/bin/bash

# Fitness Challenge Tracker - Testing Script with curl
# Run this script to test all API endpoints
# Make sure server is running on http://localhost:5000

BASE_URL="http://localhost:5000"
TOKEN=""
USER_ID=""
CHALLENGE_ID_1=""
CHALLENGE_ID_2=""

echo "========================================="
echo "Fitness Challenge Tracker - API Testing"
echo "========================================="
echo "Base URL: $BASE_URL"
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Register
echo -e "${BLUE}=== STEP 1: Register User ===${NC}"
REGISTER_RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "password": "password123"
  }')

echo "Response:"
echo "$REGISTER_RESPONSE" | jq '.'

TOKEN=$(echo "$REGISTER_RESPONSE" | jq -r '.token')
USER_ID=$(echo "$REGISTER_RESPONSE" | jq -r '.user.id')

echo -e "${GREEN}✓ Token saved: ${TOKEN:0:20}...${NC}"
echo -e "${GREEN}✓ User ID saved: $USER_ID${NC}"
echo ""

# Step 2: Login
echo -e "${BLUE}=== STEP 2: Login ===${NC}"
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "alice@example.com",
    "password": "password123"
  }')

echo "Response:"
echo "$LOGIN_RESPONSE" | jq '.'
echo ""

# Step 3: Get Current User
echo -e "${BLUE}=== STEP 3: Get Current User (Protected) ===${NC}"
curl -s -X GET "$BASE_URL/api/users/me" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Step 4: Create Challenge 1
echo -e "${BLUE}=== STEP 4: Create Challenge 1 (Protected) ===${NC}"
CREATE_CHALLENGE_1=$(curl -s -X POST "$BASE_URL/api/challenges" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "30 Day Run Streak",
    "description": "Run at least 3km every day for 30 days",
    "startDate": "2026-05-10",
    "endDate": "2026-06-09"
  }')

echo "Response:"
echo "$CREATE_CHALLENGE_1" | jq '.'

CHALLENGE_ID_1=$(echo "$CREATE_CHALLENGE_1" | jq -r '._id')
echo -e "${GREEN}✓ Challenge ID 1 saved: $CHALLENGE_ID_1${NC}"
echo ""

# Step 5: Create Challenge 2
echo -e "${BLUE}=== STEP 5: Create Challenge 2 (Protected) ===${NC}"
CREATE_CHALLENGE_2=$(curl -s -X POST "$BASE_URL/api/challenges" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Gym Challenge - 50 Workouts",
    "description": "Complete 50 gym workouts in 3 months",
    "startDate": "2026-05-01",
    "endDate": "2026-08-01"
  }')

echo "Response:"
echo "$CREATE_CHALLENGE_2" | jq '.'

CHALLENGE_ID_2=$(echo "$CREATE_CHALLENGE_2" | jq -r '._id')
echo -e "${GREEN}✓ Challenge ID 2 saved: $CHALLENGE_ID_2${NC}"
echo ""

# Step 6: List All Challenges
echo -e "${BLUE}=== STEP 6: List All Challenges ===${NC}"
curl -s -X GET "$BASE_URL/api/challenges" | jq '.'
echo ""

# Step 7: Get Specific Challenge
echo -e "${BLUE}=== STEP 7: Get Specific Challenge ===${NC}"
curl -s -X GET "$BASE_URL/api/challenges/$CHALLENGE_ID_1" | jq '.'
echo ""

# Step 8: Join Challenge
echo -e "${BLUE}=== STEP 8: Join Challenge (Protected) ===${NC}"
curl -s -X POST "$BASE_URL/api/challenges/$CHALLENGE_ID_2/join" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Step 9: Add Progress Entry 1
echo -e "${BLUE}=== STEP 9: Add Progress Entry 1 (Protected) ===${NC}"
curl -s -X POST "$BASE_URL/api/progress" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"challenge\": \"$CHALLENGE_ID_2\",
    \"date\": \"2026-05-08\",
    \"note\": \"Completed 20 pushups and 10 pullups\"
  }" | jq '.'
echo ""

# Step 10: Add Progress Entry 2
echo -e "${BLUE}=== STEP 10: Add Progress Entry 2 (Protected) ===${NC}"
curl -s -X POST "$BASE_URL/api/progress" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"challenge\": \"$CHALLENGE_ID_2\",
    \"date\": \"2026-05-09\",
    \"note\": \"Did cardio for 30 minutes\"
  }" | jq '.'
echo ""

# Step 11: Get User Progress
echo -e "${BLUE}=== STEP 11: Get User Progress (Protected) ===${NC}"
curl -s -X GET "$BASE_URL/api/progress/user/$USER_ID" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Step 12: Update Challenge
echo -e "${BLUE}=== STEP 12: Update Challenge (Protected) ===${NC}"
curl -s -X PUT "$BASE_URL/api/challenges/$CHALLENGE_ID_1" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated: 30 Day Run Streak (Advanced)",
    "description": "Run at least 5km every day for 30 days"
  }' | jq '.'
echo ""

# Step 13: Delete Challenge
echo -e "${BLUE}=== STEP 13: Delete Challenge (Protected) ===${NC}"
curl -s -X DELETE "$BASE_URL/api/challenges/$CHALLENGE_ID_1" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Error Tests
echo -e "${YELLOW}=== ERROR TESTS ===${NC}"
echo ""

echo -e "${BLUE}Error Test 1: Invalid Token${NC}"
curl -s -H "Authorization: Bearer invalid_token" \
  "$BASE_URL/api/users/me" | jq '.'
echo ""

echo -e "${BLUE}Error Test 2: Missing Token${NC}"
curl -s "$BASE_URL/api/users/me" | jq '.'
echo ""

echo -e "${BLUE}Error Test 3: Invalid Email Format${NC}"
curl -s -X POST "$BASE_URL/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Bob",
    "email": "invalid-email",
    "password": "pass123"
  }' | jq '.'
echo ""

echo -e "${BLUE}Error Test 4: Password Too Short${NC}"
curl -s -X POST "$BASE_URL/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Bob",
    "email": "bob@example.com",
    "password": "123"
  }' | jq '.'
echo ""

echo -e "${BLUE}Error Test 5: Challenge Not Found${NC}"
curl -s "$BASE_URL/api/challenges/invalid_id_12345" | jq '.'
echo ""

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}All tests completed!${NC}"
echo -e "${GREEN}=========================================${NC}"
