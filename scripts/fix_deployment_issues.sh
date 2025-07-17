#!/bin/bash

echo "🔧 Fixing GitHub Actions deployment issues..."

# Fix the workflow file with correct parameters and permissions
cat > .github/workflows/check-exercises.yml << 'EOF'
name: Check C# String Exercises

on:
  push:
    branches: [ main, student-submissions ]
  pull_request:
    branches: [ main ]

# Add permissions for GitHub Pages deployment
permissions:
  contents: read
  pages: write
  id-token: write
  pull-requests: write

jobs:
  test-exercises:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
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
    
    - name: Create report directory
      run: |
        mkdir -p ./reports/${{ github.run_number }}
        cp progress_report.html ./reports/${{ github.run_number }}/
        cp output*.txt ./reports/${{ github.run_number }}/ 2>/dev/null || true
    
    - name: Deploy Report to GitHub Pages
      uses: peaceiris/actions-gh-pages@v4
      if: always()
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./reports
        destination_dir: reports
        keep_files: true
    
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
          
          // Delete old bot comments first
          const { data: comments } = await github.rest.issues.listComments({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: context.issue.number,
          });
          
          for (const comment of comments) {
            if (comment.user.type === 'Bot' && comment.body.includes('📊 Exercise Progress Report')) {
              await github.rest.issues.deleteComment({
                owner: context.repo.owner,
                repo: context.repo.repo,
                comment_id: comment.id,
              });
            }
          }
          
          // Create new comment
          const comment = `## 📊 Exercise Progress Report
          
          Your exercise submission has been automatically tested!
          
          **📈 [View Interactive Report](${reportUrl})**
          
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
EOF

echo "✅ Fixed GitHub Actions workflow with:"
echo "   🔐 Added proper permissions for GitHub Pages and PR comments"
echo "   📝 Fixed peaceiris/actions-gh-pages parameters (removed invalid 'include_files')"
echo "   📊 Added workflow summary with direct report link"
echo "   🧹 Added automatic cleanup of old bot comments"
echo "   📁 Proper directory structure for reports"

# Create alternative simplified workflow for repositories without Pages
cat > .github/workflows/check-exercises-simple.yml << 'EOF'
name: Check C# String Exercises (Simple)

on:
  push:
    branches: [ main, student-submissions ]
  pull_request:
    branches: [ main ]

# Minimal permissions - use this if GitHub Pages doesn't work
permissions:
  contents: read
  pull-requests: write

jobs:
  test-exercises:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
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
    
    - name: Generate HTML Report
      run: |
        python3 .github/scripts/generate_html_report.py \
          "${{ steps.exercise1.outcome }}" \
          "${{ steps.exercise2.outcome }}" \
          "${{ steps.exercise3.outcome }}" \
          "${{ steps.exercise4.outcome }}" \
          "${{ steps.exercise5.outcome }}"
    
    - name: Upload Test Results with HTML Report
      uses: actions/upload-artifact@v4
      if: always()
      with:
        name: exercise-results-${{ github.run_number }}
        path: |
          progress_report.html
          progress_report.md
          output*.txt
          exercise_status.txt
        retention-days: 30
    
    - name: Add PR Comment with Download Link
      uses: actions/github-script@v7
      if: github.event_name == 'pull_request' && always()
      with:
        script: |
          const artifactUrl = `https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }}`;
          
          const comment = `## 📊 Exercise Progress Report
          
          Your exercise submission has been automatically tested!
          
          **📥 [Download Interactive HTML Report](${artifactUrl})**
          
          Steps to view your report:
          1. Click the link above to go to the Actions run
          2. Scroll down to "Artifacts" section
          3. Download "exercise-results-${{ github.run_number }}"
          4. Extract the ZIP file
          5. Open \`progress_report.html\` in your browser
          
          The report includes:
          - ✅ Overall progress summary with visual progress bar
          - 🔍 Detailed test results for each exercise
          - 💡 Specific suggestions to fix issues
          - 📝 Your program output and source code
          - 🎯 Next steps to continue learning
          
          *Report generated on: ${new Date().toLocaleString()} UTC*
          `;
          
          await github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: comment
          });
EOF

echo "✅ Created alternative simple workflow (no GitHub Pages required)"

echo ""
echo "🔧 Issues Fixed:"
echo "   1. ❌ 'include_files' parameter → ✅ Removed (not supported)"
echo "   2. ❌ Permission denied → ✅ Added proper permissions block"
echo "   3. ❌ peaceiris/actions-gh-pages@v3 → ✅ Updated to v4"
echo "   4. ❌ Complex file copying → ✅ Simplified directory structure"
echo ""
echo "📋 Two Options Available:"
echo "   1. 🌐 Full GitHub Pages deployment (check-exercises.yml)"
echo "   2. 📦 Simple artifact download (check-exercises-simple.yml)"
echo ""
echo "🚀 To apply the fix:"
echo "   git add .github/workflows/"
echo "   git commit -m 'Fix GitHub Actions deployment issues'"
echo "   git push origin main"
echo ""
echo "💡 If GitHub Pages still doesn't work:"
echo "   1. Rename check-exercises.yml to check-exercises-pages.yml"
echo "   2. Rename check-exercises-simple.yml to check-exercises.yml"
echo "   3. Students will download HTML reports instead"
echo ""
echo "✅ The HTML reports will work either way!"

EOF

chmod +x fix_deployment_issues.sh