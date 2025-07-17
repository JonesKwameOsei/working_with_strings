#!/bin/bash

echo "🔧 Creating gh-pages branch manually..."

# Save current branch
current_branch=$(git branch --show-current)
echo "📍 Current branch: $current_branch"

# Configure git
git config user.name "Manual Setup"
git config user.email "setup@local"

# Create and switch to gh-pages branch
echo "📝 Creating gh-pages branch..."
git checkout --orphan gh-pages

# Remove all files from the new branch
echo "🗑️ Cleaning gh-pages branch..."
git rm -rf . 2>/dev/null || true

# Create a beautiful index.html
echo "🎨 Creating index.html for GitHub Pages..."
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C# String Exercises - Progress Reports</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            background: rgba(255,255,255,0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        h2 {
            font-size: 1.5em;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .status {
            background: rgba(255,255,255,0.2);
            padding: 20px;
            border-radius: 15px;
            margin: 30px 0;
            border: 2px solid rgba(255,255,255,0.3);
        }
        
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            margin: 10px;
            border: 2px solid rgba(255,255,255,0.3);
            transition: all 0.3s ease;
            font-weight: bold;
        }
        
        .btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .instructions {
            text-align: left;
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 10px;
            margin: 30px 0;
        }
        
        .instructions ol {
            margin-left: 20px;
        }
        
        .instructions li {
            margin: 10px 0;
            line-height: 1.6;
        }
        
        .footer {
            margin-top: 40px;
            opacity: 0.8;
            font-size: 0.9em;
        }
        
        .emoji {
            font-size: 1.2em;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎓 C# String Exercises</h1>
        <h2>Automated Progress Reports</h2>
        
        <div class="status">
            <h3><span class="emoji">⚙️</span>System Status: Ready</h3>
            <p>This page will display beautiful HTML reports when you complete exercises!</p>
        </div>
        
        <div class="instructions">
            <h3><span class="emoji">📚</span>How to Generate Reports:</h3>
            <ol>
                <li><strong>Complete an exercise</strong> in the repository</li>
                <li><strong>Commit and push</strong> your changes to GitHub</li>
                <li><strong>GitHub Actions automatically tests</strong> your code</li>
                <li><strong>Beautiful HTML reports</strong> will appear on this page</li>
                <li><strong>Get instant feedback</strong> with specific suggestions to improve</li>
            </ol>
        </div>
        
        <div>
            <a href="https://github.com/JonesKwameOsei/working_with_strings" class="btn">
                <span class="emoji">📝</span>Start Exercises
            </a>
            <a href="https://github.com/JonesKwameOsei/working_with_strings/actions" class="btn">
                <span class="emoji">⚙️</span>View Actions
            </a>
        </div>
        
        <div class="footer">
            <p><strong>GitHub Pages Successfully Configured!</strong></p>
            <p>Updated: <script>document.write(new Date().toLocaleString())</script></p>
            <p>Reports will automatically appear here when you push code changes.</p>
        </div>
    </div>
</body>
</html>
EOF

# Create a basic README for the gh-pages branch
cat > README.md << 'EOF'
# C# String Exercises - Reports

This branch contains the automatically generated HTML reports for the C# String Exercises.

## How it works:

1. Students complete exercises in the main branch
2. GitHub Actions automatically tests their code
3. Beautiful HTML reports are generated and deployed to this branch
4. GitHub Pages serves the reports at: https://joneskwameosei.github.io/working_with_strings/

## Files:

- `index.html` - Main landing page with instructions
- `reports/` - Directory containing all generated reports
- Each report run gets its own subdirectory with timestamp

This page is automatically updated by GitHub Actions.
EOF

# Add and commit the files
echo "💾 Committing files to gh-pages branch..."
git add .
git commit -m "Initialize gh-pages branch with HTML reports setup"

# Push the gh-pages branch
echo "📤 Pushing gh-pages branch to GitHub..."
git push origin gh-pages

# Switch back to original branch
echo "🔄 Switching back to $current_branch branch..."
git checkout $current_branch

echo ""
echo "✅ Successfully created gh-pages branch!"
echo ""
echo "🔧 Now follow these steps:"
echo "   1. Go back to GitHub → Settings → Pages"
echo "   2. Refresh the page if needed"
echo "   3. Change Branch from 'main' to 'gh-pages'"
echo "   4. Click 'Save'"
echo "   5. Wait 2-3 minutes"
echo "   6. Visit: https://joneskwameosei.github.io/working_with_strings/"
echo ""
echo "🎉 You should now see the beautiful landing page instead of README.md!"

EOF

chmod +x create_ghpages_branch.sh