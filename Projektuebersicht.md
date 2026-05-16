# Projektübersicht: DiyMagic

## Ziel

**DiyMagic** ist ein statisches, dauerhaft gut wartbares Artikelarchiv für Anleitungen, Berichte, Projektnotizen und Referenzen.

Das Projekt soll mit **GitHub Pages** veröffentlicht werden. Die Inhalte liegen als **Markdown-Dateien** im Repository. Jeder Artikel besitzt strukturierte Metadaten im **YAML-Header**. Bilder werden im Repository verwaltet. Übersichtsseiten, Archivseiten und eine clientseitige Suche werden automatisch aus den Markdown-Dateien erzeugt.

Das Projekt ist bewusst **kein klassisches Blogsystem** mit Datenbank, Admin-Backend oder Serverlogik. Es ist ein statisches Wissensarchiv.

Repository-Name:

```text
DiyMagic
```

Primäre Zielplattform für Entwicklung und lokale Hilfsskripte:

```text
Windows
```

Lokale Codegenerierung und Projektpflege:

```text
Codex lokal
```

---

## Leitentscheidungen

### Hosting

- GitHub Pages als Hoster.
- Veröffentlichung aus dem GitHub-Repository.
- Kein eigener Server.
- Keine Datenbank.
- Keine serverseitige Suche.
- Keine Google-Abhängigkeit.
- Kein externer Bloghoster.
- Inhalte müssen auch ohne GitHub langfristig nutzbar bleiben.

### Inhalt

- Markdown-Dateien sind die Quelle.
- YAML-Front-Matter enthält Metadaten.
- Artikeldateien müssen als UTF-8 ohne BOM gespeichert werden, damit Jekyll den YAML-Header zuverlässig erkennt.
- Bilder liegen im Repository.
- Artikel werden als statische HTML-Seiten generiert.
- Übersichtsseiten werden automatisch erzeugt.
- Suche läuft vollständig im Browser.

### Projektcharakter

Die Website soll nicht primär wie ein chronologischer Blog wirken, sondern wie ein persönliches Archiv für:

- Anleitungen
- Berichte
- Projektbeschreibungen
- Werkstattnotizen
- technische Referenzen
- Zauber-/Requisitenideen
- DIY Zauberprojekte
- Software-/Elektroniknotizen

---

## Technische Basis

### Generator

Empfohlene Basis:

```text
Jekyll
```

Begründung:

- Jekyll ist der klassische und gut unterstützte Weg für GitHub Pages.
- Markdown und YAML-Front-Matter sind direkt vorgesehen.
- Collections eignen sich gut für Artikel, die keine klassischen Blogposts sind.
- Liquid-Templates können automatische Übersichten erzeugen.
- Für den Einstieg reichen Jekyll + Plain JavaScript aus.

### Suche

Startlösung:

```text
search.json + assets/js/search.js
```

Der Suchindex wird beim Jekyll-Build als statische JSON-Datei erzeugt. Die Suche läuft im Browser.

Keine externe Suchmaschine verwenden.

Spätere optionale Ausbaustufe:

```text
Pagefind
```

Pagefind kann später ergänzt werden, falls die Volltextsuche besser werden soll. Für den Start soll jedoch eine einfache lokale JavaScript-Suche ausreichen.

### JavaScript

Für die erste Version:

- Kein Framework.
- Kein React.
- Kein Vue.
- Kein Angular.
- Kein Node-Build-Prozess.
- Nur Plain JavaScript.
- `assets/js/site-version.js` prüft eine generierte `site-version.json` und lädt die Seite nach einem neuen Deploy einmal neu, damit Browser-Caches nicht dauerhaft alte Übersichtsseiten anzeigen.

### CSS

Für die erste Version:

- Eigenes CSS.
- Keine CSS-Framework-Abhängigkeit.
- Saubere, ruhige, lesbare Gestaltung.
- Responsive Layout für Desktop, Tablet und Smartphone.

---

## Repository-Struktur

Codex soll folgende Zielstruktur erzeugen:

```text
DiyMagic/
├─ README.md
├─ _config.yml
├─ .gitignore
├─ index.md
├─ archiv.md
├─ themen.md
├─ suche.md
├─ ueber.md
├─ search.json
├─ _artikel/
│  └─ 2026-05-16-beispiel-artikel.md
├─ _layouts/
│  ├─ default.html
│  ├─ artikel.html
│  ├─ page.html
│  └─ home.html
├─ _includes/
│  ├─ header.html
│  ├─ footer.html
│  ├─ article-card.html
│  ├─ tag-list.html
│  └─ navigation.html
├─ _data/
│  ├─ article_types.yml
│  ├─ topics.yml
│  └─ site_navigation.yml
├─ assets/
│  ├─ css/
│  │  └─ site.css
│  ├─ js/
│  │  └─ search.js
│  └─ images/
│     ├─ articles/
│     │  └─ beispiel-artikel/
│     │     ├─ hero.webp
│     │     └─ schritt-01.webp
│     └─ site/
│        └─ placeholder.webp
├─ tools/
│  ├─ New-Article.ps1
│  ├─ Validate-Articles.ps1
│  ├─ Optimize-Images.ps1
│  ├─ Build-Local.ps1
│  └─ Serve-Local.ps1
└─ .github/
   └─ workflows/
      └─ pages.yml
```

---

## URL-Konzept

Die Artikel sollen unter einer stabilen URL erreichbar sein.

Beispiel:

```text
/artikel/gartenhaus-fundament-ausrichten.html
```

Nicht erwünscht sind automatisch generierte URLs, die später schwer zu ändern sind.

Jeder Artikel kann im YAML-Header optional ein eigenes `permalink` erhalten. Wenn kein Permalink angegeben ist, soll Jekyll aus dem Dateinamen einen URL-Pfad erzeugen.

Empfohlene Regel:

```yaml
permalink: /artikel/<sprechender-slug>.html
```

Beispiel:

```yaml
permalink: /artikel/gartenhaus-fundament-ausrichten.html
```

Begründung:

Artikelbilder werden in Markdown Typora-kompatibel relativ aus `_artikel` heraus verlinkt, zum Beispiel:

```markdown
![Ausgerichtete Gehwegplatten](./../assets/images/articles/gartenhaus-fundament/schritt-01.webp)
```

Damit derselbe Link lokal in Typora und auf GitHub Pages funktioniert, werden Artikelseiten unter `/artikel/<slug>.html` statt unter `/artikel/<slug>/` veröffentlicht. Von `/artikel/<slug>.html` aus zeigt `./../assets/...` korrekt auf `/assets/...`, auch bei einer Projektseite mit `baseurl: "/DiyMagic"`.

---

## Jekyll-Konfiguration

Datei:

```text
_config.yml
```

Zielinhalt ungefähr:

```yaml
title: "DiyMagic"
description: "Anleitungen, Berichte und Projektnotizen"
url: ""
baseurl: ""

lang: "de-DE"
timezone: "Europe/Berlin"

markdown: kramdown
future: true

collections:
  artikel:
    output: true
    permalink: /artikel/:name.html

defaults:
  - scope:
      path: ""
      type: "artikel"
    values:
      layout: "artikel"
  - scope:
      path: ""
    values:
      layout: "page"

exclude:
  - tools/
  - README.md
  - Gemfile
  - Gemfile.lock
  - node_modules/
  - vendor/
```

Hinweise:

- `url` und `baseurl` sollen später angepasst werden.
- Wenn das Repository als Benutzer-/Organisationsseite veröffentlicht wird, kann `baseurl` leer bleiben.
- Wenn es als Projektseite unter `https://<user>.github.io/DiyMagic/` läuft, muss `baseurl` auf `/DiyMagic` gesetzt werden.
- Alle internen Links müssen `relative_url` verwenden, damit beide Varianten funktionieren.

---

## Artikel-Collection

Alle Inhaltsseiten liegen in:

```text
_artikel/
```

Dateinamen:

```text
YYYY-MM-DD-sprechender-slug.md
```

Beispiele:

```text
2026-05-16-gartenhaus-fundament-ausrichten.md
2026-06-02-ttgo-display-ble-test.md
2026-07-10-zauberrequisit-aus-holz.md
```

---

## YAML-Front-Matter für Artikel

Jeder Artikel muss folgenden Header haben:

```yaml
---
layout: artikel
title: "Gartenhaus: Fundament ausrichten"
date: 2026-05-16
updated:
type: "Anleitung"
topics:
  - Garten
  - Holzarbeiten
  - Fundament
summary: "Eine Schritt-für-Schritt-Anleitung zum Ausrichten eines kleinen Gartenhausfundaments."
hero: "/assets/images/articles/gartenhaus-fundament/hero.webp"
status: "fertig"
difficulty: "mittel"
permalink: /artikel/gartenhaus-fundament-ausrichten.html
---
```

### Pflichtfelder

- `title`
- `date`
- `type`
- `topics`
- `summary`
- `status`

### Optionale Felder

- `updated`
- `hero`
- `difficulty`
- `permalink`
- `material`
- `tools`
- `platforms`
- `series`
- `visibility`
- `source`
- `related`

---

## Artikeltypen

Datei:

```text
_data/article_types.yml
```

Vorschlag:

```yaml
- Anleitung
- Bericht
- Projekt
- Notiz
- Referenz
- Erfahrungsbericht
```

Bedeutung:

| Typ | Bedeutung |
|---|---|
| Anleitung | Schritt-für-Schritt-Beschreibung |
| Bericht | Erfahrungs- oder Ergebnisbericht |
| Projekt | Längeres Vorhaben mit mehreren Teilen |
| Notiz | Kurzer Eintrag oder Gedanke |
| Referenz | Nachschlageartikel |
| Erfahrungsbericht | subjektive Bewertung oder Rückblick |

---

## Themenliste

Datei:

```text
_data/topics.yml
```

Vorschlag für Startwerte:

```yaml
- Arduino
- BLE
- ESP32
- Elektronik
- Garten
- GitHub Pages
- Holzarbeiten
- Jekyll
- Lego
- Markdown
- Requisitenbau
- Software
- Windows
- Zauberei
```

Ziel:

- Kontrollierte Schreibweise.
- Keine zufälligen Varianten wie `Holz`, `Holzarbeit`, `Holzarbeiten`.
- Validierung durch lokales PowerShell-Skript.

---

## Statuswerte

Empfohlene Statuswerte:

```text
entwurf
fertig
überarbeitet
archiviert
```

Bedeutung:

| Status | Bedeutung |
|---|---|
| entwurf | noch nicht fertig, normalerweise nicht veröffentlichen |
| fertig | veröffentlichbar |
| überarbeitet | bestehender Artikel wurde aktualisiert |
| archiviert | historisch interessant, aber möglicherweise veraltet |

Für die erste Version dürfen auch Entwürfe im Repository liegen, sollen aber auf Übersichtsseiten optional ausgeblendet werden können.

---

## Layouts

### `_layouts/default.html`

Basislayout für alle Seiten.

Aufgaben:

- HTML-Grundstruktur.
- `<html lang="de">`.
- `<meta charset="utf-8">`.
- Viewport-Meta-Tag.
- Seitentitel aus `page.title` und `site.title`.
- Einbindung von `assets/css/site.css`.
- Header und Navigation einbinden.
- Hauptinhalt ausgeben.
- Footer einbinden.

### `_layouts/page.html`

Einfaches Layout für normale Seiten wie `ueber.md`, `archiv.md`, `themen.md`, `suche.md`.

### `_layouts/home.html`

Startseitenlayout.

Aufgaben:

- Begrüßung.
- Kurzbeschreibung.
- neueste Artikel anzeigen.
- wichtige Themen anzeigen.
- Link zur Suche und zum Archiv.

### `_layouts/artikel.html`

Layout für einzelne Artikel.

Aufgaben:

- Titel anzeigen.
- Datum anzeigen.
- Aktualisierungsdatum anzeigen, falls vorhanden.
- Typ anzeigen.
- Themen anzeigen.
- Zusammenfassung anzeigen.
- Hero-Bild anzeigen, falls vorhanden.
- Artikelinhalt ausgeben.
- optionale Felder wie Material, Tools, Plattformen anzeigen.
- Links zu verwandten Artikeln anzeigen, falls vorhanden.

---

## Startseite

Datei:

```text
index.md
```

Ziel:

- Nicht wie ein klassischer Blog wirken.
- Einstieg in das Archiv bieten.
- Die neuesten Artikel anzeigen.
- Themenblöcke zeigen.
- Suchseite prominent verlinken.

Beispielhafte Struktur:

```text
DiyMagic

Anleitungen, Berichte und Projektnotizen zu Zauberei, Requisitenbau,
Holzarbeiten, Garten, Software und Elektronik.

[Suche öffnen] [Archiv anzeigen]

Neueste Artikel
- ...

Themen
- Zauberei
- Requisitenbau
- ESP32
- Holzarbeiten
- Garten
- Software
```

---

## Archivseite

Datei:

```text
archiv.md
```

Ziel:

- Alle veröffentlichten Artikel nach Jahr gruppieren.
- Innerhalb eines Jahres absteigend nach Datum sortieren.
- Pro Eintrag anzeigen:
  - Titel
  - Datum
  - Typ
  - Zusammenfassung
  - Themen

Logik:

```liquid
{% assign artikel_sortiert = site.artikel | sort: "date" | reverse %}
```

Gruppierung nach Jahr:

```liquid
{% assign year = item.date | date: "%Y" %}
```

Codex soll diese Seite als Liquid/Jekyll-Seite umsetzen.

---

## Themenseite

Datei:

```text
themen.md
```

Ziel:

- Alle Themen aus `_data/topics.yml` anzeigen.
- Zu jedem Thema passende Artikel auflisten.
- Themen ohne Artikel entweder ausblenden oder als leer markieren.

Artikel sollen über `item.topics contains topic` gefiltert werden.

Wichtig:

- Themenliste aus `_data/topics.yml` ist die Quelle.
- Artikel sollen nicht automatisch beliebige neue Themen erzeugen.
- Neue Themen müssen bewusst in `_data/topics.yml` ergänzt werden.

---

## Suchseite

Datei:

```text
suche.md
```

Ziel:

- Suchfeld.
- Filter nach Artikeltyp.
- Filter nach Jahr.
- Ergebnisliste.
- Kein externer Suchdienst.
- Keine Tracking-Skripte.
- Keine Google-Suche.

HTML-Grundstruktur:

```html
<input id="search-input" type="search" placeholder="Suchbegriff eingeben..." autocomplete="off">

<select id="type-filter">
  <option value="">Alle Typen</option>
</select>

<select id="year-filter">
  <option value="">Alle Jahre</option>
</select>

<div id="search-results"></div>
```

Die Optionen für Typen und Jahre sollen von JavaScript aus dem Suchindex erzeugt werden.

---

## Suchindex

Datei:

```text
search.json
```

Diese Datei wird von Jekyll mit Liquid erzeugt.

Zielstruktur:

```json
[
  {
    "title": "Gartenhaus: Fundament ausrichten",
    "url": "/artikel/gartenhaus-fundament-ausrichten.html",
    "date": "2026-05-16",
    "year": "2026",
    "type": "Anleitung",
    "summary": "Eine Schritt-für-Schritt-Anleitung...",
    "topics": ["Garten", "Holzarbeiten", "Fundament"],
    "content": "Ausgangslage Ich wollte ein kleines Gartenhaus..."
  }
]
```

Liquid-Vorlage:

```liquid
---
layout: null
---

[
{% assign artikel_sortiert = site.artikel | where_exp: "item", "item.status != 'entwurf'" | sort: "date" | reverse %}
{% for item in artikel_sortiert %}
  {
    "title": {{ item.title | jsonify }},
    "url": {{ item.url | relative_url | jsonify }},
    "date": {{ item.date | date: "%Y-%m-%d" | jsonify }},
    "year": {{ item.date | date: "%Y" | jsonify }},
    "type": {{ item.type | default: "Artikel" | jsonify }},
    "summary": {{ item.summary | default: "" | jsonify }},
    "topics": {{ item.topics | jsonify }},
    "content": {{ item.content | strip_html | normalize_whitespace | jsonify }}
  }{% unless forloop.last %},{% endunless %}
{% endfor %}
]
```

Hinweis:

Für sehr viele oder sehr lange Artikel kann `content` später gekürzt oder entfernt werden. Für den Start ist Volltextsuche über `content` in Ordnung.

---

## Clientseitige Suche

Datei:

```text
assets/js/search.js
```

Anforderungen:

- Lädt `search.json`.
- Baut Typfilter und Jahresfilter automatisch.
- Durchsucht:
  - Titel
  - Zusammenfassung
  - Themen
  - Typ
  - Inhalt
- Gewichtung:
  - Treffer im Titel zählen stärker.
  - Treffer in Zusammenfassung zählen stärker als Treffer im Volltext.
  - Themen zählen stärker als Volltext.
- Ergebnisliste maximal 50 Einträge anzeigen.
- Bei leerer Suche die neuesten 20 Artikel anzeigen.
- Keine externen JavaScript-Abhängigkeiten.
- Muss auch funktionieren, wenn die Site unter `/DiyMagic/` läuft.

Wichtig für `baseurl`:

In `suche.md` soll ein Data-Attribut gesetzt werden:

```html
<div id="search-config" data-search-url="{{ '/search.json' | relative_url }}"></div>
```

`search.js` soll diese URL auslesen und nicht fest `/search.json` annehmen.

---

## Bilder im Repository

Bilder sollen im Repository liegen.

Empfohlene Struktur:

```text
assets/images/articles/<artikel-slug>/
├─ hero.webp
├─ schritt-01.webp
├─ schritt-02.webp
└─ detail-01.webp
```

Beispiel:

```text
assets/images/articles/gartenhaus-fundament/
├─ hero.webp
├─ schritt-01.webp
└─ schritt-02.webp
```

Im Markdown:

```markdown
![Ausgerichtete Gehwegplatten](./../assets/images/articles/gartenhaus-fundament/schritt-01.webp)
```

Diese relative Schreibweise ist bewusst gewählt, damit Typora die Bilder direkt aus dem Repository anzeigen kann. Artikel-Permalinks müssen deshalb auf `/artikel/<slug>.html` enden. Absolute Markdown-Bildpfade wie `/assets/...` sollen in neuen Artikeln nicht mehr verwendet werden.

---

## Bildregeln

Empfehlung:

- Blog-/Artikelbilder maximal ca. 1600 px Breite.
- Für Hero-Bilder ca. 1600 × 900 px.
- Dateiformat bevorzugt `.webp`.
- Alternativ `.jpg` für Fotos.
- `.png` nur für Screenshots, Diagramme oder Bilder mit Transparenz.
- Keine riesigen Originalfotos ins Repository übernehmen.
- Originalbilder lokal außerhalb des Repositories sichern.
- Für veröffentlichte Website nur optimierte Bilder einchecken.

---

## Lokale Automatismen für Windows

Alle lokalen Hilfsskripte sollen in `tools/` liegen und als PowerShell-Skripte umgesetzt werden.

Keine Beta- oder Preview-Abhängigkeiten verwenden.

### `tools/New-Article.ps1`

Zweck:

- Neuen Artikel anlegen.
- Dateinamen aus Datum und Slug erzeugen.
- YAML-Header erzeugen.
- Bildordner erzeugen.
- Optional Hero-Platzhalter kopieren.

Aufrufbeispiel:

```powershell
.\tools\New-Article.ps1 `
  -Title "Gartenhaus: Fundament ausrichten" `
  -Type "Anleitung" `
  -Topics "Garten,Holzarbeiten,Fundament" `
  -Summary "Eine Schritt-für-Schritt-Anleitung zum Ausrichten eines kleinen Gartenhausfundaments."
```

Erzeugt:

```text
_artikel/2026-05-16-gartenhaus-fundament-ausrichten.md
assets/images/articles/gartenhaus-fundament-ausrichten/
```

Das Skript soll:

- aktuelles Datum verwenden, falls kein Datum angegeben wird.
- deutsche Umlaute für Slug normalisieren:
  - ä → ae
  - ö → oe
  - ü → ue
  - ß → ss
- Leerzeichen und Sonderzeichen in Bindestriche umwandeln.
- doppelte Bindestriche vermeiden.
- prüfen, ob Datei bereits existiert.
- bei Konflikt abbrechen.

YAML-Template:

```yaml
---
layout: artikel
title: "<Titel>"
date: <YYYY-MM-DD>
updated:
type: "<Typ>"
topics:
  - <Thema1>
summary: "<Zusammenfassung>"
hero:
status: "entwurf"
difficulty:
permalink: /artikel/<slug>.html
---
```

### `tools/Validate-Articles.ps1`

Zweck:

- Artikel-Metadaten prüfen.
- Einheitliche Qualität sicherstellen.
- Fehler vor Commit finden.

Prüfungen:

- Jede Datei in `_artikel/*.md` hat YAML-Front-Matter.
- Keine Artikeldatei beginnt mit einem UTF-8-BOM.
- Pflichtfelder vorhanden:
  - title
  - date
  - type
  - topics
  - summary
  - status
- `date` ist im Format `YYYY-MM-DD`.
- `updated`, falls vorhanden, ist im Format `YYYY-MM-DD`.
- `type` ist in `_data/article_types.yml` enthalten.
- Alle `topics` sind in `_data/topics.yml` enthalten.
- `status` ist einer der erlaubten Werte.
- `summary` ist nicht leer.
- `permalink`, falls vorhanden, beginnt mit `/artikel/` und endet mit `.html`.
- `hero`, falls gesetzt, zeigt auf eine existierende Datei.
- Bildreferenzen im Markdown zeigen auf existierende Dateien, soweit einfach erkennbar.
- Dateiname beginnt mit Datum.
- Slug im Dateinamen enthält nur Kleinbuchstaben, Zahlen und Bindestriche.

Das Skript soll mit Exitcode `1` abbrechen, wenn Fehler gefunden werden.

### `tools/Optimize-Images.ps1`

Zweck:

- Bilder für Webausgabe vorbereiten.
- Große Bilder verkleinern.
- WebP-Versionen erzeugen.
- Optional Metadaten entfernen.

Empfohlene externe Abhängigkeit:

```text
ImageMagick
```

Skriptverhalten:

- Prüfen, ob `magick` im PATH verfügbar ist.
- Wenn nicht verfügbar, verständliche Fehlermeldung ausgeben.
- Quellordner und Zielordner als Parameter akzeptieren.
- Standardbreite für Artikelbilder: 1600 px.
- Standardbreite für Vorschaubilder: 640 px.
- Originale nicht überschreiben, außer Parameter `-Overwrite` ist gesetzt.
- Zielbilder als `.webp` schreiben.

Aufrufbeispiel:

```powershell
.\tools\Optimize-Images.ps1 `
  -Source ".\_incoming-images\gartenhaus" `
  -Target ".\assets\images\articles\gartenhaus-fundament-ausrichten" `
  -MaxWidth 1600
```

### `tools\Build-Local.ps1`

Zweck:

- Lokalen Build anstoßen.
- Vorher Validierung ausführen.
- Optional Jekyll-Build starten.

Ablauf:

```text
1. Validate-Articles.ps1 ausführen
2. Prüfen, ob Ruby/Bundler/Jekyll verfügbar sind
3. Falls verfügbar: bundle exec jekyll build ausführen
4. Falls nicht verfügbar: Hinweis ausgeben, dass der GitHub-Actions-Build maßgeblich ist
```

Das Skript soll nicht voraussetzen, dass Jekyll lokal installiert ist.

### `tools\Serve-Local.ps1`

Zweck:

- Lokale Vorschau starten.
- Optional, nur wenn Jekyll lokal verfügbar ist.

Ablauf:

```text
1. Validate-Articles.ps1 ausführen
2. bundle exec jekyll serve starten
3. Adresse ausgeben, typischerweise http://localhost:4000
```

Wenn Jekyll lokal nicht verfügbar ist, soll eine klare Installations-/Hinweismeldung erscheinen.

---

## GitHub Actions Workflow

Datei:

```text
.github/workflows/pages.yml
```

Ziel:

- Build und Deployment zu GitHub Pages.
- Auslöser bei Push auf `main`.
- Manuell startbar über `workflow_dispatch`.
- Keine Beta-/Preview-Actions verwenden.
- Stabile offizielle GitHub-Pages-Actions verwenden.
- Vor dem Build Validierung ausführen, soweit PowerShell auf Ubuntu funktioniert.
- Danach Jekyll bauen und nach Pages deployen.

Grobe Struktur:

```yaml
name: Deploy GitHub Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Setup Pages
        uses: actions/configure-pages@v5

      - name: Validate articles
        shell: pwsh
        run: ./tools/Validate-Articles.ps1

      - name: Build with Jekyll
        uses: actions/jekyll-build-pages@v1
        with:
          source: ./
          destination: ./_site

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: ./_site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

Codex soll die tatsächlich aktuell passenden stabilen Action-Versionen prüfen, bevor der Workflow final erzeugt wird. Keine Beta-Versionen verwenden.

---

## README.md

Codex soll eine `README.md` erzeugen mit:

- Projektziel.
- Lokales Erstellen eines Artikels.
- Artikelmetadaten.
- Bilder ablegen.
- Validierung ausführen.
- Lokalen Build starten.
- GitHub Pages aktivieren.
- Deployment per GitHub Actions.
- Hinweise zu `baseurl`.
- Hinweise zu Backups.

---

## `.gitignore`

Empfohlener Inhalt:

```gitignore
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata
.bundle/
vendor/
Gemfile.lock

# Windows
Thumbs.db
Desktop.ini

# Editors
.vscode/
.idea/

# Local incoming images
_incoming-images/
```

Hinweis:

Ob `Gemfile.lock` ignoriert werden soll, hängt von der finalen Jekyll-Strategie ab. Wenn reproduzierbare lokale Builds wichtig werden, kann `Gemfile.lock` eingecheckt werden. Für GitHub Pages mit offizieller Build-Action ist es für den Start nicht zwingend.

---

## Beispielartikel

Codex soll einen Beispielartikel erzeugen:

Datei:

```text
_artikel/2026-05-16-beispiel-artikel.md
```

Inhalt:

```markdown
---
layout: artikel
title: "Beispiel: Eine erste Anleitung"
date: 2026-05-16
updated:
type: "Anleitung"
topics:
  - Markdown
  - GitHub Pages
summary: "Ein Beispielartikel, der Struktur, Metadaten und Bildverwendung demonstriert."
hero:
status: "entwurf"
difficulty: "einfach"
permalink: /artikel/beispiel-erste-anleitung.html
---

## Worum geht es?

Dieser Beispielartikel zeigt die Grundstruktur eines DiyMagic-Artikels.

## Material

- Markdown-Datei
- YAML-Header
- optionales Bild

## Vorgehen

1. Artikel in `_artikel` anlegen.
2. Metadaten ausfüllen.
3. Inhalt in Markdown schreiben.
4. Bilder unter `assets/images/articles/<slug>/` ablegen.
5. Validierung ausführen.

## Ergebnis

Der Artikel erscheint automatisch im Archiv, in der Suche und auf passenden Themenseiten.
```

---

## Design-Richtung

Die Gestaltung soll ruhig, textorientiert und langlebig sein.

Keine verspielte Blog-Optik.

Empfohlene Eigenschaften:

- Lesbare Schriftgrößen.
- Maximalbreite für Text, z. B. 760 px.
- Breitere Container für Übersichtsseiten, z. B. 1100 px.
- Gute Darstellung von Codeblöcken.
- Gute Darstellung von Tabellen.
- Responsive Article Cards.
- Dezente Tags.
- Helle Standarddarstellung.
- Keine externen Webfonts in der ersten Version.
- Keine Tracking-Skripte.
- Keine CDN-Abhängigkeiten.

---

## Artikelkarten

Article Cards sollen auf Startseite, Archiv und Suchergebnissen wiederverwendet werden.

Include:

```text
_includes/article-card.html
```

Inhalt pro Karte:

- optionales Vorschaubild
- Typ
- Titel mit Link
- Datum
- Zusammenfassung
- Themenliste

Die Karte soll auch ohne Bild gut aussehen.

---

## Navigation

Datei:

```text
_data/site_navigation.yml
```

Vorschlag:

```yaml
- title: Start
  url: /
- title: Archiv
  url: /archiv/
- title: Themen
  url: /themen/
- title: Suche
  url: /suche/
- title: Über
  url: /ueber/
```

Navigation soll über Include erzeugt werden:

```text
_includes/navigation.html
```

Alle Links müssen `relative_url` verwenden.

---

## Barrierefreiheit und Robustheit

Codex soll beachten:

- Bilder benötigen sinnvolle `alt`-Texte.
- Navigation soll per Tastatur bedienbar sein.
- Suchfeld braucht Label oder `aria-label`.
- Farbkontraste ausreichend.
- Kein Inhalt darf nur über Farbe verständlich sein.
- HTML soll semantisch sein:
  - `header`
  - `nav`
  - `main`
  - `article`
  - `footer`
- Bei deaktiviertem JavaScript muss die Website weiterhin nutzbar sein.
- Die Suche darf ohne JavaScript ausfallen, aber Archiv und Themen müssen funktionieren.

---

## Datenschutz

- Keine Analytics.
- Keine externen Fonts.
- Keine externen JavaScript-CDNs.
- Keine eingebetteten Drittanbieterinhalte in der Startversion.
- Bilder lokal hosten.
- Suche lokal im Browser.
- Keine Cookies erforderlich.

---

## Backup-Strategie

Da der Inhalt als Git-Repository vorliegt, ist Backup einfach.

Empfohlene Maßnahmen:

- Lokaler Git-Clone auf dem Projektrechner.
- Regelmäßiges Backup des Repositories auf externe Platte oder NAS.
- Optional zweiter Remote, z. B. Codeberg, GitLab oder eigener Gitea-Server.
- Originalbilder außerhalb des Repositories separat sichern.
- Veröffentlichte optimierte Bilder im Repository speichern.

Optionaler zweiter Remote:

```powershell
git remote add backup <backup-url>
git push backup main
```

---

## Arbeitsablauf für neue Artikel

Empfohlener Ablauf:

```text
1. Neuen Artikel erzeugen:
   tools/New-Article.ps1

2. Text in Markdown schreiben.

3. Bilder optimieren:
   tools/Optimize-Images.ps1

4. Bilder im Artikel referenzieren.

5. Metadaten prüfen:
   tools/Validate-Articles.ps1

6. Optional lokal bauen:
   tools/Build-Local.ps1

7. Commit:
   git add .
   git commit -m "Artikel: <Titel>"

8. Push:
   git push

9. GitHub Actions veröffentlicht die Seite.
```

---

## Codex-Aufgabe: Erste Implementierung

Codex soll aus dieser Projektübersicht ein vollständiges initiales Projekt erzeugen.

### Muss-Anforderungen

- Jekyll-kompatible Struktur.
- GitHub-Pages-Workflow.
- `_artikel`-Collection.
- Layouts:
  - default
  - page
  - home
  - artikel
- Includes:
  - header
  - footer
  - navigation
  - article-card
  - tag-list
- Seiten:
  - Startseite
  - Archiv
  - Themen
  - Suche
  - Über
- Suchindex:
  - `search.json`
- Clientseitige Suche:
  - `assets/js/search.js`
- CSS:
  - `assets/css/site.css`
- Daten:
  - `article_types.yml`
  - `topics.yml`
  - `site_navigation.yml`
- Windows-Hilfsskripte:
  - `New-Article.ps1`
  - `Validate-Articles.ps1`
  - `Optimize-Images.ps1`
  - `Build-Local.ps1`
  - `Serve-Local.ps1`
- Beispielartikel.
- README.
- `.gitignore`.

### Qualitätsanforderungen

- Keine Beta- oder Preview-Pakete.
- Keine unnötigen Abhängigkeiten.
- Kein Tracking.
- Keine CDN-Abhängigkeiten.
- Funktioniert als GitHub Pages Projektseite mit `baseurl`.
- Funktioniert später auch als Benutzerseite mit leerem `baseurl`.
- Alle Links verwenden `relative_url`, wo Liquid verfügbar ist.
- JavaScript liest die Search-URL aus dem DOM und nimmt keinen festen Root-Pfad an.
- Suche funktioniert auch bei Umlauten ordentlich genug.
- Markdown-Artikel bleiben auch außerhalb von Jekyll lesbar.

---

## Spätere Erweiterungen

Nicht in der ersten Version zwingend umsetzen, aber beim Design berücksichtigen:

### Serien

Mehrteilige Projekte könnten über ein Feld `series` gruppiert werden:

```yaml
series: "Gartenhaus 2026"
```

Später kann daraus eine Serienübersicht entstehen.

### Verwandte Artikel

```yaml
related:
  - /artikel/gartenhaus-fundament-ausrichten.html
  - /artikel/gartenhaus-dach-eindecken.html
```

### Schwierigkeitsgrad

```yaml
difficulty: "einfach"
```

Mögliche Werte:

```text
einfach
mittel
fortgeschritten
```

### Material- und Werkzeuglisten

Für Anleitungen:

```yaml
material:
  - Fichtenholz
  - Schrauben
  - Holzleim

tools:
  - Akkuschrauber
  - Säge
  - Winkel
```

### Druckansicht

Später kann ein Print-CSS ergänzt werden:

```text
assets/css/print.css
```

### Bessere Suche

Später kann `search.json + search.js` durch Pagefind ersetzt oder ergänzt werden.

### RSS/Atom Feed

Für klassische Abonnements könnte später ein Feed ergänzt werden.

### Sitemap

Eine Sitemap kann später ergänzt werden, falls die Website öffentlich besser auffindbar sein soll.

---

## Akzeptanzkriterien für Version 1

Version 1 gilt als fertig, wenn:

- Die Website lokal oder über GitHub Actions gebaut werden kann.
- Die Startseite die neuesten Artikel anzeigt.
- Die Archivseite Artikel nach Jahren gruppiert.
- Die Themenseite Artikel nach Themen gruppiert.
- Die Suchseite ohne Server funktioniert.
- Ein Beispielartikel sichtbar ist.
- Ein neuer Artikel per PowerShell-Skript erzeugt werden kann.
- Artikelmetadaten per PowerShell-Skript validiert werden können.
- Bilder sinnvoll im Repository abgelegt werden können.
- GitHub Actions erfolgreich nach GitHub Pages deployed.
- Das Projekt ohne externe Dienste nutzbar ist.
- Alle Inhalte als Markdown und Bilddateien im Repository liegen.

---

## Erste Schritte nach Erzeugung des Projekts

1. Leeres Repository `DiyMagic` auf GitHub anlegen.
2. Projektdateien lokal erzeugen lassen.
3. Dateien in das Repository kopieren.
4. Commit und Push nach `main`.
5. In GitHub unter Repository Settings → Pages als Quelle GitHub Actions auswählen.
6. Workflow ausführen.
7. Veröffentlichte URL prüfen.
8. Falls Projektseite: `baseurl: "/DiyMagic"` setzen.
9. Falls Benutzerseite oder eigene Domain: `baseurl: ""` verwenden.
10. Ersten echten Artikel mit `tools/New-Article.ps1` anlegen.

---

## Hinweise für Codex

Codex soll nicht nur Fragmente erzeugen, sondern ein lauffähiges Projektgerüst.

Priorität:

1. Korrekte Struktur.
2. Funktionierender Build.
3. Verständlicher Code.
4. Gute Wartbarkeit.
5. Wenige Abhängigkeiten.
6. Saubere Windows-Hilfsskripte.

Codex soll bei Unklarheiten konservative Entscheidungen treffen:

- lieber statisch als dynamisch.
- lieber Plain JavaScript als Framework.
- lieber lokale Daten als externe Dienste.
- lieber Markdown und YAML als proprietäre Formate.
- lieber einfache robuste Templates als komplexe Logik.
