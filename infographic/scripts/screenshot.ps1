#Requires -Version 5.1
<#
.SYNOPSIS
  Renders a local HTML file to PNG using Chrome or Edge headless (no Node / Playwright).

.DESCRIPTION
  Uses Chromium's built-in --screenshot with --force-device-scale-factor for Retina-like output.
  Requires Google Chrome or Microsoft Edge installed on Windows.

.PARAMETER InputHtml
  Path to the self-contained HTML file (file:// will be used).

.PARAMETER OutputPng
  Path for the output PNG.

.PARAMETER ScaleFactor
  Device pixel ratio (default 3). Physical width ≈ ViewportWidth * ScaleFactor.

.PARAMETER ViewportWidth
  CSS viewport width in px (default 750).

.PARAMETER ViewportHeight
  Viewport height in px (default 9000). Increase if the bottom of the page is clipped.

.EXAMPLE
  .\screenshot.ps1 .\infographic.html .\out.png 3 750
  .\screenshot.ps1 .\infographic.html .\out.png 3 750 12000
#>
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$InputHtml,
  [Parameter(Mandatory = $true, Position = 1)]
  [string]$OutputPng,
  [Parameter(Position = 2)]
  [int]$ScaleFactor = 3,
  [Parameter(Position = 3)]
  [int]$ViewportWidth = 750,
  [Parameter(Position = 4)]
  [int]$ViewportHeight = 9000
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Find-ChromiumExe {
  $candidates = @(
    "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "${env:LocalAppData}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe"
  )
  foreach ($p in $candidates) {
    if (Test-Path -LiteralPath $p) { return $p }
  }
  return $null
}

if (-not (Test-Path -LiteralPath $InputHtml)) {
  Write-Error "File not found: $InputHtml"
}

$browser = Find-ChromiumExe
if (-not $browser) {
  Write-Error "Neither Google Chrome nor Microsoft Edge found under Program Files. Install one of them, or add chrome.exe/msedge.exe to PATH."
}

$inAbs = (Resolve-Path -LiteralPath $InputHtml).Path
$outAbs = [System.IO.Path]::GetFullPath($OutputPng)
$outDir = [System.IO.Path]::GetDirectoryName($outAbs)
if (-not (Test-Path -LiteralPath $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

# file:/// URI for Chromium (handles spaces and non-ASCII)
$fileUri = [System.Uri]::new($inAbs).AbsoluteUri

$argList = @(
  "--headless=new",
  "--disable-gpu",
  "--hide-scrollbars",
  "--force-device-scale-factor=$ScaleFactor",
  "--window-size=${ViewportWidth},${ViewportHeight}",
  "--screenshot=$outAbs",
  "--run-all-compositor-stages-before-draw",
  "--virtual-time-budget=8000",
  $fileUri
)

$proc = Start-Process -FilePath $browser -ArgumentList $argList -Wait -PassThru -NoNewWindow
if ($proc.ExitCode -ne 0) {
  Write-Error "Browser exited with code $($proc.ExitCode)."
}

if (-not (Test-Path -LiteralPath $outAbs)) {
  Write-Error "Screenshot was not written: $outAbs"
}

$len = (Get-Item -LiteralPath $outAbs).Length
Write-Host "OK $outAbs"
Write-Host ("  scale={0}x width={1}px viewport={2}x{3} (~{4} KB)" -f $ScaleFactor, $ViewportWidth, $ViewportWidth, $ViewportHeight, [math]::Round($len / 1024))
