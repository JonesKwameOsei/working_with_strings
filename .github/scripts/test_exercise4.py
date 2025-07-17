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
