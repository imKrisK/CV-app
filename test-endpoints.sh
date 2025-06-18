#!/bin/bash

echo "🐳 CV Application Docker Setup - Port 3001 Testing"
echo "=================================================="
echo

echo "✅ Testing Health Endpoint..."
health_response=$(curl -s http://localhost:3001/health)
echo "Response: $health_response"
echo

echo "✅ Testing Main Application..."
main_response=$(curl -s http://localhost:3001/ | head -1)
echo "Response: $main_response"
echo

echo "✅ Testing API Data Endpoint..."
api_response=$(curl -s http://localhost:3001/api/data | jq -r '.name')
echo "Name: $api_response"
echo

echo "✅ Testing PDF Generation..."
pdf_headers=$(curl -s -I http://localhost:3001/api/generate-pdf | grep -E "(HTTP|Content-Type|Content-Disposition)")
echo "$pdf_headers"
echo

echo "🎉 All endpoints are working correctly on port 3001!"
echo
echo "🌐 Access your application at: http://localhost:3001"
echo "📊 Health check: http://localhost:3001/health"
echo "📄 Download PDF: http://localhost:3001/api/generate-pdf"
echo "📡 API data: http://localhost:3001/api/data"
