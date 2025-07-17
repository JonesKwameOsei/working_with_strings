# Repository Settings for GitHub Actions and Pages

## 1. Enable GitHub Actions Permissions

Go to your repository Settings → Actions → General:

### Workflow Permissions:
- ✅ **Read and write permissions** 
- ✅ **Allow GitHub Actions to create and approve pull requests**

## 2. Configure GitHub Pages

Go to your repository Settings → Pages:

### Source:
- ✅ **Deploy from a branch**
- ✅ **Branch: gh-pages**
- ✅ **Folder: / (root)**

## 3. Branch Protection (Optional)

If you want to prevent direct pushes to main:
- Go to Settings → Branches
- Add rule for `main` branch
- ✅ **Require pull request reviews before merging**

## 4. Verify Setup

After making these changes:
1. Push a new commit to trigger the workflow
2. Check Actions tab for successful runs
3. Visit your GitHub Pages URL:
   ```
   https://YOUR_USERNAME.github.io/YOUR_REPOSITORY_NAME
   ```

## 5. Troubleshooting

### If deployment still fails:
1. Check that "Read and write permissions" is enabled
2. Verify the gh-pages branch exists
3. Check that GitHub Pages source is set to gh-pages branch
4. Wait 5-10 minutes for Pages to update

### If Pages shows README instead of reports:
1. The workflow creates an index.html that redirects to reports
2. Clear your browser cache
3. Try visiting the direct report URL
