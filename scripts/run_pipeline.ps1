# ============================================
# AgriPrice Project - Automated ETL Pipeline
# ============================================
$ErrorActionPreference = "Stop"
Set-Location "C:\Users\polad\Documents\MyProjects\AgriPriceProject"

New-Item -ItemType Directory -Force -Path logs | Out-Null
log = "logs\pipeline_(Get-Date -Format 'yyyy-MM-dd_HH-mm').log"

"=== PIPELINE STARTED: (Get−Date)==="∣Tee−Object(Get-Date) ===" | Tee-Object(Get−Date)==="∣Tee−Objectlog

Write-Host "--- STEP 1: Cleaning data ---" -ForegroundColor Cyan
python scripts\clean_agri_data.py 2>&1 | Tee-Object $log -Append

Write-Host "--- STEP 2: Loading to MySQL ---" -ForegroundColor Cyan
python scripts\load_to_mysql.py 2>&1 | Tee-Object $log -Append

"=== PIPELINE FINISHED: (Get−Date)==="∣Tee−Object(Get-Date) ===" | Tee-Object(Get−Date)==="∣Tee−Objectlog -Append
Write-Host "Log saved to: $log" -ForegroundColor Green
