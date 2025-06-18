#!/bin/bash

echo "🔄 Preparing Git Commit for CV Application Docker Implementation"
echo "================================================================"
echo

# Add all new Docker and backend files
echo "📁 Adding new files..."
git add Dockerfile
git add docker-compose.yml
git add docker-compose.override.yml
git add .dockerignore
git add .gitignore
git add nginx.conf
git add server.js
git add package.json
git add package-lock.json
git add test-endpoints.sh
git add CHANGES_SUMMARY.md
git add COMMIT_MESSAGE.txt

# Add modified files
echo "📝 Adding modified files..."
git add README.md
git add resume-web/index.html
git add resume-web/style.css

# Exclude non-project files
echo "🚫 Excluding non-project files..."
git reset "_imacKris_.png" 2>/dev/null || true
git reset "create a high definition futuristic logo of _imacKris_.png" 2>/dev/null || true

# Show what will be committed
echo "📋 Files staged for commit:"
git status --cached --porcelain

echo
echo "🎯 Ready to commit with message from COMMIT_MESSAGE.txt"
echo
echo "To commit, run:"
echo "git commit -F COMMIT_MESSAGE.txt"
echo
echo "Or to commit with a simpler message:"
echo 'git commit -m "feat: implement Docker containerization with Node.js backend and PDF generation"'
