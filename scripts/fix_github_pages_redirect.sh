#!/bin/bash

echo "🔧 Fixing GitHub Pages to show HTML reports instead of README..."

# The issue is that GitHub Pages is still showing the main branch README
# We need to ensure the gh-pages branch has the correct index.html

# Create a workflow that properly manages the gh-pages branch
cat > .github/workflows/check-exercises.yml << 'EOF'
name: Check C# String Exercises

on:
  push:
    branches: [ main, student-submissions ]
  pull_request:
    branches: [ main ]

permissions:
  contents: write
  pull-requests: write
  actions: write

jobs:
  test-exercises:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
        fetch-depth: 0  # Fetch all history for proper branch management
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: '6.0.x'
    
    - name: Test Exercise 1
      id: exercise1
      run: |
        echo "Testing Exercise 1..."
        cd Exercise1
        timeout 30s dotnet run > ../output1.txt 2>&1 || echo "Exercise 1 execution completed"
        cd ..
        python3 .github/scripts/test_exercise1.py
      continue-on-error: true
    
    - name: Test Exercise 2
      id: exercise2
      if: steps.exercise1.outcome == 'success'
      run: |
        echo "Testing Exercise 2..."
        cd Exercise2
        timeout 30s dotnet run > ../output2.txt 2>&1 || echo "Exercise 2 execution completed"
        cd ..
        python3 .github/scripts/test_exercise2.py
      continue-on-error: true
    
    - name: Test Exercise 3
      id: exercise3
      if: steps.exercise2.outcome == 'success'
      run: |
        echo "Testing Exercise 3..."
        cd Exercise3
        timeout 30s dotnet run > ../output3.txt 2>&1 || echo "Exercise 3 execution completed"
        cd ..
        python3 .github/scripts/test_exercise3.py
      continue-on-error: true
    
    - name: Test Exercise 4
      id: exercise4
      if: steps.exercise3.outcome == 'success'
      run: |
        echo "Testing Exercise 4..."
        cd Exercise4
        timeout 30s dotnet run > ../output4.txt 2>&1 || echo "Exercise 4 execution completed"
        cd ..
        python3 .github/scripts/test_exercise4.py
      continue-on-error: true
    
    - name: Test Exercise 5
      id: exercise5
      if: steps.exercise4.outcome == 'success'
      run: |
        echo "Testing Exercise 5..."
        cd Exercise5
        timeout 30s dotnet run > ../output5.txt 2>&1 || echo "Exercise 5 execution completed"
        cd ..
        python3 .github/scripts/test_exercise5.py
      continue-on-error: true
    
    - name: Generate Interactive HTML Report
      run: |
        python3 .github/scripts/generate_html_report.py \
          "${{ steps.exercise1.outcome }}" \
          "${{ steps.exercise2.outcome }}" \
          "${{ steps.exercise3.outcome }}" \
          "${{ steps.exercise4.outcome }}" \
          "${{ steps.exercise5.outcome }}"
    
    - name: Setup gh-pages branch and deploy
      run: |
        # Configure git
        git config --global user.name 'github-actions[bot]'
        git config --global user.email 'github-actions[bot]@users.noreply.github.com'
        
        # Create a temporary directory for our site
        mkdir -p temp-site/reports/${{ github.run_number }}
        
        # Copy the HTML report and outputs
        cp progress_report.html temp-site/reports/${{ github.run_number }}/
        cp output*.txt temp-site/reports/${{ github.run_number }}/ 2>/dev/null || true
        
        # Create the main index.html that redirects to the latest report
        cat > temp-site/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C# String Exercises - Latest Report</title>
    <meta http-equiv="refresh" content="3; url=reports/${{ github.run_number }}/progress_report.html">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 50px 20px;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            max-width: 600px;
            background: rgba(255,255,255,0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(255,255,255,0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            margin: 20px 10px;
            border: 2px solid rgba(255,255,255,0.3);
            transition: all 0.3s ease;
            font-weight: bold;
        }
        .btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .meta {
            margin-top: 30px;
            opacity: 0.8;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎓 C# String Exercises</h1>
        <h2>Progress Report</h2>
        <div class="spinner"></div>
        <p>Redirecting to your latest exercise report...</p>
        <p><strong>Run #${{ github.run_number }}</strong></p>
        
        <div>
            <a href="reports/${{ github.run_number }}/progress_report.html" class="btn">📊 View Report</a>
            <a href="https://github.com/${{ github.repository }}" class="btn">📚 Back to Exercises</a>
        </div>
        
        <div class="meta">
            <p>Generated on: $(date)</p>
            <p>If you're not redirected automatically, click "View Report" above.</p>
        </div>
    </div>
</body>
</html>
HTML
        
        # Switch to gh-pages branch (create if doesn't exist)
        if git show-ref --verify --quiet refs/heads/gh-pages; then
            git checkout gh-pages
            # Remove old files but keep the reports directory structure
            find . -maxdepth 1 -not -name 'reports' -not -name '.git' -not -name '.' -not -name 'temp-site' -exec rm -rf {} + 2>/dev/null || true
        else
            git checkout --orphan gh-pages
            # Remove all files from the new orphan branch
            git rm -rf . 2>/dev/null || true
        fi
        
        # Copy new files from temp directory
        cp -r temp-site/* . 2>/dev/null || true
        rm -rf temp-site
        
        # Ensure we have an index.html
        if [ ! -f "index.html" ]; then
            echo "<!DOCTYPE html><html><head><title>C# String Exercises</title></head><body><h1>C# String Exercises</h1><p>Reports will appear here after running exercises.</p></body></html>" > index.html
        fi
        
        # Add all files and commit
        git add .
        git commit -m "Deploy exercise reports for run #${{ github.run_number }}" || echo "No changes to commit"
        
        # Push to gh-pages
        git push origin gh-pages --force
    
    - name: Upload Test Results (Backup)
      uses: actions/upload-artifact@v4
      if: always()
      with:
        name: test-results-${{ github.run_number }}
        path: |
          progress_report.html
          progress_report.md
          output*.txt
          exercise_status.txt
        retention-days: 30
    
    - name: Add PR Comment with Report Link
      uses: actions/github-script@v7
      if: github.event_name == 'pull_request' && always()
      with:
        script: |
          const reportUrl = `https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/reports/${{ github.run_number }}/progress_report.html`;
          const mainUrl = `https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/`;
          
          const comment = `## 📊 Exercise Progress Report
          
          Your exercise submission has been automatically tested!
          
          **📈 [View Interactive Report](${reportUrl})**
          
          Alternative access:
          - 🌐 [Main Reports Page](${mainUrl})
          - 📥 [Download Backup](https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})
          
          The report includes:
          - ✅ Overall progress summary with visual progress bar
          - 🔍 Detailed test results for each exercise
          - 💡 Specific suggestions to fix issues
          - 📝 Your program output and source code
          - 🎯 Next steps to continue learning
          
          *Report generated on: ${new Date().toLocaleString()} UTC*
          *Run #${{ github.run_number }}*
          `;
          
          await github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: comment
          });
    
    - name: Add Workflow Summary
      if: always()
      run: |
        echo "## 📊 Test Results Summary" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise | Status |" >> $GITHUB_STEP_SUMMARY
        echo "|----------|--------|" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise 1 | ${{ steps.exercise1.outcome == 'success' && '✅ PASSED' || '❌ FAILED' }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise 2 | ${{ steps.exercise2.outcome == 'success' && '✅ PASSED' || (steps.exercise1.outcome == 'success' && '❌ FAILED' || '⏭️ SKIPPED') }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise 3 | ${{ steps.exercise3.outcome == 'success' && '✅ PASSED' || (steps.exercise2.outcome == 'success' && '❌ FAILED' || '⏭️ SKIPPED') }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise 4 | ${{ steps.exercise4.outcome == 'success' && '✅ PASSED' || (steps.exercise3.outcome == 'success' && '❌ FAILED' || '⏭️ SKIPPED') }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Exercise 5 | ${{ steps.exercise5.outcome == 'success' && '✅ PASSED' || (steps.exercise4.outcome == 'success' && '❌ FAILED' || '⏭️ SKIPPED') }} |" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "🌐 **[View Detailed Interactive Report](https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/reports/${{ github.run_number }}/progress_report.html)**" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "🏠 **[Main Reports Page](https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/)**" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "📥 **[Download Backup](https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})**" >> $GITHUB_STEP_SUMMARY
EOF

echo "✅ Updated workflow with proper gh-pages branch management"

# Create a manual script to force update the gh-pages branch
cat > force_update_pages.sh << 'EOF'
#!/bin/bash

echo "🔧 Manually updating gh-pages branch to show HTML reports..."

# Configure git
git config --global user.name "Manual Update"
git config --global user.email "update@local"

# Create a simple index.html for testing
mkdir -p temp-pages

cat > temp-pages/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C# String Exercises</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 50px 20px;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            max-width: 600px;
            background: rgba(255,255,255,0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        h1 { font-size: 2.5em; margin-bottom: 20px; }
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            margin: 10px;
            border: 2px solid rgba(255,255,255,0.3);
            transition: all 0.3s ease;
        }
        .btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎓 C# String Exercises</h1>
        <h2>Automated Progress Reports</h2>
        <p>This page will show your exercise reports after you commit code changes.</p>
        <p><strong>How it works:</strong></p>
        <ol style="text-align: left; display: inline-block;">
            <li>Complete an exercise in the repository</li>
            <li>Commit and push your changes</li>
            <li>GitHub Actions automatically tests your code</li>
            <li>Beautiful HTML reports appear here</li>
        </ol>
        <div>
            <a href="https://github.com/JonesKwameOsei/working_with_strings" class="btn">📚 Go to Exercises</a>
            <a href="https://github.com/JonesKwameOsei/working_with_strings/actions" class="btn">⚙️ View Actions</a>
        </div>
        <p style="margin-top: 30px; opacity: 0.8; font-size: 0.9em;">
            Updated: $(date)<br>
            Reports will appear here automatically when you push code changes.
        </p>
    </div>
</body>
</html>
HTML

# Switch to gh-pages branch and update
git checkout -B gh-pages
git rm -rf . 2>/dev/null || true
cp temp-pages/* . 2>/dev/null || true
rm -rf temp-pages

git add .
git commit -m "Force update gh-pages to show HTML reports"
git push origin gh-pages --force

echo "✅ Manually updated gh-pages branch"
echo "🌐 Check: https://joneskwameosei.github.io/working_with_strings/"
echo "⏰ Wait 2-3 minutes for GitHub Pages to update"
EOF

chmod +x force_update_pages.sh

echo "✅ Created workflow fixes and manual update script"

echo ""
echo "🔧 What's Wrong and How to Fix It:"
echo "   ❌ Issue: GitHub Pages showing README.md instead of HTML reports"
echo "   ❌ Cause: gh-pages branch not properly configured"
echo "   ❌ Problem: Index.html redirect not working"
echo ""
echo "✅ Solutions Provided:"
echo "   1. 📝 Updated workflow with proper gh-pages management"
echo "   2. 🔧 Manual script to force update gh-pages branch"
echo "   3. 🎨 Beautiful landing page with auto-redirect"
echo ""
echo "🚀 Apply the fixes:"
echo "   1. Run: git add . && git commit -m 'Fix GitHub Pages display' && git push"
echo "   2. OR run: ./force_update_pages.sh (manual immediate fix)"
echo "   3. Wait 2-3 minutes for GitHub Pages to update"
echo "   4. Visit: https://joneskwameosei.github.io/working_with_strings/"
echo ""
echo "🎯 After this fix:"
echo "   ✅ GitHub Pages will show beautiful HTML reports"
echo "   ✅ Auto-redirect to latest report"
echo "   ✅ Professional landing page"
echo "   ✅ No more README.md display"

EOF

chmod +x fix_github_pages_redirect.sh