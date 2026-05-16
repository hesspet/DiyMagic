param(
  [Parameter(Mandatory = $true)]
  [string]$Title,

  [Parameter(Mandatory = $true)]
  [string]$Type,

  [Parameter(Mandatory = $true)]
  [string]$Topics,

  [Parameter(Mandatory = $true)]
  [string]$Summary,

  [datetime]$Date = (Get-Date)
)

$ErrorActionPreference = "Stop"

function Convert-ToSlug {
  param([string]$Value)

  $slug = $Value.ToLowerInvariant()
  $slug = $slug.Replace("ä", "ae").Replace("ö", "oe").Replace("ü", "ue").Replace("ß", "ss")
  $slug = $slug -replace "[^a-z0-9]+", "-"
  $slug = $slug -replace "-+", "-"
  return $slug.Trim("-")
}

function Escape-YamlValue {
  param([string]$Value)
  return $Value.Replace("\", "\\").Replace('"', '\"')
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$dateText = $Date.ToString("yyyy-MM-dd")
$slug = Convert-ToSlug -Value $Title

if ([string]::IsNullOrWhiteSpace($slug)) {
  throw "Aus dem Titel konnte kein gültiger Slug erzeugt werden."
}

$articleDirectory = Join-Path $projectRoot "_artikel"
$imageDirectory = Join-Path (Join-Path (Join-Path (Join-Path $projectRoot "assets") "images") "articles") $slug
$articlePath = Join-Path $articleDirectory "$dateText-$slug.md"

if (Test-Path -LiteralPath $articlePath) {
  throw "Der Artikel existiert bereits: $articlePath"
}

New-Item -ItemType Directory -Force -Path $articleDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $imageDirectory | Out-Null

$topicItems = $Topics.Split(",") | ForEach-Object { $_.Trim() } | Where-Object { $_ }
if ($topicItems.Count -eq 0) {
  throw "Mindestens ein Thema ist erforderlich."
}

$topicYaml = ($topicItems | ForEach-Object { "  - $_" }) -join [Environment]::NewLine
$escapedTitle = Escape-YamlValue -Value $Title
$escapedType = Escape-YamlValue -Value $Type
$escapedSummary = Escape-YamlValue -Value $Summary

$content = @"
---
layout: artikel
title: "$escapedTitle"
date: $dateText
updated:
type: "$escapedType"
topics:
$topicYaml
summary: "$escapedSummary"
hero:
status: "entwurf"
difficulty:
permalink: /artikel/$slug.html
---

## Worum geht es?

"@

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($articlePath, $content, $utf8NoBom)

Write-Host "Artikel erzeugt: $articlePath"
Write-Host "Bildordner erzeugt: $imageDirectory"
