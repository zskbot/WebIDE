#!/bin/bash

# VelCat Clone & Setup Script
# Usage: bash clone-velcat.sh
# Works on Termux and other Linux/Unix systems

set -e

REPO_URL="https://github.com/zskbot/WebIDE.git"
REPO_NAME="velcat-web-ide"
INSTALL_DIR="$HOME/$REPO_NAME"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     VelCat Web IDE - Clone Script      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git not found. Installing...${NC}"
    if command -v apt &> /dev/null; then
        apt update && apt install -y git
    elif command -v pkg &> /dev/null; then
        pkg update && pkg install -y git
    else
        echo -e "${RED}❌ Cannot install git. Please install it manually.${NC}"
        exit 1
    fi
fi

# Check if Python3 is installed (for server)
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}⚠️  Python3 not found. Installing...${NC}"
    if command -v apt &> /dev/null; then
        apt install -y python3
    elif command -v pkg &> /dev/null; then
        pkg install -y python
    fi
fi

echo -e "${YELLOW}📥 Cloning VelCat repository...${NC}"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}📂 Directory exists. Pulling latest updates...${NC}"
    cd "$INSTALL_DIR"
    git pull origin main
else
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

echo -e "${GREEN}✅ Repository ready at: $INSTALL_DIR${NC}"
echo ""
echo -e "${BLUE}📋 Available commands:${NC}"
echo -e "  ${YELLOW}cd $INSTALL_DIR${NC}              - Navigate to project"
echo -e "  ${YELLOW}python3 -m http.server 8000${NC} - Start web server"
echo -e "  ${YELLOW}bash build.sh${NC}              - Build & push to GitHub"
echo ""
echo -e "${GREEN}🚀 Next steps:${NC}"
echo -e "  1. ${YELLOW}cd $INSTALL_DIR${NC}"
echo -e "  2. ${YELLOW}python3 -m http.server 8000${NC}"
echo -e "  3. Open browser to ${BLUE}http://localhost:8000${NC}"
echo ""
