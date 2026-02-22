Write-Host "USERPROFILE: $env:USERPROFILE"
Write-Host "HOME: $env:HOME"
if (-not $env:HOME) { Write-Host "HOME is NOT set." }
else { Write-Host "HOME is set to $env:HOME" }
