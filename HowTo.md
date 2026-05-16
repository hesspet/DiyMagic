# HowTo: Dokumente und Artikel pflegen

## 1. Artikel anlegen

In PowerShell im Projektordner ausführen:

```powershell
.\tools\New-Article.ps1 `
  -Title "Titel des Artikels" `
  -Type "Anleitung" `
  -Topics "Markdown,GitHub Pages" `
  -Summary "Kurze Zusammenfassung des Artikels."
```

Das erzeugt:

```text
_artikel/YYYY-MM-DD-titel-des-artikels.md
assets/images/articles/titel-des-artikels/
```

## 2. Metadaten prüfen

Am Anfang jeder Artikeldatei steht der YAML-Header. Wichtig sind diese Pflichtfelder:

```yaml
title: "Titel"
date: 2026-05-16
type: "Anleitung"
topics:
  - Markdown
summary: "Kurze Zusammenfassung."
status: "entwurf"
```

Wenn der Artikel öffentlich erscheinen soll, setze:

```yaml
status: "fertig"
```

Artikel mit `status: "entwurf"` erscheinen nicht auf Startseite, Archiv, Themenseite oder Suche.

## 3. Typ eintragen

Der Wert bei `type` muss in dieser Datei vorhanden sein:

```text
_data/article_types.yml
```

Erlaubte Startwerte sind:

```text
Anleitung
Bericht
Projekt
Notiz
Referenz
Erfahrungsbericht
```

## 4. Themen eintragen

Jedes Thema aus dem Artikel muss in dieser Datei stehen:

```text
_data/topics.yml
```

Wenn du ein neues Thema verwenden willst, trage es dort zuerst ein, zum Beispiel:

```yaml
- 3D-Druck
```

Dann darf es im Artikel verwendet werden:

```yaml
topics:
  - 3D-Druck
```

## 5. Bilder ablegen

Bilder zum Artikel gehören hierhin:

```text
assets/images/articles/<artikel-slug>/
```

Im Artikel referenzierst du sie so:

```markdown
![Beschreibung des Bildes]({{ '/assets/images/articles/artikel-slug/bild.webp' | relative_url }})
```

## 6. Artikel schreiben

Unterhalb des YAML-Headers schreibst du normalen Markdown-Text:

```markdown
## Worum geht es?

Text ...

## Material

- Teil 1
- Teil 2

## Vorgehen

1. Schritt eins
2. Schritt zwei
```

## 7. Validieren

Vor dem Commit ausführen:

```powershell
.\tools\Validate-Articles.ps1
```

Wenn Fehler gemeldet werden, zuerst korrigieren.

## 8. Optional lokal bauen

Falls Jekyll installiert ist:

```powershell
.\tools\Build-Local.ps1
```

Ohne Jekyll reicht für den Start die Validierung; der eigentliche Build läuft später über GitHub Actions.
