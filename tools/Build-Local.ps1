$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $PSScriptRoot "Validate-Articles.ps1")

Set-Location -LiteralPath $projectRoot

if ((Test-Path -LiteralPath (Join-Path $projectRoot "Gemfile")) -and (Get-Command "bundle" -ErrorAction SilentlyContinue)) {
  & bundle exec jekyll build
  exit $LASTEXITCODE
}

if (Get-Command "jekyll" -ErrorAction SilentlyContinue) {
  & jekyll build
  exit $LASTEXITCODE
}

Write-Host "Jekyll ist lokal nicht verfügbar. Die Artikelvalidierung war erfolgreich; der GitHub-Actions-Build bleibt maßgeblich."
