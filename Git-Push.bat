@echo off

set REPO_URL=https://github.com/Bishmanrock/Tiled.git

:: Check if the .git directory exists to determine if it's already a git repository
if not exist .git (
    echo Initializing new Git repository...
    git init
    git remote add origin %REPO_URL%
) else (
    echo Repository already initialized.
)

:: Prompt for a commit message
set /p COMMIT_MSG="Enter your commit message: "

:: Pull the latest changes from the remote repository
git pull origin main

:: Push changes to GitHub with the provided commit message
echo Pushing changes to GitHub...
git remote add origin %REPO_URL%
git add .
git commit -m "%COMMIT_MSG%"

:: Push change from the local branch (HEAD) to the "main" branch on GitHub
git push origin HEAD:main

echo Push completed.

pause 