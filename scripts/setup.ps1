# PowerShell Agentic AI Development Environment Setup Script
# Run with: .\scripts\setup.ps1

$ErrorActionPreference = "Stop"

Write-Host "🤖 Setting up Agentic AI Development Environment (Windows PowerShell)..." -ForegroundColor Cyan
Write-Host "=========================================================================" -ForegroundColor Cyan

# Check if Python is installed
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
    Write-Host "❌ Python is required but not found in PATH. Please install Python 3.10 or higher." -ForegroundColor Red
    exit 1
}

# Check Python version
$verCheck = & python -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Python 3.10 or higher is required." -ForegroundColor Red
    exit 1
}

$pyVersion = (& python --version)
Write-Host "✅ $pyVersion detected" -ForegroundColor Green

# Project directory
$projectName = Read-Host "Enter project name (default: my-agentic-ai-project)"
if ([string]::IsNullOrWhiteSpace($projectName)) {
    $projectName = "my-agentic-ai-project"
}

if (Test-Path $projectName) {
    Write-Host "❌ Directory $projectName already exists!" -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Path $projectName | Out-Null
Set-Location $projectName

Write-Host "📁 Created project directory: $projectName" -ForegroundColor Green

# Create virtual environment
Write-Host "🔧 Creating virtual environment (.venv)..." -ForegroundColor Yellow
python -m venv .venv
& ".\.venv\Scripts\Activate.ps1"

# Upgrade pip
Write-Host "⬆️ Upgrading pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Install core packages
Write-Host "📦 Installing core AI agent packages..." -ForegroundColor Yellow
pip install langchain langchain-community langchain-openai pyautogen crewai llama-index pydantic pydantic-ai openai anthropic streamlit python-dotenv rich loguru simpleeval

# Create directory structure
New-Item -ItemType Directory -Path "src\agents", "src\tools", "src\utils", "examples", "tests", "docs", "data", "logs" -Force | Out-Null

# Create .env.example
@"
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here
LANGCHAIN_API_KEY=your_langchain_api_key_here
DEFAULT_MODEL=gpt-4o-mini
TEMPERATURE=0.7
"@ | Set-Content -Path ".env.example"

# Create requirements.txt
pip freeze > requirements.txt

Write-Host ""
Write-Host "🎉 Setup Complete!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. cd $projectName"
Write-Host "2. .\.venv\Scripts\Activate.ps1"
Write-Host "3. Copy-Item .env.example .env"
