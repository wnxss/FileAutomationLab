$sourceFolder  = Join-Path $PSScriptRoot "SampleFiles"
$archiveFolder = Join-Path $PSScriptRoot "Archive"

$cutoffDate = (Get-Date).AddDays(-7)

if (-not (Test-Path $archiveFolder)) {
    New-Item -Path $archiveFolder -ItemType Directory | Out-Null
}

$oldFiles = Get-ChildItem -Path $sourceFolder -File |
    Where-Object { $_.LastWriteTime -lt $cutoffDate }

Write-Host "Cutoff date: $cutoffDate"
Write-Host "Files older than 7 days: $($oldFiles.Count)"
$oldFiles | ForEach-Object { Write-Host " - $($_.Name) | $($_.LastWriteTime)" }

$oldFiles | Move-Item -Destination $archiveFolder -WhatIf