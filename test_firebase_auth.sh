#!/bin/bash

# GramaYatri Firebase Auth Build & Test Script

echo "==============================================="
echo "GramaYatri Firebase Authentication"
echo "Build & Verification Script"
echo "==============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Clean build
echo -e "${YELLOW}[1/5]${NC} Cleaning previous builds..."
./gradlew clean
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Clean failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Clean successful${NC}"
echo ""

# Step 2: Build project
echo -e "${YELLOW}[2/5]${NC} Building project..."
./gradlew build -x test
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Build successful${NC}"
echo ""

# Step 3: Install on device/emulator
echo -e "${YELLOW}[3/5]${NC} Installing APK..."
./gradlew installDebug
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Installation failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Installation successful${NC}"
echo ""

# Step 4: Clear logs and run app
echo -e "${YELLOW}[4/5]${NC} Starting application..."
adb shell am start -n com.example.grama_yatri/.activities.SplashActivity
echo -e "${GREEN}✓ Application started${NC}"
echo ""

# Step 5: Stream logs
echo -e "${YELLOW}[5/5]${NC} Streaming logs (Ctrl+C to stop)..."
echo -e "${GREEN}Watching for: SplashActivity, LoginActivity, AuthManager${NC}"
echo ""
adb logcat | grep -E "SplashActivity|LoginActivity|AuthManager|MainActivity|Firebase"

echo ""
echo -e "${GREEN}===============================================${NC}"
echo -e "${GREEN}Firebase Auth Implementation Complete!${NC}"
echo -e "${GREEN}===============================================${NC}"
