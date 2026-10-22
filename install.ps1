# install.ps1 — Apply forgegrid slicer customizations to a Cura 5.9 base distribution
# Usage: .\install.ps1 -DistDir "C:\path\to\dist\forgegrid-slicer"

param(
    [Parameter(Mandatory=$true)]
    [string]$DistDir
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path "$DistDir\forgegrid-slicer.exe")) {
    Write-Error "Could not find forgegrid-slicer.exe in '$DistDir'. Please provide the correct dist directory."
    exit 1
}

$RepoRoot = $PSScriptRoot

Write-Host "Applying forgegrid slicer customizations..." -ForegroundColor Cyan

# 1. Printer definitions
Write-Host "  -> Printer definitions"
Copy-Item "$RepoRoot\definitions\*" "$DistDir\share\cura\resources\definitions\" -Force

# 2. Extruder definitions
Write-Host "  -> Extruder definitions"
Copy-Item "$RepoRoot\extruders\*" "$DistDir\share\cura\resources\extruders\" -Force

# 3. Quality profiles
Write-Host "  -> Quality profiles"
$qualityDir = "$DistDir\share\cura\resources\quality\forgegrid"
if (-not (Test-Path $qualityDir)) { New-Item -ItemType Directory -Path $qualityDir -Force | Out-Null }
Copy-Item "$RepoRoot\quality\forgegrid\*" $qualityDir -Force

# 4. Marketplace stub plugin
Write-Host "  -> Marketplace stub plugin"
$mpDir = "$DistDir\share\cura\plugins\Marketplace"
if (-not (Test-Path $mpDir)) { New-Item -ItemType Directory -Path $mpDir -Force | Out-Null }
Copy-Item "$RepoRoot\plugins\Marketplace\*" $mpDir -Force

# 5. UpdateChecker modifications
Write-Host "  -> UpdateChecker modifications"
Copy-Item "$RepoRoot\plugins\UpdateChecker\*.py" "$DistDir\share\uranium\plugins\UpdateChecker\" -Force

# 6. QML patches
Write-Host "  -> QML patches"
$qmlMap = @{
    "AddUltimakerOrThirdPartyPrinter.qml" = "share\cura\resources\qml\WelcomePages"
    "AddUltimakerOrThirdPartyPrinterStack.qml" = "share\cura\resources\qml\WelcomePages"
    "AddThirdPartyPrinter.qml" = "share\cura\resources\qml\WelcomePages"
    "AddLocalPrinterScrollView.qml" = "share\cura\resources\qml\WelcomePages"
    "Actions.qml" = "share\cura\resources\qml"
    "FileMenu.qml" = "share\cura\resources\qml\Menus"
    "AskOpenAsProjectOrModelsDialog.qml" = "share\cura\resources\qml\Dialogs"
    "UCPDialog.qml" = "share\cura\plugins\3MFWriter"
}
foreach ($file in $qmlMap.Keys) {
    $dest = "$DistDir\$($qmlMap[$file])"
    Copy-Item "$RepoRoot\qml-patches\$file" "$dest\$file" -Force
}

# 7. Theme
Write-Host "  -> Theme files"
if (Test-Path "$RepoRoot\theme") {
    Copy-Item "$RepoRoot\theme\*" "$DistDir\share\cura\resources\themes\forgegrid\" -Recurse -Force
}

# 8. Splash screen
if (Test-Path "$RepoRoot\branding\CuraSplashScreen.py") {
    Write-Host "  -> Splash screen"
    Copy-Item "$RepoRoot\branding\CuraSplashScreen.py" "$DistDir\cura\UI\CuraSplashScreen.py" -Force
}

Write-Host ""
Write-Host "Done! All customizations applied to: $DistDir" -ForegroundColor Green
