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
