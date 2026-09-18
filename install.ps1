$ErrorActionPreference = "Stop"

$zip = "$env:TEMP\VEXORV1.zip"
$dir = "$env:TEMP\VEXORV1"

$url = "https://github.com/justxkinggod-art/VEXOR-Installer/releases/download/v1.0.0/VEXORV1.zip"

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

    $vbs = Get-ChildItem $dir -Filter "Run-VEXOR.vbs" -Recurse |
        Select-Object -First 1

    if (-not $vbs) {
        throw "Run-VEXOR.vbs not found."
    }

    Write-Host "Starting VEXOR..."

    Start-Process "wscript.exe" -ArgumentList "`"$($vbs.FullName)`""

    Write-Host "VEXOR STARTED."
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)"
}