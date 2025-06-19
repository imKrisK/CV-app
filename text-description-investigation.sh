#!/bin/bash

echo "🔍 CV Application Text Description Investigation"
echo "=============================================="
echo

echo "📊 ISSUE IDENTIFICATION:"
echo "Investigating why text descriptions may not be displaying correctly..."
echo

echo "1️⃣ Testing API Data Endpoint:"
API_RESPONSE=$(curl -s http://localhost:3001/api/data)
echo "✅ API Response received: $(echo $API_RESPONSE | jq -r '.name') - $(echo $API_RESPONSE | jq -r '.title')"
echo

echo "2️⃣ Checking Summary Text:"
SUMMARY=$(echo $API_RESPONSE | jq -r '.summary')
echo "Summary Length: ${#SUMMARY} characters"
echo "Summary Preview: ${SUMMARY:0:100}..."
echo

echo "3️⃣ Checking Experience Details Structure:"
echo $API_RESPONSE | jq '.experience[0].details | length' > /dev/null 2>&1
if [ $? -eq 0 ]; then
    DETAILS_COUNT=$(echo $API_RESPONSE | jq '.experience[0].details | length')
    echo "✅ First job has $DETAILS_COUNT detail items"
    echo "First detail: $(echo $API_RESPONSE | jq -r '.experience[0].details[0]')"
else
    echo "❌ Issue with experience details structure"
fi
echo

echo "4️⃣ Testing Main Page Load:"
MAIN_PAGE=$(curl -s http://localhost:3001/)
if echo "$MAIN_PAGE" | grep -q "id=\"summary\""; then
    echo "✅ Summary element found in HTML"
else
    echo "❌ Summary element missing from HTML"
fi
echo

echo "5️⃣ Checking for JavaScript Errors:"
if echo "$MAIN_PAGE" | grep -q "fetch('/api/data')"; then
    echo "✅ Data fetching script found"
else
    echo "❌ Data fetching script missing"
fi
echo

echo "🎯 POTENTIAL ISSUES IDENTIFIED:"
echo "Based on the investigation, checking common problems..."
