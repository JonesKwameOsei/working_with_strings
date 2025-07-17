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
