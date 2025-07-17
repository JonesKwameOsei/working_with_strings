#!/bin/bash

echo "🚀 Deploying HTML Reports System..."

# Update permissions
chmod +x .github/scripts/*.py

# Commit changes
echo "💾 Committing changes..."
git add .github/workflows/check-exercises.yml
git add .github/scripts/generate_html_report.py
git add GITHUB_PAGES_SETUP.md
git add deploy_html_reports.sh

git commit -m "✨ Add beautiful HTML reports with GitHub Pages deployment

- Interactive web-based progress reports
- No more downloading artifacts!
- Direct browser viewing with professional UI
- Detailed test feedback with specific suggestions
- Mobile-responsive design
- Auto-deployment to GitHub Pages
- PR comments with direct report links"

echo "📤 Pushing to GitHub..."
git push origin main

echo ""
echo "🎉 HTML Reports System Deployed!"
echo ""
echo "📋 Next Steps:"
echo "1. 🌐 Enable GitHub Pages in repository Settings > Pages"
echo "2. 📖 Read GITHUB_PAGES_SETUP.md for detailed instructions"
echo "3. 🧪 Test by making a code change and pushing"
echo "4. 🔗 Check PR comments for direct report links"
echo ""
echo "✨ Student Experience Improvements:"
echo "   ❌ Old: Download → Unzip → Read 3 files"  
echo "   ✅ New: Click link → Beautiful web report opens!"
echo ""
echo "🎯 Features:"
echo "   • Interactive dashboard with progress visualization"
echo "   • Tabbed interface (Summary/Output/Code)"
echo "   • Specific suggestions to fix issues"
echo "   • Mobile-responsive design"
echo "   • Auto-scroll to failed exercises"
echo "   • Professional appearance"
echo "   • No downloads required!"
