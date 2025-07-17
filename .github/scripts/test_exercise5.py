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
