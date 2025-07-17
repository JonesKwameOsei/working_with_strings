#!/bin/bash

# complete_setup.sh
# Complete script to set up the C# String Exercises repository with all files

echo "🚀 Setting up Complete C# String Exercises Repository..."

# Create main directory structure
mkdir -p .github/workflows
mkdir -p .github/scripts
mkdir -p Exercise1 Exercise2 Exercise3 Exercise4 Exercise5
mkdir -p Solutions

echo "📁 Created directory structure"

# Create .csproj files for each exercise
for i in {1..5}; do
    cat > "Exercise${i}/Exercise${i}.csproj" << 'EOF'
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net6.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>

</Project>
EOF
    echo "✅ Created Exercise${i}/Exercise${i}.csproj"
done

# Create Exercise1.cs
cat > Exercise1/Exercise1.cs << 'EOF'
using System;

namespace StringExercises
{
    class Exercise1
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 1: Variable Declaration and Initialization ===");
            
            // TODO: Declare and initialize string variables for personal information
            // Requirements:
            // 1. Declare a string variable called 'firstName' and initialize it with any first name
            // 2. Declare a string variable called 'lastName' and initialize it with any last name
            // 3. Declare a string variable called 'email' and initialize it with any email address
            // 4. Declare a string variable called 'phoneNumber' and initialize it with any phone number
            // 5. Declare a string variable called 'address' and initialize it with any address
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Display all the information using Console.WriteLine
            // Requirements:
            // 6. Display "Personal Information:" as a header
            // 7. Display each piece of information with a label (e.g., "First Name: John")
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
EOF

# Create Exercise2.cs
cat > Exercise2/Exercise2.cs << 'EOF'
using System;

namespace StringExercises
{
    class Exercise2
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 2: Variable Reassignment ===");
            
            // TODO: Initial character setup
            // Requirements:
            // 1. Declare and initialize 'characterName' with any name
            // 2. Declare and initialize 'characterJob' with "Student"
            // 3. Declare and initialize 'characterLocation' with "College"
            // 4. Declare and initialize 'characterMood' with "Nervous"
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Display initial character information
            // Requirements:
            // 5. Display "=== Story Beginning ===" as header
            // 6. Display each character attribute with labels
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n--- 5 Years Later ---");
            
            // TODO: Reassign variables for 5 years later
            // Requirements:
            // 7. Reassign 'characterJob' to "Software Developer"
            // 8. Reassign 'characterLocation' to "Tech Company"
            // 9. Reassign 'characterMood' to "Confident"
            // Note: Do NOT reassign characterName - it should stay the same
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Display updated character information
            // Requirements:
            // 10. Display each character attribute with labels (same format as before)
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n--- Another 3 Years Later ---");
            
            // TODO: Reassign variables for 8 years total
            // Requirements:
            // 11. Reassign 'characterJob' to "Senior Developer"
            // 12. Reassign 'characterLocation' to "Remote Office"
            // 13. Reassign 'characterMood' to "Accomplished"
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Display final character information
            // Requirements:
            // 14. Display each character attribute with labels (same format as before)
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
EOF

# Create Exercise3.cs
cat > Exercise3/Exercise3.cs << 'EOF'
using System;

namespace StringExercises
{
    class Exercise3
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 3: String Concatenation ===");
            
            // Given word components - DO NOT MODIFY THESE
            string subject = "The cat";
            string verb = "jumped";
            string preposition = "over";
            string object1 = "the";
            string object2 = "fence";
            string adverb = "quickly";
            
            Console.WriteLine("Word Components:");
            Console.WriteLine($"Subject: '{subject}', Verb: '{verb}', Preposition: '{preposition}'");
            Console.WriteLine($"Articles/Objects: '{object1}', '{object2}', Adverb: '{adverb}'\n");
            
            // TODO: Method 1 - Using + operator
            // Requirements:
            // 1. Create a variable called 'sentence1'
            // 2. Build the sentence "The cat jumped over the fence quickly." using + operator
            // 3. Include proper spaces between words and a period at the end
            // 4. Display the result with label "Method 1 (+ operator): "
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 2 - Using += operator
            // Requirements:
            // 5. Create a variable called 'sentence2' and initialize it with 'subject'
            // 6. Use += operator to add each word piece by piece
            // 7. Build the same sentence with proper spacing and period
            // 8. Display the result with label "Method 2 (+= operator): "
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 3 - Using String.Concat()
            // Requirements:
            // 9. Create a variable called 'sentence3'
            // 10. Use String.Concat() method to combine all words with proper spacing
            // 11. Display the result with label "Method 3 (String.Concat): "
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 4 - Using String.Join() with array
            // Requirements:
            // 12. Create a string array called 'words' containing all the word components
            // 13. Add the period to the last word (adverb) in the array
            // 14. Create a variable called 'sentence4' using String.Join with space separator
            // 15. Display the result with label "Method 4 (String.Join): "
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
EOF

# Create Exercise4.cs
cat > Exercise4/Exercise4.cs << 'EOF'
using System;

namespace StringExercises
{
    class Exercise4
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 4: String Interpolation ===");
            
            // Given product information - DO NOT MODIFY THESE
            string productName = "Wireless Headphones";
            string brand = "TechSound";
            decimal price = 89.99m;
            int stockQuantity = 25;
            double rating = 4.5;
            bool isOnSale = true;
            decimal discountPercent = 15.0m;
            
            Console.WriteLine("=== Product Catalog ===");
            
            // TODO: Basic string interpolation
            // Requirements:
            // 1. Use string interpolation to display "Product: [productName]"
            // 2. Use string interpolation to display "Brand: [brand]"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: Formatting numbers with string interpolation
            // Requirements:
            // 3. Display price with 2 decimal places using format "Price: $89.99"
            // 4. Display stock with format "Stock: 25 units available"
            // 5. Display rating with 1 decimal place using format "Rating: 4.5/5.0 stars"
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Conditional expressions in interpolation
            // Requirements:
            // 6. Display stock status: "In Stock" if stockQuantity > 0, otherwise "Out of Stock"
            // 7. Display sale status: "ON SALE!" if isOnSale is true, otherwise "Regular Price"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: Complex expressions in interpolation
            // Requirements:
            // 8. IF the product is on sale, calculate and display the sale price
            // 9. Use this format: "Sale Price: $XX.XX (Save 15% - $XX.XX off!)"
            // 10. Calculate: salePrice = price - (price * discountPercent / 100)
            // 11. Calculate savings: price - salePrice
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Multi-line string interpolation
            // Requirements:
            // 12. Create a variable called 'productSummary' using verbatim string (@"")
            // 13. Include all product information in a formatted summary
            // 14. Use string interpolation within the verbatim string
            // 15. Display the productSummary
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
EOF

# Create Exercise5.cs
cat > Exercise5/Exercise5.cs << 'EOF'
using System;

namespace StringExercises
{
    class Exercise5
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 5: String Methods ===");
            
            // Given messy user input - DO NOT MODIFY THESE
            string userEmail = "  JOHN.SMITH@GMAIL.COM  ";
            string userComment = "This product is AMAZING!!! I love it so much!!!";
            string userPhone = "(555) 123-4567 ext. 890";
            string productReview = "  The wireless headphones are great, but the WIRELESS connection sometimes drops. Overall, wireless technology is improving.  ";
            
            Console.WriteLine("=== Original Messy Data ===");
            Console.WriteLine($"Email: '{userEmail}'");
            Console.WriteLine($"Comment: '{userComment}'");
            Console.WriteLine($"Phone: '{userPhone}'");
            Console.WriteLine($"Review: '{productReview}'");
            
            Console.WriteLine("\n=== Cleaning Data with String Methods ===");
            
            // TODO: TRIM - Remove whitespace and convert to lowercase
            // Requirements:
            // 1. Create 'cleanEmail' by trimming userEmail and converting to lowercase
            // 2. Create 'cleanReview' by trimming productReview
            // 3. Display both cleaned strings with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Format phone number
            // Requirements:
            // 4. Create 'formattedPhone' by removing: "(", ")", "-", spaces
            // 5. Also replace "ext." with "x"
            // 6. Chain multiple Replace() calls
            // 7. Display the formatted phone with label
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Tone down comment
            // Requirements:
            // 8. Create 'censoredComment' by replacing:
            //    - "AMAZING" with "great"
            //    - "!!!" with "!"
            //    - "so much" with "very much"
            // 9. Display the toned down comment with label
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Case-insensitive replacement
            // Requirements:
            // 10. Create 'updatedReview' by replacing all instances of "wireless" with "Bluetooth"
            // 11. Use StringComparison.OrdinalIgnoreCase for case-insensitive replacement
            // 12. Also trim the result
            // 13. Display the updated review with label
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n=== Search Operations ===");
            
            // TODO: CONTAINS - Check if string contains substring
            // Requirements:
            // 14. Create 'containsGreat' boolean to check if cleanReview contains "great"
            // 15. Display the result with format "Review contains 'great': True/False"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: INDEXOF - Find position and extract parts
            // Requirements:
            // 16. Create 'atPosition' to find position of "@" in cleanEmail
            // 17. Display the position with format "Position of '@' in email: X"
            // 18. IF atPosition > 0, extract username and domain using Substring
            // 19. Display username and domain with format "Username: 'X', Domain: 'Y'"
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: STARTSWITH and ENDSWITH
            // Requirements:
            // 20. Create 'isGmail' boolean to check if cleanEmail ends with "@gmail.com"
            // 21. Create 'startsWithJohn' boolean to check if cleanEmail starts with "john"
            // 22. Display both results with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: LASTINDEXOF - Find first and last occurrence
            // Requirements:
            // 23. Create a test string: "The word 'test' appears in this test string for testing purposes"
            // 24. Find first occurrence of "test" using IndexOf
            // 25. Find last occurrence of "test" using LastIndexOf
            // 26. Display both positions with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n=== Final Processed Data ===");
            // TODO: Display all cleaned data
            // Requirements:
            // 27. Display all the cleaned variables with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
EOF

echo "✅ Created all Exercise .cs files"

# Create GitHub Actions workflow
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
    - uses: actions/checkout@v3
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: '6.0.x'
    
    - name: Test Exercise 1
      id: exercise1
      run: |
        echo "Testing Exercise 1..."
        dotnet run --project Exercise1/Exercise1.csproj > output1.txt 2>&1
        python3 .github/scripts/test_exercise1.py
      continue-on-error: true
    
    - name: Test Exercise 2
      id: exercise2
      if: steps.exercise1.outcome == 'success'
      run: |
        echo "Testing Exercise 2..."
        dotnet run --project Exercise2/Exercise2.csproj > output2.txt 2>&1
        python3 .github/scripts/test_exercise2.py
      continue-on-error: true
    
    - name: Test Exercise 3
      id: exercise3
      if: steps.exercise2.outcome == 'success'
      run: |
        echo "Testing Exercise 3..."
        dotnet run --project Exercise3/Exercise3.csproj > output3.txt 2>&1
        python3 .github/scripts/test_exercise3.py
      continue-on-error: true
    
    - name: Test Exercise 4
      id: exercise4
      if: steps.exercise3.outcome == 'success'
      run: |
        echo "Testing Exercise 4..."
        dotnet run --project Exercise4/Exercise4.csproj > output4.txt 2>&1
        python3 .github/scripts/test_exercise4.py
      continue-on-error: true
    
    - name: Test Exercise 5
      id: exercise5
      if: steps.exercise4.outcome == 'success'
      run: |
        echo "Testing Exercise 5..."
        dotnet run --project Exercise5/Exercise5.csproj > output5.txt 2>&1
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
      uses: actions/upload-artifact@v3
      with:
        name: test-results
        path: |
          output*.txt
          progress_report.md
EOF

echo "✅ Created GitHub Actions workflow"

# Create all test scripts
# Test Exercise 1
cat > .github/scripts/test_exercise1.py << 'EOF'
#!/usr/bin/env python3
import re
import sys
import os

def test_exercise1():
    """Test Exercise 1 - Variable Declaration and Initialization"""
    
    # Read the source code
    try:
        with open('Exercise1/Exercise1.cs', 'r') as f:
            source_code = f.read()
    except FileNotFoundError:
        print("❌ Exercise1.cs file not found!")
        return False
    
    # Read the output
    try:
        with open('output1.txt', 'r') as f:
            output = f.read()
    except FileNotFoundError:
        print("❌ Program output not found!")
        return False
    
    print("🔍 Testing Exercise 1 Requirements...")
    
    # Test 1: Check for required variable declarations
    required_variables = ['firstName', 'lastName', 'email', 'phoneNumber', 'address']
    declarations_found = []
    
    for var in required_variables:
        pattern = rf'string\s+{var}\s*=\s*"[^"]*"'
        if re.search(pattern, source_code):
            declarations_found.append(var)
            print(f"✅ Variable '{var}' declared and initialized correctly")
        else:
            print(f"❌ Variable '{var}' not found or incorrectly declared")
    
    # Test 2: Check if all variables are declared
    if len(declarations_found) != len(required_variables):
        print(f"❌ Expected {len(required_variables)} variables, found {len(declarations_found)}")
        return False
    
    # Test 3: Check output format
    output_checks = [
        ("Personal Information:", "Header not found"),
        ("First Name:", "First name output not found"),
        ("Last Name:", "Last name output not found"),
        ("Email:", "Email output not found"),
        ("Phone:", "Phone output not found"),
        ("Address:", "Address output not found")
    ]
    
    for check, error_msg in output_checks:
        if check in output:
            print(f"✅ Output contains: {check}")
        else:
            print(f"❌ {error_msg}")
            return False
    
    print("🎉 Exercise 1 completed successfully!")
    return True

if __name__ == "__main__":
    success = test_exercise1()
    sys.exit(0 if success else 1)
EOF

# Make scripts executable
chmod +x .github/scripts/test_exercise1.py

echo "✅ Created test scripts"

# Create .gitignore
cat > .gitignore << 'EOF'
# Build results
[Dd]ebug/
[Dd]ebugPublic/
[Rr]elease/
[Rr]eleases/
x64/
x86/
[Aa][Rr][Mm]/
[Aa][Rr][Mm]64/
bld/
[Bb]in/
[Oo]bj/
[Ll]og/

# Visual Studio files
.vs/
*.suo
*.user
*.userosscache
*.sln.docstates

# Visual Studio Code
.vscode/

# JetBrains Rider
.idea/

# User-specific files
*.rsuser
*.suo
*.user
*.userosscache
*.sln.docstates

# Test outputs
output*.txt
progress_report.md
exercise_status.txt

# macOS
.DS_Store

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini
EOF

echo "✅ Created .gitignore"

# Test that all exercises can build
echo "🔨 Testing that all exercise templates build..."
for i in {1..5}; do
    cd "Exercise${i}"
    if dotnet build > /dev/null 2>&1; then
        echo "✅ Exercise${i} builds successfully"
    else
        echo "❌ Exercise${i} failed to build"
        echo "Error details:"
        dotnet build
    fi
    cd ..
done

echo ""
echo "🎉 Complete repository setup finished!"
echo ""
echo "📁 Files created:"
echo "   ✅ 5 Exercise templates with C# code"
echo "   ✅ 5 Project files (.csproj)"
echo "   ✅ GitHub Actions workflow"
echo "   ✅ Test scripts (placeholder for Exercise 1)"
echo "   ✅ .gitignore file"
echo ""
echo "📋 Next steps:"
echo "1. Add the remaining test scripts (test_exercise2.py through test_exercise5.py)"
echo "2. Add generate_report.py script"
echo "3. Create README.md file"
echo "4. Initialize git repository:"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Initial setup with all exercise templates'"
echo "5. Push to GitHub and start testing!"
echo ""
echo "🏁 Setup completed successfully!"
EOF

chmod +x complete_setup.sh
echo "✅ Created complete setup script"