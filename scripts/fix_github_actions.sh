#!/bin/bash

echo "🔧 Updating GitHub Actions workflow to use current action versions..."

# Create updated workflow file
cat > .github/workflows/check-exercises.yml << 'EOF'
name: Check C# String Exercises

on:
  push:
    branches: [ main, student-submissions ]
  pull_request:
    branches: [ main ]

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
    
    - name: Generate Progress Report
      run: |
        python3 .github/scripts/generate_report.py \
          "${{ steps.exercise1.outcome }}" \
          "${{ steps.exercise2.outcome }}" \
          "${{ steps.exercise3.outcome }}" \
          "${{ steps.exercise4.outcome }}" \
          "${{ steps.exercise5.outcome }}"
    
    - name: Upload Test Results
      uses: actions/upload-artifact@v4
      if: always()
      with:
        name: test-results
        path: |
          output*.txt
          progress_report.md
          exercise_status.txt
        retention-days: 30
EOF

echo "✅ Updated GitHub Actions workflow with:"
echo "   - actions/checkout@v4 (was v3)"
echo "   - actions/setup-dotnet@v4 (was v3)" 
echo "   - actions/upload-artifact@v4 (was v3)"
echo "   - Added timeout to prevent hanging on Console.ReadKey()"
echo "   - Added if: always() to ensure artifacts are uploaded"
echo "   - Added retention-days: 30 for artifact cleanup"
echo ""
echo "🚀 The workflow should now work with current GitHub Actions!"
echo ""
echo "💡 Additional improvements made:"
echo "   - Programs will timeout after 30 seconds to prevent hanging"
echo "   - Test results will always be uploaded, even if tests fail"
echo "   - Artifacts will be cleaned up after 30 days"
echo ""
echo "📝 To apply the update:"
echo "   git add .github/workflows/check-exercises.yml"
echo "   git commit -m 'Update GitHub Actions to use current action versions'"
echo "   git push origin main"
EOF

chmod +x fix_github_actions.sh