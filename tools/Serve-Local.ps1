$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $PSScriptRoot "Validate-Articles.ps1")

Set-Location -LiteralPath $projectRoot

if ((Test-Path -LiteralPath (Join-Path $projectRoot "Gemfile")) -and (Get-Command "bundle" -ErrorAction SilentlyContinue)) {
  Write-Host "Lokale Vorschau startet unter http://localhost:4000"
  & bundle exec jekyll serve
  exit $LASTEXITCODE
}

if (Get-Command "jekyll" -ErrorAction SilentlyContinue) {
  Write-Host "Lokale Vorschau startet unter http://localhost:4000"
  & jekyll serve
  exit $LASTEXITCODE
}

Write-Host "Jekyll ist lokal nicht verfügbar. Installiere Ruby und Jekyll oder nutze den GitHub-Actions-Build."
