#!/bin/bash

echo "🔧 Manually updating gh-pages branch to show HTML reports..."

# Configure git
git config --global user.name "Manual Update"
git config --global user.email "update@local"

# Create a simple index.html for testing
mkdir -p temp-pages

cat > temp-pages/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C# String Exercises</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 50px 20px;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            max-width: 600px;
            background: rgba(255,255,255,0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        h1 { font-size: 2.5em; margin-bottom: 20px; }
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
        }
        .btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎓 C# String Exercises</h1>
        <h2>Automated Progress Reports</h2>
        <p>This page will show your exercise reports after you commit code changes.</p>
        <p><strong>How it works:</strong></p>
        <ol style="text-align: left; display: inline-block;">
            <li>Complete an exercise in the repository</li>
            <li>Commit and push your changes</li>
            <li>GitHub Actions automatically tests your code</li>
            <li>Beautiful HTML reports appear here</li>
        </ol>
        <div>
            <a href="https://github.com/JonesKwameOsei/working_with_strings" class="btn">📚 Go to Exercises</a>
            <a href="https://github.com/JonesKwameOsei/working_with_strings/actions" class="btn">⚙️ View Actions</a>
        </div>
        <p style="margin-top: 30px; opacity: 0.8; font-size: 0.9em;">
            Updated: $(date)<br>
            Reports will appear here automatically when you push code changes.
        </p>
    </div>
</body>
</html>
HTML

# Switch to gh-pages branch and update
git checkout -B gh-pages
git rm -rf . 2>/dev/null || true
cp temp-pages/* . 2>/dev/null || true
rm -rf temp-pages

git add .
git commit -m "Force update gh-pages to show HTML reports"
git push origin gh-pages --force

echo "✅ Manually updated gh-pages branch"
echo "🌐 Check: https://joneskwameosei.github.io/working_with_strings/"
echo "⏰ Wait 2-3 minutes for GitHub Pages to update"
