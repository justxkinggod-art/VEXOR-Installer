$ErrorActionPreference = "Stop"

$url = "https://github.com/justxkinggod-art/VEXOR-Installer/releases/download/v1.0.0/VEXORV1.zip"

$zip = "$env:TEMP\VEXORV1.zip"
$dir = "$env:TEMP\VEXORV1"

try {
    if (Test-Path $zip) {
        Remove-Item $zip -Force
    }

    if (Test-Path $dir) {
        Remove-Item $dir -Recurse -Force
    }

    Write-Host "Downloading VEXOR..."

    Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing

    if (-not (Test-Path $zip)) {
        throw "Download failed."
    }

    Write-Host "Extracting VEXOR..."

    Expand-Archive -Path $zip -DestinationPath $dir -Force

    $exe = Get-ChildItem $dir -Filter "VEXOR.exe" -Recurse |
        Select-Object -First 1

    if (-not $exe) {
        throw "VEXOR.exe not found."
    }

    Write-Host "Starting VEXOR..."

    Start-Process $exe.FullName

    Write-Host "VEXOR STARTED." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
}