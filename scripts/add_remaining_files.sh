#!/bin/bash

echo "📝 Adding remaining test scripts and files..."

# Create test_exercise2.py
cat > .github/scripts/test_exercise2.py << 'EOF'
#!/usr/bin/env python3
import re
import sys
import os

def test_exercise2():
    """Test Exercise 2 - Variable Reassignment"""
    
    try:
        with open('Exercise2/Exercise2.cs', 'r') as f:
            source_code = f.read()
    except FileNotFoundError:
        print("❌ Exercise2.cs file not found!")
        return False
    
    try:
        with open('output2.txt', 'r') as f:
            output = f.read()
    except FileNotFoundError:
        print("❌ Program output not found!")
        return False
    
    print("🔍 Testing Exercise 2 Requirements...")
    
    # Test initial variable declarations
    initial_vars = {
        'characterName': r'string\s+characterName\s*=\s*"[^"]*"',
        'characterJob': r'string\s+characterJob\s*=\s*"Student"',
        'characterLocation': r'string\s+characterLocation\s*=\s*"College"',
        'characterMood': r'string\s+characterMood\s*=\s*"Nervous"'
    }
    
    for var, pattern in initial_vars.items():
        if re.search(pattern, source_code):
            print(f"✅ Initial {var} declared correctly")
        else:
            print(f"❌ Initial {var} not declared correctly")
            return False
    
    # Test for reassignments
    reassignment_patterns = [
        (r'characterJob\s*=\s*"Software Developer"', "First job reassignment"),
        (r'characterLocation\s*=\s*"Tech Company"', "First location reassignment"),
        (r'characterMood\s*=\s*"Confident"', "First mood reassignment"),
        (r'characterJob\s*=\s*"Senior Developer"', "Second job reassignment"),
        (r'characterLocation\s*=\s*"Remote Office"', "Second location reassignment"),
        (r'characterMood\s*=\s*"Accomplished"', "Second mood reassignment")
    ]
    
    for pattern, description in reassignment_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Check that characterName is NOT reassigned
    lines = source_code.split('\n')
    initial_declaration_found = False
    reassignment_found = False
    
    for line in lines:
        if re.search(r'string\s+characterName\s*=', line):
            initial_declaration_found = True
        elif initial_declaration_found and re.search(r'characterName\s*=', line):
            reassignment_found = True
            break
    
    if reassignment_found:
        print("❌ characterName should NOT be reassigned!")
        return False
    else:
        print("✅ characterName correctly remains unchanged")
    
    # Check output format
    required_output = [
        "=== Story Beginning ===",
        "--- 5 Years Later ---",
        "--- Another 3 Years Later ---",
        "Character:",
        "Job:",
        "Location:",
        "Mood:"
    ]
    
    for req in required_output:
        if req in output:
            print(f"✅ Output contains: {req}")
        else:
            print(f"❌ Output missing: {req}")
            return False
    
    if "Student" in output and "Software Developer" in output and "Senior Developer" in output:
        print("✅ Job progression visible in output")
    else:
        print("❌ Job progression not visible in output")
        return False
    
    print("🎉 Exercise 2 completed successfully!")
    return True

if __name__ == "__main__":
    success = test_exercise2()
    sys.exit(0 if success else 1)
EOF

# Create test_exercise3.py
cat > .github/scripts/test_exercise3.py << 'EOF'
#!/usr/bin/env python3
import re
import sys
import os

def test_exercise3():
    """Test Exercise 3 - String Concatenation"""
    
    try:
        with open('Exercise3/Exercise3.cs', 'r') as f:
            source_code = f.read()
    except FileNotFoundError:
        print("❌ Exercise3.cs file not found!")
        return False
    
    try:
        with open('output3.txt', 'r') as f:
            output = f.read()
    except FileNotFoundError:
        print("❌ Program output not found!")
        return False
    
    print("🔍 Testing Exercise 3 Requirements...")
    
    # Test sentence1 using + operator
    pattern1 = r'sentence1\s*=\s*subject\s*\+.*\+.*\+.*\+.*\+.*\+.*'
    if re.search(pattern1, source_code.replace('\n', ' ').replace(' ', '')):
        print("✅ sentence1 uses + operator for concatenation")
    else:
        print("❌ sentence1 does not use + operator correctly")
        return False
    
    # Test sentence2 using += operator
    sentence2_patterns = [
        r'sentence2\s*=\s*subject',
        r'sentence2\s*\+=.*verb',
        r'sentence2\s*\+=.*preposition',
        r'sentence2\s*\+=.*object1.*object2',
        r'sentence2\s*\+=.*adverb'
    ]
    
    for i, pattern in enumerate(sentence2_patterns):
        if re.search(pattern, source_code):
            print(f"✅ sentence2 step {i+1} uses += operator")
        else:
            print(f"❌ sentence2 step {i+1} does not use += operator")
            return False
    
    # Test sentence3 using String.Concat
    if re.search(r'sentence3\s*=\s*String\.Concat\s*\(', source_code):
        print("✅ sentence3 uses String.Concat method")
    else:
        print("❌ sentence3 does not use String.Concat method")
        return False
    
    # Test sentence4 using String.Join with array
    array_pattern = r'string\[\]\s+words\s*=.*\{.*subject.*verb.*preposition.*object1.*object2.*adverb.*\}'
    join_pattern = r'sentence4\s*=\s*String\.Join\s*\(\s*"\s*"\s*,\s*words\s*\)'
    
    if re.search(array_pattern, source_code.replace('\n', ' ')):
        print("✅ words array declared correctly")
    else:
        print("❌ words array not declared correctly")
        return False
    
    if re.search(join_pattern, source_code):
        print("✅ sentence4 uses String.Join method")
    else:
        print("❌ sentence4 does not use String.Join method")
        return False
    
    # Check output format
    expected_outputs = [
        "Method 1 (+ operator):",
        "Method 2 (+= operator):",
        "Method 3 (String.Concat):",
        "Method 4 (String.Join):"
    ]
    
    for expected in expected_outputs:
        if expected in output:
            print(f"✅ Output contains: {expected}")
        else:
            print(f"❌ Output missing: {expected}")
            return False
    
    # Check that all sentences produce the correct result
    expected_sentence = "The cat jumped over the fence quickly."
    if output.count(expected_sentence) >= 4:
        print("✅ All methods produce the correct sentence")
    else:
        print("❌ Not all methods produce the correct sentence")
        return False
    
    print("🎉 Exercise 3 completed successfully!")
    return True

if __name__ == "__main__":
    success = test_exercise3()
    sys.exit(0 if success else 1)
EOF

# Create test_exercise4.py
cat > .github/scripts/test_exercise4.py << 'EOF'
#!/usr/bin/env python3
import re
import sys
import os

def test_exercise4():
    """Test Exercise 4 - String Interpolation"""
    
    try:
        with open('Exercise4/Exercise4.cs', 'r') as f:
            source_code = f.read()
    except FileNotFoundError:
        print("❌ Exercise4.cs file not found!")
        return False
    
    try:
        with open('output4.txt', 'r') as f:
            output = f.read()
    except FileNotFoundError:
        print("❌ Program output not found!")
        return False
    
    print("🔍 Testing Exercise 4 Requirements...")
    
    # Test basic string interpolation
    basic_interpolations = [
        (r'\$"Product:\s*\{productName\}"', "Product name interpolation"),
        (r'\$"Brand:\s*\{brand\}"', "Brand interpolation")
    ]
    
    for pattern, description in basic_interpolations:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test formatted number interpolation
    format_patterns = [
        (r'\{price:F2\}', "Price formatting with F2"),
        (r'\{rating:F1\}', "Rating formatting with F1"),
        (r'\{stockQuantity\}.*units', "Stock quantity display")
    ]
    
    for pattern, description in format_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test conditional expressions in interpolation
    conditional_patterns = [
        (r'\{.*stockQuantity.*>.*0.*\?.*"In Stock".*:.*"Out of Stock".*\}', "Stock status conditional"),
        (r'\{.*isOnSale.*\?.*"ON SALE!".*:.*"Regular Price".*\}', "Sale status conditional")
    ]
    
    for pattern, description in conditional_patterns:
        if re.search(pattern, source_code.replace('\n', ' ').replace(' ', '')):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test sale price calculation
    sale_calc_patterns = [
        (r'salePrice\s*=\s*price\s*-\s*\(\s*price\s*\*\s*discountPercent\s*/\s*100\s*\)', "Sale price calculation"),
        (r'\{salePrice:F2\}', "Sale price formatting"),
        (r'\{.*discountPercent.*\}', "Discount percentage display")
    ]
    
    for pattern, description in sale_calc_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test verbatim string
    verbatim_pattern = r'string\s+productSummary\s*=\s*\$@"'
    if re.search(verbatim_pattern, source_code):
        print("✅ Verbatim string with interpolation found")
    else:
        print("❌ Verbatim string with interpolation not found")
        return False
    
    # Test output content
    expected_outputs = [
        "Product: Wireless Headphones",
        "Brand: TechSound",
        "Price: $89.99",
        "Rating: 4.5/5.0",
        "Stock: 25 units",
        "ON SALE!",
        "Sale Price:",
        "Product Summary"
    ]
    
    for expected in expected_outputs:
        if expected in output:
            print(f"✅ Output contains: {expected}")
        else:
            print(f"❌ Output missing: {expected}")
            return False
    
    if "$76.49" in output or "$76.50" in output:
        print("✅ Sale price calculation appears correct")
    else:
        print("❌ Sale price calculation may be incorrect")
        return False
    
    print("🎉 Exercise 4 completed successfully!")
    return True

if __name__ == "__main__":
    success = test_exercise4()
    sys.exit(0 if success else 1)
EOF

# Create test_exercise5.py
cat > .github/scripts/test_exercise5.py << 'EOF'
#!/usr/bin/env python3
import re
import sys
import os

def test_exercise5():
    """Test Exercise 5 - String Methods"""
    
    try:
        with open('Exercise5/Exercise5.cs', 'r') as f:
            source_code = f.read()
    except FileNotFoundError:
        print("❌ Exercise5.cs file not found!")
        return False
    
    try:
        with open('output5.txt', 'r') as f:
            output = f.read()
    except FileNotFoundError:
        print("❌ Program output not found!")
        return False
    
    print("🔍 Testing Exercise 5 Requirements...")
    
    # Test TRIM operations
    trim_patterns = [
        (r'cleanEmail\s*=\s*userEmail\.Trim\(\)\.ToLower\(\)', "Clean email with Trim and ToLower"),
        (r'cleanReview\s*=\s*productReview\.Trim\(\)', "Clean review with Trim")
    ]
    
    for pattern, description in trim_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test REPLACE operations for phone formatting
    phone_replace_patterns = [
        r'\.Replace\s*\(\s*"\("\s*,\s*""\s*\)',
        r'\.Replace\s*\(\s*"\)"\s*,\s*""\s*\)',
        r'\.Replace\s*\(\s*"-"\s*,\s*""\s*\)',
        r'\.Replace\s*\(\s*"\s"\s*,\s*""\s*\)',
        r'\.Replace\s*\(\s*"ext\."\s*,\s*"x"\s*\)'
    ]
    
    phone_found = sum(1 for pattern in phone_replace_patterns if re.search(pattern, source_code))
    
    if phone_found >= 4:
        print("✅ Phone formatting with multiple Replace operations found")
    else:
        print("❌ Phone formatting with Replace operations incomplete")
        return False
    
    # Test REPLACE operations for comment
    comment_patterns = [
        (r'\.Replace\s*\(\s*"AMAZING"\s*,\s*"great"\s*\)', "Replace AMAZING with great"),
        (r'\.Replace\s*\(\s*"!!!"\s*,\s*"!"\s*\)', "Replace !!! with !"),
        (r'\.Replace\s*\(\s*"so much"\s*,\s*"very much"\s*\)', "Replace so much")
    ]
    
    for pattern, description in comment_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test case-insensitive replace
    case_insensitive_pattern = r'\.Replace\s*\(\s*"wireless"\s*,\s*"Bluetooth"\s*,\s*StringComparison\.OrdinalIgnoreCase\s*\)'
    if re.search(case_insensitive_pattern, source_code):
        print("✅ Case-insensitive Replace found")
    else:
        print("❌ Case-insensitive Replace not found")
        return False
    
    # Test CONTAINS operation
    contains_pattern = r'containsGreat\s*=\s*cleanReview\.Contains\s*\(\s*"great"\s*\)'
    if re.search(contains_pattern, source_code):
        print("✅ Contains method found")
    else:
        print("❌ Contains method not found")
        return False
    
    # Test INDEXOF and SUBSTRING operations
    indexof_patterns = [
        (r'atPosition\s*=\s*cleanEmail\.IndexOf\s*\(\s*"@"\s*\)', "IndexOf for @ symbol"),
        (r'username\s*=\s*cleanEmail\.Substring\s*\(\s*0\s*,\s*atPosition\s*\)', "Substring for username"),
        (r'domain\s*=\s*cleanEmail\.Substring\s*\(\s*atPosition\s*\+\s*1\s*\)', "Substring for domain")
    ]
    
    for pattern, description in indexof_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test STARTSWITH and ENDSWITH
    startend_patterns = [
        (r'isGmail\s*=\s*cleanEmail\.EndsWith\s*\(\s*"@gmail\.com"\s*\)', "EndsWith for Gmail check"),
        (r'startsWithJohn\s*=\s*cleanEmail\.StartsWith\s*\(\s*"john"\s*\)', "StartsWith for john check")
    ]
    
    for pattern, description in startend_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test LASTINDEXOF
    lastindexof_patterns = [
        (r'\.IndexOf\s*\(\s*"test"\s*\)', "First IndexOf for test"),
        (r'\.LastIndexOf\s*\(\s*"test"\s*\)', "LastIndexOf for test")
    ]
    
    for pattern, description in lastindexof_patterns:
        if re.search(pattern, source_code):
            print(f"✅ {description} found")
        else:
            print(f"❌ {description} not found")
            return False
    
    # Test expected output transformations
    expected_outputs = [
        "john.smith@gmail.com",
        "5551234567x890",
        "This product is great!",
        "Bluetooth",
        "contains 'great': True",
        "Position of '@'",
        "Username:",
        "Domain:",
        "Is Gmail account: True",
        "Starts with 'john': True"
    ]
    
    found_outputs = sum(1 for expected in expected_outputs if expected in output)
    
    if found_outputs < 7:
        print("❌ Too many expected outputs are missing")
        return False
    
    print("🎉 Exercise 5 completed successfully!")
    return True

if __name__ == "__main__":
    success = test_exercise5()
    sys.exit(0 if success else 1)
EOF

# Create generate_report.py
cat > .github/scripts/generate_report.py << 'EOF'
#!/usr/bin/env python3
import sys
from datetime import datetime

def generate_progress_report(results):
    """Generate a progress report based on exercise results"""
    
    exercises = [
        "Exercise 1: Variable Declaration and Initialization",
        "Exercise 2: Variable Reassignment", 
        "Exercise 3: String Concatenation",
        "Exercise 4: String Interpolation",
        "Exercise 5: String Methods (Trim, Replace, Search)"
    ]
    
    passed = sum(1 for result in results if result == "success")
    total = len(exercises)
    
    report = f"""# C# String Exercises Progress Report
    
Generated on: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")} UTC

## Overall Progress: {passed}/{total} Exercises Completed

### Exercise Status:

"""
    
    for i, (exercise, result) in enumerate(zip(exercises, results)):
        status_emoji = "✅" if result == "success" else "❌"
        status_text = "PASSED" if result == "success" else "FAILED"
        
        report += f"{status_emoji} **{exercise}** - {status_text}\n"
        
        if result != "success" and i > 0:
            prev_result = results[i-1]
            if prev_result != "success":
                report += f"   ⚠️  *Cannot attempt this exercise until previous exercise passes*\n"
        
        report += "\n"
    
    if passed == total:
        report += """## 🎉 Congratulations!

You have successfully completed all C# String exercises!

### Next Steps:
- Practice with more complex string manipulations
- Learn about regular expressions
- Explore file I/O with strings
- Build a text processing application

"""
    else:
        next_exercise_num = passed + 1
        if next_exercise_num <= total:
            report += f"""## Next Steps:

You need to complete **{exercises[next_exercise_num - 1]}** to proceed.

### Tips for Success:
- Read the requirements carefully in the comments
- Follow the exact variable names specified
- Ensure your output matches the expected format
- Test your code locally before committing

"""
    
    report += f"""## Debug Information:

Exercise Results: {results}
Timestamp: {datetime.now().isoformat()}

---
*This report was automatically generated by the GitHub Actions testing system.*
"""
    
    with open('progress_report.md', 'w') as f:
        f.write(report)
    
    print("📊 Progress Report Generated:")
    print(f"   Completed: {passed}/{total} exercises")
    print(f"   Success Rate: {(passed/total)*100:.1f}%")
    
    return passed == total

def main():
    if len(sys.argv) != 6:
        print("Usage: generate_report.py <ex1_result> <ex2_result> <ex3_result> <ex4_result> <ex5_result>")
        sys.exit(1)
    
    results = sys.argv[1:6]
    success = generate_progress_report(results)
    
    with open('exercise_status.txt', 'w') as f:
        for i, result in enumerate(results, 1):
            f.write(f"Exercise {i}: {result}\n")
    
    print("\n📋 Individual Exercise Status:")
    for i, result in enumerate(results, 1):
        status_emoji = "✅" if result == "success" else "❌"
        print(f"   Exercise {i}: {status_emoji} {result}")

if __name__ == "__main__":
    main()
EOF

# Make all scripts executable
chmod +x .github/scripts/*.py

# Create README.md
cat > README.md << 'EOF'
# C# String Exercises - Progressive Learning System

Welcome to the C# String Exercises! This repository contains 5 progressive exercises designed to teach you fundamental C# string concepts.

## 🎯 Learning Objectives

By completing these exercises, you will master:
- Variable declaration and initialization
- Variable reassignment
- String concatenation (4 different methods)
- String interpolation with formatting
- String methods: Trim, Replace, Contains, IndexOf, StartsWith, EndsWith

## 📚 Exercise Overview

### Exercise 1: Variable Declaration and Initialization
Learn to declare and initialize string variables for personal information.

### Exercise 2: Variable Reassignment
Practice changing variable values over time through a character story.

### Exercise 3: String Concatenation
Master 4 different ways to combine strings into sentences.

### Exercise 4: String Interpolation
Use modern C# string interpolation with formatting and conditionals.

### Exercise 5: String Methods
Clean and process messy data using various string methods.

## 🚀 Getting Started

### Prerequisites
- .NET 6.0 or later installed
- Visual Studio, Visual Studio Code, or any C# IDE
- Git for version control

### Setup Instructions

1. **Fork this repository** to your GitHub account
2. **Clone your fork** to your local machine:
   ```bash
   git clone https://github.com/YOUR_USERNAME/CSharpStringExercises.git
   cd CSharpStringExercises
   ```

3. **Start with Exercise 1**:
   ```bash
   cd Exercise1
   dotnet run
   ```

## 📖 How to Complete Exercises

### Step-by-Step Process

1. **Open Exercise 1 template** (`Exercise1/Exercise1.cs`)
2. **Read the requirements** in the comments carefully
3. **Write your code** in the designated sections marked with:
   ```csharp
   // YOUR CODE HERE - START
   
   // YOUR CODE HERE - END
   ```
4. **Test locally**:
   ```bash
   cd Exercise1
   dotnet run
   ```
5. **Commit and push** your changes:
   ```bash
   git add Exercise1/Exercise1.cs
   git commit -m "Complete Exercise 1"
   git push origin main
   ```

### 🔄 Automated Testing System

This repository uses **GitHub Actions** for automated testing:

- ✅ **Automatic grading** when you push code
- 📊 **Progress tracking** through all exercises
- 🚫 **Sequential unlocking** - you must pass Exercise 1 to attempt Exercise 2
- 📝 **Detailed feedback** on what needs to be fixed

### Checking Your Progress

1. Go to your repository on GitHub
2. Click on the **"Actions"** tab
3. View the latest workflow run
4. Download the **"test-results"** artifact to see your progress report

## ⚠️ Important Rules

### DO:
- ✅ Follow the exact variable names specified
- ✅ Complete exercises in order (1 → 2 → 3 → 4 → 5)
- ✅ Write code only in designated sections
- ✅ Test your code locally before committing

### DON'T:
- ❌ Skip exercises or attempt them out of order
- ❌ Modify the given variables or setup code
- ❌ Change the required output format

## 🆘 Getting Help

### Common Issues:
- **Case sensitivity**: `firstName` ≠ `firstname`
- **Missing spaces**: Check spaces in output strings
- **Wrong method**: Make sure you're using the required string methods
- **Output format**: Your output must match the expected format exactly

---

**Happy Coding! 🚀**
EOF

echo "✅ Created test_exercise2.py"
echo "✅ Created test_exercise3.py"
echo "✅ Created test_exercise4.py"
echo "✅ Created test_exercise5.py"
echo "✅ Created generate_report.py"
echo "✅ Made all scripts executable"
echo "✅ Created README.md"

echo ""
echo "🎉 All remaining files created successfully!"
echo ""
echo "📁 Complete file structure:"
echo "   ✅ All 5 Exercise templates (.cs files)"
echo "   ✅ All 5 Project files (.csproj)"
echo "   ✅ GitHub Actions workflow"
echo "   ✅ All 5 test scripts"
echo "   ✅ Progress report generator"
echo "   ✅ README.md with instructions"
echo "   ✅ .gitignore file"
echo ""
echo "🚀 Ready to deploy! Next steps:"
echo "1. git init"
echo "2. git add ."
echo "3. git commit -m 'Complete C# String Exercises setup'"
echo "4. git remote add origin https://github.com/YOUR_USERNAME/CSharpStringExercises.git"
echo "5. git push -u origin main"
echo "6. Students can now fork and start working!"
echo ""
echo "🏁 Setup completed successfully!"
EOF

chmod +x add_remaining_files.sh
echo "✅ Created add_remaining_files.sh"