#!/usr/bin/env python3
# .github/scripts/generate_html_report.py
import sys
import os
import json
from datetime import datetime
import re

def read_file_safe(filename):
    """Safely read a file, return empty string if not found"""
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return ""
    except Exception as e:
        return f"Error reading {filename}: {str(e)}"

def extract_test_details(exercise_num, source_code, output):
    """Extract specific test details for an exercise"""
    details = {
        'variables_found': [],
        'output_issues': [],
        'code_issues': [],
        'suggestions': []
    }
    
    if exercise_num == 1:
        # Check variables
        required_vars = ['firstName', 'lastName', 'email', 'phoneNumber', 'address']
        for var in required_vars:
            pattern = rf'string\s+{var}\s*=\s*"[^"]*"'
            if re.search(pattern, source_code):
                details['variables_found'].append(f"✅ {var}")
            else:
                details['variables_found'].append(f"❌ {var}")
                details['code_issues'].append(f"Variable '{var}' not declared correctly")
        
        # Check output format
        required_outputs = [
            ("Personal Information:", "Header format"),
            ("First Name:", "First name label"),
            ("Last Name:", "Last name label"), 
            ("Email:", "Email label"),
            ("Phone:", "Phone label"),
            ("Address:", "Address label")
        ]
        
        for check, description in required_outputs:
            if check in output:
                details['output_issues'].append(f"✅ {description}")
            else:
                details['output_issues'].append(f"❌ {description}")
                if check == "Personal Information:":
                    details['suggestions'].append("Remove any emojis from 'Personal Information:' header")
                elif check == "Last Name:":
                    details['suggestions'].append("Fix capitalization: 'last Name:' should be 'Last Name:'")
                elif check == "Email:":
                    details['suggestions'].append("Use 'Email:' not 'Email Address:'")
                elif check == "Phone:":
                    details['suggestions'].append("Use 'Phone:' not 'Phone Number:'")
                elif check == "Address:":
                    details['suggestions'].append("Use 'Address:' not 'Home Address:'")
    
    return details

def generate_html_report(results):
    """Generate a comprehensive HTML report"""
    
    exercises = [
        "Exercise 1: Variable Declaration and Initialization",
        "Exercise 2: Variable Reassignment", 
        "Exercise 3: String Concatenation",
        "Exercise 4: String Interpolation",
        "Exercise 5: String Methods (Trim, Replace, Search)"
    ]
    
    passed = sum(1 for result in results if result == "success")
    total = len(exercises)
    progress_percent = (passed / total) * 100
    
    # Read all output files and source code
    exercise_data = []
    for i in range(1, 6):
        output_file = f"output{i}.txt"
        source_file = f"Exercise{i}/Exercise{i}.cs"
        
        output_content = read_file_safe(output_file)
        source_content = read_file_safe(source_file)
        
        # Extract test details
        test_details = extract_test_details(i, source_content, output_content) if i == 1 else {
            'variables_found': [], 'output_issues': [], 'code_issues': [], 'suggestions': []
        }
        
        exercise_data.append({
            'number': i,
            'title': exercises[i-1],
            'status': results[i-1] if i-1 < len(results) else 'skipped',
            'output': output_content,
            'source': source_content,
            'details': test_details
        })
    
    # Generate HTML
    html_content = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C# String Exercises - Progress Report</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }}
        
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }}
        
        .header {{
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }}
        
        .header h1 {{
            color: #2c3e50;
            font-size: 2.5em;
            margin-bottom: 10px;
        }}
        
        .progress-container {{
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }}
        
        .progress-bar {{
            width: 100%;
            height: 30px;
            background: #e9ecef;
            border-radius: 15px;
            overflow: hidden;
            margin: 10px 0;
        }}
        
        .progress-fill {{
            height: 100%;
            background: linear-gradient(90deg, #28a745, #20c997);
            width: {progress_percent}%;
            transition: width 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }}
        
        .exercise-card {{
            background: white;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }}
        
        .exercise-card:hover {{
            transform: translateY(-5px);
        }}
        
        .exercise-header {{
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        
        .exercise-header.success {{
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }}
        
        .exercise-header.failure {{
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        }}
        
        .exercise-header.skipped {{
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
        }}
        
        .exercise-title {{
            font-size: 1.3em;
            font-weight: bold;
        }}
        
        .exercise-status {{
            padding: 8px 16px;
            border-radius: 25px;
            background: rgba(255,255,255,0.2);
            font-weight: bold;
        }}
        
        .exercise-content {{
            padding: 0;
        }}
        
        .tabs {{
            display: flex;
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }}
        
        .tab {{
            padding: 15px 25px;
            cursor: pointer;
            background: none;
            border: none;
            font-size: 16px;
            font-weight: 500;
            color: #6c757d;
            transition: all 0.3s ease;
        }}
        
        .tab.active {{
            background: white;
            color: #495057;
            border-bottom: 3px solid #007bff;
        }}
        
        .tab-content {{
            padding: 25px;
            display: none;
        }}
        
        .tab-content.active {{
            display: block;
        }}
        
        .code-block {{
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin: 15px 0;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            overflow-x: auto;
            white-space: pre-wrap;
        }}
        
        .output-block {{
            background: #1e1e1e;
            color: #d4d4d4;
            border-radius: 8px;
            padding: 20px;
            margin: 15px 0;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            overflow-x: auto;
            white-space: pre-wrap;
        }}
        
        .status-list {{
            list-style: none;
            margin: 15px 0;
        }}
        
        .status-list li {{
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }}
        
        .suggestion-box {{
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin: 15px 0;
        }}
        
        .suggestion-box h4 {{
            color: #856404;
            margin-bottom: 10px;
        }}
        
        .suggestion-box ul {{
            color: #856404;
            margin-left: 20px;
        }}
        
        .next-steps {{
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-top: 30px;
            text-align: center;
        }}
        
        .timestamp {{
            text-align: center;
            color: #6c757d;
            margin-top: 20px;
            font-size: 0.9em;
        }}
        
        @media (max-width: 768px) {{
            .container {{
                padding: 10px;
            }}
            
            .exercise-header {{
                flex-direction: column;
                text-align: center;
            }}
            
            .exercise-title {{
                margin-bottom: 10px;
            }}
            
            .tabs {{
                flex-wrap: wrap;
            }}
            
            .tab {{
                flex: 1;
                min-width: 120px;
            }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎓 C# String Exercises</h1>
            <h2>Progress Report</h2>
            <div class="progress-container">
                <h3>Overall Progress: {passed}/{total} Exercises Completed</h3>
                <div class="progress-bar">
                    <div class="progress-fill">{progress_percent:.1f}%</div>
                </div>
                <p>Generated on: {datetime.now().strftime("%B %d, %Y at %I:%M %p UTC")}</p>
            </div>
        </div>
"""

    # Add exercise cards
    for exercise in exercise_data:
        status_class = exercise['status']
        status_text = {
            'success': '✅ PASSED',
            'failure': '❌ FAILED', 
            'skipped': '⏭️ SKIPPED'
        }.get(status_class, '❓ UNKNOWN')
        
        html_content += f"""
        <div class="exercise-card">
            <div class="exercise-header {status_class}">
                <div class="exercise-title">Exercise {exercise['number']}: {exercise['title'].split(': ', 1)[1]}</div>
                <div class="exercise-status">{status_text}</div>
            </div>
            <div class="exercise-content">
                <div class="tabs">
                    <button class="tab active" onclick="showTab(event, 'summary-{exercise['number']}')">Summary</button>
                    <button class="tab" onclick="showTab(event, 'output-{exercise['number']}')">Program Output</button>
                    <button class="tab" onclick="showTab(event, 'code-{exercise['number']}')">Your Code</button>
                </div>
                
                <div id="summary-{exercise['number']}" class="tab-content active">
"""

        # Add summary content based on status
        if exercise['status'] == 'success':
            html_content += f"""
                    <h3>🎉 Congratulations!</h3>
                    <p>You successfully completed Exercise {exercise['number']}. All requirements were met!</p>
"""
        elif exercise['status'] == 'failure' and exercise['details']['variables_found']:
            html_content += f"""
                    <h3>📝 Test Results</h3>
                    <h4>Variable Declarations:</h4>
                    <ul class="status-list">
"""
            for var in exercise['details']['variables_found']:
                html_content += f"<li>{var}</li>"
            
            html_content += """
                    </ul>
                    <h4>Output Format:</h4>
                    <ul class="status-list">
"""
            for output in exercise['details']['output_issues']:
                html_content += f"<li>{output}</li>"
            
            html_content += "</ul>"
            
            if exercise['details']['suggestions']:
                html_content += """
                    <div class="suggestion-box">
                        <h4>💡 Suggestions to Fix:</h4>
                        <ul>
"""
                for suggestion in exercise['details']['suggestions']:
                    html_content += f"<li>{suggestion}</li>"
                html_content += """
                        </ul>
                    </div>
"""
        elif exercise['status'] == 'skipped':
            html_content += f"""
                    <h3>⏭️ Exercise Skipped</h3>
                    <p>This exercise was skipped because previous exercises haven't passed yet.</p>
                    <p>Complete the previous exercises first to unlock this one.</p>
"""
        else:
            html_content += f"""
                    <h3>❌ Exercise Failed</h3>
                    <p>This exercise didn't meet the requirements. Check the output and code tabs for details.</p>
"""

        html_content += f"""
                </div>
                
                <div id="output-{exercise['number']}" class="tab-content">
                    <h3>Program Output</h3>
                    <div class="output-block">{exercise['output'] if exercise['output'] else 'No output available'}</div>
                </div>
                
                <div id="code-{exercise['number']}" class="tab-content">
                    <h3>Your Source Code</h3>
                    <div class="code-block">{exercise['source'] if exercise['source'] else 'Source code not available'}</div>
                </div>
            </div>
        </div>
"""

    # Add next steps
    if passed == total:
        next_steps_content = """
            <h2>🎉 All Exercises Complete!</h2>
            <p>Congratulations! You've mastered all C# string fundamentals.</p>
            <h3>🚀 What's Next?</h3>
            <ul style="text-align: left; display: inline-block;">
                <li>Practice with more complex string manipulations</li>
                <li>Learn about regular expressions</li>
                <li>Explore file I/O with strings</li>
                <li>Build a text processing application</li>
            </ul>
"""
    else:
        next_exercise_num = passed + 1
        next_steps_content = f"""
            <h2>📚 Next Steps</h2>
            <p>Complete <strong>Exercise {next_exercise_num}</strong> to continue your learning journey!</p>
            <h3>💡 Tips for Success:</h3>
            <ul style="text-align: left; display: inline-block;">
                <li>Read the requirements carefully in the code comments</li>
                <li>Follow the exact variable names specified</li>
                <li>Ensure your output matches the expected format</li>
                <li>Test your code locally before committing</li>
            </ul>
"""

    html_content += f"""
        <div class="next-steps">
            {next_steps_content}
        </div>
        
        <div class="timestamp">
            Report generated automatically by GitHub Actions<br>
            Timestamp: {datetime.now().isoformat()}
        </div>
    </div>

    <script>
        function showTab(event, tabId) {{
            // Hide all tab contents
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(content => content.classList.remove('active'));
            
            // Remove active class from all tabs
            const tabs = event.target.parentElement.querySelectorAll('.tab');
            tabs.forEach(tab => tab.classList.remove('active'));
            
            // Show selected tab content and mark tab as active
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
        }}
        
        // Auto-scroll to first failed exercise
        window.addEventListener('load', function() {{
            const firstFailedCard = document.querySelector('.exercise-header.failure');
            if (firstFailedCard) {{
                firstFailedCard.scrollIntoView({{ behavior: 'smooth', block: 'center' }});
            }}
        }});
    </script>
</body>
</html>
"""

    # Write HTML file
    with open('progress_report.html', 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    # Also create the markdown version for compatibility
    generate_markdown_report(results, exercises, passed, total)
    
    print("📊 Generated comprehensive HTML progress report!")
    print(f"   📁 progress_report.html - Interactive web report")
    print(f"   📁 progress_report.md - Markdown version")
    print(f"   📈 Progress: {passed}/{total} exercises ({progress_percent:.1f}%)")
    
    return passed == total

def generate_markdown_report(results, exercises, passed, total):
    """Generate markdown report for compatibility"""
    
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
        if next_exercise_num <= len(exercises):
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
*View the interactive HTML report (progress_report.html) for detailed feedback and better visualization.*
"""
    
    with open('progress_report.md', 'w') as f:
        f.write(report)

def main():
    if len(sys.argv) != 6:
        print("Usage: generate_html_report.py <ex1_result> <ex2_result> <ex3_result> <ex4_result> <ex5_result>")
        sys.exit(1)
    
    results = sys.argv[1:6]
    success = generate_html_report(results)
    
    # Create status file
    with open('exercise_status.txt', 'w') as f:
        for i, result in enumerate(results, 1):
            f.write(f"Exercise {i}: {result}\n")

if __name__ == "__main__":
    main()
