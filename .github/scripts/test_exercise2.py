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
