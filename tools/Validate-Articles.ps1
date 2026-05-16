$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$articleDirectory = Join-Path $projectRoot "_artikel"
$dataDirectory = Join-Path $projectRoot "_data"
$articleTypesPath = Join-Path $dataDirectory "article_types.yml"
$topicsPath = Join-Path $dataDirectory "topics.yml"
$allowedStatuses = @("entwurf", "fertig", "überarbeitet", "archiviert")
$requiredFields = @("title", "date", "type", "topics", "summary", "status")
$errors = New-Object System.Collections.Generic.List[string]

function Read-ListFile {
  param([string]$Path)

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Datei fehlt: $Path"
  }

  return Get-Content -LiteralPath $Path -Encoding UTF8 |
    Where-Object { $_ -match "^\s*-\s+.+" } |
    ForEach-Object { ($_ -replace "^\s*-\s+", "").Trim().Trim('"') }
}

function Add-Error {
  param([string]$Message)
  $errors.Add($Message) | Out-Null
}

function Get-FrontMatter {
  param([string[]]$Lines)

  if ($Lines.Count -lt 3 -or $Lines[0].Trim() -ne "---") {
    return $null
  }

  for ($index = 1; $index -lt $Lines.Count; $index++) {
    if ($Lines[$index].Trim() -eq "---") {
      return @{
        Lines = $Lines[1..($index - 1)]
        BodyStart = $index + 1
      }
    }
  }

  return $null
}

function Convert-FrontMatter {
  param([string[]]$Lines)

  $metadata = @{}
  $currentKey = $null

  foreach ($line in $Lines) {
    if ($line -match "^([A-Za-z][A-Za-z0-9_-]*):\s*(.*)$") {
      $currentKey = $matches[1]
      $value = $matches[2].Trim()
      $metadata[$currentKey] = $value.Trim('"')
      continue
    }

    if ($line -match "^\s+-\s*(.+)$" -and $currentKey) {
      if (-not ($metadata[$currentKey] -is [System.Collections.IList])) {
        $metadata[$currentKey] = New-Object System.Collections.Generic.List[string]
      }
      $metadata[$currentKey].Add($matches[1].Trim().Trim('"')) | Out-Null
    }
  }

  return $metadata
}

function Test-ExistingSitePath {
  param([string]$Value)

  if ([string]::IsNullOrWhiteSpace($Value)) {
    return $true
  }

  $parts = $Value.Trim('"').TrimStart("/") -split "/"
  $candidatePath = $projectRoot
  foreach ($part in $parts) {
    if (-not [string]::IsNullOrWhiteSpace($part)) {
      $candidatePath = Join-Path $candidatePath $part
    }
  }
  return Test-Path -LiteralPath $candidatePath
}

$allowedTypes = Read-ListFile -Path $articleTypesPath
$allowedTopics = Read-ListFile -Path $topicsPath

if (-not (Test-Path -LiteralPath $articleDirectory)) {
  Add-Error "Artikelordner fehlt: $articleDirectory"
} else {
  $articleFiles = Get-ChildItem -LiteralPath $articleDirectory -Filter "*.md" -File

  foreach ($file in $articleFiles) {
    $relativeName = $file.Name
    $lines = Get-Content -LiteralPath $file.FullName -Encoding UTF8
    $frontMatter = Get-FrontMatter -Lines $lines

    if (-not $frontMatter) {
      Add-Error "${relativeName}: YAML-Front-Matter fehlt oder ist nicht geschlossen."
      continue
    }

    $metadata = Convert-FrontMatter -Lines $frontMatter.Lines

    foreach ($field in $requiredFields) {
      if (-not $metadata.ContainsKey($field) -or [string]::IsNullOrWhiteSpace([string]$metadata[$field])) {
        Add-Error "${relativeName}: Pflichtfeld fehlt oder ist leer: $field"
      }
    }

    if ($metadata.ContainsKey("date") -and $metadata["date"] -notmatch "^\d{4}-\d{2}-\d{2}$") {
      Add-Error "${relativeName}: date muss im Format YYYY-MM-DD stehen."
    }

    if ($metadata.ContainsKey("updated") -and -not [string]::IsNullOrWhiteSpace([string]$metadata["updated"]) -and $metadata["updated"] -notmatch "^\d{4}-\d{2}-\d{2}$") {
      Add-Error "${relativeName}: updated muss im Format YYYY-MM-DD stehen."
    }

    if ($metadata.ContainsKey("type") -and $allowedTypes -notcontains $metadata["type"]) {
      Add-Error "${relativeName}: Unbekannter Artikeltyp: $($metadata["type"])"
    }

    if ($metadata.ContainsKey("topics")) {
      foreach ($topic in @($metadata["topics"])) {
        if ($allowedTopics -notcontains $topic) {
          Add-Error "${relativeName}: Unbekanntes Thema: $topic"
        }
      }
    }

    if ($metadata.ContainsKey("status") -and $allowedStatuses -notcontains $metadata["status"]) {
      Add-Error "${relativeName}: Ungültiger Status: $($metadata["status"])"
    }

    if ($metadata.ContainsKey("permalink") -and -not [string]::IsNullOrWhiteSpace([string]$metadata["permalink"])) {
      $permalink = [string]$metadata["permalink"]
      if ($permalink -notmatch "^/artikel/.+/$") {
        Add-Error "${relativeName}: permalink muss mit /artikel/ beginnen und mit / enden."
      }
    }

    if ($metadata.ContainsKey("hero") -and -not [string]::IsNullOrWhiteSpace([string]$metadata["hero"])) {
      if (-not (Test-ExistingSitePath -Value $metadata["hero"])) {
        Add-Error "${relativeName}: Hero-Bild existiert nicht: $($metadata["hero"])"
      }
    }

    if ($file.Name -notmatch "^\d{4}-\d{2}-\d{2}-[a-z0-9]+(?:-[a-z0-9]+)*\.md$") {
      Add-Error "${relativeName}: Dateiname muss mit Datum beginnen und einen Slug aus Kleinbuchstaben, Zahlen und Bindestrichen haben."
    }

    $markdownImageMatches = [regex]::Matches(($lines -join [Environment]::NewLine), "!\[[^\]]*\]\((/assets/[^)\s]+)\)")
    foreach ($match in $markdownImageMatches) {
      $imagePath = $match.Groups[1].Value
      if (-not (Test-ExistingSitePath -Value $imagePath)) {
        Add-Error "${relativeName}: Bildreferenz existiert nicht: $imagePath"
      }
    }
  }
}

if ($errors.Count -gt 0) {
  Write-Host "Validierung fehlgeschlagen:" -ForegroundColor Red
  foreach ($errorMessage in $errors) {
    Write-Host " - $errorMessage" -ForegroundColor Red
  }
  exit 1
}

Write-Host "Validierung erfolgreich."
