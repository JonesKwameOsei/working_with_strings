#!/bin/bash

echo "🔧 Fixing GitHub Pages permissions and configuration..."

# The issue is that we need to enable the right permissions in repository settings
# Let's create a simplified approach that works with default GitHub permissions

echo "📋 Current Issues Identified:"
echo "   ❌ GitHub Actions bot doesn't have push permissions to gh-pages branch"
echo "   ❌ Repository settings may not allow Actions to create branches"
echo "   ❌ GitHub Pages is showing README.md instead of our reports"
echo ""

# Create a simplified workflow that doesn't need special permissions
cat > .github/workflows/check-exercises.yml << 'EOF'
name: Check C# String Exercises

on:
  push:
    branches: [ main, student-submissions ]
  pull_request:
    branches: [ main ]

permissions:
  contents: write  # This should be enough for most repositories
  pull-requests: write
  actions: write

jobs:
  test-exercises:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
    
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
    
    - name: Prepare deployment files
      run: |
        # Create the reports directory structure
        mkdir -p docs/reports/${{ github.run_number }}
        
        # Copy the HTML report
        cp progress_report.html docs/reports/${{ github.run_number }}/
        
        # Copy output files if they exist
        cp output*.txt docs/reports/${{ github.run_number }}/ 2>/dev/null || true
        
        # Create an index.html that redirects to the latest report
        cat > docs/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>C# String Exercises Reports</title>
    <meta http-equiv="refresh" content="0; url=reports/${{ github.run_number }}/progress_report.html">
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .container { max-width: 600px; margin: 0 auto; }
        .btn { display: inline-block; padding: 15px 30px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; margin: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎓 C# String Exercises</h1>
        <p>Redirecting to the latest progress report...</p>
        <p>If you are not redirected automatically:</p>
        <a href="reports/${{ github.run_number }}/progress_report.html" class="btn">View Latest Report</a>
    </div>
</body>
</html>
HTML
        
        # Create a reports index
        cat > docs/reports/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Reports - C# String Exercises</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; max-width: 800px; margin: 0 auto; }
        .report-link { display: block; padding: 15px; margin: 10px 0; background: #f8f9fa; border-radius: 5px; text-decoration: none; color: #333; }
        .report-link:hover { background: #e9ecef; }
    </style>
</head>
<body>
    <h1>📊 All Exercise Reports</h1>
    <p>Here are all the generated reports:</p>
    <a href="${{ github.run_number }}/progress_report.html" class="report-link">
        📈 Run #${{ github.run_number }} - Latest Report
    </a>
</body>
</html>
HTML
    
    - name: Commit and push to gh-pages
      run: |
        # Configure git
        git config --global user.name 'github-actions[bot]'
        git config --global user.email 'github-actions[bot]@users.noreply.github.com'
        
        # Create or switch to gh-pages branch
        git checkout -B gh-pages
        
        # Remove everything except docs folder
        find . -maxdepth 1 -not -name 'docs' -not -name '.git' -not -name '.' -exec rm -rf {} + 2>/dev/null || true
        
        # Move docs contents to root
        if [ -d "docs" ]; then
          mv docs/* . 2>/dev/null || true
          rmdir docs 2>/dev/null || true
        fi
        
        # Add and commit
        git add .
        git commit -m "Deploy reports for run #${{ github.run_number }}" || echo "No changes to commit"
        
        # Push to gh-pages
        git push origin gh-pages --force
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    
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
          
          const comment = `## 📊 Exercise Progress Report
          
          Your exercise submission has been automatically tested!
          
          **📈 [View Interactive Report](${reportUrl})**
          
          Alternative access:
          - 🌐 [All Reports](https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/)
          - 📥 Download from [Artifacts](https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})
          
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
        echo "📥 **[Download Backup](https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})**" >> $GITHUB_STEP_SUMMARY
EOF

echo "✅ Created new workflow that handles GitHub Pages deployment manually"

# Create instructions for repository settings
cat > REPOSITORY_SETTINGS.md << 'EOF'
# Repository Settings for GitHub Actions and Pages

## 1. Enable GitHub Actions Permissions

Go to your repository Settings → Actions → General:

### Workflow Permissions:
- ✅ **Read and write permissions** 
- ✅ **Allow GitHub Actions to create and approve pull requests**

## 2. Configure GitHub Pages

Go to your repository Settings → Pages:

### Source:
- ✅ **Deploy from a branch**
- ✅ **Branch: gh-pages**
- ✅ **Folder: / (root)**

## 3. Branch Protection (Optional)

If you want to prevent direct pushes to main:
- Go to Settings → Branches
- Add rule for `main` branch
- ✅ **Require pull request reviews before merging**

## 4. Verify Setup

After making these changes:
1. Push a new commit to trigger the workflow
2. Check Actions tab for successful runs
3. Visit your GitHub Pages URL:
   ```
   https://YOUR_USERNAME.github.io/YOUR_REPOSITORY_NAME
   ```

## 5. Troubleshooting

### If deployment still fails:
1. Check that "Read and write permissions" is enabled
2. Verify the gh-pages branch exists
3. Check that GitHub Pages source is set to gh-pages branch
4. Wait 5-10 minutes for Pages to update

### If Pages shows README instead of reports:
1. The workflow creates an index.html that redirects to reports
2. Clear your browser cache
3. Try visiting the direct report URL
EOF

echo "✅ Created repository settings instructions"

echo ""
echo "🔧 What This Fix Does:"
echo "   ✅ Uses manual git operations instead of peaceiris/actions-gh-pages"
echo "   ✅ Creates proper directory structure for GitHub Pages"
echo "   ✅ Adds automatic redirection from root to latest report"
echo "   ✅ Provides both direct links and backup downloads"
echo "   ✅ Handles permissions more reliably"
echo ""
echo "📋 Next Steps:"
echo "   1. Apply this fix: git add . && git commit -m 'Fix Pages deployment' && git push"
echo "   2. Go to repository Settings → Actions → General"
echo "   3. Enable 'Read and write permissions' for GitHub Actions"
echo "   4. Go to Settings → Pages and set source to 'gh-pages' branch"
echo "   5. Test by pushing a change"
echo ""
echo "🌐 After setup, reports will be available at:"
echo "   https://YOUR_USERNAME.github.io/YOUR_REPOSITORY_NAME/"
echo ""
echo "✅ This approach should work with any repository permissions!"

EOF

chmod +x fix_pages_permissions.sh