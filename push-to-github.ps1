# SecureVault - Push Project to GitHub (PowerShell Script)

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  SecureVault - Push Project to GitHub" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check if Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Git is not installed or not in your PATH." -ForegroundColor Red
    Write-Host "Please install Git for Windows from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "Or install GitHub Desktop: https://desktop.github.com/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit..."
    exit 1
}

Write-Host "[1/5] Git detected successfully." -ForegroundColor Green

# 2. Initialize repository if needed
if (-not (Test-Path ".git")) {
    Write-Host "[2/5] Initializing local Git repository..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "[2/5] Local Git repository already initialized." -ForegroundColor Green
}

# 3. Stage files
Write-Host "[3/5] Staging files according to .gitignore..." -ForegroundColor Yellow
git add .

# 4. Commit
Write-Host "[4/5] Committing project files..." -ForegroundColor Yellow
git commit -m "Initial release of SecureVault: Cybersecurity File Encryption & Sharing Platform"

# 5. Remote repository check
$remotes = git remote
if (-not ($remotes -contains "origin")) {
    Write-Host ""
    Write-Host "Please create a new repository on https://github.com/new" -ForegroundColor Cyan
    $repoUrl = Read-Host "Enter your GitHub repository URL (e.g., https://github.com/username/securevault.git)"
    if ([string]::IsNullOrWhiteSpace($repoUrl)) {
        Write-Host "[ERROR] No repository URL provided. Aborting." -ForegroundColor Red
        exit 1
    }
    git branch -M main
    git remote add origin $repoUrl
} else {
    git branch -M main
}

# 6. Push
Write-Host "[5/5] Pushing files to GitHub main branch..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Green
    Write-Host "  [SUCCESS] SecureVault pushed to GitHub successfully!" -ForegroundColor Green
    Write-Host "========================================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[ERROR] Push encountered an issue. Ensure your GitHub credentials are configured." -ForegroundColor Red
}

Read-Host "Press Enter to finish..."
