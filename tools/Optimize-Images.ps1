param(
  [Parameter(Mandatory = $true)]
  [string]$Source,

  [Parameter(Mandatory = $true)]
  [string]$Target,

  [int]$MaxWidth = 1600,

  [switch]$Overwrite
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command "magick" -ErrorAction SilentlyContinue)) {
  throw "ImageMagick wurde nicht gefunden. Bitte installiere ImageMagick und stelle sicher, dass 'magick' im PATH verfügbar ist."
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourcePath = Resolve-Path -LiteralPath $Source
$targetPath = Join-Path $projectRoot $Target

New-Item -ItemType Directory -Force -Path $targetPath | Out-Null

$extensions = @("*.jpg", "*.jpeg", "*.png", "*.webp")
$images = foreach ($extension in $extensions) {
  Get-ChildItem -LiteralPath $sourcePath -Filter $extension -File
}

foreach ($image in $images) {
  $targetFile = Join-Path $targetPath "$($image.BaseName).webp"

  if ((Test-Path -LiteralPath $targetFile) -and -not $Overwrite) {
    Write-Host "Übersprungen, Ziel existiert bereits: $targetFile"
    continue
  }

  & magick $image.FullName -auto-orient -strip -resize "${MaxWidth}x>" -quality 82 $targetFile
  if ($LASTEXITCODE -ne 0) {
    throw "Bild konnte nicht optimiert werden: $($image.FullName)"
  }

  Write-Host "Optimiert: $targetFile"
}
